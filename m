Received: from eggs.gnu.org ([209.51.188.92]:49388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydO-0005AG-NS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydM-00071S-RY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:02 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydK-0006zz-Se
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:00 -0500
Received: by mail-lj1-x242.google.com with SMTP id q128so16334334ljb.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:11:56 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:49 -0800
Message-Id: <20190219061111.10231-2-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 01/23] target/xtensa: implement PREFCTL SR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Cache prefetch option adds an unprivileged SR PREFCTL. Add trivial
implementation for this SR.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  1 +
 target/xtensa/translate.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index a01a94e2a683..4d8152682fe1 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -131,6 +131,7 @@ enum {
     ACCLO = 16,
     ACCHI = 17,
     MR = 32,
+    PREFCTL = 40,
     WINDOW_BASE = 72,
     WINDOW_START = 73,
     PTEVADDR = 83,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 2fd64f8d995d..cbc52ecd8fa4 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -134,6 +134,7 @@ static const XtensaReg sregnames[256] = {
     [MR + 1] = XTENSA_REG("MR1", XTENSA_OPTION_MAC16),
     [MR + 2] = XTENSA_REG("MR2", XTENSA_OPTION_MAC16),
     [MR + 3] = XTENSA_REG("MR3", XTENSA_OPTION_MAC16),
+    [PREFCTL] = XTENSA_REG_BITS("PREFCTL", XTENSA_OPTION_ALL),
     [WINDOW_BASE] = XTENSA_REG("WINDOW_BASE", XTENSA_OPTION_WINDOWED_REGISTER),
     [WINDOW_START] = XTENSA_REG("WINDOW_START",
             XTENSA_OPTION_WINDOWED_REGISTER),
@@ -4152,6 +4153,11 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "rsr.prefctl",
+        .translate = translate_rsr,
+        .test_ill = test_ill_rsr,
+        .par = (const uint32_t[]){PREFCTL},
+    }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
@@ -4777,6 +4783,11 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MMID},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "wsr.prefctl",
+        .translate = translate_wsr,
+        .test_ill = test_ill_wsr,
+        .par = (const uint32_t[]){PREFCTL},
+    }, {
         .name = "wsr.prid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
@@ -5265,6 +5276,11 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "xsr.prefctl",
+        .translate = translate_xsr,
+        .test_ill = test_ill_xsr,
+        .par = (const uint32_t[]){PREFCTL},
+    }, {
         .name = "xsr.prid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
-- 
2.11.0
