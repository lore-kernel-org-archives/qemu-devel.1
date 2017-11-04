Received: from eggs.gnu.org ([2001:4830:134:3::10]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPe-0006D5-Eu
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPc-000110-E0
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:26 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:47258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPc-0000z2-2v
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:24 -0400
Received: by mail-lf0-x242.google.com with SMTP id k40so5158182lfi.4
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:23 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:17 -0700
Message-Id: <1509767121-26925-13-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 12/16] target/xtensa: add internal/noop SRs and
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

Add two special registers: MMID and DDR:
- MMID is write-only and the only side effect of writing to it is output
  to the trace port, which is not emulated;
- DDR is only accessible in debug mode, which is not emulated.

Add two debug-mode-only opcodes:
- rfdd and rfdo do return from the debug mode, which is not emulated.

Add three internal opcodes for full MMU:
- hwwdtlba and hwwitlba are the internal opcodes that write a value into
  autoupdate DTLB or ITLB entry.
- ldpte is internal opcode that loads PTE entry that covers the most
  recent page fault address.
None of these three opcodes may appear in a valid instruction.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  2 ++
 target/xtensa/translate.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d28249a2b37c..fae6d586d5cf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -127,6 +127,7 @@ enum {
     WINDOW_BASE = 72,
     WINDOW_START = 73,
     PTEVADDR = 83,
+    MMID = 89,
     RASID = 90,
     ITLBCFG = 91,
     DTLBCFG = 92,
@@ -134,6 +135,7 @@ enum {
     MEMCTL = 97,
     CACHEATTR = 98,
     ATOMCTL = 99,
+    DDR = 104,
     IBREAKA = 128,
     DBREAKA = 144,
     DBREAKC = 160,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index fb6a4c979590..f644d9fed22a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -135,6 +135,7 @@ static const XtensaReg sregnames[256] = {
     [WINDOW_START] = XTENSA_REG("WINDOW_START",
             XTENSA_OPTION_WINDOWED_REGISTER),
     [PTEVADDR] = XTENSA_REG("PTEVADDR", XTENSA_OPTION_MMU),
+    [MMID] = XTENSA_REG_BITS("MMID", XTENSA_OPTION_ALL),
     [RASID] = XTENSA_REG("RASID", XTENSA_OPTION_MMU),
     [ITLBCFG] = XTENSA_REG("ITLBCFG", XTENSA_OPTION_MMU),
     [DTLBCFG] = XTENSA_REG("DTLBCFG", XTENSA_OPTION_MMU),
@@ -142,6 +143,7 @@ static const XtensaReg sregnames[256] = {
     [MEMCTL] = XTENSA_REG_BITS("MEMCTL", XTENSA_OPTION_ALL),
     [CACHEATTR] = XTENSA_REG("CACHEATTR", XTENSA_OPTION_CACHEATTR),
     [ATOMCTL] = XTENSA_REG("ATOMCTL", XTENSA_OPTION_ATOMCTL),
+    [DDR] = XTENSA_REG("DDR", XTENSA_OPTION_DEBUG),
     [IBREAKA] = XTENSA_REG("IBREAKA0", XTENSA_OPTION_DEBUG),
     [IBREAKA + 1] = XTENSA_REG("IBREAKA1", XTENSA_OPTION_DEBUG),
     [DBREAKA] = XTENSA_REG("DBREAKA0", XTENSA_OPTION_DEBUG),
@@ -2767,6 +2769,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "extw",
         .translate = translate_nop,
     }, {
+        .name = "hwwdtlba",
+        .translate = translate_ill,
+    }, {
+        .name = "hwwitlba",
+        .translate = translate_ill,
+    }, {
         .name = "idtlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){true},
@@ -2852,6 +2860,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, 0, 4},
     }, {
+        .name = "ldpte",
+        .translate = translate_ill,
+    }, {
         .name = "loop",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NEVER},
@@ -3270,9 +3281,15 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "retw.n",
         .translate = translate_retw,
     }, {
+        .name = "rfdd",
+        .translate = translate_ill,
+    }, {
         .name = "rfde",
         .translate = translate_rfde,
     }, {
+        .name = "rfdo",
+        .translate = translate_ill,
+    }, {
         .name = "rfe",
         .translate = translate_rfe,
     }, {
@@ -3373,6 +3390,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .par = (const uint32_t[]){DBREAKC + 1},
     }, {
+        .name = "rsr.ddr",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){DDR},
+    }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
@@ -3808,6 +3829,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .par = (const uint32_t[]){DBREAKC + 1},
     }, {
+        .name = "wsr.ddr",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){DDR},
+    }, {
         .name = "wsr.debugcause",
         .translate = translate_wsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
@@ -4000,6 +4025,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .par = (const uint32_t[]){MISC + 3},
     }, {
+        .name = "wsr.mmid",
+        .translate = translate_wsr,
+        .par = (const uint32_t[]){MMID},
+    }, {
         .name = "wsr.prid",
         .translate = translate_wsr,
         .par = (const uint32_t[]){PRID},
@@ -4127,6 +4156,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .par = (const uint32_t[]){DBREAKC + 1},
     }, {
+        .name = "xsr.ddr",
+        .translate = translate_xsr,
+        .par = (const uint32_t[]){DDR},
+    }, {
         .name = "xsr.debugcause",
         .translate = translate_xsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
-- 
2.1.4
