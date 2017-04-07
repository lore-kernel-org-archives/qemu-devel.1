Received: from eggs.gnu.org ([2001:4830:134:3::10]:55253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cwW7f-00077w-Tj
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cwW7c-0001ED-19
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cwW7b-0001E9-RZ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:48:23 -0400
Date: Fri, 7 Apr 2017 18:48:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170407184601-mutt-send-email-mst@kernel.org>
References: <1491614650-5144-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491614650-5144-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] vhost: skip RAM device memory sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: wang.guang55@zte.com.cn, qemu-devel@nongnu.org

On Sat, Apr 08, 2017 at 09:24:10AM +0800, ZhiPeng Lu wrote:
> A RAM device represents a mapping to a physical device, such as to a PCI
> * MMIO BAR of an vfio-pci assigned device.
> Vhost listens to this region,and increases the region's reference count
> while passthrough?for?network adapters (Physical Function, PF or Virtual Function, VF).
> After detaching   network adapters with  vhost backend dirver or vhost user dirver,
> it unregister vhost listen function  by memory_listener_unregister.

Shouldn't that drop all references? That might be a cleaner fix.

> After detaching the passthrough pf  or vf,
> the RAM device region's reference by  vhost listener increated can not be released,
> due to vhost listen function does not exist.So let's just skip RAM device memory.
> 
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  hw/virtio/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 613494d..c1ff98f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -611,7 +611,8 @@ static void vhost_set_memory(MemoryListener *listener,
>  static bool vhost_section(MemoryRegionSection *section)
>  {
>      return memory_region_is_ram(section->mr) &&
> -        !memory_region_is_rom(section->mr);
> +        !memory_region_is_rom(section->mr) &&
> +        !memory_region_is_skip_dump(section->mr);
>  }
>  
>  static void vhost_begin(MemoryListener *listener)
> -- 
> 1.8.3.1
> 
