Received: from eggs.gnu.org ([2001:4830:134:3::10]:51321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmLaF-0007Tb-Rv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmLaA-00038Z-25
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmLa9-00037y-S1
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:04:05 -0400
Date: Mon, 28 Aug 2017 17:04:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170828170400.0a23b2fe.cohuck@redhat.com>
In-Reply-To: <1503907487-2764-3-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-3-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] s390x/pci: remove idx from msix msg
 data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Mon, 28 Aug 2017 10:04:45 +0200
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> PCIDevcie pointer has been a parameter of kvm_arch_fixup_msi_route().

s/PCIDevcie/PCIDevice/

> So we don't need to store zpci idx in msix message data to find out the
> specific zpci device. Instead, we could use pci device id to find its
> corresponding zpci device.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 16 +++++-----------
>  hw/s390x/s390-pci-bus.h  |  2 ++
>  hw/s390x/s390-pci-inst.c | 24 ------------------------
>  target/s390x/kvm.c       |  7 +++++--
>  4 files changed, 12 insertions(+), 37 deletions(-)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 1c68c36663..e348bfb7cc 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2503,10 +2503,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
>      S390PCIBusDevice *pbdev;
> -    uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
>      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
>  
> -    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> +    if (!dev) {
> +        return -ENODEV;
> +    }
> +
> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(dev)->id);

You need to replace the stub for s390_pci_find_dev_by_idx() with a stub
for s390_pci_find_dev_by_target() in s390-pci-stubs.c (on my s390-next
branch), so that it compiles without CONFIG_PCI.

>      if (!pbdev) {
>          DPRINTF("add_msi_route no dev\n");
>          return -ENODEV;
