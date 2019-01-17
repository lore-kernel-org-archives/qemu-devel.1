Received: from eggs.gnu.org ([209.51.188.92]:37962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBHT-0003RF-3O
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBHS-00022U-5Q
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46854
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBHR-0001Xa-Ub
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHERnF019570
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:16:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2v6bwdr9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:16:20 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:16:18 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:16:11 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774537154.1208625.5549578310287539996.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 16/19] spapr: Expose the name of the
 interrupt controller node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

This will be needed by PHB hotplug in order to access the "phandle"
property of the interrupt controller node.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_spapr.c        |    2 +-
 include/hw/ppc/spapr_xive.h |    5 +++++
 include/hw/ppc/xics_spapr.h |    7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 375cb883c86d..ec50e21b8607 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -252,7 +252,7 @@ int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
     };
     int node;
 
-    _FDT(node = fdt_add_subnode(fdt, 0, "interrupt-controller"));
+    _FDT(node = fdt_add_subnode(fdt, 0, XICS_NODENAME));
 
     _FDT(fdt_setprop_string(fdt, node, "device_type",
                             "PowerPC-External-Interrupt-Presentation"));
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index deea34b03ee5..e769c2f9a018 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -51,4 +51,9 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
 
+static inline const char *spapr_xive_get_nodename(sPAPRXive *xive)
+{
+    return xive->nodename;
+}
+
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 9f51f8621f75..fd66cf7bbba3 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -29,6 +29,13 @@
 
 #include "hw/ppc/spapr.h"
 
+#define XICS_NODENAME "interrupt-controller"
+
+static inline const char *xics_spapr_get_nodename(void)
+{
+    return XICS_NODENAME;
+}
+
 int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
