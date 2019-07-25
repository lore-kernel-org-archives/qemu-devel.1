Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAF8C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DAB206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DSSBaOdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DAB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiua-0001np-MK
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqite-0006LE-JU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitd-0007us-B2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitc-0007rZ-SZ; Thu, 25 Jul 2019 14:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564080921; x=1595616921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XNjBwmh1LFBChEJ+quD7Z2691WqYMlE30zxPXnx8bn8=;
 b=DSSBaOdp52zuqbgFbj7CRCV6RncG3SLz8lscsg0dkb4HGlTcsGKfFgcX
 SUTgDBmCMpe/SJ7902dicOTR7fuhtZdQ5ftzrIUYAskXpHtfYElPyHCRU
 uusnnZmyeUFUpIIXtsFKXWyLbFbsr/IRTDfDiU2JXZRXU7r+zEKBw0zl+
 ddqSQQw+lOxvRQPzW1M5jrobAvxY9FG4miqjrspo0/OlxW7DNsB8QtTtx
 HtbdtByMgzBtUah1WmNG3HoGAOLoq2AxI8W7UDAfEoEaWGO7MBkOIirTe
 XEKnDL79FAMbPNl5P+f8Af91syMS+UkoluC/vW2FxhYVvDnI0H7T84W9L A==;
IronPort-SDR: 3U+L11vXi7BcPCiwhAK9ztxiKoMCv1n6Vzygnqiqj3Fkml5859yH39k6OI4yC9Uiq3MzuZWk5W
 VF0kn92SdVR+nRTi1zcO747qQvG9MfM+mTgdlpw7NHp+ciILVb9WnokNvh2AW7dGP1CCqiRx1L
 YMPC95ecQczW5Vj79o92BLcBVgbBYl0yrU+mIrG15YNfqp7KUwBuCBGniLqXQgSUgygLnuRUdv
 A5Enklz72dZaLfPCJvu9+1729eelrsNvNTgo30tvf6l/nTC1BodLP4QIkzHWWcLdSWSdEuMKUA
 olI=
X-IronPort-AV: E=Sophos;i="5.64,307,1559491200"; d="scan'208";a="115109069"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 02:55:19 +0800
IronPort-SDR: lhXjGBIP1sEA8PwGoQ0oPABExk0ow3XaZdYB/pl1x1si3frnyg784YBQvec1AfMFtse4xovPx7
 +7dBgUVPMz6aG+M54S08NAS3yFrPOVpi1zb2pBz12hU4mQGqNfe6a6xIlMwAXd59xqfI6CqRfz
 Vl2m00mDKF76+/LHgvl+QkP/hM98LWh2vw0YnfivXEkA6lGbv6vHn/JK3Y/b/CPxgn2r5mN9VQ
 GBoBYcFl47NzUuX/yEyQFc66PEU5gF3wcVa6gbDYcM/sEsXh2S/Wnxd49oCvzs9utu9POtOCxi
 J2XrSw+5cuRaVgmLav0STxo7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 25 Jul 2019 11:53:29 -0700
IronPort-SDR: E8ifU7kZm71V8FGinzNexRn2uMalZnkYLqnTQY6H2JALVJURBjQqSuzdCwUYmpcEFfEcEVxIUy
 0iR8bTLGyR7a6SbT4KE42K/ku16IrDt/v5lIzNOIUYX7YLj/odEJtkEvUHPh5McDHjWL7mY3qP
 mgV5MnP50DaJjFKYyaYnWSK7zNv+T9z7O1urTVogGV3OXdUenRXcEpwZs09DcGK77KRQ6uZjMr
 ZxDPMyyurwEtAMEPoavogZkeHJIIRPCOzWaqAaFCrUdNYbXdvHUICKQcaK4VAAa8omV1QScliu
 RUs=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jul 2019 11:55:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 25 Jul 2019 11:52:14 -0700
Message-Id: <4116c27c037b5e7f4822cfd7199724450dc6b5da.1564080680.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564080680.git.alistair.francis@wdc.com>
References: <cover.1564080680.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH-4.2 v1 6/6] target/riscv: Fix Floating Point
 register names
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Atish Patra <atish.patra@wdc.com>

As per the RISC-V spec, Floating Point registers are named as f0..f31
so lets fix the register names accordingly.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20a..af1e9b7690 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] = {
 };
 
 const char * const riscv_fpr_regnames[] = {
-  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
-  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
-  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
-  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
+  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
+  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
+  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
+  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
 };
 
 const char * const riscv_excp_names[] = {
-- 
2.22.0


