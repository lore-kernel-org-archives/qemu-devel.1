Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212BDC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E193E2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E193E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJN2-0001G9-51
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 15:58:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hEJME-0000x2-Pf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hEJMD-0005wO-Rc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:58:06 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:46382
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hEJMD-0005w5-Jf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:58:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id 00827DB1F96;
	Wed, 10 Apr 2019 21:48:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
	by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id S2ZBroo6CLon; Wed, 10 Apr 2019 21:48:43 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id 50466DB165C;
	Wed, 10 Apr 2019 21:48:43 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
	id 3D11D460011; Wed, 10 Apr 2019 21:48:43 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 21:48:38 +0200
Message-Id: <20190410194838.10123-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] tci: Add implementation for INDEX_op_ld16u_i64
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410194838.LsCmuzJJKhW-BTNXmUOB-LXgXLkZBVET8jUdTp6QSTQ@z>

This fixes "make check-tcg" on a Debian x86_64 host.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 tcg/tci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1903..a6208653e8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -127,6 +127,12 @@ static void tci_write_reg8(tcg_target_ulong *regs, TCGReg index, uint8_t value)
     tci_write_reg(regs, index, value);
 }
 
+static void
+tci_write_reg16(tcg_target_ulong *regs, TCGReg index, uint16_t value)
+{
+    tci_write_reg(regs, index, value);
+}
+
 static void
 tci_write_reg32(tcg_target_ulong *regs, TCGReg index, uint32_t value)
 {
@@ -585,6 +591,8 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i32:
+            TODO();
+            break;
         case INDEX_op_ld16u_i32:
             TODO();
             break;
@@ -854,7 +862,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i64:
+            TODO();
+            break;
         case INDEX_op_ld16u_i64:
+            t0 = *tb_ptr++;
+            t1 = tci_read_r(regs, &tb_ptr);
+            t2 = tci_read_s32(&tb_ptr);
+            tci_write_reg16(regs, t0, *(uint16_t *)(t1 + t2));
+            break;
         case INDEX_op_ld16s_i64:
             TODO();
             break;
-- 
2.20.1


