Received: from eggs.gnu.org ([2001:4830:134:3::10]:59096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dujy4-000249-Mm
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dujy1-0001vZ-JW
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:43:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dujy1-0001rC-A9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:43:25 -0400
Date: Wed, 20 Sep 2017 19:43:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170920184317.GK2449@work-vm>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164820eucas1p25f16f91aa65933fa18cdff7cb7b7444c@eucas1p2.samsung.com>
	<1505839684-10046-2-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505839684-10046-2-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v10 01/10] userfault: update kernel header
 for UFFD_FEATURE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This commit adds modification for UFFD_FEATURE_SIGBUS and
> UFFD_FEATURE_THREAD_ID.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

This should be replaced with just running the 
   scripts/update-linux-headers.sh
against a 4.14-rc1 checkout.

That can be done as a separate patch or the first patch
of this series.

Dave

> ---
>  linux-headers/linux/userfaultfd.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
> index 9701772..b43cf0d 100644
> --- a/linux-headers/linux/userfaultfd.h
> +++ b/linux-headers/linux/userfaultfd.h
> @@ -23,7 +23,9 @@
>  			   UFFD_FEATURE_EVENT_REMOVE |	\
>  			   UFFD_FEATURE_EVENT_UNMAP |		\
>  			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
> -			   UFFD_FEATURE_MISSING_SHMEM)
> +			   UFFD_FEATURE_MISSING_SHMEM |		\
> +			   UFFD_FEATURE_SIGBUS |		\
> +			   UFFD_FEATURE_THREAD_ID)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -78,6 +80,9 @@ struct uffd_msg {
>  		struct {
>  			__u64	flags;
>  			__u64	address;
> +			union {
> +				__u32 ptid;
> +			} feat;
>  		} pagefault;
>  
>  		struct {
> @@ -153,6 +158,13 @@ struct uffdio_api {
>  	 * UFFD_FEATURE_MISSING_SHMEM works the same as
>  	 * UFFD_FEATURE_MISSING_HUGETLBFS, but it applies to shmem
>  	 * (i.e. tmpfs and other shmem based APIs).
> +	 *
> +	 * UFFD_FEATURE_SIGBUS feature means no page-fault
> +	 * (UFFD_EVENT_PAGEFAULT) event will be delivered, instead
> +	 * a SIGBUS signal will be sent to the faulting process.
> +	 *
> +	 * UFFD_FEATURE_THREAD_ID pid of the page faulted task_struct will
> +	 * be returned, if feature is not requested 0 will be returned.
>  	 */
>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -161,6 +173,8 @@ struct uffdio_api {
>  #define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
>  #define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
>  #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
> +#define UFFD_FEATURE_SIGBUS			(1<<7)
> +#define UFFD_FEATURE_THREAD_ID			(1<<8)
>  	__u64 features;
>  
>  	__u64 ioctls;
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
