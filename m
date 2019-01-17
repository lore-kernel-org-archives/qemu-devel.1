Received: from eggs.gnu.org ([209.51.188.92]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBHS-0003RC-Oq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBHR-00021z-TS
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49782
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBHM-0001R3-JQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHEP8L010482
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:16:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2um6y5ck-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:16:14 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:16:12 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:16:05 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774536496.1208625.12823909967079119637.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 15/19] spapr_xive: Cache device tree
 nodename in sPAPRXive
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

PHB hotplug will need to know the name of the XIVE controller node. Since
it is an invariant for the machine lifetime, compute it at realize and
store it under the sPAPRXive structure.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |    9 ++++-----
 include/hw/ppc/spapr_xive.h |    3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e542ae59d7fd..9732c3d89c77 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -316,6 +316,9 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     /* Map all regions */
     spapr_xive_map_mmio(xive);
 
+    xive->nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
+                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
+
     qemu_register_reset(spapr_xive_reset, dev);
 }
 
@@ -1436,7 +1439,6 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
         cpu_to_be32(7),    /* start */
         cpu_to_be32(0xf8), /* count */
     };
-    gchar *nodename;
 
     /*
      * The "ibm,plat-res-int-priorities" property defines the priority
@@ -1453,10 +1455,7 @@ int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
                            XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
     timas[3] = cpu_to_be64(1ull << TM_SHIFT);
 
-    nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
-                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
-    _FDT(node = fdt_add_subnode(fdt, 0, nodename));
-    g_free(nodename);
+    _FDT(node = fdt_add_subnode(fdt, 0, xive->nodename));
 
     _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
     _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 29dafead9ba0..deea34b03ee5 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -26,6 +26,9 @@ typedef struct sPAPRXive {
     XiveENDSource end_source;
     hwaddr        end_base;
 
+    /* DT */
+    gchar *nodename;
+
     /* Routing table */
     XiveEAS       *eat;
     uint32_t      nr_irqs;
