Received: from eggs.gnu.org ([2001:4830:134:3::10]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUVyW-0008H3-MU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUVyS-0003dg-LD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:31:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dUVyS-0003bX-FL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:31:28 -0400
Date: Mon, 10 Jul 2017 18:31:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170710103114.GC21344@pxdev.xzpeter.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-7-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170628190047.26159-7-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 06/29] postcopy: Add notifier chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On Wed, Jun 28, 2017 at 08:00:24PM +0100, Dr. David Alan Gilbert (git) wrote:

[...]

> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 78a3591322..d688411674 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -114,4 +114,30 @@ PostcopyState postcopy_state_get(void);
>  /* Set the state and return the old state */
>  PostcopyState postcopy_state_set(PostcopyState new_state);
>  
> +/*
> + * To be called once at the start before any device initialisation

initialization?

> + */
> +void postcopy_infrastructure_init(void);
> +
> +/* Add a notifier to a list to be called when checking whether the devices
> + * can support postcopy.
> + * It's data is a *PostcopyNotifyData
> + * It should return 0 if OK, or a negative value on failure.
> + * On failure it must set the data->errp to an error.
> + *
> + */
> +enum PostcopyNotifyReason {
> +    POSTCOPY_NOTIFY_PROBE = 0,
> +};
> +
> +struct PostcopyNotifyData {
> +    enum PostcopyNotifyReason reason;
> +    Error **errp;
> +};
> +
> +void postcopy_add_notifier(NotifierWithReturn *nn);
> +void postcopy_remove_notifier(NotifierWithReturn *n);
> +/* Call the notifier list set by postcopy_add_start_notifier */
> +int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
> +
>  #endif
> diff --git a/vl.c b/vl.c
> index a2bd69f4e0..b6c660a703 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -93,8 +93,9 @@ int main(int argc, char **argv)
>  #include "sysemu/dma.h"
>  #include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
> -#include "sysemu/cpus.h"
>  #include "migration/colo.h"
> +#include "migration/postcopy-ram.h"
> +#include "sysemu/cpus.h"

(just curious: is moving sysemu/cpus.h intended?)

>  #include "sysemu/kvm.h"
>  #include "sysemu/hax.h"
>  #include "qapi/qobject-input-visitor.h"
> @@ -3060,6 +3061,7 @@ int main(int argc, char **argv, char **envp)
>      module_call_init(MODULE_INIT_OPTS);
>  
>      runstate_init();
> +    postcopy_infrastructure_init();
>  
>      if (qcrypto_init(&err) < 0) {
>          error_reportf_err(err, "cannot initialize crypto: ");
> -- 
> 2.13.0
> 

Thanks,

-- 
Peter Xu
