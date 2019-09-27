Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA33C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A746321A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHI9HEbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A746321A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwIY-0007nT-Hr
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5l-0003L1-C9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5b-0006H7-6B
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5a-0006FG-Rm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:39 -0400
Received: by mail-pf1-x442.google.com with SMTP id q5so2112755pfg.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cOr/j2swL6x+TNgS9oubk3VZWNSao1nhLd3EVmod6Xg=;
 b=KHI9HEbuu9ciWyYePpO4V2FHtcSeROC+6Do0ls0O0D+uztZG5QUz5V1nYYNelPyymb
 Gd+Fp+D+SPp9U+VUS6bSsVzzfEv5ULJYKOpKRyfW1iadibeuUGx5MKqnP2EyAFODcMLZ
 YphZj2K/25FyCp+5hvRJPGded813r3Ea/bAAzGwL/F8TpLkLjFKPtzxSMQ1UoySNLmPy
 9B2FF+At3lFrlrn5fbiUyvgraIB5DHmYzeZj7ptLyKz2fPZOlrD1m2SbUwTosPwHJIX3
 7cAbkX13U5g8WsS7DAK6QexZcyOQXGlX9zTfFsGYAfT6l2DUOXPh1zG6uFYz+iOWBeB4
 zF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cOr/j2swL6x+TNgS9oubk3VZWNSao1nhLd3EVmod6Xg=;
 b=LCYMsRStcIlhZWI17WMv9bN5rRGzgBcyKHwqy5av8duizThBtYDngfG2vzAk2AyXed
 TKpT0ib5Jj9oIhE9d4PK7dwfvP4jYWoJhnD8+nxtAp/S+w4UL3N03qoqYY4DEBEGb8T2
 UMghRQtF4qd5oAPPCgaS9FlN5pUPK9fNPHPmhopDmmoZYtfJtvmLO7HSKvuQr0dB2Tfq
 UUt0txIHVkMId+Wilk4I0dZVaw69teOb46qpV5+nWgZ0GaqzlZ4HssIjGzoX8UgCJ8vQ
 Ni7ddufsMaC0+oR6sxe3ZDJfSVPFAGXShgb2b11yLqCNFScpxkUwzv2Wz3gdUDRUbXRf
 d9cA==
X-Gm-Message-State: APjAAAXMlLXvBnfcsiPQb0wz10y6prTK8XC/qnoJdYUWQHa7xYGvCorm
 AyNmEu9GK+MhMcKXtiRx4bSuVC25H04=
X-Google-Smtp-Source: APXvYqz4qEag+3JO9KsrKEv7wp0KHKCOLxjR1x7KndjWKLdogVsTvgkDFAee8TWwVGSetGQCWXkcSQ==
X-Received: by 2002:a63:9742:: with SMTP id d2mr10698294pgo.356.1569613175567; 
 Fri, 27 Sep 2019 12:39:35 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/18] target/s390x: Remove ilen parameter from
 s390_program_interrupt
Date: Fri, 27 Sep 2019 12:39:10 -0700
Message-Id: <20190927193925.23567-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is no longer used, and many of the existing uses -- particularly
within hw/s390x -- seem questionable.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h           |  3 +-
 hw/s390x/s390-pci-inst.c     | 58 ++++++++++++++++++------------------
 target/s390x/cc_helper.c     |  2 +-
 target/s390x/crypto_helper.c |  4 +--
 target/s390x/diag.c          | 14 ++++-----
 target/s390x/excp_helper.c   |  4 +--
 target/s390x/fpu_helper.c    |  6 ++--
 target/s390x/int_helper.c    | 14 ++++-----
 target/s390x/interrupt.c     |  3 +-
 target/s390x/ioinst.c        | 40 ++++++++++++-------------
 target/s390x/mem_helper.c    | 43 +++++++++++++-------------
 target/s390x/misc_helper.c   | 27 ++++++-----------
 12 files changed, 103 insertions(+), 115 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b7d408bf81..67126acc99 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -808,8 +808,7 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
