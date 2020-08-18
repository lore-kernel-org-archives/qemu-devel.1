Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74960206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hqqVhKK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74960206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tRi-0005OY-L9
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7W-00014K-9x; Tue, 18 Aug 2020 00:21:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54639 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7T-0006Ra-8P; Tue, 18 Aug 2020 00:21:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNh0RC3z9sW1; Tue, 18 Aug 2020 14:19:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724372;
 bh=f17eHWmr0QrRSY6D5qBKY2clFh9KCJR5rbxvIA2fYXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hqqVhKK6ekY7HZnu4m7Y2c7i8n4OfkYXJJSDhG5pinS+Wp6IYrZqCSeyJNSRQNXDi
 VSB/L9d1HRcnU0j6bws6EkxeGu9aWHooI0Z40jOmQwW4PUuTiLAXu7A5GsWE9fLmX1
 Ms2MOi8fwUVSHpSUQjKYP+Hjz1RUENEfwLu9IIYY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 32/40] spapr/xive: Rework error handling of
 kvmppc_xive_set_source_config()
Date: Tue, 18 Aug 2020 14:19:14 +1000
Message-Id: <20200818041922.251708-33-david@gibson.dropbear.id.au>
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
kvmppc_xive_set_source_config() to use it for error checking. This allows
to get rid of the local_err boilerplate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707848764.1489912.17078842252160674523.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c    | 13 ++++---------
 include/hw/ppc/spapr_xive.h |  4 ++--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 4142aaffff..f2dda69218 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -186,8 +186,8 @@ int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
  * XIVE Interrupt Source (KVM)
  */
 
-void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
-                                   Error **errp)
+int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
+                                  Error **errp)
 {
     uint32_t end_idx;
     uint32_t end_blk;
@@ -196,7 +196,6 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
     bool masked;
     uint32_t eisn;
     uint64_t kvm_src;
-    Error *local_err = NULL;
 
     assert(xive_eas_is_valid(eas));
 
@@ -216,12 +215,8 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
     kvm_src |= ((uint64_t)eisn << KVM_XIVE_SOURCE_EISN_SHIFT) &
         KVM_XIVE_SOURCE_EISN_MASK;
 
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
-                      &kvm_src, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
+                             &kvm_src, true, errp);
 }
 
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index d0a08b618f..0ffbe0be02 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -80,8 +80,8 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
                         Error **errp);
 void kvmppc_xive_disconnect(SpaprInterruptController *intc);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
-void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
-                                   Error **errp);
+int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
+                                  Error **errp);
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp);
 uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
                             uint64_t data, bool write);
-- 
2.26.2


