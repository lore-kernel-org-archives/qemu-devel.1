Received: from eggs.gnu.org ([2001:4830:134:3::10]:35786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fufbt-0007gm-2w
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fufRx-0005X7-Tp
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fufRx-0005Vy-Mr
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:58:33 -0400
Date: Tue, 28 Aug 2018 11:58:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180828145815.GJ5675@localhost.localdomain>
References: <1535199590-68475-1-git-send-email-peng.hao2@zte.com.cn>
	<1535199590-68475-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535199590-68475-2-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V4 1/4] target-i386: introduce
 coalesced_pio kvm header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On Sat, Aug 25, 2018 at 08:19:47PM +0800, Peng Hao wrote:
> add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

What's the status of the corresponding KVM header patch?


> ---
>  accel/kvm/kvm-all.c       | 4 ++--
>  linux-headers/linux/kvm.h | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index eb7db92..4a3909d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -536,7 +536,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
>  
>          zone.addr = start;
>          zone.size = size;
> -        zone.pad = 0;
> +        zone.pio = 0;
>  
>          (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
>      }
> @@ -553,7 +553,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
>  
>          zone.addr = start;
>          zone.size = size;
> -        zone.pad = 0;
> +        zone.pio = 0;
>  
>          (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
>      }
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 98f389a..747b473 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -420,13 +420,13 @@ struct kvm_run {
>  struct kvm_coalesced_mmio_zone {
>  	__u64 addr;
>  	__u32 size;
> -	__u32 pad;
> +	__u32 pio;
>  };
>  
>  struct kvm_coalesced_mmio {
>  	__u64 phys_addr;
>  	__u32 len;
> -	__u32 pad;
> +	__u32 pio;
>  	__u8  data[8];
>  };
>  
> @@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_COALESCED_PIO 156
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 1.8.3.1
> 

-- 
Eduardo