-void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
-                            uintptr_t ra);
+void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 4b3bd4a804..92c7e45df5 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -157,7 +157,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
     int i;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
@@ -168,7 +168,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
     reqh = (ClpReqHdr *)buffer;
     req_len = lduw_p(&reqh->len);
     if (req_len < 16 || req_len > 8184 || (req_len % 8 != 0)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
     }
 
@@ -180,11 +180,11 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
     resh = (ClpRspHdr *)(buffer + req_len);
     res_len = lduw_p(&resh->len);
     if (res_len < 8 || res_len > 8176 || (res_len % 8 != 0)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
     }
     if ((req_len + res_len) > 8192) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
     }
 
@@ -390,12 +390,12 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     uint8_t pcias;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
     if (r2 & 0x1) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
@@ -429,25 +429,25 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     switch (pcias) {
     case ZPCI_IO_BAR_MIN...ZPCI_IO_BAR_MAX:
         if (!len || (len > (8 - (offset & 0x7)))) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
         result = zpci_read_bar(pbdev, pcias, offset, &data, len);
         if (result != MEMTX_OK) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
         break;
     case ZPCI_CONFIG_BAR:
         if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
         data =  pci_host_config_read_common(
                    pbdev->pdev, offset, pci_config_size(pbdev->pdev), len);
 
         if (zpci_endian_swap(&data, len)) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
         break;
@@ -489,12 +489,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     uint8_t pcias;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
     if (r2 & 0x1) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
@@ -536,13 +536,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
          * A length of 0 is invalid and length should not cross a double word
          */
         if (!len || (len > (8 - (offset & 0x7)))) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
 
         result = zpci_write_bar(pbdev, pcias, offset, data, len);
         if (result != MEMTX_OK) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
         break;
@@ -550,7 +550,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         /* ZPCI uses the pseudo BAR number 15 as configuration space */
         /* possible access lengths are 1,2,4 and must not cross a word */
         if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
         /* len = 1,2,4 so we do not need to test */
@@ -622,12 +622,12 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     hwaddr start, end;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
     if (r2 & 0x1) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
@@ -709,7 +709,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     uint8_t buffer[128];
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
@@ -772,7 +772,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     if (!memory_region_access_valid(mr, offset, len, true,
                                     MEMTXATTRS_UNSPECIFIED)) {
-        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
     }
 
@@ -786,7 +786,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
                                               ldq_p(buffer + i * 8),
                                               MO_64, MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
-            s390_program_interrupt(env, PGM_OPERAND, 6, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
     }
@@ -797,7 +797,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     return 0;
 
 specification_error:
-    s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+    s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     return 0;
 }
 
@@ -871,14 +871,14 @@ static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib,
     pba &= ~0xfff;
     pal |= 0xfff;
     if (pba > pal || pba < ZPCI_SDMA_ADDR || pal > ZPCI_EDMA_ADDR) {
-        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
 
     /* currently we only support designation type 1 with translation */
     if (!(dt == ZPCI_IOTA_RTTO && t)) {
         error_report("unsupported ioat dt %d t %d", dt, t);
-        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
 
@@ -1003,7 +1003,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     uint64_t cc = ZPCI_PCI_LS_OK;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
@@ -1012,7 +1012,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     fh = env->regs[r1] >> 32;
 
     if (fiba & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
@@ -1040,7 +1040,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     }
 
     if (fib.fmt != 0) {
-        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return 0;
     }
 
@@ -1151,7 +1151,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         break;
     }
     default:
-        s390_program_interrupt(&cpu->env, PGM_OPERAND, 6, ra);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, ra);
         cc = ZPCI_PCI_LS_ERR;
     }
 
@@ -1171,7 +1171,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     uint64_t cc = ZPCI_PCI_LS_OK;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return 0;
     }
 
