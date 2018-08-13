Received: from eggs.gnu.org ([2001:4830:134:3::10]:38903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpFYV-0001zK-3e
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpFYR-00086S-S4
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:18:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpFYR-00086A-Ls
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:18:51 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-41-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87a5ca96-5f44-5e18-a8a0-91c76f66f054@redhat.com>
Date: Mon, 13 Aug 2018 11:18:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-41-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 40/56] json: Replace %I64d, %I64u by %PRId64,
 %PRIu64
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

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Support for %I64d got addded in commit 2c0d4b36e7f "json: fix PRId64

s/addded/added/

> on Win32".  We had to hard-code I64d because we used the lexer's
> finite state machine to check interpolations.  No more, so clean this
> up.
> 
> Additional conversion specifications would be easy enough to implement
> when needed.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-parser.c | 10 ++++++----
>   tests/check-qjson.c   | 10 ++++++++++
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

>          return QOBJECT(qnum_from_int(va_arg(*ap, long)));
> -    } else if (!strcmp(token->str, "%lld") ||
> -               !strcmp(token->str, "%I64d")) {
> +    } else if (!strcmp(token->str, "%lld")) {
>          return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
> +    } else if (!strcmp(token->str, "%" PRId64)) {
> +        return QOBJECT(qnum_from_int(va_arg(*ap, int64_t)));

I had a double-take to make sure this still works on mingw. The trick 
used to be that the lexer had to parse the union of all forms understood 
by any libc (making Linux understand %I64d even though only mingw would 
generate it) then the parser had to accept all forms allowed through by 
the lexer.  Now the lexer accepts all forms with no effort (because it 
is no longer validates), and the parser is made stricter (%I64d no 
longer works on Linux, where we have two redundant 'if' clauses; but 
mingw has two distinct 'if' clauses and works as desired).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
