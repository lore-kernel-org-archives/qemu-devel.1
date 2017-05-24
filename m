Received: from eggs.gnu.org ([2001:4830:134:3::10]:59445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDMAD-0004Vl-F9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDMA8-00029x-OD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:36:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDMA8-00029r-Et
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:36:36 -0400
Date: Wed, 24 May 2017 10:36:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170524023629.GD3873@pxdev.xzpeter.org>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113128eucas1p17a89f8cb47d5731c50f94c3218ba155f@eucas1p1.samsung.com>
	<1495539071-12995-5-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495539071-12995-5-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V6 04/10] migration: split
 ufd_version_check onto receive/request features part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, eblake@redhat.com, dgilbert@redhat.com

On Tue, May 23, 2017 at 02:31:05PM +0300, Alexey Perevalov wrote:
> This modification is necessary for userfault fd features which are
> required to be requested from userspace.
> UFFD_FEATURE_THREAD_ID is a one of such "on demand" feature, which will
> be introduced in the next patch.
> 
> QEMU have to use separate userfault file descriptor, due to
> userfault context has internal state, and after first call of
> ioctl UFFD_API it changes its state to UFFD_STATE_RUNNING (in case of
> success), but kernel while handling ioctl UFFD_API expects UFFD_STATE_WAIT_API.
> So only one ioctl with UFFD_API is possible per ufd.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Hi, Alexey,

Mostly good to me, some nitpicks below.

> ---
>  migration/postcopy-ram.c | 100 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 3ed78bf..4f3f495 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -59,32 +59,114 @@ struct PostcopyDiscardState {
>  #include <sys/eventfd.h>
>  #include <linux/userfaultfd.h>
>  
> -static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> +
> +/**
> + * receive_ufd_features: check userfault fd features, to request only supported
> + * features in the future.
> + *
> + * Returns: true on success
> + *
> + * __NR_userfaultfd - should be checked before

I don't see this line necessary. After all we will detect the error no
matter what...

> + *  @features: out parameter will contain uffdio_api.features provided by kernel
> + *              in case of success
> + */
> +static bool receive_ufd_features(uint64_t *features)
>  {
> -    struct uffdio_api api_struct;
> -    uint64_t ioctl_mask;
> +    struct uffdio_api api_struct = {0};
> +    int ufd;
> +    bool ret = true;
> +
> +    /* if we are here __NR_userfaultfd should exists */
> +    ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
> +    if (ufd == -1) {
> +        error_report("%s: syscall __NR_userfaultfd failed: %s", __func__,
> +                     strerror(errno));
> +        return false;
> +    }
>  
> +    /* ask features */
>      api_struct.api = UFFD_API;
>      api_struct.features = 0;
>      if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> -        error_report("%s: UFFDIO_API failed: %s", __func__
> +        error_report("%s: UFFDIO_API failed: %s", __func__,
>                       strerror(errno));
> +        ret = false;
> +        goto release_ufd;
> +    }
> +
> +    *features = api_struct.features;
> +
> +release_ufd:
> +    close(ufd);
> +    return ret;
> +}
> +
> +/**
> + * request_ufd_features: this function should be called only once on a newly
> + * opened ufd, subsequent calls will lead to error.
> + *
> + * Returns: true on succes
> + *
> + * @ufd: fd obtained from userfaultfd syscall
> + * @features: bit mask see UFFD_API_FEATURES
> + */
> +static bool request_ufd_features(int ufd, uint64_t features)
> +{
> +    struct uffdio_api api_struct = {0};
> +    uint64_t ioctl_mask;
> +
> +    api_struct.api = UFFD_API;
> +    api_struct.features = features;
> +    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> +        error_report("%s failed: UFFDIO_API failed: %s", __func__,
> +                strerror(errno));

Maybe we can indent this line to follow this file's rule?

    error_report("%s failed: UFFDIO_API failed: %s", __func__,
                 strerror(errno));

>          return false;
>      }
>  
> -    ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
> -                 (__u64)1 << _UFFDIO_UNREGISTER;
> +    ioctl_mask = 1 << _UFFDIO_REGISTER |
> +                 1 << _UFFDIO_UNREGISTER;

Could I ask why we explicitly removed (__u64) here? Since I see the
old one better.

>      if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
>          error_report("Missing userfault features: %" PRIx64,
>                       (uint64_t)(~api_struct.ioctls & ioctl_mask));
>          return false;
>      }
>  
> +    return true;
> +}
> +
> +static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
> +{
> +    uint64_t asked_features = 0;
> +    static uint64_t supported_features;
> +
> +    /*
> +     * it's not possible to
> +     * request UFFD_API twice per one fd
> +     * userfault fd features is persistent
> +     */
> +    if (!supported_features) {

I would prefer not having this static variable. After all, this
function call is rare, and the receive_ufd_features() is not that slow
as well.

> +        if (!receive_ufd_features(&supported_features)) {
> +            error_report("%s failed", __func__);
> +            return false;
> +        }
> +    }
> +
> +    /*
> +     * request features, even if asked_features is 0, due to
> +     * kernel expects UFFD_API before UFFDIO_REGISTER, per
> +     * userfault file descriptor
> +     */
> +    if (!request_ufd_features(ufd, asked_features)) {
> +        error_report("%s failed: features %" PRIu64, __func__,
> +                asked_features);

Better indent?

Thanks,

-- 
Peter Xu
