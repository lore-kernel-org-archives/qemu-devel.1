Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B777C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93EF2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qAZA4KFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93EF2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joi3M-0002zW-3x
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2N-0001PH-9w; Fri, 26 Jun 2020 02:40:35 -0400
Received: from ozlabs.org ([203.11.71.1]:39473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2K-0001ES-Jf; Fri, 26 Jun 2020 02:40:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49tS1l4VBWz9sRR; Fri, 26 Jun 2020 16:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593153627;
 bh=o+KHJQVzpFO+ZEGV70kRkztoAAIYNBYFB3V3S/KxQWY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qAZA4KFWYn+kYNhe+nYW8jQegk/ysUYTMPEV/mAtq7ss0X51mqSdOerSwEPZvOQXQ
 25bgC7pcEBDivHkVdB1cjihrDnzMrE/cpHUX3sk9aKgQeGs05+tt4TnSYk1k9Ksbq9
 fp7px2wEA24acLFRS1dvIXXHoG7X+GkX7Q7JEULE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 1/4] spapr: Simplify some warning printing paths in spapr_caps.c
Date: Fri, 26 Jun 2020 16:40:21 +1000
Message-Id: <20200626064024.383996-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626064024.383996-1-david@gibson.dropbear.id.au>
References: <20200626064024.383996-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 00:31:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

We obviously only want to print a warning in these cases, but this is done
in a rather convoluted manner. Just use warn_report() instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159188281098.70166.18387926536399257573.stgit@bahia.lan>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index efdc0dbbcf..0c2bc8e06e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -248,23 +248,18 @@ SpaprCapPossible cap_cfpc_possible = {
 static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
-    Error *local_err = NULL;
     uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
 
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warning */
-        error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-cfpc=%s",
-                   cap_cfpc_possible.vals[val]);
+        warn_report("TCG doesn't support requested feature, cap-cfpc=%s",
+                    cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
                    "Requested safe cache capability level not supported by kvm,"
                    " try appending -machine cap-cfpc=%s",
                    cap_cfpc_possible.vals[kvm_val]);
     }
-
-    if (local_err != NULL)
-        warn_report_err(local_err);
 }
 
 SpaprCapPossible cap_sbbc_possible = {
@@ -277,23 +272,18 @@ SpaprCapPossible cap_sbbc_possible = {
 static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
                                         Error **errp)
 {
-    Error *local_err = NULL;
     uint8_t kvm_val =  kvmppc_get_cap_safe_bounds_check();
 
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warning */
-        error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-sbbc=%s",
-                   cap_sbbc_possible.vals[val]);
+        warn_report("TCG doesn't support requested feature, cap-sbbc=%s",
+                    cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe bounds check capability level not supported by kvm,"
                    " try appending -machine cap-sbbc=%s",
                    cap_sbbc_possible.vals[kvm_val]);
     }
-
-    if (local_err != NULL)
-        warn_report_err(local_err);
 }
 
 SpaprCapPossible cap_ibs_possible = {
@@ -309,24 +299,18 @@ SpaprCapPossible cap_ibs_possible = {
 static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
-    Error *local_err = NULL;
     uint8_t kvm_val = kvmppc_get_cap_safe_indirect_branch();
 
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warning */
-        error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-ibs=%s",
-                   cap_ibs_possible.vals[val]);
+        warn_report("TCG doesn't support requested feature, cap-ibs=%s",
+                    cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by kvm,"
                    " try appending -machine cap-ibs=%s",
                    cap_ibs_possible.vals[kvm_val]);
     }
-
-    if (local_err != NULL) {
-        warn_report_err(local_err);
-    }
 }
 
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
-- 
2.26.2


