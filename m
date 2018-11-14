Received: from eggs.gnu.org ([2001:4830:134:3::10]:38070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMxjt-0007nZ-BW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMxjp-00049f-Bx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:10:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gMxjp-00048v-5h
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:09:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-3-david@redhat.com>
Date: Wed, 14 Nov 2018 17:09:50 +0100
In-Reply-To: <20181109110221.10553-3-david@redhat.com> (David Hildenbrand's
	message of "Fri, 9 Nov 2018 12:02:17 +0100")
Message-ID: <87r2fnod2p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 2/6] qapi: use qemu_strtod() in
 string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> Let's use the new function.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi/string-input-visitor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index b3fdd0827d..dee708d384 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -20,6 +20,7 @@
>  #include "qemu/option.h"
>  #include "qemu/queue.h"
>  #include "qemu/range.h"
> +#include "qemu/cutils.h"
>  
>  
>  struct StringInputVisitor
> @@ -313,12 +314,9 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
>                                Error **errp)
>  {
>      StringInputVisitor *siv = to_siv(v);
> -    char *endp = (char *) siv->string;
>      double val;
>  
> -    errno = 0;
> -    val = strtod(siv->string, &endp);
> -    if (errno || endp == siv->string || *endp) {
> +    if (qemu_strtod(siv->string, NULL, &val)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                     "number");
>          return;

Three more: in qobject-input-visitor.c's
qobject_input_type_number_keyval(), cutil.c's do_strtosz(), and
json-parser.c's parse_literal().

The latter doesn't check for errors since the lexer ensures the input is
sane.  Overflow can still happen, and is silently ignored.  Feel free
not to convert this one.
