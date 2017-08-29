Received: from eggs.gnu.org ([2001:4830:134:3::10]:55757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhWz-0006Ed-O6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhWu-0006mk-8D
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:30:17 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dmhWt-0006mL-Vy
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:30:12 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1502109458-31251-4-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1502109458-31251-4-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Tue, 29 Aug 2017 16:30:01 +0200
Message-ID: <w51k21mfnva.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 3/6] throttle: move out function to
 reuse the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Mon 07 Aug 2017 02:37:35 PM CEST, Pradeep Jagadeesh wrote:
> This patch move out the throttle code to util/throttle.c to maximize
> the reusability of the code.The same code is also used by fsdev.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

> +    iothrottle = qapi_BlockIOThrottle_base(arg);
> +    throttle_set_io_limits(&cfg, iothrottle);

Since you only use it once, you can spare the definition of the local
iothrottle variable with

     throttle_set_io_limits(&cfg, qapi_BlockIOThrottle_base(arg));

but it's ok with me if you decide to leave it as it is now.

> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -11,6 +11,7 @@
>  #define THROTTLE_OPTIONS_H
>  
>  #include "typedefs.h"
> +#include "qapi-types.h"
>  
>  #define THROTTLE_OPTS \
>            { \
> @@ -93,4 +94,6 @@
>  
>  void throttle_parse_options(ThrottleConfig *, QemuOpts *);
>  
> +void throttle_set_io_limits(ThrottleConfig *, IOThrottle *);
> +

Please remove the empty line between those two prototypes.

> +/* set the throttle limits

Or rather "Initialize a throttle config from an IOThrottle structure"

> + *
> + * @arg: iothrottle limits
> + * @cfg: throttle configuration
> + */
> +void throttle_set_io_limits(ThrottleConfig *cfg, IOThrottle *arg)
> +{

With those changes (the first one is optional),

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
