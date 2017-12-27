Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUBk0-0001rw-25
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUBjs-000136-HT
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:27:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUBjs-000101-6y
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:27:20 -0500
Date: Wed, 27 Dec 2017 14:27:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171227142707.50888166@igors-macbook-pro.local>
In-Reply-To: <20171218201340.27583-8-dgilbert@redhat.com>
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-8-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 7/7] vhost: Merge and delete unused
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

On Mon, 18 Dec 2017 20:13:40 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Now that the olf vhost_set_memory code is gone, the _nop and _add
> callbacks are identical and can be merged.  The _del callback is
> no longer needed.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
With style nit fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/virtio/vhost.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 358ceb3033..4eaa4f889f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -555,7 +555,8 @@ static void vhost_region_add_section(struct vhost_dev *dev,
>      }
>  }
>  
> -static void vhost_region_add(MemoryListener *listener,
> +/* Used for both add and nop callbacks */
> +static void vhost_region_addnop(MemoryListener *listener,
>                               MemoryRegionSection *section)
argument alignment should on '('

>  {
>      struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> @@ -567,29 +568,6 @@ static void vhost_region_add(MemoryListener *listener,
>      vhost_region_add_section(dev, section);
>  }
>  
> -/* Called on regions that have not changed */
> -static void vhost_region_nop(MemoryListener *listener,
> -                             MemoryRegionSection *section)
> -{
> -    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> -                                         memory_listener);
> -
> -    if (!vhost_section(section)) {
> -        return;
> -    }
> -
> -    vhost_region_add_section(dev, section);
> -}
> -
> -static void vhost_region_del(MemoryListener *listener,
> -                             MemoryRegionSection *section)
> -{
> -    if (!vhost_section(section)) {
> -        return;
> -    }
> -
> -}
> -
>  static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>  {
>      struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
> @@ -1158,9 +1136,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      hdev->memory_listener = (MemoryListener) {
>          .begin = vhost_begin,
>          .commit = vhost_commit,
> -        .region_add = vhost_region_add,
> -        .region_del = vhost_region_del,
> -        .region_nop = vhost_region_nop,
> +        .region_add = vhost_region_addnop,
> +        .region_nop = vhost_region_addnop,
>          .log_start = vhost_log_start,
>          .log_stop = vhost_log_stop,
>          .log_sync = vhost_log_sync,
