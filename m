Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019AA2073F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/our2Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019AA2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIPC-0003NS-Od
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBIMZ-00011t-3d
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBIMX-0001QC-1w
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:50:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBIMW-0001Kb-Mv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:50:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id i1so6646521wro.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KI6NTqb1buhCdYJKVoPm4gQLaKDSP96PDJ7uqHgYONU=;
 b=P/our2Wxx0ATVnb1oG/LssbUw7amOPlv6h8menQ0E/etnGRLtHEkXxUgotfhTz/S6R
 EsKzEATwuE0Z42Rj9PitN2gVn/3FkH3IG1pSC25OXa5JLBzQKSp5SKY5lf6AMkTOvzc/
 Kbn9RLET0ZC/+GWi2SVXDIzSNy0kw/SPitLbhBsLWcDySB6nFzlKWLByt95THaLYXujR
 ZMa65tX5Jl2xEPeBM5TdQpvT/rt6b4G4EKUtLyLoqUVSJh/qaYutQsgvrX+sm96WJSw4
 HBKFNRMnB+yYXYGmuwmsmAvC8Ag+uO71m3jobTTgAlaWJoVnTKd3QSQHGaT/SRCbssG3
 aDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KI6NTqb1buhCdYJKVoPm4gQLaKDSP96PDJ7uqHgYONU=;
 b=rQRQi+9NPf4zHL5rTW4FMMXVVY4V+x8u0pKwLkCGWYENN20ynLvh5qQZbxSMoYsFpy
 8fT+RaxJkaGZKLavfqtFUU45MxmcluUgXmyngghIllAGA3LRYNIERYSdP0LDeSCLy9Uz
 BOeEadMdxJgMjIofhSCqkGlh4JjMqTo4uddvOCs/axoyXEEmlTiDF2zEsGaMVBWNK2Pe
 WXg2h4RC902Oc/9FKueVq0cMG20lK0yUfCJS6I9BnMks9P048SyBUV368GZKYEC7Zfae
 ZKQvkoxt32oum5kj9Q0I+Lg/i+oQWSNIiBJOmJ0pb3TZG52MgIwTfdMXfD24Ps99QdsO
 6vBA==
X-Gm-Message-State: APjAAAWGZxAyTvLYPWboIb3XAeCoyi4BrFr757s07pmsH2iGVZninK1b
 7GbWfNzwLCvK8Hl9KGxq4Le2GHRFel83nw==
X-Google-Smtp-Source: APXvYqxSGh+btkb9KnW3EA6QDxTfasLVfHzJ6F5jZ0vzg95U5hwYar7X23e7hSDHLe9lzDKY/nMKRQ==
X-Received: by 2002:adf:e548:: with SMTP id z8mr11829188wrm.324.1568983810940; 
 Fri, 20 Sep 2019 05:50:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm2040467wrs.6.2019.09.20.05.50.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:50:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Remove unassigned_access CPU hook
Date: Fri, 20 Sep 2019 13:50:08 +0100
Message-Id: <20190920125008.13604-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All targets have now migrated away from the old unassigned_access
hook to the new do_transaction_failed hook. This means we can remove
the core-code infrastructure for that hook and the code that calls it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based-on: <cover.1568762497.git.alistair.francis@wdc.com>
("[PATCH v1 0/2] RISC-V: Convert to do_transaction_failed hook")
 -- the last of the conversions isn't in master yet, but I figured
I might as well put the cleanup patch out for review.

 include/hw/core/cpu.h | 24 ------------------------
 accel/tcg/cputlb.c    |  1 -
 memory.c              |  7 -------
 3 files changed, 32 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c7cda65c66d..a5a13e26a20 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -71,10 +71,6 @@ typedef enum MMUAccessType {
 
 typedef struct CPUWatchpoint CPUWatchpoint;
 
-typedef void (*CPUUnassignedAccess)(CPUState *cpu, hwaddr addr,
-                                    bool is_write, bool is_exec, int opaque,
-                                    unsigned size);
-
 struct TranslationBlock;
 
 /**
@@ -86,8 +82,6 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
  * @do_interrupt: Callback for interrupt handling.
- * @do_unassigned_access: Callback for unassigned access handling.
- * (this is deprecated: new targets should use do_transaction_failed instead)
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
  * @do_transaction_failed: Callback for handling failed memory transactions
@@ -174,7 +168,6 @@ typedef struct CPUClass {
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
-    CPUUnassignedAccess do_unassigned_access;
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr);
@@ -414,12 +407,6 @@ struct CPUState {
      */
     uintptr_t mem_io_pc;
     vaddr mem_io_vaddr;
-    /*
-     * This is only needed for the legacy cpu_unassigned_access() hook;
-     * when all targets using it have been converted to use
-     * cpu_transaction_failed() instead it can be removed.
-     */
-    MMUAccessType mem_io_access_type;
 
     int kvm_fd;
     struct KVMState *kvm_state;
@@ -879,17 +866,6 @@ void cpu_interrupt(CPUState *cpu, int mask);
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU
-static inline void cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                         bool is_write, bool is_exec,
-                                         int opaque, unsigned size)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->do_unassigned_access) {
-        cc->do_unassigned_access(cpu, addr, is_write, is_exec, opaque, size);
-    }
-}
-
 static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                         MMUAccessType access_type,
                                         int mmu_idx, uintptr_t retaddr)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abae79650c0..9c21b320eb4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -914,7 +914,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     }
 
     cpu->mem_io_vaddr = addr;
-    cpu->mem_io_access_type = access_type;
 
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
diff --git a/memory.c b/memory.c
index b9dd6b94cac..93a05395cff 100644
--- a/memory.c
+++ b/memory.c
@@ -1278,10 +1278,6 @@ static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
 #endif
-    if (current_cpu != NULL) {
-        bool is_exec = current_cpu->mem_io_access_type == MMU_INST_FETCH;
-        cpu_unassigned_access(current_cpu, addr, false, is_exec, 0, size);
-    }
     return 0;
 }
 
@@ -1291,9 +1287,6 @@ static void unassigned_mem_write(void *opaque, hwaddr addr,
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem write " TARGET_FMT_plx " = 0x%"PRIx64"\n", addr, val);
 #endif
-    if (current_cpu != NULL) {
-        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
-    }
 }
 
 static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
-- 
2.20.1


