Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D27C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBA32080F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0MaqjUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA32080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtEC-0001OV-2J
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy5-0001tc-Bd
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy3-0008Kt-Sx
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsy3-0008KT-LZ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:23 -0400
Received: by mail-pl1-x642.google.com with SMTP id q15so4954379pll.11
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ToVeCrPKjDs8wNyDQYleTQmt7ApWfc5+CUsaiKNo26w=;
 b=m0MaqjUYkr9stJiKXjGopdqhG9rTUZy1hB90ac1UPuPjsuJ03RytcMXSvCNrYsEVz4
 J/MZyWxQAxNorfzu4UvOooZmoqyPdAIxNT+tM1irVR+WlmV0S6OZYvv/GbCy6UfvtulE
 gZKUVKDC51+ty9EDvB+TgQ25aMQ79qgMxOJqqdLQZrGNAjcytdsCS3SKbH729CV+51KL
 B+Ys7SZblMl6vK0TUqxbTUsSvMqrbMOMopHHk2hZiRrQ1vmzZr4/HLsj+5IfUDbS3aKh
 c9gQnBHyL4VTEF8GLsRxIdgj8Z2NpwEIi/x5NkPOijzhb8DNqB+EDyo7wG1mR1/hVi/i
 X+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ToVeCrPKjDs8wNyDQYleTQmt7ApWfc5+CUsaiKNo26w=;
 b=sjvEyqtY4J7DZ/wMp1yYlJCgEsAgsD4FoXA2T4qneiPx1nrVySyAtY0damlUjG9lci
 5ZyIh/rGLUjpC50ueeV8LsDFCDVatnKLL6TVWTi9DtTesGBzbMyotKnA+kf6ovO/mEBr
 oRkSj6WLZJoBHBFlG32Q2RO7omzI3eRN/U/Ml3muuYicM9DjftQummbxFGnoNVB59hOG
 5sfUrxvYX33BgM5AQ4Sl1cWnIP20O8ZwtRm8iI6vZHaVEN8UnmLkGy9H038c5QuzV+gz
 ff8bWGnM98lCxtExCKRW0PNrMEYyV7yqZmOuk9NGU8jYFNJTlN2w1FxrK8NeqxhnNv5e
 o0HQ==
X-Gm-Message-State: APjAAAVPzdf+OScSwDtaIuk1moakcAXayy9ei8e0mLmisI0c14Q3s0zp
 C3Jkoj2+6/ZNndk8txMyj4oGcECOp/A=
X-Google-Smtp-Source: APXvYqzFPUd20hgQixKWWc0r1tmUH49sVgX+BGPxuuP6532s1e3YVbTIQ5XlEUbT34trnYuYhAZpvA==
X-Received: by 2002:a17:902:426:: with SMTP id
 35mr25954265ple.192.1569124522370; 
 Sat, 21 Sep 2019 20:55:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/20] cputlb: Remove cpu->mem_io_vaddr
Date: Sat, 21 Sep 2019 20:54:55 -0700
Message-Id: <20190922035458.14879-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the merge of notdirty handling into store_helper,
the last user of cpu->mem_io_vaddr was removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 --
 accel/tcg/cputlb.c    | 2 --
 hw/core/cpu.c         | 1 -
 3 files changed, 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c7cda65c66..031f587e51 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -338,7 +338,6 @@ struct qemu_work_item;
  * @next_cpu: Next CPU sharing TB cache.
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
- * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
@@ -413,7 +412,6 @@ struct CPUState {
      * we store some rarely used information in the CPU context.
      */
     uintptr_t mem_io_pc;
-    vaddr mem_io_vaddr;
     /*
      * This is only needed for the legacy cpu_unassigned_access() hook;
      * when all targets using it have been converted to use
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6f4096bd0d..257c59c08c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -927,7 +927,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         cpu_io_recompile(cpu, retaddr);
     }
 
-    cpu->mem_io_vaddr = addr;
     cpu->mem_io_access_type = access_type;
 
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
@@ -967,7 +966,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
-    cpu->mem_io_vaddr = addr;
     cpu->mem_io_pc = retaddr;
 
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0035845511..73b1ee34d0 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -261,7 +261,6 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->interrupt_request = 0;
     cpu->halted = 0;
     cpu->mem_io_pc = 0;
-    cpu->mem_io_vaddr = 0;
     cpu->icount_extra = 0;
     atomic_set(&cpu->icount_decr_ptr->u32, 0);
     cpu->can_do_io = 1;
-- 
2.17.1