@@ -1185,7 +1185,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     }
 
     if (fiba & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index cf68792733..3cb00bcb09 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -588,7 +588,7 @@ void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
         break;
     default:
         HELPER_LOG("unknown sacf mode: %" PRIx64 "\n", a1);
-        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
         break;
     }
 }
diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
index 5c79790187..1f83987e9d 100644
--- a/target/s390x/crypto_helper.c
+++ b/target/s390x/crypto_helper.c
@@ -34,7 +34,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         if (mod) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
             return 0;
         }
         break;
@@ -42,7 +42,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
 
     s390_get_feat_block(type, subfunc);
     if (!test_be_bit(fc, subfunc)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 0;
     }
 
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 65eabf0461..53c2f81f2a 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -61,12 +61,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
     IplParameterBlock *iplb;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
         return;
     }
 
     if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
 
@@ -82,13 +82,13 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         break;
     case 5:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
                                         sizeof(IplParameterBlock), false,
                                         MEMTXATTRS_UNSPECIFIED)) {
-            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
@@ -112,13 +112,13 @@ out:
         return;
     case 6:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
                                         sizeof(IplParameterBlock), true,
                                         MEMTXATTRS_UNSPECIFIED)) {
-            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
             return;
         }
         iplb = s390_ipl_get_iplb();
@@ -130,7 +130,7 @@ out:
         }
         return;
     default:
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         break;
     }
 }
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 681a9c59e1..089623a248 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -75,7 +75,7 @@ void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
 
     /* Always store the VXC into the FPC, without AFP it is undefined */
     env->fpc = deposit32(env->fpc, 8, 8, vxc);
-    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ILEN_AUTO, ra);
+    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ra);
 }
 
 void HELPER(data_exception)(CPUS390XState *env, uint32_t dxc)
@@ -614,7 +614,7 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, retaddr);
+    s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
 }
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 5faf973c6c..7228eb96e2 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -825,7 +825,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
     if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u ||
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     /* Install everything in the main FPC.  */
@@ -843,7 +843,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
 
     if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u ||
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     /*
@@ -880,7 +880,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
 void HELPER(srnm)(CPUS390XState *env, uint64_t rnd)
 {
     if (rnd > 0x7 || fpc_to_rnd[rnd & 0x7] == -1) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     env->fpc = deposit32(env->fpc, 0, 3, rnd);
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index d13cc49be6..1d29a1fc1f 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -39,7 +39,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
     int64_t q;
 
     if (b == 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     ret = q = a / b;
@@ -47,7 +47,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
 
     /* Catch non-representable quotient.  */
     if (ret != q) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     return ret;
@@ -60,7 +60,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
     uint64_t q;
 
     if (b == 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     ret = q = a / b;
@@ -68,7 +68,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
 
     /* Catch non-representable quotient.  */
     if (ret != q) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     return ret;
@@ -79,7 +79,7 @@ int64_t HELPER(divs64)(CPUS390XState *env, int64_t a, int64_t b)
 {
     /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
     if (b == 0 || (b == -1 && a == (1ll << 63))) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
     env->retxl = a % b;
     return a / b;
@@ -92,7 +92,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
     uint64_t ret;
     /* Signal divide by zero.  */
     if (b == 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
     if (ah == 0) {
         /* 64 -> 64/64 case */
@@ -106,7 +106,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
         env->retxl = a % b;
         ret = q;
         if (ret != q) {
-            s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
+            s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
         }
 #else
         /* 32-bit hosts would need special wrapper functionality - just abort if
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index b798e2ecbe..2b71e03914 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -34,8 +34,7 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
     }
 }
 
-void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
-                            uintptr_t ra)
+void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
 {
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(env_archcpu(env), code);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 83c164a168..c437a1d8c6 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -44,7 +44,7 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, ra);
         return;
     }
     trace_ioinst_sch_id("xsch", cssid, ssid, schid);
@@ -62,7 +62,7 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, ra);
         return;
     }
     trace_ioinst_sch_id("csch", cssid, ssid, schid);
@@ -80,7 +80,7 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, ra);
         return;
     }
     trace_ioinst_sch_id("hsch", cssid, ssid, schid);
@@ -116,7 +116,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
@@ -125,7 +125,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     }
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_schib_valid(&schib)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
     trace_ioinst_sch_id("msch", cssid, ssid, schid);
@@ -173,7 +173,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
@@ -183,7 +183,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     copy_orb_from_guest(&orb, &orig_orb);
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_orb_valid(&orb)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
     trace_ioinst_sch_id("ssch", cssid, ssid, schid);
@@ -205,7 +205,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
 
@@ -236,7 +236,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
 
@@ -247,7 +247,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
          * access execption if it is not) first.
          */
         if (!s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib))) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+            s390_program_interrupt(env, PGM_OPERAND, ra);
         } else {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
         }
@@ -299,13 +299,13 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     uint8_t ar;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -EIO;
     }
 
