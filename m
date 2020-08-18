Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4406A206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ChM439LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4406A206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tMb-0004wS-GS
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7K-0000Z0-CL; Tue, 18 Aug 2020 00:20:58 -0400
Received: from ozlabs.org ([203.11.71.1]:45861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6u-0006Qj-U0; Tue, 18 Aug 2020 00:20:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNg5LF8z9sVy; Tue, 18 Aug 2020 14:19:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724371;
 bh=R4hwxEmQn586lRXLI0JdQqAdlRHDs2bpPhNkBigRBAU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ChM439LEqqM20BS47aIOpspIH5J2lW5V9tJlsJqiyM5HZ5+P+vioCXST7Q7LoNyqk
 U7WBwlftcZNRiREZA5ddCShrhYv6jIZPU1s5UhGkxxHvwZDP0JBqSJcUq4gYLbpyXd
 QErVuEEB8dtlRYLpbGxH1+0zhV6EA2RMPTlE+kJM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 30/40] spapr/xive: Rework error handling of
 kvmppc_xive_[gs]et_queue_config()
Date: Tue, 18 Aug 2020 14:19:12 +1000
Message-Id: <20200818041922.251708-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Since kvm_device_access() returns a negative errno on failure, convert
kvmppc_xive_get_queue_config() and kvmppc_xive_set_queue_config() to
use it for error checking. This allows to get rid of the local_err
boilerplate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707847357.1489912.2032291280645236480.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c    | 35 ++++++++++++++++-------------------
 include/hw/ppc/spapr_xive.h |  4 ++--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5e088ccbf8..696623f717 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -374,15 +374,15 @@ void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
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
     struct kvm_ppc_xive_eq kvm_eq = { 0 };
     uint64_t kvm_eq_idx;
     uint8_t priority;
     uint32_t server;
-    Error *local_err = NULL;
+    int ret;
 
     assert(xive_end_is_valid(end));
 
@@ -394,11 +394,10 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
     kvm_eq_idx |= server << KVM_XIVE_EQ_SERVER_SHIFT &
         KVM_XIVE_EQ_SERVER_MASK;
 
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
-                      &kvm_eq, false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+    ret = kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
+                            &kvm_eq, false, errp);
+    if (ret < 0) {
+        return ret;
     }
 
     /*
@@ -408,17 +407,18 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
      */
     end->w1 = xive_set_field32(END_W1_GENERATION, 0ul, kvm_eq.qtoggle) |
         xive_set_field32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
+
+    return 0;
 }
 
-void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
-                                  uint32_t end_idx, XiveEND *end,
-                                  Error **errp)
+int kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                 uint32_t end_idx, XiveEND *end,
+                                 Error **errp)
 {
     struct kvm_ppc_xive_eq kvm_eq = { 0 };
     uint64_t kvm_eq_idx;
     uint8_t priority;
     uint32_t server;
-    Error *local_err = NULL;
 
     /*
      * Build the KVM state from the local END structure.
@@ -456,12 +456,9 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
     kvm_eq_idx |= server << KVM_XIVE_EQ_SERVER_SHIFT &
         KVM_XIVE_EQ_SERVER_MASK;
 
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
-                      &kvm_eq, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    return
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
+                          &kvm_eq, true, errp);
 }
 
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 93d09d68de..d0a08b618f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -85,10 +85,10 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp);
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
-- 
2.26.2


