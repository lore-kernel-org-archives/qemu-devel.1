Received: from eggs.gnu.org ([209.51.188.92]:37238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGP-0002aj-7C
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGI-000811-JY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60428
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBG7-0007gr-W6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHETeJ120033
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2v3uwdax-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:08 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:15:06 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:14:59 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774529913.1208625.7473971232891874613.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 05/19] spapr: Set irq type in a dedicated
 function
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

Prepare for that by moving the behaviour of setting the type from
spapr_irq_claim() to a separate spapr_irq_set_type() function. Have
all the callers of spapr_irq_claim() to also call the new function.

There's no such need of separating allocation and type setting for
MSIs, so this introduces a convenient spapr_irq_claim_msi() function
for MSI users.

Wire all this to the existing backends.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_events.c      |    4 +--
 hw/ppc/spapr_irq.c         |   59 ++++++++++++++++++++++++++++++++++++--------
 hw/ppc/spapr_pci.c         |    5 ++--
 hw/ppc/spapr_vio.c         |    2 +
 include/hw/ppc/spapr_irq.h |    7 ++++-
 5 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index b9c7ecb9e987..777a70842acc 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -713,7 +713,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
         epow_irq = spapr_irq_findone(spapr, &error_fatal);
     }
 
-    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+    spapr_irq_claim(spapr, epow_irq, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
 
@@ -737,7 +737,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
             hp_irq = spapr_irq_findone(spapr, &error_fatal);
         }
 
-        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+        spapr_irq_claim_msi(spapr, hp_irq, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
                                      hp_irq);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index bcd816c5a5fb..396dd09bdbe0 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -125,8 +125,7 @@ error:
     error_propagate(errp, local_err);
 }
 
-static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool lsi,
-                                Error **errp)
+static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, Error **errp)
 {
     ICSState *ics = spapr->ics;
 
@@ -142,11 +141,20 @@ static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool lsi,
         return -1;
     }
 
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
     ics_claim_irq(ics, irq - ics->offset);
     return 0;
 }
 
+static void spapr_irq_set_type_xics(sPAPRMachineState *spapr, int irq, bool lsi)
+{
+    ICSState *ics = spapr->ics;
+
+    assert(ics);
+    assert(ics_valid_irq(ics, irq));
+
+    ics_set_irq_type(ics, irq - ics->offset, lsi);
+}
+
 static void spapr_irq_free_xics(sPAPRMachineState *spapr, int irq, int num)
 {
     ICSState *ics = spapr->ics;
@@ -245,6 +253,7 @@ sPAPRIrq spapr_irq_xics = {
 
     .init        = spapr_irq_init_xics,
     .claim       = spapr_irq_claim_xics,
+    .set_type    = spapr_irq_set_type_xics,
     .free        = spapr_irq_free_xics,
     .qirq        = spapr_qirq_xics,
     .print_info  = spapr_irq_print_info_xics,
@@ -292,17 +301,20 @@ static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
     spapr_xive_hcall_init(spapr);
 }
 
-static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, bool lsi,
-                                Error **errp)
+static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, Error **errp)
 {
     if (!spapr_xive_irq_claim(spapr->xive, irq)) {
         error_setg(errp, "IRQ %d is invalid", irq);
         return -1;
     }
-    xive_source_irq_set(&spapr->xive->source, irq, lsi);
     return 0;
 }
 
+static void spapr_irq_set_type_xive(sPAPRMachineState *spapr, int irq, bool lsi)
+{
+    xive_source_irq_set(&spapr->xive->source, irq, lsi);
+}
+
 static void spapr_irq_free_xive(sPAPRMachineState *spapr, int irq, int num)
 {
     int i;
@@ -403,6 +415,7 @@ sPAPRIrq spapr_irq_xive = {
 
     .init        = spapr_irq_init_xive,
     .claim       = spapr_irq_claim_xive,
+    .set_type    = spapr_irq_set_type_xive,
     .free        = spapr_irq_free_xive,
     .qirq        = spapr_qirq_xive,
     .print_info  = spapr_irq_print_info_xive,
@@ -466,19 +479,19 @@ static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
     }
 }
 
