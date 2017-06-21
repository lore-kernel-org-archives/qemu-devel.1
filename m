Received: from eggs.gnu.org ([2001:4830:134:3::10]:52724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dNadG-0004DU-Sc
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dNadD-0000nu-M1
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dNadD-0000ng-CL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:04:55 -0400
References: <cover.1497957189.git.maozy.fnst@cn.fujitsu.com>
	<37b8b2b9120a2d406eae6764c1554272d5fbcfb5.1497957189.git.maozy.fnst@cn.fujitsu.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <51ac9d8b-64df-3c4e-9f30-2333f4e834c2@redhat.com>
Date: Wed, 21 Jun 2017 11:04:45 +0300
MIME-Version: 1.0
In-Reply-To: <37b8b2b9120a2d406eae6764c1554272d5fbcfb5.1497957189.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 9/9] i386/kvm/pci-assign: Use errp
 directly rather than local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com

On 20/06/2017 14:57, Mao Zhongyi wrote:
> In assigned_device_pci_cap_init(), first, error messages are filled
> to a local_err variable, then through error_propagate() pass to
> the parameter of errp. It leads to cumbersome code. In order to
> avoid the extra local_err and error_propagate(), drop it and use
> errp instead.
> 
> Cc: pbonzini@redhat.com
> Cc: rth@twiddle.net
> Cc: ehabkost@redhat.com
> Cc: mst@redhat.com
> Cc: armbru@redhat.com
> Cc: marcel@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   hw/i386/kvm/pci-assign.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
> index b7fdb47..9f2615c 100644
> --- a/hw/i386/kvm/pci-assign.c
> +++ b/hw/i386/kvm/pci-assign.c
> @@ -1232,7 +1232,6 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>       AssignedDevice *dev = PCI_ASSIGN(pci_dev);
>       PCIRegion *pci_region = dev->real_device.regions;
>       int ret, pos;
> -    Error *local_err = NULL;
>   
>       /* Clear initial capabilities pointer and status copied from hw */
>       pci_set_byte(pci_dev->config + PCI_CAPABILITY_LIST, 0);
> @@ -1251,9 +1250,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>           dev->cap.available |= ASSIGNED_DEVICE_CAP_MSI;
>           /* Only 32-bit/no-mask currently supported */
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_MSI, pos, 10,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>           pci_dev->msi_cap = pos;
> @@ -1283,9 +1281,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>           dev->dev.cap_present |= QEMU_PCI_CAP_MSIX;
>           dev->cap.available |= ASSIGNED_DEVICE_CAP_MSIX;
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_MSIX, pos, 12,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>           pci_dev->msix_cap = pos;
> @@ -1313,9 +1310,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>           uint16_t pmc;
>   
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_PM, pos, PCI_PM_SIZEOF,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>   
> @@ -1381,9 +1377,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>           }
>   
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_EXP, pos, size,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>   
> @@ -1457,9 +1452,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>   
>           /* Only expose the minimum, 8 byte capability */
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_PCIX, pos, 8,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>   
> @@ -1485,9 +1479,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>       if (pos) {
>           /* Direct R/W passthrough */
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_VPD, pos, 8,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>   
> @@ -1503,9 +1496,8 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>           uint8_t len = pci_get_byte(pci_dev->config + pos + PCI_CAP_FLAGS);
>           /* Direct R/W passthrough */
>           ret = pci_add_capability(pci_dev, PCI_CAP_ID_VNDR, pos, len,
> -                                  &local_err);
> +                                  errp);
>           if (ret < 0) {
> -            error_propagate(errp, local_err);
>               return ret;
>           }
>   
> 


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
