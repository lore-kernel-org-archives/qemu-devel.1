Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d41nk-0004Jy-SE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d41ng-00048H-Pb
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d41ng-000480-Gv
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:02:52 -0400
Date: Fri, 28 Apr 2017 17:01:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170428090153.GB24485@pxdev.xzpeter.org>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065753eucas1p1524aa2bd8e469e6c94a88ee80eb54a6e@eucas1p1.samsung.com>
	<1493362658-8179-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493362658-8179-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 3/6] migration: split
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com, f4bug@amsat.org

On Fri, Apr 28, 2017 at 09:57:35AM +0300, Alexey Perevalov wrote:
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
>  migration/postcopy-ram.c | 68 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 4c859b4..21e7150 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -60,15 +60,51 @@ struct PostcopyDiscardState {
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
> + */
> +static bool receive_ufd_features(__u64 *features)
>  {
> -    struct uffdio_api api_struct;
> -    uint64_t ioctl_mask;
> +    struct uffdio_api api_struct = {0};
> +    int ufd;
> +    bool ret = true;
>  
> +    /* if we are here __NR_userfaultfd should exists */
> +    ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
> +    if (ufd == -1) {

This check should be <0 rather than -1?

> +        return false;
> +    }
> +
> +    /* ask features */
>      api_struct.api = UFFD_API;
>      api_struct.features = 0;
>      if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> -        error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
> +        error_report("receive_ufd_features: UFFDIO_API failed: %s",
> +                strerror(errno));
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
> +static bool request_ufd_features(int ufd, __u64 features)
> +{
> +    struct uffdio_api api_struct = {0};
> +    uint64_t ioctl_mask;
> +
> +    api_struct.api = UFFD_API;
> +    api_struct.features = features;
> +    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> +        error_report("request_ufd_features: UFFDIO_API failed: %s",
>                       strerror(errno));
>          return false;
>      }
> @@ -81,11 +117,33 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
>          return false;
>      }
>  
> +    return true;
> +}
> +
> +static bool ufd_version_check(int ufd, MigrationIncomingState *mis)

This is not only a check not... It enables something in the kernel. So
I'll suggest change the function name correspondingly.

> +{
> +    __u64 new_features = 0;
> +
> +    /* ask features */
> +    __u64 supported_features;
> +
> +    if (!receive_ufd_features(&supported_features)) {
> +        error_report("ufd_version_check failed");
> +        return false;
> +    }
> +
> +    /* request features */
> +    if (new_features && !request_ufd_features(ufd, new_features)) {

Firstly, looks like new_features == 0 here always, no?

Second, I would suggest we enable feature explicitly. For this series,
it's only for the THREAD_ID thing. I would mask the rest. The problem
is, what if new features introduced in the future that we don't really
want to enable for postcopy?

Thanks,

> +        error_report("ufd_version_check failed: features %" PRIu64,
> +                (uint64_t)new_features);
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
> -- 
> 1.9.1
> 

-- 
Peter Xu
