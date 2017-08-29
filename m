Received: from eggs.gnu.org ([2001:4830:134:3::10]:32900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmZbZ-00026B-RH
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmZbU-0001p5-Ri
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:02:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmZbU-0001ov-IF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:02:24 -0400
Date: Tue, 29 Aug 2017 14:02:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170829060206.GU14174@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-8-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824192730.8440-8-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 07/32] postcopy: Add notifier chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

On Thu, Aug 24, 2017 at 08:27:05PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add a notifier chain for postcopy with a 'reason' flag
> and an opportunity for a notifier member to return an error.
> 
> Call it when enabling postcopy.
> 
> This will initially used to enable devices to declare they're unable
> to postcopy and later to notify of devices of stages within postcopy.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/postcopy-ram.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.h | 26 ++++++++++++++++++++++++++
>  vl.c                     |  2 ++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 640b72d86d..95007c00ef 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -23,6 +23,8 @@
>  #include "savevm.h"
>  #include "postcopy-ram.h"
>  #include "ram.h"
> +#include "qapi/error.h"
> +#include "qemu/notify.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/balloon.h"
>  #include "qemu/error-report.h"
> @@ -45,6 +47,38 @@ struct PostcopyDiscardState {
>      unsigned int nsentcmds;
>  };
>  
> +/* A notifier chain for postcopy
> + * The notifier should return 0 if it's OK, or a
> + * -errno on error.
> + * The notifier should expect an Error ** as it's data

"PostcopyNotifyData *" but not "Error **"?

Maybe we can just remove this block of comment since there is a
similar one in the header below.

Besides:

Reviewed-by: Peter Xu <peterx@redhat.com>

> + */
> +static NotifierWithReturnList postcopy_notifier_list;
> +
> +void postcopy_infrastructure_init(void)
> +{
> +    notifier_with_return_list_init(&postcopy_notifier_list);
> +}
> +
> +void postcopy_add_notifier(NotifierWithReturn *nn)
> +{
> +    notifier_with_return_list_add(&postcopy_notifier_list, nn);
> +}
> +
> +void postcopy_remove_notifier(NotifierWithReturn *n)
> +{
> +    notifier_with_return_remove(n);
> +}
> +
> +int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
> +{
> +    struct PostcopyNotifyData pnd;
> +    pnd.reason = reason;
> +    pnd.errp = errp;
> +
> +    return notifier_with_return_list_notify(&postcopy_notifier_list,
> +                                            &pnd);
> +}
> +
>  /* Postcopy needs to detect accesses to pages that haven't yet been copied
>   * across, and efficiently map new pages in, the techniques for doing this
>   * are target OS specific.
> @@ -133,6 +167,7 @@ bool postcopy_ram_supported_by_host(void)
>      struct uffdio_register reg_struct;
>      struct uffdio_range range_struct;
>      uint64_t feature_mask;
> +    Error *local_err = NULL;
>  
>      if (qemu_target_page_size() > pagesize) {
>          error_report("Target page size bigger than host page size");
> @@ -146,6 +181,12 @@ bool postcopy_ram_supported_by_host(void)
>          goto out;
>      }
>  
> +    /* Give devices a chance to object */
> +    if (postcopy_notify(POSTCOPY_NOTIFY_PROBE, &local_err)) {
> +        error_report_err(local_err);
> +        goto out;
> +    }
> +
>      /* Version and features check */
>      if (!ufd_version_check(ufd)) {
>          goto out;
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
> index 8e247cc2a2..65dd9dc324 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -95,6 +95,7 @@ int main(int argc, char **argv)
>  #include "audio/audio.h"
>  #include "sysemu/cpus.h"
>  #include "migration/colo.h"
> +#include "migration/postcopy-ram.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/hax.h"
>  #include "qapi/qobject-input-visitor.h"
> @@ -3082,6 +3083,7 @@ int main(int argc, char **argv, char **envp)
>      module_call_init(MODULE_INIT_OPTS);
>  
>      runstate_init();
> +    postcopy_infrastructure_init();
>  
>      if (qcrypto_init(&err) < 0) {
>          error_reportf_err(err, "cannot initialize crypto: ");
> -- 
> 2.13.5
> 

-- 
Peter Xu
