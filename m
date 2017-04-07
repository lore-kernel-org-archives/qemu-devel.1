Received: from eggs.gnu.org ([2001:4830:134:3::10]:53016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cwXPj-0007t3-CI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cwXPf-0008Nz-Cg
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:11:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cwXPf-0008N7-5w
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:11:07 -0400
Received: by mail-wm0-x241.google.com with SMTP id q125so698607wmd.3
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 10:11:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1491614183-4580-1-git-send-email-wang.guang55@zte.com.cn>
	<1491614183-4580-2-git-send-email-wang.guang55@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62d3af82-73cf-25b0-b476-d2391090629e@redhat.com>
Date: Sat, 8 Apr 2017 01:10:54 +0800
MIME-Version: 1.0
In-Reply-To: <1491614183-4580-2-git-send-email-wang.guang55@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: skip RAM device memory sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang guang <wang.guang55@zte.com.cn>, mst@redhat.com
Cc: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, qemu-devel@nongnu.org



On 08/04/2017 09:16, Wang guang wrote:
> From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> 
> A RAM device represents a mapping to a physical device, such as to a PCI
> * MMIO BAR of an vfio-pci assigned device.
> Vhost listens to this region,and increases the region's reference count
> while passthrough?for?network adapters (Physical Function, PF or Virtual Function, VF).
> After detaching   network adapters with  vhost backend dirver or vhost user dirver,
> it unregister vhost listen function  by memory_listener_unregister.
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

Why not memory_region_is_ram_device?

Paolo
