Received: from eggs.gnu.org ([2001:4830:134:3::10]:51986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1ehh8H-0006Hl-Tv
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1ehh8D-0007ak-Vz
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1ehh8D-0007Uh-PV
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:36:17 -0500
Date: Fri, 2 Feb 2018 20:35:59 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20180202193559.GC660@flask>
References: <20180202045153.1916-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202045153.1916-1-ppandit@redhat.com>
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
To: P J P <ppandit@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Guoxiang Niu <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org

This should primarily go to the qemu devel list.  I've Cc'd it, but
reposting would be safer, thanks.


2018-02-02 10:21+0530, P J P:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When updating message signalled interrupt(MSI) route in routine
> kvm_irqchip_update_msi_route, device parameter could be null.
> Add check to avoid null dereference.
> 
> Reported-by: Guoxiang Niu <niuguoxiang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
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
> -- 
> 2.14.3
> 
