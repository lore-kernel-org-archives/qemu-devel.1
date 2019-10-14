Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB9C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6713620873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="2+TsIVlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6713620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2dk-00026f-C6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iK2Yf-0005Eh-7a
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iK2Yd-00083a-7p
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:53 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:10123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iK2YK-0007o1-3S
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1571067989; h=Content-Transfer-Encoding: MIME-Version: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=mKfdVcMnjwr/PCEUJrPeGUjvWyXL5CqobGQSV80LBhI=;
 b=2+TsIVlW9qVqiYooExvIi5uQyk9mqulUBOB+gUwDuoJkYZifnpeVIbDNN2D0u5k2q9sqPIgh
 YgBUtiXIDPSaGboAuuxxFSl3HARSSFqm7gph/424fzX7w5EBt2sFvIFLRFaNFHT+LqIqvYWH
 7l6lcZo3dd+Q68qEtcgwQDHIZMGAGUqn6krFny0V+dYFIGMa+wHMaAkXM05L1QQkxU/QjJzB
 eK+A8Tw8zab76yrfzsblL39773XfkY/UFyMwDA9oXekHs8RjSUvQp0tztC5JIeumLaGAH6fe
 y6q1s2yd4guokLOcG8fHEXwxr2xmcQztV6d5wIJJxTVNzcdSdi6Ojw==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.pdos.lcs.mit.edu
 (26-5-211.dynamic.csail.mit.edu [18.26.5.211])
 by mxa.mailgun.org with ESMTP id 5da49851.7f705dace450-smtp-out-n01;
 Mon, 14 Oct 2019 15:46:25 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 1/3] target/riscv: Tell gdbstub the correct number of CSRs
Date: Mon, 14 Oct 2019 11:45:27 -0400
Message-Id: <20191014154529.287048-2-jonathan@fintelia.io>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014154529.287048-1-jonathan@fintelia.io>
References: <20191014154529.287048-1-jonathan@fintelia.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the number of registers reported to the gdbstub code does not match the
number in the associated XML file, then the register numbers used by the stub
may get out of sync with a remote GDB instance.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---
 target/riscv/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index ded140e8d8..cb5bfd3d50 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -384,7 +384,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             4096, "riscv-32bit-csr.xml", 0);
+                             240, "riscv-32bit-csr.xml", 0);
 #elif defined(TARGET_RISCV64)
     if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
@@ -392,6 +392,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             4096, "riscv-64bit-csr.xml", 0);
+                             240, "riscv-64bit-csr.xml", 0);
 #endif
 }
-- 
2.23.0

