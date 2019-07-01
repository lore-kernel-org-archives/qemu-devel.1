Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1077C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC8E20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="TEqhY4qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC8E20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhygT-0007K1-AL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:57:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49078)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hhyWb-0007ht-6y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hhyWa-00064W-9U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:47:25 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:11874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hhyWa-0005uM-5N
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:47:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1561996030; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
 Date: Subject: Cc: To: From: Sender;
 bh=lBCHiDL7WNGa2WRZT3RH1NkA3mkdOOmWboMA1YaH7Ak=;
 b=TEqhY4qjyNu7mVBPg8wpo9s++jOaaxSPW8LeV+ATHbu50WOQcmAQGCI1a1ZxpZPCquFnueh6
 ugWSrJuhGbxAkBC/cGpOj9eX2hMwknFBy5VCI463Np+VJus+oezkTUAF3Vqtri167Kx3IePG
 SSWMo0Dhknnc/2zgT8yvvIOU8JBUlKRNvq2MgjOqqvxJ0ecH9EGBcQTeMrQ5XCKYwurl09XU
 h4mF7NjXyWrkELwr7y2oaHEv9In66ABwxMvLbR9eNBRlTEhdZGIuI0bq5TTCgMAe7dD43x5H
 t5Yxc9uZCxkHIS5/3VxAqR3T83EXqwn/1mGYXbKHALiWvl14WtoOCw==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.csail.mit.edu
 (30-9-3.wireless.csail.mit.edu [128.30.9.3])
 by mxa.mailgun.org with ESMTP id 5d1a2afc.7fb1ab6aeb70-smtp-out-n01;
 Mon, 01 Jul 2019 15:47:08 -0000 (UTC)
From: jonathan@fintelia.io
To: qemu-riscv@nongnu.org
Date: Mon,  1 Jul 2019 11:46:17 -0400
Message-Id: <20190701154617.22908-1-jonathan@fintelia.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Subject: [Qemu-devel] [PATCH v2] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <jonathan@fintelia.io>

QEMU currently always triggers an illegal instruction exception when
code attempts to read the time CSR. This is valid behavor, but only if
the TM bit in mcounteren is hardwired to zero. This change also
corrects mcounteren and scounteren CSRs to be 32-bits on both 32-bit
and 64-bit targets.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
---
 target/riscv/cpu.h      | 4 ++--
 target/riscv/cpu_bits.h | 5 +++++
 target/riscv/csr.c      | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f32..2d0cbe9c78 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -151,8 +151,8 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
-    target_ulong scounteren;
-    target_ulong mcounteren;
+    uint32_t scounteren;
+    uint32_t mcounteren;
 
     target_ulong sscratch;
     target_ulong mscratch;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 11f971ad5d..0ea1e1caf5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -532,4 +532,9 @@
 #define SIP_STIP                           MIP_STIP
 #define SIP_SEIP                           MIP_SEIP
 
+/* mcounteren CSR bits */
+#define MCOUNTEREN_CY                      0x1
+#define MCOUNTEREN_TM                      0x2
+#define MCOUNTEREN_IR                      0x4
+
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e0d4586760..8425a6d2bd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -473,7 +473,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
     if (env->priv_ver < PRIV_VERSION_1_10_0) {
         return -1;
     }
-    env->mcounteren = val;
+    env->mcounteren = val & ~MCOUNTEREN_TM;
     return 0;
 }
 
-- 
2.22.0

