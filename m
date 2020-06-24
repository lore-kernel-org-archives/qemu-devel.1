Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601E62076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Ve33mCRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601E62076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joER1-00043D-Jp
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO8-0007zF-By
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:04 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:32880 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO4-0006lK-PZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:04 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 677224C8B2;
 Wed, 24 Jun 2020 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593039657; x=1594854058; bh=O+oD/8e5D+BiPYJW8vexoxBygMLUSq69Ksz
 h5Vme0KY=; b=Ve33mCRdTnKZCz/qGoRt5QiDgyRPFFjfU7xvt5UGtGlvS+s8J6B
 Pza4tttxYuHM67TrZnvZtqoqOHh51tXRfJ4r9+JEgN7+5aGCBFU98CbQ2xdRl9Bm
 VVTludNQ7kJJ/LSOiNL5sNf+hPGjPgHA2nSiYqu0emH6lZYmKqFZ5PIY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvh5Qxh-11fM; Thu, 25 Jun 2020 02:00:57 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id E7EF34C8AB;
 Thu, 25 Jun 2020 02:00:56 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 02:00:56 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/8] i386: hvf: Move synchronize functions to sysemu
Date: Thu, 25 Jun 2020 01:58:45 +0300
Message-ID: <20200624225850.16982-3-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200624225850.16982-1-r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 19:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Claudio Fontana <cfontana@suse.de>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 cpus.c                    | 12 ------------
 include/sysemu/hw_accel.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/cpus.c b/cpus.c
index 7317ae06b9..26709677d3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1017,10 +1017,6 @@ void cpu_synchronize_all_states(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_state(cpu);
-        /* TODO: move to cpu_synchronize_state() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_state(cpu);
-        }
     }
 }
 
@@ -1030,10 +1026,6 @@ void cpu_synchronize_all_post_reset(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_reset(cpu);
-        /* TODO: move to cpu_synchronize_post_reset() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_post_reset(cpu);
-        }
     }
 }
 
@@ -1043,10 +1035,6 @@ void cpu_synchronize_all_post_init(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_init(cpu);
-        /* TODO: move to cpu_synchronize_post_init() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_post_init(cpu);
-        }
     }
 }
 
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 0ec2372477..80bce75921 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -14,6 +14,7 @@
 #include "hw/core/cpu.h"
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
+#include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 
 static inline void cpu_synchronize_state(CPUState *cpu)
@@ -24,6 +25,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_state(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_state(cpu);
+    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
@@ -37,6 +41,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_post_reset(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_post_reset(cpu);
+    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_reset(cpu);
     }
@@ -50,6 +57,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_post_init(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_post_init(cpu);
+    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
-- 
2.26.1


