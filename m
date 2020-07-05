Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22AAC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B73020720
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B73020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5Ft-0000dP-R0
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F1-00077y-0f
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:35 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:43789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5Ez-0008I5-4h
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:34 -0400
Received: by mail-ej1-f49.google.com with SMTP id l12so39626122ejn.10
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ahYN4Ge3uqmONxG6z02hvCW/RKw9GJyc5ErJ800j5g=;
 b=uNmnJRRT8cwxybzydXCmnLHMTUx56ejSaH+RBXqYcl2jdhlVw1Jv3bTvQWqKQjyVKa
 R1RFSflADwNfcg76fjpSATNpImz7DZod1/qiarg2nqxBlbklW/gNKnmSJ8QQuIATmWis
 WS0fOLynNEEeH69V/XyM0nLR9bWbl33D+e6tcOnn25/rOzpH1ru+wSC3EuoStRW9+4H2
 aUN+4Egiz918K88c287XAxUUkFHkhCHb52QKQUQBDTHObdLFBKf+HvMdrza4AEwXKKLq
 K1QWv/JhfB3HKN/jeDV8lgNHSltwnDQrxc5QkhRWuuNJSrizdMlq92tERAUbYxOGkbQt
 nfSQ==
X-Gm-Message-State: AOAM530c4u6G6YkKekAMsGfAqpvsSmqyDLhwTydE2nF3fho2UXDe8Uua
 hRwHBzf1kGiJMhYV9A4dB9dyulS/
X-Google-Smtp-Source: ABdhPJyY7TC/v/bC+RoT/CDnxxwkgF1i/uPcInN6dXDFjBlafdG59HpbVjZbXokk5KoCjbw70ZfGGw==
X-Received: by 2002:a17:906:4dd4:: with SMTP id
 f20mr41743537ejw.170.1593957811655; 
 Sun, 05 Jul 2020 07:03:31 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:31 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 04/30] target/avr: CPU class: Add memory menagement support
Date: Sun,  5 Jul 2020 16:02:49 +0200
Message-Id: <20200705140315.260514-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.49; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f49.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This patch introduces three memory-management-related functions
that will become part of AVR CPU class object.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 target/avr/cpu.c    |  3 +++
 target/avr/helper.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8305a3a85d..a1d5f3c1eb 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -203,6 +203,9 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
+    cc->memory_rw_debug = avr_cpu_memory_rw_debug;
+    cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
+    cc->tlb_fill = avr_cpu_tlb_fill;
     cc->disas_set_info = avr_cpu_disas_set_info;
     cc->tcg_initialize = avr_cpu_tcg_init;
     cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 731a9ee27f..354def2a65 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -87,3 +87,53 @@ void avr_cpu_do_interrupt(CPUState *cs)
 
     cs->exception_index = -1;
 }
+
+int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
+                                int len, bool is_write)
+{
+    return cpu_memory_rw_debug(cs, addr, buf, len, is_write);
+}
+
+hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    return addr; /* I assume 1:1 address correspondance */
+}
+
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
+{
+    int prot = 0;
+    MemTxAttrs attrs = {};
+    uint32_t paddr;
+
+    address &= TARGET_PAGE_MASK;
+
+    if (mmu_idx == MMU_CODE_IDX) {
+        /* access to code in flash */
+        paddr = OFFSET_CODE + address;
+        prot = PAGE_READ | PAGE_EXEC;
+        if (paddr + TARGET_PAGE_SIZE > OFFSET_DATA) {
+            error_report("execution left flash memory");
+            exit(1);
+        }
+    } else if (address < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
+        /*
+         * access to CPU registers, exit and rebuilt this TB to use full access
+         * incase it touches specially handled registers like SREG or SP
+         */
+        AVRCPU *cpu = AVR_CPU(cs);
+        CPUAVRState *env = &cpu->env;
+        env->fullacc = 1;
+        cpu_loop_exit_restore(cs, retaddr);
+    } else {
+        /* access to memory. nothing special */
+        paddr = OFFSET_DATA + address;
+        prot = PAGE_READ | PAGE_WRITE;
+    }
+
+    tlb_set_page_with_attrs(
+        cs, address, paddr, attrs, prot, mmu_idx, TARGET_PAGE_SIZE);
+
+    return true;
+}
-- 
2.26.2


