Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC26C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE6C22D6D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE6C22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B84-0004xq-VJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4H-0005sW-N5
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4G-0000kL-1v
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-7zJVZ1EKMGmWCtcPIlqtng-1; Mon, 10 Aug 2020 12:54:29 -0400
X-MC-Unique: 7zJVZ1EKMGmWCtcPIlqtng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 575778005B0;
 Mon, 10 Aug 2020 16:54:28 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 825F35F1E4;
 Mon, 10 Aug 2020 16:54:27 +0000 (UTC)
Subject: [PATCH 05/14] spapr/xive: Rework error handling of
 kvmppc_xive_cpu_[gs]et_state()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:54:26 +0200
Message-ID: <159707846665.1489912.14267225652103441921.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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

kvm_set_one_reg() returns a negative errno on failure, use that instead
of errno. Also propagate it to callers so they can use it to check
for failures and hopefully get rid of their local_err boilerplate.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   15 ++++++++++-----
 include/hw/ppc/xive.h    |    4 ++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index b2a36fd59dae..5e088ccbf885 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -73,7 +73,7 @@ static void kvm_cpu_disable_all(void)
  * XIVE Thread Interrupt Management context (KVM)
  */
=20
-void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
     uint64_t state[2];
@@ -86,13 +86,16 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **=
errp)
=20
     ret =3D kvm_set_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
     if (ret !=3D 0) {
-        error_setg_errno(errp, errno,
+        error_setg_errno(errp, -ret,
                          "XIVE: could not restore KVM state of CPU %ld",
                          kvm_arch_vcpu_id(tctx->cs));
+        return ret;
     }
+
+    return 0;
 }
=20
-void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
     uint64_t state[2] =3D { 0 };
@@ -102,14 +105,16 @@ void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error =
**errp)
=20
     ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
     if (ret !=3D 0) {
-        error_setg_errno(errp, errno,
+        error_setg_errno(errp, -ret,
                          "XIVE: could not capture KVM state of CPU %ld",
                          kvm_arch_vcpu_id(tctx->cs));
-        return;
+        return ret;
     }
=20
     /* word0 and word1 of the OS ring. */
     *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
+
+    return 0;
 }
=20
 typedef struct {
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2d87ed43728a..785c905357dc 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -489,7 +489,7 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int =
srcno, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
-void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
-void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
=20
 #endif /* PPC_XIVE_H */



