Received: from eggs.gnu.org ([2001:4830:134:3::10]:43751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dp9Eo-0000PU-4A
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dp9Ej-0006zm-Bk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dp9Ej-0006zB-2q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:29:33 -0400
Date: Tue, 5 Sep 2017 10:29:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905102928.6b23a28a.cohuck@redhat.com>
In-Reply-To: <1504239778-29893-2-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1504239778-29893-2-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/pci: remove idx from msix msg
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

On Fri,  1 Sep 2017 06:22:56 +0200
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> PCIDevice pointer has been a parameter of kvm_arch_fixup_msi_route().
> So we don't need to store zpci idx in msix message data to find out the
> specific zpci device. Instead, we could use pci device id to find its
> corresponding zpci device.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 16 +++++-----------
>  hw/s390x/s390-pci-bus.h  |  2 ++
>  hw/s390x/s390-pci-inst.c | 24 ------------------------
>  hw/s390x/s390-pci-stub.c |  6 ++++++
>  target/s390x/kvm.c       |  7 +++++--
>  5 files changed, 18 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 0a31a4ae88..bd8a3e1e1c 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -199,8 +199,8 @@ static S390PCIBusDevice *s390_pci_find_dev_by_uid(S390pciState *s, uint16_t uid)
>      return NULL;
>  }
>  
> -static S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
> -                                                     const char *target)
> +S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
> +                                              const char *target)
>  {
>      S390PCIBusDevice *pbdev;
>  
> @@ -465,19 +465,13 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
>                                  unsigned int size)
>  {
>      S390PCIBusDevice *pbdev = opaque;
> -    uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
>      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
>      uint64_t ind_bit;
>      uint32_t sum_bit;
> -    uint32_t e = 0;
>  
> -    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data, idx, vec);
> -
> -    if (!pbdev) {
> -        e |= (vec << ERR_EVENT_MVN_OFFSET);
> -        s390_pci_generate_error_event(ERR_EVENT_NOMSI, idx, 0, addr, e);
> -        return;
> -    }
> +    assert(pbdev);

I'm wondering whether you could/should generate an error event here.
The one above probably won't work (as it seems to take idx as a
parameter), but is this really 'this must not happen, we messed up in
our code'? (Probably yes, but I want to be sure.)

> +    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data,
> +            pbdev->idx, vec);
>  
>      if (pbdev->state != ZPCI_FS_ENABLED) {
>          return;

> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
> index 7a642d376c..e501e1b9ea 100644
> --- a/hw/s390x/s390-pci-stub.c
> +++ b/hw/s390x/s390-pci-stub.c
> @@ -74,3 +74,9 @@ S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
>  {
>      return NULL;
>  }

Please remove s390_pci_find_dev_by_idx() from the stubs file, as it is
not used outside of the conditionally-built pci code anymore.

> +
> +S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
> +                                              const char *target)
> +{
> +    return NULL;
> +}
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 1338c29528..3d490c5e4b 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2533,10 +2533,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
>      S390PCIBusDevice *pbdev;
> -    uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
>      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
>  
> -    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> +    if (!dev) {
> +        return -ENODEV;

Can this actually happen?

> +    }
> +
> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(dev)->id);
>      if (!pbdev) {
>          DPRINTF("add_msi_route no dev\n");
>          return -ENODEV;
