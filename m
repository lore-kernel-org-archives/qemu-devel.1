Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA86BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 23:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9656220692
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="D9YKJ3D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9656220692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXvSe-0001Mz-To
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 18:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iXvNo-0005wQ-QB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iXvNn-0005pn-9J
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:57:04 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:40434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iXvNn-0005pI-1P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:57:03 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xALMujDi027515; Thu, 21 Nov 2019 14:57:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=MTGn9Affg3FX/o+lDey4B+G2I1n8oyt7fyv9hdbTV1s=;
 b=D9YKJ3D76JNuDQjBh5eaz+gEVM8qOz+c2U20rUmA8d7ntYuaw7H9YvLgkMuzcnyJ7OHn
 eGzfEVL4kY4jGJXlH59C+uptanPCPd++SyQz/Rt09eGZH+3iN32RKu4ouoMf8FwcufxO
 t8s3fbg/R6Nyc/gvB/aV0bUj0f2g+HwL4BJinCcLO9fv8gxVdgEtLN+oNOeAgeCL26H1
 EjmS/sGoPl6g4mM/ENwZGhy1zJya+TKq40FGK3CoPkL/lN5CYVEA1yr7fM7uN8hQK3Lp
 XBVYrG+kdeVslx7j8iSS5Qyp9HU4eqqMF9ZE+qb4YNTB79DG/5bLBXFTGiGsg0J6vFgt NA== 
Received: from ma1-mtap-s02.corp.apple.com (ma1-mtap-s02.corp.apple.com
 [17.40.76.6])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2wb27r8ws7-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 21 Nov 2019 14:57:02 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s02.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1C0084FD2XSN00@ma1-mtap-s02.corp.apple.com>; Thu,
 21 Nov 2019 14:57:01 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1C00200CPUWV00@nwk-mmpp-sz11.apple.com>; Thu,
 21 Nov 2019 14:57:01 -0800 (PST)
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 68762ae16886458bf29d00cd16ced23e
X-V-R-CD: 079ab5962a430194fb375439bf6c9e22
X-V-CD: 0
X-V-ID: e156e455-b310-4fbc-aa81-d06e81965175
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-21_06:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.199]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1C00JWACZIHUA0@nwk-mmpp-sz11.apple.com>; Thu,
 21 Nov 2019 14:54:54 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 3/5] hvf: correctly handle REX prefix in relation to legacy
 prefixes
Date: Thu, 21 Nov 2019 14:54:52 -0800
Message-id: <452dc9f9126f3bad20aeb803c9ad555f0f86c0f9.1574375668.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1574375668.git.dirty@apple.com>
References: <cover.1574375668.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-21_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

In real x86 processors, the REX prefix must come after legacy prefixes.
REX before legacy is ignored.  Update the HVF emulation code to properly
handle this.  Fix some spelling errors in constants.  Fix some decoder
table initialization issues found by Coverity.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/hvf/x86_decode.c | 55 +++++++++++++++++++-----------------
 target/i386/hvf/x86_decode.h | 16 +++++------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 822fa1866e..e2806f7967 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -122,7 +122,8 @@ static void decode_rax(CPUX86State *env, struct x86_decode *decode,
 {
     op->type = X86_VAR_REG;
     op->reg = R_EAX;
-    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, 0,
+    /* Since reg is always AX, REX prefix has no impact. */
+    op->ptr = get_reg_ref(env, op->reg, false, 0,
                           decode->operand_size);
 }
 
@@ -1687,40 +1688,35 @@ calc_addr:
     }
 }
 