@@ -613,7 +613,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     addr = env->regs[reg];
     /* Page boundary? */
     if (addr & 0xfff) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
     /*
@@ -629,7 +629,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     len = be16_to_cpu(req->len);
     /* Length field valid? */
     if ((len < 16) || (len > 4088) || (len & 7)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
     memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
@@ -678,7 +678,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
     trace_ioinst("schm");
 
     if (SCHM_REG1_RES(reg1)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
 
@@ -687,7 +687,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
     dct = SCHM_REG1_DCT(reg1);
 
     if (update && (reg2 & 0x000000000000001f)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
 
@@ -700,7 +700,7 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, ra);
         return;
     }
     trace_ioinst_sch_id("rsch", cssid, ssid, schid);
@@ -724,7 +724,7 @@ void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
 
     if (RCHP_REG1_RES(reg1)) {
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
 
@@ -747,7 +747,7 @@ void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
         break;
     default:
         /* Invalid channel subsystem. */
-        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
     setcc(cpu, cc);
@@ -758,6 +758,6 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     /* We do not provide address limit checking, so let's suppress it. */
     if (SAL_REG1_INVALID(reg1) || reg1 & 0x000000000000ffff) {
-        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, ra);
     }
 }
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 08c5cc6a99..77d2eb96d4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -71,7 +71,7 @@ static inline void check_alignment(CPUS390XState *env, uint64_t v,
                                    int wordsize, uintptr_t ra)
 {
     if (v % wordsize) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 }
 
@@ -730,7 +730,7 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
     /* Bits 32-55 must contain all 0.  */
     if (env->regs[0] & 0xffffff00u) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     str = get_address(env, r2);
@@ -767,7 +767,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
     /* Bits 32-47 of R0 must be zero.  */
     if (env->regs[0] & 0xffff0000u) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     str = get_address(env, r2);
