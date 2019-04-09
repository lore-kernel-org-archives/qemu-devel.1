Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A620C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE772083E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE772083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDk17-0001ya-FM
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 02:13:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDk0H-0001cG-J3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDk0G-0005Mz-M9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:13:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:43718
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>)
	id 1hDk0G-0005Ml-DG; Tue, 09 Apr 2019 02:13:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id B1AD4DB6050;
	Tue,  9 Apr 2019 08:04:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
	by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 0hL-XRLQcPSb; Tue,  9 Apr 2019 08:04:38 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id E83CFDB604C;
	Tue,  9 Apr 2019 08:04:38 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
	id DD47A46000F; Tue,  9 Apr 2019 08:04:38 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Date: Tue,  9 Apr 2019 08:04:35 +0200
Message-Id: <20190409060435.22801-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409060435.BpsAiVpcWsAkiz-9P4GY2R0YryvacwYBCkoSwFU_xms@z>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 tcg/tci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1903..20b0715b6e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -1,7 +1,7 @@
 /*
  * Tiny Code Interpreter for QEMU
  *
- * Copyright (c) 2009, 2011, 2016 Stefan Weil
+ * Copyright (c) 2009, 2011, 2016, 2019 Stefan Weil
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -159,7 +159,8 @@ static uint64_t tci_uint64(uint32_t high, uint32_t low)
 /* Read constant (native size) from bytecode. */
 static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
 {
-    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
+    tcg_target_ulong value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -167,7 +168,8 @@ static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
 /* Read unsigned constant (32 bit) from bytecode. */
 static uint32_t tci_read_i32(uint8_t **tb_ptr)
 {
-    uint32_t value = *(uint32_t *)(*tb_ptr);
+    uint32_t value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -175,7 +177,8 @@ static uint32_t tci_read_i32(uint8_t **tb_ptr)
 /* Read signed constant (32 bit) from bytecode. */
 static int32_t tci_read_s32(uint8_t **tb_ptr)
 {
-    int32_t value = *(int32_t *)(*tb_ptr);
+    int32_t value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -184,7 +187,8 @@ static int32_t tci_read_s32(uint8_t **tb_ptr)
 /* Read constant (64 bit) from bytecode. */
 static uint64_t tci_read_i64(uint8_t **tb_ptr)
 {
-    uint64_t value = *(uint64_t *)(*tb_ptr);
+    uint64_t value;
+    memcpy(&value, *tb_ptr, sizeof(value));
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -474,7 +478,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     long tcg_temps[CPU_TEMP_BUF_NLONGS];
     uintptr_t sp_value = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
-    uintptr_t ret = 0;
+    uint64_t ret = 0;
 
     regs[TCG_AREG0] = (tcg_target_ulong)env;
     regs[TCG_REG_CALL_STACK] = sp_value;
@@ -1094,7 +1098,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             /* QEMU specific operations. */
 
         case INDEX_op_exit_tb:
-            ret = *(uint64_t *)tb_ptr;
+            memcpy(&ret, tb_ptr, sizeof(uint64_t));
             goto exit;
             break;
         case INDEX_op_goto_tb:
-- 
2.11.0