-target_ulong get_reg_ref(CPUX86State *env, int reg, int rex, int is_extended,
+target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present, int is_extended,
                          int size)
 {
     target_ulong ptr = 0;
-    int which = 0;
 
     if (is_extended) {
         reg |= R_R8;
     }
 
-
     switch (size) {
     case 1:
-        if (is_extended || reg < 4 || rex) {
-            which = 1;
+        if (is_extended || reg < 4 || rex_present) {
             ptr = (target_ulong)&RL(env, reg);
         } else {
-            which = 2;
             ptr = (target_ulong)&RH(env, reg - 4);
         }
         break;
     default:
-        which = 3;
         ptr = (target_ulong)&RRX(env, reg);
         break;
     }
     return ptr;
 }
 
-target_ulong get_reg_val(CPUX86State *env, int reg, int rex, int is_extended,
+target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present, int is_extended,
                          int size)
 {
     target_ulong val = 0;
-    memcpy(&val, (void *)get_reg_ref(env, reg, rex, is_extended, size), size);
+    memcpy(&val, (void *)get_reg_ref(env, reg, rex_present, is_extended, size), size);
     return val;
 }
 
@@ -1853,28 +1849,35 @@ void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
 static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
 {
     while (1) {
+        /* REX prefix must come after legacy prefixes.  REX before legacy is ignored.
+           Clear rex to simulate this. */
         uint8_t byte = decode_byte(env, decode);
         switch (byte) {
         case PREFIX_LOCK:
             decode->lock = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_REPN:
         case PREFIX_REP:
             decode->rep = byte;
+            decode->rex.rex = 0;
             break;
-        case PREFIX_CS_SEG_OVEERIDE:
-        case PREFIX_SS_SEG_OVEERIDE:
-        case PREFIX_DS_SEG_OVEERIDE:
-        case PREFIX_ES_SEG_OVEERIDE:
-        case PREFIX_FS_SEG_OVEERIDE:
-        case PREFIX_GS_SEG_OVEERIDE:
+        case PREFIX_CS_SEG_OVERRIDE:
+        case PREFIX_SS_SEG_OVERRIDE:
+        case PREFIX_DS_SEG_OVERRIDE:
+        case PREFIX_ES_SEG_OVERRIDE:
+        case PREFIX_FS_SEG_OVERRIDE:
+        case PREFIX_GS_SEG_OVERRIDE:
             decode->segment_override = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_OP_SIZE_OVERRIDE:
             decode->op_size_override = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_ADDR_SIZE_OVERRIDE:
             decode->addr_size_override = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_REX ... (PREFIX_REX + 0xf):
             if (x86_is_long_mode(env_cpu(env))) {
@@ -2111,14 +2114,14 @@ void init_decoder()
 {
     int i;
     
-    for (i = 0; i < ARRAY_SIZE(_decode_tbl2); i++) {
-        memcpy(_decode_tbl1, &invl_inst, sizeof(invl_inst));
+    for (i = 0; i < ARRAY_SIZE(_decode_tbl1); i++) {
+        memcpy(&_decode_tbl1[i], &invl_inst, sizeof(invl_inst));
     }
     for (i = 0; i < ARRAY_SIZE(_decode_tbl2); i++) {
-        memcpy(_decode_tbl2, &invl_inst, sizeof(invl_inst));
+        memcpy(&_decode_tbl2[i], &invl_inst, sizeof(invl_inst));
     }
     for (i = 0; i < ARRAY_SIZE(_decode_tbl3); i++) {
-        memcpy(_decode_tbl3, &invl_inst, sizeof(invl_inst_x87));
+        memcpy(&_decode_tbl3[i], &invl_inst_x87, sizeof(invl_inst_x87));
     
     }
     for (i = 0; i < ARRAY_SIZE(_1op_inst); i++) {
@@ -2167,22 +2170,22 @@ target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
                                target_ulong addr, X86Seg seg)
 {
     switch (decode->segment_override) {
-    case PREFIX_CS_SEG_OVEERIDE:
+    case PREFIX_CS_SEG_OVERRIDE:
         seg = R_CS;
         break;
-    case PREFIX_SS_SEG_OVEERIDE:
+    case PREFIX_SS_SEG_OVERRIDE:
         seg = R_SS;
         break;
-    case PREFIX_DS_SEG_OVEERIDE:
+    case PREFIX_DS_SEG_OVERRIDE:
         seg = R_DS;
         break;
-    case PREFIX_ES_SEG_OVEERIDE:
+    case PREFIX_ES_SEG_OVERRIDE:
         seg = R_ES;
         break;
-    case PREFIX_FS_SEG_OVEERIDE:
+    case PREFIX_FS_SEG_OVERRIDE:
         seg = R_FS;
         break;
-    case PREFIX_GS_SEG_OVEERIDE:
+    case PREFIX_GS_SEG_OVERRIDE:
         seg = R_GS;
         break;
     default:
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index bc574a7a44..e50ae34adf 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -27,12 +27,12 @@ typedef enum x86_prefix {
     PREFIX_REPN =                  0xf2,
     PREFIX_REP =                   0xf3,
     /* group 2 */
-    PREFIX_CS_SEG_OVEERIDE =       0x2e,
-    PREFIX_SS_SEG_OVEERIDE =       0x36,
-    PREFIX_DS_SEG_OVEERIDE =       0x3e,
-    PREFIX_ES_SEG_OVEERIDE =       0x26,
-    PREFIX_FS_SEG_OVEERIDE =       0x64,
-    PREFIX_GS_SEG_OVEERIDE =       0x65,
+    PREFIX_CS_SEG_OVERRIDE =       0x2e,
+    PREFIX_SS_SEG_OVERRIDE =       0x36,
+    PREFIX_DS_SEG_OVERRIDE =       0x3e,
+    PREFIX_ES_SEG_OVERRIDE =       0x26,
+    PREFIX_FS_SEG_OVERRIDE =       0x64,
+    PREFIX_GS_SEG_OVERRIDE =       0x65,
     /* group 3 */
     PREFIX_OP_SIZE_OVERRIDE =      0x66,
     /* group 4 */
@@ -303,9 +303,9 @@ uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
 
-target_ulong get_reg_ref(CPUX86State *env, int reg, int rex, int is_extended,
+target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present, int is_extended,
                          int size);
-target_ulong get_reg_val(CPUX86State *env, int reg, int rex, int is_extended,
+target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present, int is_extended,
                          int size);
 void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
                         struct x86_decode_op *op);
-- 
2.24.0


