Received: from eggs.gnu.org ([2001:4830:134:3::10]:58649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eik58-0000lF-Be
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eik55-0007BF-A2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:57:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eik55-00078x-57
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:57:23 -0500
References: <20180205061849.17696-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a824b3a1-632a-7089-a579-44b5d6fd0f85@redhat.com>
Date: Mon, 5 Feb 2018 17:57:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180205061849.17696-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: check dev parameter when updating msi
 route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Guoxiang Niu <niuguoxiang@huawei.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 05/02/2018 07:18, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When updating message signalled interrupt(MSI) route in routine
> kvm_irqchip_update_msi_route, device parameter could be null.
> Add check to avoid null dereference.
> 
> Reported-by: Guoxiang Niu <niuguoxiang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Please include the full backtrace.  On a machine that needs
KVM_MSI_VALID_DEVID, it should not be possible to associate MSIs with
non-PCI devices (dev should only be NULL for x86 with "-machine
kernel_irqchip=split", and x86 does not need KVM_MSI_VALID_DEVID).

Paolo

> ---
>  accel/kvm/kvm-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f487a5..cb7613d282 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1167,7 +1167,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>      kroute.u.msi.address_lo = (uint32_t)msg.address;
>      kroute.u.msi.address_hi = msg.address >> 32;
>      kroute.u.msi.data = le32_to_cpu(msg.data);
> -    if (pci_available && kvm_msi_devid_required()) {
> +    if (pci_available && dev && kvm_msi_devid_required()) {
>          kroute.flags = KVM_MSI_VALID_DEVID;
>          kroute.u.msi.devid = pci_requester_id(dev);
>      }
> @@ -1205,7 +1205,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
>      kroute.u.msi.address_lo = (uint32_t)msg.address;
>      kroute.u.msi.address_hi = msg.address >> 32;
>      kroute.u.msi.data = le32_to_cpu(msg.data);
> -    if (pci_available && kvm_msi_devid_required()) {
> +    if (pci_available && dev && kvm_msi_devid_required()) {
>          kroute.flags = KVM_MSI_VALID_DEVID;
>          kroute.u.msi.devid = pci_requester_id(dev);
>      }
> 
