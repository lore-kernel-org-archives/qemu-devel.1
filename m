Received: from eggs.gnu.org ([2001:4830:134:3::10]:37269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frywb-0006S9-98
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frywX-0004F5-3i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:11:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1frywW-0004Eq-VD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:11:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-42-armbru@redhat.com>
	<2ad9b303-8108-3f66-c478-65081fc4062a@redhat.com>
	<87woslqnay.fsf@dusky.pond.sub.org>
	<4c068b57-280f-7999-dc07-291282302101@redhat.com>
Date: Tue, 21 Aug 2018 07:10:57 +0200
In-Reply-To: <4c068b57-280f-7999-dc07-291282302101@redhat.com> (Eric Blake's
	message of "Mon, 20 Aug 2018 13:36:35 -0500")
Message-ID: <87sh38gv8e.fsf@dusky.pond.sub.org>
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/20/2018 06:39 AM, Markus Armbruster wrote:
>
>> In review of v1, we discussed whether to try matching non-integer
>> numbers with redundant leading zero.  Doing that tightly in the lexer
>> requires duplicating six states.  A simpler alternative is to have the
>> lexer eat "digit salad" after redundant leading zero: 0[0-9.eE+-]+.
>> Your suggestion for hexadecimal numbers is digit salad with different
>> digits: [0-9a-fA-FxX].  Another option is their union: [0-9a-fA-FxX+-].
>> Even more radical would be eating anything but whitespace and structural
>> characters: [^][}{:, \t\n\r].  That idea pushed to the limit results in
>> a two-stage lexer: first stage finds token strings, where a token string
>> is a structural character or a sequence of non-structural,
>> non-whitespace characters, second stage rejects invalid token strings.
>>
>> Hmm, we could try to recover from lexical errors more smartly in
>> general: instead of ending the JSON error token after the first
>> offending character, end it before the first whitespace or structural
>> character following the offending character.
>>
>> I can try that, but I'd prefer to try it in a follow-up patch.
>
> Indeed, that sounds like a valid approach. So, for this patch, I'm
> fine with just accepting ['0' ... '9'], then seeing if the later
> smarter-lexing change makes back-to-back non-structural tokens give
> saner error messages in general.

I think I'll drop this patch for now.  It's not useful enough to apply
it now, then revert it when we have the more general error recovery
improvement.