@@ -846,7 +846,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
     S390Access srca, desta;
 
     if ((f && s) || extract64(r0, 12, 4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     r1 = wrap_address(env, r1 & TARGET_PAGE_MASK);
@@ -879,7 +879,7 @@ uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     int i;
 
     if (env->regs[0] & 0xffffff00ull) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     /*
@@ -911,8 +911,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     int i;
 
     if (a2 & 0x3) {
-        /* we either came here by lam or lamy, which have different lengths */
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -932,7 +931,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     int i;
 
     if (a2 & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1888,7 +1887,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     return cc;
 
  spec_exception:
-    s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+    s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     g_assert_not_reached();
 }
 
@@ -1912,7 +1911,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (src & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1945,7 +1944,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (src & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1976,7 +1975,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (dest & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1996,7 +1995,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (dest & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -2168,7 +2167,7 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
     if (!(env->psw.mask & PSW_MASK_DAT) || !(env->cregs[0] & CR0_SECONDARY) ||
         psw_as == AS_HOME || psw_as == AS_ACCREG) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
 
     l = wrap_length32(env, l);
@@ -2199,7 +2198,7 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
     if (!(env->psw.mask & PSW_MASK_DAT) || !(env->cregs[0] & CR0_SECONDARY) ||
         psw_as == AS_HOME || psw_as == AS_ACCREG) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ILEN_AUTO, ra);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
 
     l = wrap_length32(env, l);
@@ -2226,7 +2225,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
     uint16_t entries, i, index = 0;
 
     if (r2 & 0xff000) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     if (!(r2 & 0x800)) {
@@ -2370,7 +2369,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, 2, GETPC());
+        s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
     }
 
     old_exc = cs->exception_index;
@@ -2539,7 +2538,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
                __func__, dest, src, len);
 
     if (!(env->psw.mask & PSW_MASK_DAT)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
 
     /* OAC (operand access control) for the first operand -> dest */
@@ -2570,14 +2569,14 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
     }
 
     if (dest_a && dest_as == AS_HOME && (env->psw.mask & PSW_MASK_PSTATE)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
     if (!(env->cregs[0] & CR0_SECONDARY) &&
         (dest_as == AS_SECONDARY || src_as == AS_SECONDARY)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, 6, ra);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
     if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
     }
 
     len = wrap_length32(env, len);
@@ -2591,7 +2590,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
         (env->psw.mask & PSW_MASK_PSTATE)) {
         qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing\n",
                       __func__);
-        s390_program_interrupt(env, PGM_ADDRESSING, 6, ra);
+        s390_program_interrupt(env, PGM_ADDRESSING, ra);
     }
 
     /* FIXME: Access using correct keys and AR-mode */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 7530dcb8f3..9fbb37cfb9 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -106,7 +106,7 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
     int r = sclp_service_call(env, r1, r2);
     qemu_mutex_unlock_iothread();
     if (r < 0) {
-        s390_program_interrupt(env, -r, 4, GETPC());
+        s390_program_interrupt(env, -r, GETPC());
     }
     return r;
 }
@@ -143,7 +143,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     }
 
     if (r) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 }
 
@@ -222,7 +222,7 @@ void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
     uint32_t val = r0;
 
     if (val & 0xffff0000) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
+        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
     env->todpr = val;
 }
@@ -266,7 +266,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
     }
 
     if ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     if ((r0 & STSI_R0_FC_MASK) == STSI_R0_FC_CURRENT) {
@@ -276,7 +276,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
     }
 
     if (a0 & ~TARGET_PAGE_MASK) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     /* count the cpus and split them into configured and reserved ones */
@@ -509,7 +509,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
     LowCore *lowcore;
 
     if (addr & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     qemu_mutex_lock_iothread();
@@ -573,17 +573,8 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 #ifndef CONFIG_USER_ONLY
 void HELPER(per_check_exception)(CPUS390XState *env)
 {
-    uint32_t ilen;
-
     if (env->per_perc_atmid) {
-        /*
-         * FIXME: ILEN_AUTO is most probably the right thing to use. ilen
-         * always has to match the instruction referenced in the PSW. E.g.
-         * if a PER interrupt is triggered via EXECUTE, we have to use ilen
-         * of EXECUTE, while per_address contains the target of EXECUTE.
-         */
-        ilen = get_ilen(cpu_ldub_code(env, env->per_address));
-        s390_program_interrupt(env, PGM_PER, ilen, GETPC());
+        s390_program_interrupt(env, PGM_PER, GETPC());
     }
 }
 
@@ -673,7 +664,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
     int i;
 
     if (addr & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     prepare_stfl();
@@ -746,7 +737,7 @@ void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
     qemu_mutex_unlock_iothread();
     /* css_do_sic() may actually return a PGM_xxx value to inject */
     if (r) {
-        s390_program_interrupt(env, -r, 4, GETPC());
+        s390_program_interrupt(env, -r, GETPC());
     }
 }
 
-- 
2.17.1


