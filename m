Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08572C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC24208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="opD8y6BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC24208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsau-0000zt-1e
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:01:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQ7-0008Nf-P4
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQ4-0002eq-Jo
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45161 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQ3-0002aa-DU; Wed, 29 May 2019 02:50:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv52gjXz9sPQ; Wed, 29 May 2019 16:50:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112625;
	bh=ohV9WV8ZSAR+x3akRFqW+oT6jNQt5nM2BD8xfGbgabw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opD8y6BUdjw5BvSnqX8E4kmUO5tTtC/U0ox2gjLYA9fAbDJaQzeN17zyESvEHlMaN
	iIa2aJP8pLoViqdBQK0PUSknjiBoXlin67IjS88QiqUBRtk+5xZR+Fl98ppt6ljYD5
	1YZ6msjpy7ICZTM+fw/qZvUGVEOwBwR0BJnf/qug=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:01 +1000
Message-Id: <20190529065017.15149-29-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 28/44] spapr/xive: add state synchronization
 with KVM
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

This extends the KVM XIVE device backend with 'synchronize_state'
methods used to retrieve the state from KVM. The HW state of the
sources, the KVM device and the thread interrupt contexts are
collected for the monitor usage and also migration.

These get operations rely on their KVM counterpart in the host kernel
which acts as a proxy for OPAL, the host firmware. The set operations
will be added for migration support later.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190513084245.25755-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 17 ++++---
 hw/intc/spapr_xive_kvm.c    | 90 +++++++++++++++++++++++++++++++++++++
 hw/intc/xive.c              | 10 +++++
 include/hw/ppc/spapr_xive.h |  8 ++++
 include/hw/ppc/xive.h       |  1 +
 5 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 03f92c3e65..e771db5fd0 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -40,13 +40,6 @@
=20
 #define SPAPR_XIVE_NVT_BASE 0x400
=20
-/*
- * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
- * to the controller block id value. It can nevertheless be changed
- * for testing purpose.
- */
-#define SPAPR_XIVE_BLOCK_ID 0x0
-
 /*
  * sPAPR NVT and END indexing helpers
  */
@@ -157,6 +150,16 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Moni=
tor *mon)
     XiveSource *xsrc =3D &xive->source;
     int i;
=20
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_synchronize_state(xive, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return;
+        }
+    }
+
     monitor_printf(mon, "  LISN         PQ    EISN     CPU/PRIO EQ\n");
=20
     for (i =3D 0; i < xive->nr_irqs; i++) {
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 964bad0c23..8dd4f96e0b 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -60,6 +60,54 @@ static void kvm_cpu_enable(CPUState *cs)
 /*
  * XIVE Thread Interrupt Management context (KVM)
  */
+static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
+{
+    uint64_t state[2] =3D { 0 };
+    int ret;
+
+    ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
+    if (ret !=3D 0) {
+        error_setg_errno(errp, errno,
+                         "XIVE: could not capture KVM state of CPU %ld",
+                         kvm_arch_vcpu_id(tctx->cs));
+        return;
+    }
+
+    /* word0 and word1 of the OS ring. */
+    *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
+}
+
+typedef struct {
+    XiveTCTX *tctx;
+    Error *err;
+} XiveCpuGetState;
+
+static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
+                                                 run_on_cpu_data arg)
+{
+    XiveCpuGetState *s =3D arg.host_ptr;
+
+    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
+}
+
+void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
+{
+    XiveCpuGetState s =3D {
+        .tctx =3D tctx,
+        .err =3D NULL,
+    };
+
+    /*
+     * Kick the vCPU to make sure they are available for the KVM ioctl.
+     */
+    run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
+               RUN_ON_CPU_HOST_PTR(&s));
+
+    if (s.err) {
+        error_propagate(errp, s.err);
+        return;
+    }
+}
=20
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
@@ -227,6 +275,19 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int sr=
cno, uint32_t offset,
     }
 }
=20
+static void kvmppc_xive_source_get_state(XiveSource *xsrc)
+{
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        /* Perform a load without side effect to retrieve the PQ bits */
+        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
+
+        /* and save PQ locally */
+        xive_source_esb_set(xsrc, i, pq);
+    }
+}
+
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc =3D opaque;
@@ -353,6 +414,35 @@ void kvmppc_xive_reset(SpaprXive *xive, Error **errp=
)
                       NULL, true, errp);
 }
=20
+static void kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
+{
+    Error *local_err =3D NULL;
+    int i;
+
+    for (i =3D 0; i < xive->nr_ends; i++) {
+        if (!xive_end_is_valid(&xive->endt[i])) {
+            continue;
+        }
+
+        kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
+                                     &xive->endt[i], &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
+void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
+{
+    kvmppc_xive_source_get_state(&xive->source);
+
+    /* EAT: there is no extra state to query from KVM */
+
+    /* ENDT */
+    kvmppc_xive_get_queues(xive, errp);
+}
+
 static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
                               Error **errp)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 78047adb11..7f1c54a7b5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -493,6 +493,16 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
     int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
     int i;
=20
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return;
+        }
+    }
+
     monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC A=
GE PIPR"
                    "  W2\n", cpu_index);
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 03685910e7..7e49badd8c 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -44,6 +44,13 @@ typedef struct SpaprXive {
     void          *tm_mmap;
 } SpaprXive;
=20
+/*
+ * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
+ * to the controller block id value. It can nevertheless be changed
+ * for testing purpose.
+ */
+#define SPAPR_XIVE_BLOCK_ID 0x0
+
 bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
@@ -74,5 +81,6 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, uint=
8_t end_blk,
 void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
                                  uint32_t end_idx, XiveEND *end,
                                  Error **errp);
+void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index dd115da30e..78c919c4a5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -435,5 +435,6 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc, i=
nt srcno, Error **errp);
 void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
+void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
=20
 #endif /* PPC_XIVE_H */
--=20
2.21.0


