Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C4EC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5372146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5372146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6q3-0008On-KY
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:01:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6oA-0006iZ-GD
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6Z2-0004F9-Qg
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:06 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:47605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6Z2-0004ER-Ks
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:04 -0400
Received: from player778.ha.ovh.net (unknown [10.109.159.248])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1F9B7F6C48
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:44:02 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 9D9FC59C40A6;
	Mon, 13 May 2019 08:43:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:41 +0200
Message-Id: <20190513084245.25755-11-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3337730274498087910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.51.249
Subject: [Qemu-devel] [PATCH v4 10/14] spapr: check for the activation of
 the KVM IRQ device
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

The activation of the KVM IRQ device depends on the interrupt mode
chosen at CAS time by the machine and some methods used at reset or by
the migration need to be protected.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 May be we can improve these checkd by using spapr->ov5_cas in some
 cases.

 Changes since v3:

 - update in kvmppc_xive_source_reset_one()

 hw/intc/spapr_xive_kvm.c | 33 +++++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c       | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 259cd1db9582..078d18d7757f 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -90,9 +90,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, =
Error **errp)
=20
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
+    SpaprXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
     uint64_t state[2] =3D { 0 };
     int ret;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
     if (ret !=3D 0) {
         error_setg_errno(errp, errno,
@@ -143,6 +149,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
*errp)
     unsigned long vcpu_id;
     int ret;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     /* Check if CPU was hot unplugged and replugged. */
     if (kvm_cpu_is_enabled(tctx->cs)) {
         return;
@@ -219,6 +230,11 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc, =
int srcno, Error **errp)
     SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
     uint64_t state =3D 0;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     if (xive_source_irq_is_lsi(xsrc, srcno)) {
         state |=3D KVM_XIVE_LEVEL_SENSITIVE;
         if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
@@ -319,9 +335,13 @@ static void kvmppc_xive_source_get_state(XiveSource =
*xsrc)
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc =3D opaque;
+    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
     struct kvm_irq_level args;
     int rc;
=20
+    /* The KVM XIVE device should be in use */
+    assert(xive->fd !=3D -1);
+
     args.irq =3D srcno;
     if (!xive_source_irq_is_lsi(xsrc, srcno)) {
         if (!val) {
@@ -546,6 +566,11 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
=20
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
 {
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     /*
      * When the VM is stopped, the sources are masked and the previous
      * state is saved in anticipation of a migration. We should not
@@ -571,6 +596,11 @@ int kvmppc_xive_pre_save(SpaprXive *xive)
 {
     Error *local_err =3D NULL;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return 0;
+    }
+
     /* EAT: there is no extra state to query from KVM */
=20
     /* ENDT */
@@ -595,6 +625,9 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versio=
n_id)
     CPUState *cs;
     int i;
=20
+    /* The KVM XIVE device should be in use */
+    assert(xive->fd !=3D -1);
+
     /* Restore the ENDT first. The targetting depends on it. */
     for (i =3D 0; i < xive->nr_ends; i++) {
         if (!xive_end_is_valid(&xive->endt[i])) {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 1185846ff183..12bd5190cfad 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -69,6 +69,11 @@ void icp_get_kvm_state(ICPState *icp)
     uint64_t state;
     int ret;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
     /* ICP for this CPU thread is not in use, exiting */
     if (!icp->cs) {
         return;
@@ -105,6 +110,11 @@ int icp_set_kvm_state(ICPState *icp)
     uint64_t state;
     int ret;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     /* ICP for this CPU thread is not in use, exiting */
     if (!icp->cs) {
         return 0;
@@ -133,8 +143,9 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
     unsigned long vcpu_id;
     int ret;
=20
+    /* The KVM XICS device is not in use */
     if (kernel_xics_fd =3D=3D -1) {
-        abort();
+        return;
     }
=20
     cs =3D icp->cs;
@@ -170,6 +181,11 @@ void ics_get_kvm_state(ICSState *ics)
     uint64_t state;
     int i;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
=20
@@ -230,6 +246,11 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno)
     ICSIRQState *irq =3D &ics->irqs[srcno];
     int ret;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     state =3D irq->server;
     state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
         << KVM_XICS_PRIORITY_SHIFT;
@@ -269,6 +290,11 @@ int ics_set_kvm_state(ICSState *ics)
 {
     int i;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         int ret;
=20
@@ -286,6 +312,9 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
     struct kvm_irq_level args;
     int rc;
=20
+    /* The KVM XICS device should be in use */
+    assert(kernel_xics_fd !=3D -1);
+
     args.irq =3D srcno + ics->offset;
     if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MSI) {
         if (!val) {
--=20
2.20.1


