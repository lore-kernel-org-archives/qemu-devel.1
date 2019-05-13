Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D8C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328942146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328942146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6oO-0006sz-BM
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:59:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6nA-0006PK-6H
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6YW-00044d-Nd
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:43:34 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:44265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6YW-000448-Fq
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:43:32 -0400
Received: from player778.ha.ovh.net (unknown [10.109.143.72])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1F3F055227
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:43:31 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 668C859C3DDA;
	Mon, 13 May 2019 08:43:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:36 +0200
Message-Id: <20190513084245.25755-6-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3329004550225431526
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
Subject: [Qemu-devel] [PATCH v4 05/14] spapr/xive: introduce a VM state
 change handler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This handler is in charge of stabilizing the flow of event notifications
in the XIVE controller before migrating a guest. This is a requirement
before transferring the guest EQ pages to a destination.

When the VM is stopped, the handler sets the source PQs to PENDING to
stop the flow of events and to possibly catch a triggered interrupt
occuring while the VM is stopped. Their previous state is saved. The
XIVE controller is then synced through KVM to flush any in-flight
event notification and to stabilize the EQs. At this stage, the EQ
pages are marked dirty to make sure the EQ pages are transferred if a
migration sequence is in progress.

The previous configuration of the sources is restored when the VM
resumes, after a migration or a stop. If an interrupt was queued while
the VM was stopped, the handler simply generates the missing trigger.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive_kvm.c    | 96 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7e49badd8c9a..734662c12a10 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -42,6 +42,7 @@ typedef struct SpaprXive {
     /* KVM support */
     int           fd;
     void          *tm_mmap;
+    VMChangeStateEntry *change;
 } SpaprXive;
=20
 /*
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 8dd4f96e0b97..735577a6f816 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -433,9 +433,100 @@ static void kvmppc_xive_get_queues(SpaprXive *xive,=
 Error **errp)
     }
 }
=20
+/*
+ * The primary goal of the XIVE VM change handler is to mark the EQ
+ * pages dirty when all XIVE event notifications have stopped.
+ *
+ * Whenever the VM is stopped, the VM change handler sets the source
+ * PQs to PENDING to stop the flow of events and to possibly catch a
+ * triggered interrupt occuring while the VM is stopped. The previous
+ * state is saved in anticipation of a migration. The XIVE controller
+ * is then synced through KVM to flush any in-flight event
+ * notification and stabilize the EQs.
+ *
+ * At this stage, we can mark the EQ page dirty and let a migration
+ * sequence transfer the EQ pages to the destination, which is done
+ * just after the stop state.
+ *
+ * The previous configuration of the sources is restored when the VM
+ * runs again. If an interrupt was queued while the VM was stopped,
+ * simply generate a trigger.
+ */
+static void kvmppc_xive_change_state_handler(void *opaque, int running,
+                                             RunState state)
+{
+    SpaprXive *xive =3D opaque;
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    /*
+     * Restore the sources to their initial state. This is called when
+     * the VM resumes after a stop or a migration.
+     */
+    if (running) {
+        for (i =3D 0; i < xsrc->nr_irqs; i++) {
+            uint8_t pq =3D xive_source_esb_get(xsrc, i);
+            uint8_t old_pq;
+
+            old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
+
+            /*
+             * An interrupt was queued while the VM was stopped,
+             * generate a trigger.
+             */
+            if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QUEUE=
D) {
+                xive_esb_trigger(xsrc, i);
+            }
+        }
+
+        return;
+    }
+
+    /*
+     * Mask the sources, to stop the flow of event notifications, and
+     * save the PQs locally in the XiveSource object. The XiveSource
+     * state will be collected later on by its vmstate handler if a
+     * migration is in progress.
+     */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
+
+        /*
+         * PQ is set to PENDING to possibly catch a triggered
+         * interrupt occuring while the VM is stopped (hotplug event
+         * for instance) .
+         */
+        if (pq !=3D XIVE_ESB_OFF) {
+            pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_10);
+        }
+        xive_source_esb_set(xsrc, i, pq);
+    }
+
+    /*
+     * Sync the XIVE controller in KVM, to flush in-flight event
+     * notification that should be enqueued in the EQs and mark the
+     * XIVE EQ pages dirty to collect all updates.
+     */
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                      KVM_DEV_XIVE_EQ_SYNC, NULL, true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+}
+
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
 {
-    kvmppc_xive_source_get_state(&xive->source);
+    /*
+     * When the VM is stopped, the sources are masked and the previous
+     * state is saved in anticipation of a migration. We should not
+     * synchronize the source state in that case else we will override
+     * the saved state.
+     */
+    if (runstate_is_running()) {
+        kvmppc_xive_source_get_state(&xive->source);
+    }
=20
     /* EAT: there is no extra state to query from KVM */
=20
@@ -515,6 +606,9 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
                                       "xive.tima", tima_len, xive->tm_mm=
ap);
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
=20
+    xive->change =3D qemu_add_vm_change_state_handler(
+        kvmppc_xive_change_state_handler, xive);
+
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
--=20
2.20.1


