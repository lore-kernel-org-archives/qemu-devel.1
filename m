Received: from eggs.gnu.org ([2001:4830:134:3::10]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnpdc-00022f-N4
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnpdY-0008Aj-LE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:26:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnpdY-00089C-FC
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:26:16 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3e41b9c-add4-31e5-296c-68b518cb14d2@redhat.com>
Date: Thu, 9 Aug 2018 13:26:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> Fix the lexer to reject unescaped control characters in JSON strings,
> in accordance with RFC 7159.

Question - can this break existing QMP clients that were relying on this 
extension working?

Libvirt used to use libyajl, now it uses libjansson. So I'll check both 
of those libraries:

yajl: https://github.com/lloyd/yajl/blob/master/src/yajl_encode.c#L32

             default:
                 if ((unsigned char) str[end] < 32) {
                     CharToHex(str[end], hexBuf + 4);
escaped = hexBuf;

jansson: https://github.com/akheron/jansson/blob/master/src/dump.c#L101

             /* mandatory escape or control char */
if(codepoint == '\\' || codepoint == '"' || codepoint < 0x20)

Okay, both libraries appear to always send control characters encoded, 
and thus were not relying on this accidental QMP extension.

Are we worried about other clients?

> 
> Bonus: we now recover more nicely from unclosed strings.  E.g.
> 
>      {"one: 1}\n{"two": 2}
> 
> now recovers cleanly after the newline, where before the lexer
> remained confused until the next unpaired double quote or lexical
> error.

On that grounds alone, I could live with this patch, even if we end up 
having to revert it later if some client was actually depending on 
sending raw control characters as part of a string.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