-static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bool lsi,
+static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq,
                                 Error **errp)
 {
     Error *local_err = NULL;
     int ret;
 
-    ret = spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
+    ret = spapr_irq_xics.claim(spapr, irq, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return ret;
     }
 
-    ret = spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
+    ret = spapr_irq_xive.claim(spapr, irq, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return ret;
@@ -487,6 +500,12 @@ static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bool lsi,
     return ret;
 }
 
+static void spapr_irq_set_type_dual(sPAPRMachineState *spapr, int irq, bool lsi)
+{
+    spapr_irq_xics.set_type(spapr, irq, lsi);
+    spapr_irq_xive.set_type(spapr, irq, lsi);
+}
+
 static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, int num)
 {
     spapr_irq_xics.free(spapr, irq, num);
@@ -582,6 +601,7 @@ sPAPRIrq spapr_irq_dual = {
 
     .init        = spapr_irq_init_dual,
     .claim       = spapr_irq_claim_dual,
+    .set_type    = spapr_irq_set_type_dual,
     .free        = spapr_irq_free_dual,
     .qirq        = spapr_qirq_dual,
     .print_info  = spapr_irq_print_info_dual,
@@ -608,9 +628,25 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
                                       spapr->irq->nr_irqs);
 }
 
-int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp)
+int spapr_irq_claim(sPAPRMachineState *spapr, int irq, Error **errp)
+{
+    return spapr->irq->claim(spapr, irq, errp);
+}
+
+void spapr_irq_set_type(sPAPRMachineState *spapr, int irq, bool lsi)
 {
-    return spapr->irq->claim(spapr, irq, lsi, errp);
+    return spapr->irq->set_type(spapr, irq, lsi);
+}
+
+int spapr_irq_claim_msi(sPAPRMachineState *spapr, int irq, Error **errp)
+{
+    int ret = spapr_irq_claim(spapr, irq, errp);
+
+    if (!ret) {
+        spapr_irq_set_type(spapr, irq, false);
+    }
+
+    return ret;
 }
 
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
@@ -699,6 +735,7 @@ sPAPRIrq spapr_irq_xics_legacy = {
 
     .init        = spapr_irq_init_xics,
     .claim       = spapr_irq_claim_xics,
+    .set_type    = spapr_irq_set_type_xics,
     .free        = spapr_irq_free_xics,
     .qirq        = spapr_qirq_xics,
     .print_info  = spapr_irq_print_info_xics,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ccdaf2c9a606..ec9d4d28004c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -391,7 +391,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     }
 
     for (i = 0; i < req_num; i++) {
-        spapr_irq_claim(spapr, irq + i, false, &err);
+        spapr_irq_claim_msi(spapr, irq + i, &err);
         if (err) {
             error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                               config_addr);
@@ -1738,11 +1738,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
             }
         }
 
-        spapr_irq_claim(spapr, irq, true, &local_err);
+        spapr_irq_claim(spapr, irq, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
             return;
         }
+        spapr_irq_set_type(spapr, irq, true);
 
         sphb->lsi_table[i].irq = irq;
     }
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index f80b70a39c46..9ae4351d4414 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -546,7 +546,7 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    spapr_irq_claim(spapr, dev->irq, false, &local_err);
+    spapr_irq_claim_msi(spapr, dev->irq, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 14b02c3aca33..42b325eb51ba 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -36,7 +36,8 @@ typedef struct sPAPRIrq {
     uint8_t     ov5;
 
     void (*init)(sPAPRMachineState *spapr, Error **errp);
-    int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp);
+    int (*claim)(sPAPRMachineState *spapr, int irq, Error **errp);
+    void (*set_type)(sPAPRMachineState *spapr, int irq, bool lsi);
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
@@ -55,7 +56,9 @@ extern sPAPRIrq spapr_irq_xive;
 extern sPAPRIrq spapr_irq_dual;
 
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
-int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp);
+int spapr_irq_claim(sPAPRMachineState *spapr, int irq, Error **errp);
+void spapr_irq_set_type(sPAPRMachineState *spapr, int irq, bool lsi);
+int spapr_irq_claim_msi(sPAPRMachineState *spapr, int irq, Error **errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
