Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A653821D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFu6s/Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A653821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vol-0001hC-Sx
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkC-0000xX-A7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkA-00047c-4H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:07 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:45562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vk8-00046x-EI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:05 -0500
Received: by mail-pg1-x52d.google.com with SMTP id m15so653212pgv.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=+WltSHyolw+4rQE+XPimaO0DHQK7HzUxfJXf8ld/qCk=;
 b=oFu6s/Qy+KVjDpayZV7soZUhwXca0iJ0AHS2pQPCjVx3MXEd2Md9Cb2M9s7lKY5C2Y
 wfaCcknXFcvrQ7NkvSdwWFjES1QwHcNF9SkKRQPlXauw9NQ7hVdGgmQcWj33XJ4hzYQ0
 lcOC8QEeSI0fThCSRvyLf6D3G43DCnPlbw0fUQZzCSQs8FfMTvy13avGphyoW9eYrI6U
 S8XfgcDUInzgKKQlcz+50YOZckUwCa7NtgslbW6VgbEFvDvLiCeuP4nYkmEgT2uRBnAu
 BYRlEgw1e1a8LGx7lRxrPvS+OIDWcf/xNgWvRrPITQJjqrUYpQv5DibaKDktaGx/0X53
 YWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=+WltSHyolw+4rQE+XPimaO0DHQK7HzUxfJXf8ld/qCk=;
 b=L8b6hJd9X6r6MjTWmwo+ygXu3c2xRFp/15ujpSEkNl5RLFHPD8hN+IG4KonGEW114K
 pTK+S+xz/rX2uhPbAkSjvZxM28o5TfhH8PeccmJHP27bQ5OQgmIHMQ4xZ+QanzYsPiVU
 HAn4NDLJlqSZ1f0PV49XVRr0Tv1VmkIeurVbolD+iNBy1MsYmeySDnaM5H36bhJHyaAt
 1Ax6956bgJqjEynT9Jx4q0jo9Sgp5iT5cPuwBB6si2TNQ6URKFd0pxEMHPc5h6bc9djx
 7152ruXnZFb5uM2/SOM0nrUWxK86+XBZIa9t2SLVIltu1j4e/JC4lm2bRX8UHvk9gCbP
 exJg==
X-Gm-Message-State: ANhLgQ0HrM3daEPFxT07sFMdXTWC9x7yewyG5rVkVS6C3AjrWUJwBhkY
 BpOmZqT0R0JEsFj7L/kapdUVpQ==
X-Google-Smtp-Source: ADFU+vuLG8/8IhkoqL0mK0ULov5VVM4mXoZPyaFd5YrvRg3BPr9yHjnh4iDUXjDhZAgBeiRfNKQ2TQ==
X-Received: by 2002:aa7:8bdd:: with SMTP id s29mr1565556pfd.208.1583196543314; 
 Mon, 02 Mar 2020 16:49:03 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id bb5sm108161pjb.8.2020.03.02.16.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:02 -0800 (PST)
Subject: [PULL 03/38] target/riscv: Add the Hypervisor CSRs to CPUState
Date: Mon,  2 Mar 2020 16:48:13 -0800
Message-Id: <20200303004848.136788-4-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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

From: Alistair Francis <alistair.francis@wdc.com>

Add the Hypervisor CSRs to CPUState and at the same time (to avoid
bisect issues) update the CSR macros for the v0.5 Hyp spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h      | 21 +++++++++++++++++++++
 target/riscv/cpu_bits.h | 34 +++++++++++++++++++++-------------
 target/riscv/gdbstub.c  | 11 ++++++-----
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 010125efd6..c7f7ae5c38 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -143,6 +143,27 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* Hypervisor CSRs */
+    target_ulong hstatus;
+    target_ulong hedeleg;
+    target_ulong hideleg;
+    target_ulong hcounteren;
+    target_ulong htval;
+    target_ulong htinst;
+    target_ulong hgatp;
+
+    /* Virtual CSRs */
+    target_ulong vsstatus;
+    target_ulong vstvec;
+    target_ulong vsscratch;
+    target_ulong vsepc;
+    target_ulong vscause;
+    target_ulong vstval;
+    target_ulong vsatp;
+
+    target_ulong mtval2;
+    target_ulong mtinst;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e99834856c..25c0fb258d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -177,8 +177,14 @@
 #define CSR_HSTATUS         0x600
 #define CSR_HEDELEG         0x602
 #define CSR_HIDELEG         0x603
