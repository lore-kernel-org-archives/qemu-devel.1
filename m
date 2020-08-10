Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF84C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FFB22BEB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FFB22BEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B6V-0001Y4-1M
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B3t-00051F-Ak
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B3r-0000gn-SA
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-dZcfky0SNGCuR5CMkki5tQ-1; Mon, 10 Aug 2020 12:54:08 -0400
X-MC-Unique: dZcfky0SNGCuR5CMkki5tQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3955E80046C;
 Mon, 10 Aug 2020 16:54:07 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6260519C4F;
 Mon, 10 Aug 2020 16:54:06 +0000 (UTC)
Subject: [PATCH 02/14] spapr/xive: Rework error handling of
 kvmppc_xive_cpu_connect()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:54:05 +0200
Message-ID: <159707844549.1489912.4862921680328017645.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use error_setg_errno() instead of error_setg(strerror()). While here,
use -ret instead of errno since kvm_vcpu_enable_cap() returns a negative
errno on failure.

Use ERRP_GUARD() to ensure that errp can be passed to error_append_hint(),
and get rid of the local_err boilerplate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   21 ++++++++++-----------
 include/hw/ppc/xive.h    |    2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 82a6f99f022d..aa1a2f915363 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -144,8 +144,9 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, =
Error **errp)
     }
 }
=20
-void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
+    ERRP_GUARD();
     SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
     unsigned long vcpu_id;
     int ret;
@@ -154,7 +155,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **er=
rp)
=20
     /* Check if CPU was hot unplugged and replugged. */
     if (kvm_cpu_is_enabled(tctx->cs)) {
-        return;
+        return 0;
     }
=20
     vcpu_id =3D kvm_arch_vcpu_id(tctx->cs);
@@ -162,20 +163,18 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **=
errp)
     ret =3D kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive->f=
d,
                               vcpu_id, 0);
     if (ret < 0) {
-        Error *local_err =3D NULL;
-
-        error_setg(&local_err,
-                   "XIVE: unable to connect CPU%ld to KVM device: %s",
-                   vcpu_id, strerror(errno));
-        if (errno =3D=3D ENOSPC) {
-            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N < %=
u\n",
+        error_setg_errno(errp, -ret,
+                         "XIVE: unable to connect CPU%ld to KVM device",
+                         vcpu_id);
+        if (ret =3D=3D -ENOSPC) {
+            error_append_hint(errp, "Try -smp maxcpus=3DN with N < %u\n",
                               MACHINE(qdev_get_machine())->smp.max_cpus);
         }
-        error_propagate(errp, local_err);
-        return;
+        return ret;
     }
=20
     kvm_cpu_enable(tctx->cs);
+    return 0;
 }
=20
 /*
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2f3c5af810bb..2d87ed43728a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -487,7 +487,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring,=
 uint8_t ipb);
=20
 int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp=
);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
-void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);



