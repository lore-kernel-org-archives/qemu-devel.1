Received: from eggs.gnu.org ([2001:4830:134:3::10]:44396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8NB-0008Hx-Du
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8N6-0000ja-VD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo8N6-0000io-Ob
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:26:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-18-armbru@redhat.com>
	<f3e41b9c-add4-31e5-296c-68b518cb14d2@redhat.com>
Date: Fri, 10 Aug 2018 16:26:24 +0200
In-Reply-To: <f3e41b9c-add4-31e5-296c-68b518cb14d2@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 13:26:14 -0500")
Message-ID: <87bmaal2lr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/56] json: Reject unescaped control
 characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> Fix the lexer to reject unescaped control characters in JSON strings,
>> in accordance with RFC 7159.
>
> Question - can this break existing QMP clients that were relying on
> this extension working?

In theory, yes.

The "extension" is undocumented.  That makes it a bug.

I'm not aware of clients relying on it.

> Libvirt used to use libyajl, now it uses libjansson. So I'll check
> both of those libraries:
>
> yajl: https://github.com/lloyd/yajl/blob/master/src/yajl_encode.c#L32
>
>             default:
>                 if ((unsigned char) str[end] < 32) {
>                     CharToHex(str[end], hexBuf + 4);
> escaped = hexBuf;
>
> jansson: https://github.com/akheron/jansson/blob/master/src/dump.c#L101
>
>             /* mandatory escape or control char */
> if(codepoint == '\\' || codepoint == '"' || codepoint < 0x20)
>
> Okay, both libraries appear to always send control characters encoded,
> and thus were not relying on this accidental QMP extension.
>
> Are we worried about other clients?

Breakage seems unlikely to me.

>> Bonus: we now recover more nicely from unclosed strings.  E.g.
>>
>>      {"one: 1}\n{"two": 2}
>>
>> now recovers cleanly after the newline, where before the lexer
>> remained confused until the next unpaired double quote or lexical
>> error.
>
> On that grounds alone, I could live with this patch, even if we end up
> having to revert it later if some client was actually depending on
> sending raw control characters as part of a string.

Having to revert the patch to stay bug-compatible wouldn't be exactly
terrible.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
