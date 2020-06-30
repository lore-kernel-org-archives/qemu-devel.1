Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB8820771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="O6yxBFm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB8820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDWC-0003dS-S8
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVE-0001j2-4O
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:36 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58100 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVA-0000Vd-Ud
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:35 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 9E1AC47D4C;
 Tue, 30 Jun 2020 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593512910; x=1595327311; bh=YG/juBfGA83r80UZ6OQaDeJguuo6NOJLVCH
 1uErc77E=; b=O6yxBFm+Inx1b4y7bAAMfExKU+9JVrJBy+ydZrnJAA3kc02PI0m
 gXtkAch8lD3rzP0w0a7mcCHjVDeTiWKjFWoCXaMAWKdOY7Kmes/g00p92tD/2KuX
 K/fn+fi6SUpnRiHJkiEX9A0cma1KUbESXuNJjpYSQ5bkIZg5kEl5jXYE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nQMavJR763Rc; Tue, 30 Jun 2020 13:28:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 993AA4C879;
 Tue, 30 Jun 2020 13:28:30 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 13:28:30 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/9] i386: hvf: Move synchronize functions to sysemu
Date: Tue, 30 Jun 2020 13:28:17 +0300
Message-ID: <20200630102824.77604-3-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200630102824.77604-1-r.bolshakov@yadro.com>
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:12:32
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
index 41d1c5099f..d94456ed29 100644
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


