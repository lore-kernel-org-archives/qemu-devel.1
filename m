Received: from eggs.gnu.org ([2001:4830:134:3::10]:44282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNKok-0007Ov-RD
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNKoe-0003EL-PB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNKoc-0003BW-Su
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:48:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-4-david@redhat.com>
Date: Thu, 15 Nov 2018 17:48:17 +0100
In-Reply-To: <20181115140501.7872-4-david@redhat.com> (David Hildenbrand's
	message of "Thu, 15 Nov 2018 15:04:55 +0100")
Message-ID: <87a7mab832.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 3/9] qapi: use qemu_strtod_finite() in
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

> Let's use the new function. "NaN" and "inf" are now properly rejected.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Whether this is a bug fix or just a change is debatable.  But the commit
message's title should highlight the change.  Perhaps you want to steal
from the one I suggested for the previous patch.

We need to assess backward compatibility impact.  I can do that.

> ---
>  qapi/string-input-visitor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index b3fdd0827d..b89c6c4e06 100644
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
> +    if (qemu_strtod_finite(siv->string, NULL, &val)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                     "number");
>          return;
