Received: from eggs.gnu.org ([209.51.188.92]:37118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBG2-0002FS-1Y
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFy-0007b7-Eh
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBFw-0007Vx-IJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHEZWw017372
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2tgmtdm6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:03 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:15:00 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:14:52 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774529254.1208625.8569916891242988294.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 04/19] spapr/xive: Don't set irq type in
 spapr_xive_irq_claim()
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

PHB hotplug will need to set the type of all LSIs at machine init.
Prepare for that by calling xive_source_irq_set() in the callers
of spapr_xive_irq_claim().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |    5 +----
 hw/ppc/spapr_irq.c          |    6 ++++--
 include/hw/ppc/spapr_xive.h |    2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d391177ab81f..aab63cfd1178 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -471,16 +471,13 @@ static void spapr_xive_register_types(void)
 
 type_init(spapr_xive_register_types)
 
-bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi)
+bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn)
 {
-    XiveSource *xsrc = &xive->source;
-
     if (lisn >= xive->nr_irqs) {
         return false;
     }
 
     xive->eat[lisn].w |= cpu_to_be64(EAS_VALID);
-    xive_source_irq_set(xsrc, lisn, lsi);
     return true;
 }
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 86c712d15382..bcd816c5a5fb 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -285,7 +285,8 @@ static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
 
     /* Enable the CPU IPIs */
     for (i = 0; i < nr_servers; ++i) {
-        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
+        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i);
+        xive_source_irq_set(&spapr->xive->source, SPAPR_IRQ_IPI + i, false);
     }
 
     spapr_xive_hcall_init(spapr);
@@ -294,10 +295,11 @@ static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
 static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, bool lsi,
                                 Error **errp)
 {
-    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
+    if (!spapr_xive_irq_claim(spapr->xive, irq)) {
         error_setg(errp, "IRQ %d is invalid", irq);
         return -1;
     }
+    xive_source_irq_set(&spapr->xive->source, irq, lsi);
     return 0;
 }
 
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7fdc25057420..f8854a4a6a18 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -37,7 +37,7 @@ typedef struct sPAPRXive {
     MemoryRegion  tm_mmio;
 } sPAPRXive;
 
-bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
+bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 
