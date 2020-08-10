Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D07C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4AC22D72
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4AC22D72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B9Z-0007op-HL
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4K-0005ug-ML
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4J-0000ka-8S
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-e8ME-aKsNkmNoXOx_d1P0g-1; Mon, 10 Aug 2020 12:54:36 -0400
X-MC-Unique: e8ME-aKsNkmNoXOx_d1P0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734C357;
 Mon, 10 Aug 2020 16:54:35 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7636F69318;
 Mon, 10 Aug 2020 16:54:34 +0000 (UTC)
Subject: [PATCH 06/14] spapr/xive: Rework error handling of
 kvmppc_xive_[gs]et_queue_config()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:54:33 +0200
Message-ID: <159707847357.1489912.2032291280645236480.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
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

Since kvm_device_access() returns a negative errno on failure, convert
kvmppc_xive_get_queue_config() and kvmppc_xive_set_queue_config() to
use it for error checking. This allows to get rid of the local_err
boilerplate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c    |   35 ++++++++++++++++-------------------
 include/hw/ppc/spapr_xive.h |    4 ++--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5e088ccbf885..696623f717b7 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -374,15 +374,15 @@ void kvmppc_xive_source_set_irq(void *opaque, int src=
no, int val)
 /*
  * sPAPR XIVE interrupt controller (KVM)
  */
-void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
-                                  uint32_t end_idx, XiveEND *end,
-                                  Error **errp)
+int kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                 uint32_t end_idx, XiveEND *end,
+                                 Error **errp)
 {
     struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
     uint64_t kvm_eq_idx;
     uint8_t priority;
     uint32_t server;
-    Error *local_err =3D NULL;
+    int ret;
=20
     assert(xive_end_is_valid(end));
=20
@@ -394,11 +394,10 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, ui=
nt8_t end_blk,
     kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
         KVM_XIVE_EQ_SERVER_MASK;
=20
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
-                      &kvm_eq, false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+    ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq=
_idx,
+                            &kvm_eq, false, errp);
+    if (ret < 0) {
+        return ret;
     }
=20
     /*
@@ -408,17 +407,18 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, ui=
nt8_t end_blk,
      */
     end->w1 =3D xive_set_field32(END_W1_GENERATION, 0ul, kvm_eq.qtoggle) |
         xive_set_field32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
+
+    return 0;
 }
=20
-void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
-                                  uint32_t end_idx, XiveEND *end,
-                                  Error **errp)
+int kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                 uint32_t end_idx, XiveEND *end,
+                                 Error **errp)
 {
     struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
     uint64_t kvm_eq_idx;
     uint8_t priority;
     uint32_t server;
-    Error *local_err =3D NULL;
=20
     /*
      * Build the KVM state from the local END structure.
@@ -456,12 +456,9 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, uin=
t8_t end_blk,
     kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
         KVM_XIVE_EQ_SERVER_MASK;
=20
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
-                      &kvm_eq, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    return
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx=
,
+                          &kvm_eq, true, errp);
 }
=20
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 93d09d68deb7..d0a08b618f79 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -85,10 +85,10 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uin=
t32_t lisn, XiveEAS *eas,
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)=
;
 uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
                             uint64_t data, bool write);
-void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
+int kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
                                  uint32_t end_idx, XiveEND *end,
                                  Error **errp);
-void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
+int kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
                                  uint32_t end_idx, XiveEND *end,
                                  Error **errp);
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);



