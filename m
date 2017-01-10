Received: from eggs.gnu.org ([2001:4830:134:3::10]:41933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQn5w-00085D-EL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQn5s-0007C6-H0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:27:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQn5s-0007BE-8c
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:27:28 -0500
Date: Tue, 10 Jan 2017 05:27:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110052640-mutt-send-email-mst@kernel.org>
References: <1482308491-25426-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1482308491-25426-3-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482308491-25426-3-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] pcie_aer: support configurable AER
 capa version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, dmitry@daynix.com, jasowang@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Wed, Dec 21, 2016 at 04:21:31PM +0800, Cao jin wrote:
> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
> Now, AER capa version is fixed to v2, if assigned device isn't v2,
> then this value will be inconsistent between guest and host
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I assume this is good for AER work so I'll merge this,
but these patches don't do anything by themselves
in the future pls make this explicit in commit log.

> ---
>  hw/net/e1000e.c                    | 3 ++-
>  hw/pci-bridge/ioh3420.c            | 3 ++-
>  hw/pci-bridge/xio3130_downstream.c | 3 ++-
>  hw/pci-bridge/xio3130_upstream.c   | 3 ++-
>  hw/pci/pcie_aer.c                  | 6 +++---
>  include/hw/pci/pcie_aer.h          | 4 ++--
>  6 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 89f96eb4a076..77a4b3e5bf9d 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -472,7 +472,8 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
>          hw_error("Failed to initialize PM capability");
>      }
>  
> -    if (pcie_aer_init(pci_dev, e1000e_aer_offset, PCI_ERR_SIZEOF, NULL) < 0) {
> +    if (pcie_aer_init(pci_dev, PCI_ERR_VER, e1000e_aer_offset,
> +                      PCI_ERR_SIZEOF, NULL) < 0) {
>          hw_error("Failed to initialize AER capability");
>      }
>  
> diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
> index 04180af79471..84b7946c3136 100644
> --- a/hw/pci-bridge/ioh3420.c
> +++ b/hw/pci-bridge/ioh3420.c
> @@ -135,7 +135,8 @@ static int ioh3420_initfn(PCIDevice *d)
>          goto err_pcie_cap;
>      }
>  
> -    rc = pcie_aer_init(d, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF, &err);
> +    rc = pcie_aer_init(d, PCI_ERR_VER, IOH_EP_AER_OFFSET,
> +                       PCI_ERR_SIZEOF, &err);
>      if (rc < 0) {
>          error_report_err(err);
>          goto err;
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 571334185b42..04b8e5b8479e 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -97,7 +97,8 @@ static int xio3130_downstream_initfn(PCIDevice *d)
>          goto err_pcie_cap;
>      }
>  
> -    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF, &err);
> +    rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
> +                       PCI_ERR_SIZEOF, &err);
>      if (rc < 0) {
>          error_report_err(err);
>          goto err;
> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> index 94c16910069e..d1f59c883477 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -85,7 +85,8 @@ static int xio3130_upstream_initfn(PCIDevice *d)
>      pcie_cap_flr_init(d);
>      pcie_cap_deverr_init(d);
>  
> -    rc = pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF, &err);
> +    rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
> +                       PCI_ERR_SIZEOF, &err);
>      if (rc < 0) {
>          error_report_err(err);
>          goto err;
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 2a4bd5aef639..daf1f65427c2 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -97,10 +97,10 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
>      aer_log->log_num = 0;
>  }
>  
> -int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size,
> -                  Error **errp)
> +int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
> +                  uint16_t size, Error **errp)
>  {
> -    pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, PCI_ERR_VER,
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, cap_ver,
>                          offset, size);
>      dev->exp.aer_cap = offset;
>  
> diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
> index 5891b6816e85..526802bd312b 100644
> --- a/include/hw/pci/pcie_aer.h
> +++ b/include/hw/pci/pcie_aer.h
> @@ -86,8 +86,8 @@ struct PCIEAERErr {
>  
>  extern const VMStateDescription vmstate_pcie_aer_log;
>  
> -int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size,
> -                  Error **errp);
> +int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
> +                  uint16_t size, Error **errp);
>  void pcie_aer_exit(PCIDevice *dev);
>  void pcie_aer_write_config(PCIDevice *dev,
>                             uint32_t addr, uint32_t val, int len);
> -- 
> 2.1.0
> 
> 
