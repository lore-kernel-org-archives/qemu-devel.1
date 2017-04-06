Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cw60z-00017q-Ny
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cw60u-0004r7-Jr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:55:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cw60u-0004qf-EI
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:55:44 -0400
Date: Thu, 6 Apr 2017 14:55:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170406145529-mutt-send-email-mst@kernel.org>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<1491462524-1617-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491462524-1617-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/9] memory: provide iommu_replay_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, Marcel Apfelbaum <marcel@redhat.com>, jan.kiszka@siemens.com, jasowang@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Thu, Apr 06, 2017 at 03:08:38PM +0800, Peter Xu wrote:
> This is an "global" version of exising memory_region_iommu_replay() - we
> announce the translations to all the registered notifiers, instead of a
> specific one.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/exec/memory.h | 8 ++++++++
>  memory.c              | 9 +++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 07e43da..fb7dff3 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -713,6 +713,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
>                                  bool is_write);
>  
>  /**
> + * memory_region_iommu_replay_all: replay existing IOMMU translations
> + * to all the notifiers registered.
> + *
> + * @mr: the memory region to observe
> + */
> +void memory_region_iommu_replay_all(MemoryRegion *mr);
> +
> +/**
>   * memory_region_unregister_iommu_notifier: unregister a notifier for
>   * changes to IOMMU translation entries.
>   *
> diff --git a/memory.c b/memory.c
> index 7496b3d..b4ed67b 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1642,6 +1642,15 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
>      }
>  }
>  
> +void memory_region_iommu_replay_all(MemoryRegion *mr)
> +{
> +    IOMMUNotifier *notifier;
> +
> +    IOMMU_NOTIFIER_FOREACH(notifier, mr) {
> +        memory_region_iommu_replay(mr, notifier, false);
> +    }
> +}
> +
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n)
>  {
> -- 
> 2.7.4
