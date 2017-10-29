Received: from eggs.gnu.org ([2001:4830:134:3::10]:35755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s5N-000599-J5
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s5K-00065Y-Cd
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:25 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:54277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e8s5K-000649-6w
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:22 -0400
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D9DB4637BF
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:13:20 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun, 29 Oct 2017 19:12:16 +0100
Message-Id: <20171029181217.9927-8-clg@kaod.org>
In-Reply-To: <20171029181217.9927-1-clg@kaod.org>
References: <20171029181217.9927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/8] spapr: move spapr_ics_free() under
 irq_free_block() operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

So we can now use bitmap_clear() which is slightly more efficent but
more important, it removes the usage of ics_valid_irq() which has a
reference to the 'ics' object of the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/trace-events |  2 --
 hw/intc/xics_spapr.c | 19 ++-----------------
 hw/ppc/spapr.c       | 11 ++++++++++-
 hw/ppc/trace-events  |  2 ++
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index b86f242b0fcf..e34ecf7a16e5 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -65,8 +65,6 @@ xics_ics_simple_reject(int nr, int srcno) "reject irq 0=
x%x [src %d]"
 xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
 xics_alloc(int irq) "irq %d"
 xics_alloc_block(int first, int num, bool lsi, int align) "first irq %d,=
 %d irqs, lsi=3D%d, alignnum %d"
-xics_ics_free(int src, int irq, int num) "Source#%d, first irq %d, %d ir=
qs"
-xics_ics_free_warn(int src, int irq) "Source#%d, irq %d is already free"
=20
 # hw/intc/s390_flic_kvm.c
 flic_create_device(int err) "flic: create device failed %d"
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 23d81ff83182..4ba23fe5125b 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -304,25 +304,10 @@ int spapr_ics_alloc_block(ICSState *ics, int num, b=
ool lsi,
     return first;
 }
=20
-static void ics_free(ICSState *ics, int irq, int num)
-{
-    int i;
-    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
-
-    for (i =3D irq; i < irq + num; ++i) {
-        if (xic->irq_test(ics->xics, i)) {
-            trace_xics_ics_free_warn(0, i);
-        }
-        xic->irq_free_block(ics->xics, i, 1);
-    }
-}
-
 void spapr_ics_free(ICSState *ics, int irq, int num)
 {
-    if (ics_valid_irq(ics, irq)) {
-        trace_xics_ics_free(0, irq, num);
-        ics_free(ics, irq, num);
-    }
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
+    xic->irq_free_block(ics->xics, irq, num);
 }
=20
 void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 557d89d9ecb5..f8224ea3e894 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3629,8 +3629,17 @@ static void spapr_irq_free_block(XICSFabric *xi, i=
nt irq, int num)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     int srcno =3D irq - spapr->irq_base;
+    int i;
=20
-    bitmap_clear(spapr->irq_map, srcno, num);
+    if (srcno >=3D 0 && srcno < spapr->nr_irqs) {
+        trace_spapr_irq_free(0, irq, num);
+        for (i =3D srcno; i < srcno + num; ++i) {
+            if (!test_bit(i, spapr->irq_map)) {
+                trace_spapr_irq_free_warn(0, i);
+            }
+        }
+        bitmap_clear(spapr->irq_map, srcno, num);
+    }
 }
=20
 static bool spapr_irq_is_lsi(XICSFabric *xi, int irq)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 4a6a6490fa78..dc9ab4c4deb3 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -12,6 +12,8 @@ spapr_pci_msi_retry(unsigned config_addr, unsigned req_=
num, unsigned max_irqs) "
 # hw/ppc/spapr.c
 spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld byte=
s"
 spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld byte=
s"
+spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d i=
rqs"
+spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already free=
"
=20
 # hw/ppc/spapr_hcall.c
 spapr_cas_pvr_try(uint32_t pvr) "0x%x"
--=20
2.13.6
