Received: from eggs.gnu.org ([2001:4830:134:3::10]:55163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cstnW-0001vA-84
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cstnT-0002Xh-3B
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cstnS-0002Wc-T3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:16:39 -0400
Date: Tue, 28 Mar 2017 19:16:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170328191527-mutt-send-email-mst@kernel.org>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-2-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490260163-6157-2-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] pcie aer: verify if AER
 functionality is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Thu, Mar 23, 2017 at 05:09:21PM +0800, Cao jin wrote:
> For devices which support AER function, verify it can work or not in the
> system:
> 1. AER capable device is a PCIe device, it can't be plugged into PCI bus
> 2. If root port doesn't support AER, then there is no need to expose the
>    AER capability
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

The two configurations aren't very different. If you disable AER
automatically in (2) you should do so in (1) as well.


> ---
>  hw/pci/pcie_aer.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index daf1f65..a2e9818 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -100,6 +100,34 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
>  int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
>                    uint16_t size, Error **errp)
>  {
> +    PCIDevice *parent_dev;
> +    uint8_t type;
> +    uint8_t parent_type;
> +
> +    /* Topology test: see if there is need to expose AER cap */
> +    type = pcie_cap_get_type(dev);
> +    parent_dev = pci_bridge_get_device(dev->bus);
> +    while (parent_dev) {
> +        parent_type = pcie_cap_get_type(parent_dev);
> +
> +        if (type == PCI_EXP_TYPE_ENDPOINT &&
> +                (parent_type != PCI_EXP_TYPE_ROOT_PORT &&
> +                 parent_type != PCI_EXP_TYPE_DOWNSTREAM)) {
> +            error_setg(errp, "Parent device is not a PCIe component");
> +            return -ENOTSUP;
> +        }
> +        
> +        if (parent_type == PCI_EXP_TYPE_ROOT_PORT) {
> +            if (!parent_dev->exp.aer_cap)
> +            {
> +                error_setg(errp, "Root port does not support AER");
> +                return -ENOTSUP;
> +            }
> +        }
> +
> +        parent_dev = pci_bridge_get_device(parent_dev->bus);
> +    }
> +
>      pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, cap_ver,
>                          offset, size);
>      dev->exp.aer_cap = offset;
> -- 
> 1.8.3.1
> 
> 
