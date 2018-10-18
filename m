Received: from eggs.gnu.org ([2001:4830:134:3::10]:53470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gD3a2-0001K4-PD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gD3Zy-00053S-Rd
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:22:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:65357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gD3Zy-0004qF-CY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:22:50 -0400
From: "Zhao, Yan Y" <yan.y.zhao@intel.com>
Date: Thu, 18 Oct 2018 08:22:41 +0000
Message-ID: <F22B14EC3CFBB843AD3E03B6B78F2C6A4ACFD80C@SHSMSX104.ccr.corp.intel.com>
References: <20181016021439.6212-1-yan.y.zhao@intel.com>
In-Reply-To: <20181016021439.6212-1-yan.y.zhao@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Xen PCI passthrough: fix passthrough
 failure when irq map failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

Hi
The background for this patch is that: for some pci device, even it's PCI_I=
NTERRUPT_PIN is not 0, it actually does not support INTx mode, so we should=
 just report error, disable INTx mode and continue the passthrough.
However, the commit 5a11d0f7 regards this as error condition and let qemu q=
uit passthrough, which is too rigorous.

Error message is below:
libxl: error: libxl_qmp.c:287:qmp_handle_error_response: Domain 2:received =
an error message from QMP server: Mapping machine irq 0 to pirq -1 failed: =
Operation not permitted
libxl: error: libxl_pci.c:1306:libxl__add_pcidevs: Domain 2:libxl_device_pc=
i_add failed: -3
libxl: error: libxl_create.c:1458:domcreate_attach_devices: Domain 2:unable=
 to add pci devices
libxl: error: libxl_domain.c:1003:libxl__destroy_domid: Domain  2:Non-exist=
ant domain
libxl: error: libxl_domain.c:962:domain_destroy_callback: Domain  2:Unable =
to destroy guest
libxl: error: libxl_domain.c:889:domain_destroy_cb: Domain 2:Destruction of=
 domain failed

After partially revert 5a11d0f7, the device can be passed through into domU=
 and running quite well using msi mode.

> -----Original Message-----
> From: Zhao, Yan Y
> Sent: Tuesday, October 16, 2018 10:15 AM
> To: qemu-devel@nongnu.org; sstabellini@kernel.org;
> anthony.perard@citrix.com; xen-devel@lists.xenproject.org
> Cc: Zhao, Yan Y <yan.y.zhao@intel.com>
> Subject: [PATCH] Xen PCI passthrough: fix passthrough failure when irq ma=
p
> failure
>=20
> Commit 5a11d0f7 mistakenly converted a log message into an error conditio=
n
> when irq map is failed for the pci device being passed through. Revert th=
at part
> of the commit.
>=20
> Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
> ---
>  hw/xen/xen_pt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c index e5a6eff44f..840fd0f7=
48
> 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -849,7 +849,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp=
)
>      machine_irq =3D s->real_device.irq;
>      rc =3D xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
>      if (rc < 0) {
> -        error_setg_errno(errp, errno, "Mapping machine irq %u to"
> +        XEN_PT_ERR(d, "Mapping machine irq %u to"
>                           " pirq %i failed", machine_irq, pirq);
>=20
>          /* Disable PCI intx assertion (turn on bit10 of devctl) */ @@ -8=
71,7 +871,7
> @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
>                                         PCI_SLOT(d->devfn),
>                                         e_intx);
>          if (rc < 0) {
> -            error_setg_errno(errp, errno, "Binding of interrupt %u faile=
d",
> +            XEN_PT_ERR(d, "Binding of interrupt %u failed",
>                               e_intx);
>=20
>              /* Disable PCI intx assertion (turn on bit10 of devctl) */
> --
> 2.17.1