-#define CSR_HCOUNTERNEN     0x606
+#define CSR_HIE             0x604
+#define CSR_HCOUNTEREN      0x606
+#define CSR_HTVAL           0x643
+#define CSR_HIP             0x644
+#define CSR_HTINST          0x64A
 #define CSR_HGATP           0x680
+#define CSR_HTIMEDELTA      0x605
+#define CSR_HTIMEDELTAH     0x615
 
 #if defined(TARGET_RISCV32)
 #define HGATP_MODE           SATP32_MODE
@@ -191,6 +197,20 @@
 #define HGATP_PPN            SATP64_PPN
 #endif
 
+/* Virtual CSRs */
+#define CSR_VSSTATUS        0x200
+#define CSR_VSIE            0x204
+#define CSR_VSTVEC          0x205
+#define CSR_VSSCRATCH       0x240
+#define CSR_VSEPC           0x241
+#define CSR_VSCAUSE         0x242
+#define CSR_VSTVAL          0x243
+#define CSR_VSIP            0x244
+#define CSR_VSATP           0x280
+
+#define CSR_MTINST          0x34a
+#define CSR_MTVAL2          0x34b
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
@@ -313,17 +333,6 @@
 #define CSR_MHPMCOUNTER30H  0xb9e
 #define CSR_MHPMCOUNTER31H  0xb9f
 
-/* Legacy Hypervisor Trap Setup (priv v1.9.1) */
-#define CSR_HIE             0x204
-#define CSR_HTVEC           0x205
-
-/* Legacy Hypervisor Trap Handling (priv v1.9.1) */
-#define CSR_HSCRATCH        0x240
-#define CSR_HEPC            0x241
-#define CSR_HCAUSE          0x242
-#define CSR_HBADADDR        0x243
-#define CSR_HIP             0x244
-
 /* Legacy Machine Protection and Translation (priv v1.9.1) */
 #define CSR_MBASE           0x380
 #define CSR_MBOUND          0x381
@@ -400,7 +409,6 @@
 
 /* hstatus CSR bits */
 #define HSTATUS_SPRV         0x00000001
-#define HSTATUS_STL          0x00000040
 #define HSTATUS_SPV          0x00000080
 #define HSTATUS_SP2P         0x00000100
 #define HSTATUS_SP2V         0x00000200
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1a72f7be9c..2f32750f2f 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -130,6 +130,8 @@ static int csr_register_map[] = {
     CSR_MCAUSE,
     CSR_MTVAL,
     CSR_MIP,
+    CSR_MTINST,
+    CSR_MTVAL2,
     CSR_PMPCFG0,
     CSR_PMPCFG1,
     CSR_PMPCFG2,
@@ -252,12 +254,11 @@ static int csr_register_map[] = {
     CSR_HEDELEG,
     CSR_HIDELEG,
     CSR_HIE,
-    CSR_HTVEC,
-    CSR_HSCRATCH,
-    CSR_HEPC,
-    CSR_HCAUSE,
-    CSR_HBADADDR,
+    CSR_HCOUNTEREN,
+    CSR_HTVAL,
     CSR_HIP,
+    CSR_HTINST,
+    CSR_HGATP,
     CSR_MBASE,
     CSR_MBOUND,
     CSR_MIBASE,
-- 
2.25.0.265.gbab2e86ba0-goog


