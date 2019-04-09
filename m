Received: from eggs.gnu.org ([209.51.188.92]:52361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDs6b-00007J-DC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDs6a-0004mH-9b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:52:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDs6a-0004k4-38
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:52:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so10419064qki.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:52:04 -0700 (PDT)
Date: Tue, 9 Apr 2019 10:52:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190409102526-mutt-send-email-mst@kernel.org>
References: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] msix: fix interrupt aggregation problem at
 the passthrough of NVMe SSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com

On Tue, Apr 09, 2019 at 02:14:56PM +0000, Zhuangyanying wrote:
> From: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> 
> Recently I tested the performance of NVMe SSD passthrough and found that interrupts
> were aggregated on vcpu0(or the first vcpu of each numa) by /proc/interrupts,when
> GuestOS was upgraded to sles12sp3 (or redhat7.6). But /proc/irq/X/smp_affinity_list
> shows that the interrupt is spread out, such as 0-10, 11-21,.... and so on.
> This problem cannot be resolved by "echo X > /proc/irq/X/smp_affinity_list", because
> the NVMe SSD interrupt is requested by the API pci_alloc_irq_vectors(), so the
> interrupt has the IRQD_AFFINITY_MANAGED flag.
> 
> GuestOS sles12sp3 backport "automatic interrupt affinity for MSI/MSI-X capable devices",
> but the implementation of __setup_irq has no corresponding modification. It is still
> irq_startup(), then setup_affinity(), that is sending an affinity message when the
> interrupt is unmasked. The bare metal configuration is successful, but qemu will
> not trigger the msix update, and the affinity configuration fails.
> The affinity is configured by /proc/irq/X/smp_affinity_list, implemented at
> apic_ack_edge(), the bitmap is stored in pending_mask,
> mask->__pci_write_msi_msg()->unmask,
> and the timing is guaranteed, and the configuration takes effect.
> 
> The GuestOS linux-master incorporates the "genirq/cpuhotplug: Enforce affinity
> setting on startup of managed irqs" to ensure that the affinity is first issued
> and then __irq_startup(), for the managerred interrupt. So configuration is
> successful.
> 
> It now looks like sles12sp3 (up to sles15sp1, linux-4.12.x), redhat7.6
> (3.10.0-957.10.1) does not have backport the patch yet.
> "if (is_masked == was_masked) return;" can it be removed at qemu?
> What is the reason for this check?

The reason is simple:

The PCI spec says:

Software must not modify the Address or Data fields of an entry while it is unmasked.

It's a guest bug then?

> 
> Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> ---
>  hw/pci/msix.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 4e33641..e1ff533 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -119,10 +119,6 @@ static void msix_handle_mask_update(PCIDevice *dev, int vector, bool was_masked)
>  {
>      bool is_masked = msix_is_masked(dev, vector);
>  
> -    if (is_masked == was_masked) {
> -        return;
> -    }
> -
>      msix_fire_vector_notifier(dev, vector, is_masked);
>  
>      if (!is_masked && msix_is_pending(dev, vector)) {
> -- 
> 1.8.3.1
> 
