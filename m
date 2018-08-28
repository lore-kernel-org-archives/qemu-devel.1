Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVcN-00046F-Ud
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVcJ-0001yl-0j
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:28:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuVcI-0001w0-Ra
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:28:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-2-armbru@redhat.com>
	<0a033e63-a980-b8e6-2f60-cd743cc6c94c@redhat.com>
Date: Tue, 28 Aug 2018 06:28:30 +0200
In-Reply-To: <0a033e63-a980-b8e6-2f60-cd743cc6c94c@redhat.com> (Eric Blake's
	message of "Mon, 27 Aug 2018 11:50:08 -0500")
Message-ID: <87pny3qfm9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] json: Fix lexer for lookahead
 character beyond '\x7F'
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

> On 08/27/2018 02:00 AM, Markus Armbruster wrote:
>> The lexer fails to end a valid token when the lookahead character is
>> beyond '\x7F'.  For instance, input
>>
>>      true\xC2\xA2
>>
>> produces the tokens
>>
>>      JSON_ERROR     true\xC2
>>      JSON_ERROR     \xA2
>>
>> The first token should be
>>
>>      JSON_KEYWORD   true
>>
>> instead.
>
> As long as we still get a JSON_ERROR in the end.

We do: one for \xC2, and one for \xA2.  PATCH 4 will lose the second one.

>> The culprit is
>>
>>      #define TERMINAL(state) [0 ... 0x7F] = (state)
>>
>> It leaves [0x80..0xFF] zero, i.e. IN_ERROR.  Has always been broken.
>
> I wonder if that was done because it was assuming that valid input is
> only ASCII, and that any byte larger than 0x7f is invalid except
> within the context of a string.

Plausible thinko.

>                                  But whatever the reason for the
> original bug, your fix makes sense.
>
>> Fix it to initialize the complete array.
>
> Worth testsuite coverage?

Since lookahead bytes > 0x7F are always a parse error, all the bug can
do is swallow a TERMINAL() token right before a parse error.  The
TERMINAL() tokens are JSON_INTEGER, JSON_FLOAT, JSON_KEYWORD, JSON_SKIP,
JSON_INTERP.  Fairly harmless.  In particular, JSON objects get through
even when followed by a byte > 0x7F.

Of course, test coverage wouldn't hurt regardless.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
