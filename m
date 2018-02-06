Received: from eggs.gnu.org ([2001:4830:134:3::10]:44156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iq-0005Pf-Q3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8im-00082e-2N
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38406
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8il-000824-RU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEIZE131022
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:59 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyfvm7066-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:59 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:58 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:55 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-35-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 34/54] spapr_pci: fix MSI/MSIX selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

In various place we don't correctly check if the device supports MSI or
MSI-X. This can cause devices to be advertised with MSI support, even
if they only support MSI-X (like virtio-pci-* devices for example):

                ethernet@0 {
                        ibm,req#msi =3D <0x1>; <--- wrong!
			.
			ibm,loc-code =3D "qemu_virtio-net-pci:0000:00:00.0";
			.
			ibm,req#msi-x =3D <0x3>;
                };

Worse, this can also cause the "ibm,change-msi" RTAS call to corrupt the
PCI status and cause migration to fail:

  qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x6
    read: 0 device: 10 cmask: 10 wmask: 0 w1cmask:0
                              ^^
           PCI_STATUS_CAP_LIST bit which is assumed to be constant

This patch changes spapr_populate_pci_child_dt() to properly check for
MSI support using msi_present(): this ensures that PCIDevice::msi_cap
was set by msi_init() and that msi_nr_vectors_allocated() will look at
the right place in the config space.

Checking PCIDevice::msix_entries_nr is enough for MSI-X but let's add
a call to msix_present() there as well for consistency.

It also changes rtas_ibm_change_msi() to select the appropriate MSI
type in Function 1 instead of always selecting plain MSI. This new
behaviour is compliant with LoPAPR 1.1, as described in "Table 71.
ibm,change-msi Argument Call Buffer":

  Function 1: If Number Outputs is equal to 3, request to set to a new
           number of MSIs (including set to 0).
           If the =E2=80=9Cibm,change-msix-capable=E2=80=9D property exis=
ts and Number
           Outputs is equal to 4, request is to set to a new number of
           MSI or MSI-X (platform choice) interrupts (including set to
           0).

Since MSI is the the platform default (LoPAPR 6.2.3 MSI Option), let's
check for MSI support first.

And finally, it checks the input parameters are valid, as described in
LoPAPR 1.1 "R1=E2=80=937.3.10.5.1=E2=80=933":

  For the MSI option: The platform must return a Status of -3 (Parameter
  error) from ibm,change-msi, with no change in interrupt assignments if
  the PCI configuration address does not support MSI and Function 3 was
  requested (that is, the =E2=80=9Cibm,req#msi=E2=80=9D property must exi=
st for the PCI
  configuration address in order to use Function 3), or does not support
  MSI-X and Function 4 is requested (that is, the =E2=80=9Cibm,req#msi-x=E2=
=80=9D property
  must exist for the PCI configuration address in order to use Function 4=
),
  or if neither MSIs nor MSI-Xs are supported and Function 1 is requested.

This ensures that the ret_intr_type variable contains a valid MSI type
for this device, and that spapr_msi_setmsg() won't corrupt the PCI status.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 9cbe305b60cc49cfcd134765b85c28be95b1b57d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_pci.c | 61 +++++++++++++++++++++++++++++++++++++-----------=
------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5a3122a9f9..a1929ab481 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -280,13 +280,42 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
     int *config_addr_key;
     Error *err =3D NULL;
=20
+    /* Fins sPAPRPHBState */
+    phb =3D spapr_pci_find_phb(spapr, buid);
+    if (phb) {
+        pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
+    }
+    if (!phb || !pdev) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
     switch (func) {
-    case RTAS_CHANGE_MSI_FN:
     case RTAS_CHANGE_FN:
-        ret_intr_type =3D RTAS_TYPE_MSI;
+        if (msi_present(pdev)) {
+            ret_intr_type =3D RTAS_TYPE_MSI;
+        } else if (msix_present(pdev)) {
+            ret_intr_type =3D RTAS_TYPE_MSIX;
+        } else {
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+            return;
+        }
+        break;
+    case RTAS_CHANGE_MSI_FN:
+        if (msi_present(pdev)) {
+            ret_intr_type =3D RTAS_TYPE_MSI;
+        } else {
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+            return;
+        }
         break;
     case RTAS_CHANGE_MSIX_FN:
-        ret_intr_type =3D RTAS_TYPE_MSIX;
+        if (msix_present(pdev)) {
+            ret_intr_type =3D RTAS_TYPE_MSIX;
+        } else {
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+            return;
+        }
         break;
     default:
         error_report("rtas_ibm_change_msi(%u) is not implemented", func)=
;
@@ -294,16 +323,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
         return;
     }
=20
-    /* Fins sPAPRPHBState */
-    phb =3D spapr_pci_find_phb(spapr, buid);
-    if (phb) {
-        pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
-    }
-    if (!phb || !pdev) {
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
     msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr=
);
=20
     /* Releasing MSIs */
@@ -1286,13 +1305,17 @@ static void spapr_populate_pci_child_dt(PCIDevice=
 *dev, void *fdt, int offset,
     _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
                           RESOURCE_CELLS_SIZE));
=20
-    max_msi =3D msi_nr_vectors_allocated(dev);
-    if (max_msi) {
-        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
+    if (msi_present(dev)) {
+        max_msi =3D msi_nr_vectors_allocated(dev);
+        if (max_msi) {
+            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
+        }
     }
-    max_msix =3D dev->msix_entries_nr;
-    if (max_msix) {
-        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix));
+    if (msix_present(dev)) {
+        max_msix =3D dev->msix_entries_nr;
+        if (max_msix) {
+            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix=
));
+        }
     }
=20
     populate_resource_props(dev, &rp);
--=20
2.11.0
