Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF58C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3A521D71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRgEbll8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3A521D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXaB-0003xf-1r
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJm-0005iB-8H
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJk-00088y-93
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJj-000887-U9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id s1so7780114pgv.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QdsEwoYPo2VsUnkZYt75w7M34lLlPDJP4qSt8k4C0rI=;
 b=yRgEbll8nKAoWtoaJG1d90UC4+BOTaBCNBwEXcKQ0ENQ2pL1xZW/Gftj3leysmrHCM
 ExfbzsS5NswjnJXjYtSV7wjDnqf7zV2U0AcnEpo34RyLM2s7HO0u4UljyYAjF+SkbBwk
 WV8eCBb87CFwPTjRo1CBToFfIDtKGdG1I3rLsLs8ejigooLBl8bNA2k3qgO8KNWLfPY7
 5W6FAGNOkMd38B4PuPsSIj7Hj8CnASjzE7zDOZhLGrFEm6+HIDEUd6WfpgocembBu8S4
 gW5mTP/7u/VMYiVbjdDDpwpL5ZqXqL9vC2MwacVPxM2TkwuSOJaf51ZcEzlpQoMh5oX9
 Pe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QdsEwoYPo2VsUnkZYt75w7M34lLlPDJP4qSt8k4C0rI=;
 b=Ud/mAFP9CYRadN+KgtfDsTO/y4i/oT5bkZ98O2c8VF29l0pAg5liulRe03Ia6TOr4e
 vBTKuqefEDfEUDe9hqfoJIiA5Lhf5tcyvNl2FE56fR1Rq+BNk+QmIlWMwCTTSZzBDLlp
 lhYorXHqPUq5pv2sahqwnSVARWqFX9Z5KFm0t/zs62LUeit/qltiZhIrfpTIrabQhyNi
 oWBWRJrFBhvZXYOxOduNZJH6CSrDzSe/E891/dR3rJMkaCYQxxhTRtHINxMKtWwbFyip
 MQfUCwRnBgs2C7Cy+CoVjImVGE8Ab6Wm736TU2nSod7BglBRYq6hYmltAM8qcoN3ll7q
 FvpQ==
X-Gm-Message-State: APjAAAV5IMFlEi/VIKUXn67La5jhcVQCndHUWHCF6M+uVXfUpXgx1WXI
 sutGhj3Mvd6WqvU+aIW8Cp3XXOrZjqs=
X-Google-Smtp-Source: APXvYqxpnbIzar0ngcMySKhQEuBEuUi6jiHtdjrZwy82ceFq0Aze5Zk9gjf4K+Y5FpLg+E5tARjYTg==
X-Received: by 2002:a17:90a:bd0a:: with SMTP id
 y10mr2010132pjr.89.1569279626369; 
 Mon, 23 Sep 2019 16:00:26 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/16] cputlb: Remove cpu->mem_io_vaddr
Date: Mon, 23 Sep 2019 16:00:01 -0700
Message-Id: <20190923230004.9231-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Reviewed-by: David Hildenbrand <david@redhat.com>
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
index d0bdef1eb3..0ca6ee60b3 100644
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


