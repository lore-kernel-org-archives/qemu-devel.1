Received: from eggs.gnu.org ([2001:4830:134:3::10]:55565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1friXO-0004qJ-TQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1friXJ-0000vK-GB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:39:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1friXJ-0000uh-BN
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:39:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-42-armbru@redhat.com>
	<2ad9b303-8108-3f66-c478-65081fc4062a@redhat.com>
Date: Mon, 20 Aug 2018 13:39:49 +0200
In-Reply-To: <2ad9b303-8108-3f66-c478-65081fc4062a@redhat.com> (Eric Blake's
	message of "Fri, 17 Aug 2018 11:03:21 -0500")
Message-ID: <87woslqnay.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 41/60] json: Nicer recovery from invalid
 leading zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/17/2018 10:05 AM, Markus Armbruster wrote:
>> For input 0123, the lexer produces the tokens
>>
>>      JSON_ERROR    01
>>      JSON_INTEGER  23
>>
>> Reporting an error is correct; 0123 is invalid according to RFC 7159.
>> But the error recovery isn't nice.
>>
>> Make the finite state machine eat digits before going into the error
>> state.  The lexer now produces
>>
>>      JSON_ERROR    0123
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Did you also want to reject invalid attempts at hex numbers, by adding
> [xXa-fA-F] to the set of characters eaten by IN_BAD_ZERO?

I put one foot on a slippery slope with this patch...

In review of v1, we discussed whether to try matching non-integer
numbers with redundant leading zero.  Doing that tightly in the lexer
requires duplicating six states.  A simpler alternative is to have the
lexer eat "digit salad" after redundant leading zero: 0[0-9.eE+-]+.
Your suggestion for hexadecimal numbers is digit salad with different
digits: [0-9a-fA-FxX].  Another option is their union: [0-9a-fA-FxX+-].
Even more radical would be eating anything but whitespace and structural
characters: [^][}{:, \t\n\r].  That idea pushed to the limit results in
a two-stage lexer: first stage finds token strings, where a token string
is a structural character or a sequence of non-structural,
non-whitespace characters, second stage rejects invalid token strings.

Hmm, we could try to recover from lexical errors more smartly in
general: instead of ending the JSON error token after the first
offending character, end it before the first whitespace or structural
character following the offending character.

I can try that, but I'd prefer to try it in a follow-up patch.

>>   +    [IN_BAD_ZERO] = {
>> +        ['0' ... '9'] = IN_BAD_ZERO,
>> +    },
>> +
