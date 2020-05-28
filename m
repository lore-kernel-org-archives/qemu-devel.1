Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EDBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D80207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="eAtKeWGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D80207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOMz-0001m8-0w
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLv-000069-MA
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35472 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLt-00072Q-Vx
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id ABF864C867;
 Thu, 28 May 2020 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694680; x=1592509081; bh=ZHRo1yGQWqHJv1jzVldNfQ9zjTc2RvhceAU
 N8X+8weg=; b=eAtKeWGPLcmpv+sZ7gWvGHNxua9ottxcFFyNJ7xOHrTl3IhftuI
 55zIPvBdK7ddSLPmHB7ju0iXVRnOGdT8Dhcbkn4rk+rCQky75dRQlKwQ+LtQdwF7
 B4Hna5Zi9rXz+5i3dhXFyA57zJBZHnoZRkVpmdZcEMES5tnX/oB3qJek=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dagtGO4IHQhb; Thu, 28 May 2020 22:38:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id B008F4C863;
 Thu, 28 May 2020 22:37:59 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 01/13] i386: hvf: Move HVFState definition into hvf
Date: Thu, 28 May 2020 22:37:46 +0300
Message-ID: <20200528193758.51454-2-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"sysemu/hvf.h" is intended for inclusion in generic code. However it
also contains several hvf definitions and declarations, including
HVFState that are used only inside "hvf.c". "hvf-i386.h" would be more
appropriate place to define HVFState as it's only included by "hvf.c"
and "x86_task.c".

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 include/sysemu/hvf.h       | 37 -------------------------------------
 target/i386/hvf/hvf-i386.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d211e808e9..30a565ab73 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -15,8 +15,6 @@
 
 #include "cpu.h"
 #include "qemu/bitops.h"
-#include "exec/memory.h"
-#include "sysemu/accel.h"
 
 extern bool hvf_allowed;
 #ifdef CONFIG_HVF
@@ -32,41 +30,6 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
 #define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif
 
-/* hvf_slot flags */
-#define HVF_SLOT_LOG (1 << 0)
-
-typedef struct hvf_slot {
-    uint64_t start;
-    uint64_t size;
-    uint8_t *mem;
-    int slot_id;
-    uint32_t flags;
-    MemoryRegion *region;
-} hvf_slot;
-
-typedef struct hvf_vcpu_caps {
-    uint64_t vmx_cap_pinbased;
-    uint64_t vmx_cap_procbased;
-    uint64_t vmx_cap_procbased2;
-    uint64_t vmx_cap_entry;
-    uint64_t vmx_cap_exit;
-    uint64_t vmx_cap_preemption_timer;
-} hvf_vcpu_caps;
-
-typedef struct HVFState {
-    AccelState parent;
-    hvf_slot slots[32];
-    int num_slots;
-
-    hvf_vcpu_caps *hvf_caps;
-} HVFState;
-extern HVFState *hvf_state;
-
-void hvf_set_phys_mem(MemoryRegionSection *, bool);
-void hvf_handle_io(CPUArchState *, uint16_t, void *,
-                  int, int, int);
-hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
-
 /* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
  * the host CPU. Use hvf_enabled() after this to get the result. */
 void hvf_disable(int disable);
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 15ee4835cf..7cdf256649 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,6 +16,7 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
+#include "sysemu/accel.h"
 #include "sysemu/hvf.h"
 #include "cpu.h"
 #include "x86.h"
@@ -37,6 +38,40 @@ struct hvf_state {
     uint64_t mem_quota;
 };
 
+/* hvf_slot flags */
+#define HVF_SLOT_LOG (1 << 0)
+
+typedef struct hvf_slot {
+    uint64_t start;
+    uint64_t size;
+    uint8_t *mem;
+    int slot_id;
+    uint32_t flags;
+    MemoryRegion *region;
+} hvf_slot;
+
+typedef struct hvf_vcpu_caps {
+    uint64_t vmx_cap_pinbased;
+    uint64_t vmx_cap_procbased;
+    uint64_t vmx_cap_procbased2;
+    uint64_t vmx_cap_entry;
+    uint64_t vmx_cap_exit;
+    uint64_t vmx_cap_preemption_timer;
+} hvf_vcpu_caps;
+
+typedef struct HVFState {
+    AccelState parent;
+    hvf_slot slots[32];
+    int num_slots;
+
+    hvf_vcpu_caps *hvf_caps;
+} HVFState;
+extern HVFState *hvf_state;
+
+void hvf_set_phys_mem(MemoryRegionSection *, bool);
+void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
+hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
+
 #ifdef NEED_CPU_H
 /* Functions exported to host specific mode */
 
-- 
2.26.1


