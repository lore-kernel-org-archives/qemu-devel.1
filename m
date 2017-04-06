Received: from eggs.gnu.org ([2001:4830:134:3::10]:37552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cw51o-0005VU-GG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cw51l-0000Dk-Cg
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1cw51l-0000DY-6W
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:52:33 -0400
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<1491462524-1617-4-git-send-email-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4e552edd-dae8-d0ea-c5b1-4c6cabaf2867@redhat.com>
Date: Thu, 6 Apr 2017 12:52:19 +0200
MIME-Version: 1.0
In-Reply-To: <1491462524-1617-4-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 3/9] memory: provide iommu_replay_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>

Hi Peter,

On 06/04/2017 09:08, Peter Xu wrote:
> This is an "global" version of exising memory_region_iommu_replay() - we
s/exising/existing
> announce the translations to all the registered notifiers, instead of a
> specific one.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>
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
It is not fully clear to me what is the consequence of setting
is_write=false always?

Thanks

Eric
> +    }
> +}
> +
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n)
>  {
> 
