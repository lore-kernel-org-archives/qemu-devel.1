Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A9BC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B5F21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CBkynX3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B5F21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsiJ-0007Dc-JT
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:09:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQT-0000Ns-VK
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQS-0002tD-Hd
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:05 -0400
Received: from ozlabs.org ([203.11.71.1]:35659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQS-0002ew-08; Wed, 29 May 2019 02:51:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv62y36z9sPR; Wed, 29 May 2019 16:50:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112626;
	bh=LzYwwIlGfEvhgV7PTNG3ZY/kRSi2/VUEFH8zizDsTrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBkynX3bLmc3/tbQIvYailcVNHSM6blqSdAi/hHk76rlkbkOrDX8SzzREkVQgwH47
	15ImpET85NqPP3QQtUToXjt9cMekq3WqT2DXxCwowajWiLDZaVFx2g3HqcN5eeUm6m
	sC8P8qyXrzIX4VWG2v/Pl0wCzX8V4m+kwtcRfGUY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:02 +1000
Message-Id: <20190529065017.15149-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 29/44] spapr/xive: introduce a VM state change
 handler
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

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
Message-Id: <20190513084245.25755-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c    | 96 ++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr_xive.h |  1 +
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 8dd4f96e0b..735577a6f8 100644
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7e49badd8c..734662c12a 100644
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
--=20
2.21.0


