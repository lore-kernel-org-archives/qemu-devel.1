Received: from eggs.gnu.org ([2001:4830:134:3::10]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cK4rO-0007mv-5G
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cK4rK-0006S1-MJ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:00:46 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:33729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cK4rK-0006RW-2r
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:00:42 -0500
Received: by mail-wj0-x241.google.com with SMTP id kp2so36619089wjc.0
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 07:00:41 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <1482308491-25426-2-git-send-email-caoj.fnst@cn.fujitsu.com>
Date: Thu, 22 Dec 2016 17:00:38 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B38E649-282F-4FAB-9B4B-C754B6F8ABED@daynix.com>
References: <1482308491-25426-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1482308491-25426-2-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] pcie_aer: Convert pcie_aer_init to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com, jasowang@redhat.com


Acked-by: Dmitry Fleytman <dmitry@daynix.com>

> On 21 Dec 2016, at 10:21 AM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>=20
> When user specify invalid value for property aer_log_max, device =
should
> fail to create, and report appropriate message.
>=20
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Acked-by: Dmitry Fleytman <dmitry@daynix.com>
> ---
> hw/net/e1000e.c                    |  2 +-
> hw/pci-bridge/ioh3420.c            |  3 ++-
> hw/pci-bridge/xio3130_downstream.c |  3 ++-
> hw/pci-bridge/xio3130_upstream.c   |  3 ++-
> hw/pci/pcie_aer.c                  | 17 +++++++----------
> include/hw/pci/pcie_aer.h          |  4 ++--
> 6 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 4994e1ca0062..89f96eb4a076 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -472,7 +472,7 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, =
Error **errp)
>         hw_error("Failed to initialize PM capability");
>     }
>=20
> -    if (pcie_aer_init(pci_dev, e1000e_aer_offset, PCI_ERR_SIZEOF) < =
0) {
> +    if (pcie_aer_init(pci_dev, e1000e_aer_offset, PCI_ERR_SIZEOF, =
NULL) < 0) {
>         hw_error("Failed to initialize AER capability");
>     }
>=20
> diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
> index c8b5ac4207c5..04180af79471 100644
> --- a/hw/pci-bridge/ioh3420.c
> +++ b/hw/pci-bridge/ioh3420.c
> @@ -135,8 +135,9 @@ static int ioh3420_initfn(PCIDevice *d)
>         goto err_pcie_cap;
>     }
>=20
> -    rc =3D pcie_aer_init(d, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF);
> +    rc =3D pcie_aer_init(d, IOH_EP_AER_OFFSET, PCI_ERR_SIZEOF, &err);
>     if (rc < 0) {
> +        error_report_err(err);
>         goto err;
>     }
>     pcie_aer_root_init(d);
> diff --git a/hw/pci-bridge/xio3130_downstream.c =
b/hw/pci-bridge/xio3130_downstream.c
> index cef6e1325ebf..571334185b42 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -97,8 +97,9 @@ static int xio3130_downstream_initfn(PCIDevice *d)
>         goto err_pcie_cap;
>     }
>=20
> -    rc =3D pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
> +    rc =3D pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF, =
&err);
>     if (rc < 0) {
> +        error_report_err(err);
>         goto err;
>     }
>=20
> diff --git a/hw/pci-bridge/xio3130_upstream.c =
b/hw/pci-bridge/xio3130_upstream.c
> index 4ad0440aa164..94c16910069e 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -85,8 +85,9 @@ static int xio3130_upstream_initfn(PCIDevice *d)
>     pcie_cap_flr_init(d);
>     pcie_cap_deverr_init(d);
>=20
> -    rc =3D pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF);
> +    rc =3D pcie_aer_init(d, XIO3130_AER_OFFSET, PCI_ERR_SIZEOF, =
&err);
>     if (rc < 0) {
> +        error_report_err(err);
>         goto err;
>     }
>=20
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 048ce6a42455..2a4bd5aef639 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -29,6 +29,7 @@
> #include "hw/pci/msi.h"
> #include "hw/pci/pci_bus.h"
> #include "hw/pci/pcie_regs.h"
> +#include "qapi/error.h"
>=20
> //#define DEBUG_PCIE
> #ifdef DEBUG_PCIE
> @@ -96,21 +97,17 @@ static void aer_log_clear_all_err(PCIEAERLog =
*aer_log)
>     aer_log->log_num =3D 0;
> }
>=20
> -int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size)
> +int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size,
> +                  Error **errp)
> {
> -    PCIExpressDevice *exp;
> -
>     pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, PCI_ERR_VER,
>                         offset, size);
> -    exp =3D &dev->exp;
> -    exp->aer_cap =3D offset;
> +    dev->exp.aer_cap =3D offset;
>=20
> -    /* log_max is property */
> -    if (dev->exp.aer_log.log_max =3D=3D PCIE_AER_LOG_MAX_UNSET) {
> -        dev->exp.aer_log.log_max =3D PCIE_AER_LOG_MAX_DEFAULT;
> -    }
> -    /* clip down the value to avoid unreasobale memory usage */
> +    /* clip down the value to avoid unreasonable memory usage */
>     if (dev->exp.aer_log.log_max > PCIE_AER_LOG_MAX_LIMIT) {
> +        error_setg(errp, "Invalid aer_log_max %d. The max number of =
aer log "
> +                "is %d", dev->exp.aer_log.log_max, =
PCIE_AER_LOG_MAX_LIMIT);
>         return -EINVAL;
>     }
>     dev->exp.aer_log.log =3D g_malloc0(sizeof dev->exp.aer_log.log[0] =
*
> diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
> index c2ee4e2bdbfc..5891b6816e85 100644
> --- a/include/hw/pci/pcie_aer.h
> +++ b/include/hw/pci/pcie_aer.h
> @@ -44,7 +44,6 @@ struct PCIEAERLog {
>      */
> #define PCIE_AER_LOG_MAX_DEFAULT        8
> #define PCIE_AER_LOG_MAX_LIMIT          128
> -#define PCIE_AER_LOG_MAX_UNSET          0xffff
>     uint16_t log_max;
>=20
>     /* Error log. log_max-sized array */
> @@ -87,7 +86,8 @@ struct PCIEAERErr {
>=20
> extern const VMStateDescription vmstate_pcie_aer_log;
>=20
> -int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size);
> +int pcie_aer_init(PCIDevice *dev, uint16_t offset, uint16_t size,
> +                  Error **errp);
> void pcie_aer_exit(PCIDevice *dev);
> void pcie_aer_write_config(PCIDevice *dev,
>                            uint32_t addr, uint32_t val, int len);
> --=20
> 2.1.0
>=20
>=20
>=20
