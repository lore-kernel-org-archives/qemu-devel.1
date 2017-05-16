Received: from eggs.gnu.org ([2001:4830:134:3::10]:43015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAZmp-0000bA-LV
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAZml-0002xF-JF
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAZml-0002wL-Ab
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:32:59 -0400
Date: Tue, 16 May 2017 11:32:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170516103250.GB2839@work-vm>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133146eucas1p17df48bb6b5fcefe3717e18cd9afd84b7@eucas1p1.samsung.com>
	<1494595886-30912-5-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494595886-30912-5-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V5 4/9] migration: split ufd_version_check
 onto receive/request features part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This modification is necessary for userfault fd features which are
> required to be requested from userspace.
> UFFD_FEATURE_THREAD_ID is a one of such "on demand" feature, which will
> be introduced in the next patch.
> 
> QEMU need to use separate userfault file descriptor, due to
> userfault context has internal state, and after first call of
> ioctl UFFD_API it changes its state to UFFD_STATE_RUNNING (in case of
> success), but
> kernel while handling ioctl UFFD_API expects UFFD_STATE_WAIT_API. So
> only one ioctl with UFFD_API is possible per ufd.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  migration/postcopy-ram.c | 82 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 0f75700..c96d5f5 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -60,32 +60,96 @@ struct PostcopyDiscardState {
>  #include <sys/eventfd.h>
>  #include <linux/userfaultfd.h>
>  
> -static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> +
> +/*
> + * Check userfault fd features, to request only supported features in
> + * future.
> + * __NR_userfaultfd - should be checked before
> + * Return obtained features

That's not quite right;
 * Returns: True on success, sets *features to supported features
            False on failure or if kernel doesn't support ufd

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

Needs a comment; perhaps something like:
  * Called once on a newly opened ufd, can request specific features.
  * Returns: True on success

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
>          return false;
>      }
>  
> -    ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
> -                 (__u64)1 << _UFFDIO_UNREGISTER;
> +    ioctl_mask = 1 << _UFFDIO_REGISTER |
> +                 1 << _UFFDIO_UNREGISTER;
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
> +    uint64_t supported_features;
> +
> +    /*
> +     * it's not possible to
> +     * request UFFD_API twice per one fd
> +     */
> +    if (!receive_ufd_features(&supported_features)) {
> +        error_report("%s failed", __func__);
> +        return false;
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
> +        return false;
> +    }
> +
>      if (getpagesize() != ram_pagesize_summary()) {
>          bool have_hp = false;
>          /* We've got a huge page */
>  #ifdef UFFD_FEATURE_MISSING_HUGETLBFS
> -        have_hp = api_struct.features & UFFD_FEATURE_MISSING_HUGETLBFS;
> +        have_hp = supported_features & UFFD_FEATURE_MISSING_HUGETLBFS;
>  #endif
>          if (!have_hp) {
>              error_report("Userfault on this host does not support huge pages");
> @@ -136,7 +200,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
>      }
>  
>      /* Version and features check */
> -    if (!ufd_version_check(ufd, mis)) {
> +    if (!ufd_check_and_apply(ufd, mis)) {
>          goto out;
>      }
>  
> @@ -513,7 +577,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>       * Although the host check already tested the API, we need to
>       * do the check again as an ABI handshake on the new fd.
>       */
> -    if (!ufd_version_check(mis->userfault_fd, mis)) {
> +    if (!ufd_check_and_apply(mis->userfault_fd, mis)) {
>          return -1;
>      }
>  
> -- 
> 1.9.1

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
