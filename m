Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248BFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C03B206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C03B206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7w0-0007Xv-GL
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kc7sK-000323-Gf; Mon, 09 Nov 2020 09:10:28 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:60172
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kc7sG-0002kg-3x; Mon, 09 Nov 2020 09:10:28 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 3F5725FE42;
 Mon,  9 Nov 2020 15:10:21 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 02/17] target/arm: add arm_is_el2_enabled() helper
Date: Mon,  9 Nov 2020 16:10:05 +0200
Message-Id: <20201109141020.27234-2-remi.denis.courmont@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <5554493.MhkbZ0Pkbq@basile.remlab.net>
References: <5554493.MhkbZ0Pkbq@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 08:56:07
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

This checks if EL2 is enabled (meaning EL2 registers take effects) in
the current security context.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c18a916766..adaded6bab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2040,6 +2040,17 @@ static inline bool arm_is_secure(CPUARMState *env)
     return arm_is_secure_below_el3(env);
 }
 
+/* Return true if the current security state has AArch64 EL2 or AArch32 Hyp.
+ * This corresponds to the pseudocode EL2Enabled()
+  */
+static inline bool arm_is_el2_enabled(CPUARMState *env)
+{
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
+        return !arm_is_secure_below_el3(env);
+    }
+    return false;
+}
+
 #else
 static inline bool arm_is_secure_below_el3(CPUARMState *env)
 {
@@ -2050,6 +2061,11 @@ static inline bool arm_is_secure(CPUARMState *env)
 {
     return false;
 }
+
+static inline bool arm_is_el2_enabled(CPUARMState *env)
+{
+    return false;
+}
 #endif
 
 /**
-- 
2.29.2


