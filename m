Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0424C54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F00D2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="Mjr+QCct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F00D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2wU-0003Mi-JP
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vR-00023a-Md
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vQ-0006oK-Oe
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:17 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jH2vQ-0006lK-0k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585130733; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=cmJkO8O1uEeT/jpyHVBIdGnY9ZmSMm8JaT5BGhbnOQg=;
 b=Mjr+QCctv3V0+DQGsOF38CtHzU9LocIkcjv3hJSZJqJwurtw3tTlYXtHwN6wbdsy
 tZkEHkeRMMYu++X55XYd7rSr57HEfs314l1TF8DBaRaMKX4C6RqMJZc965rgD6sYKUk
 ouwgBdRGf0YQs2t+lutzn4z6z+Vd1Rm9QMH1Og/c=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 1585130731636241.03722169549985;
 Wed, 25 Mar 2020 18:05:31 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200325100520.206210-4-jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] target/mips: Add loongson gs464 core
Date: Wed, 25 Mar 2020 18:05:20 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
References: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GS464 is the core we can found in Loongson-3A1000 processor with
MIPS64R2 as baseline ISA and Loongson self defined MMI & EXT ASE.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate_init.inc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.=
inc.c
index 6d145a905a..4e1eb5a2e4 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -830,7 +830,30 @@ const mips_def_t mips_defs[] =3D
         .insn_flags =3D CPU_MIPS64R2 | ASE_DSP | ASE_DSP_R2,
         .mmu_type =3D MMU_TYPE_R4000,
     },
-
+    {
+        .name =3D "gs464",
+        .CP0_PRid =3D 0x6305,
+        .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_=
AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU=
) |
+                       (3 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA)=
 |
+                       (3 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA)=
 |
+                       (1 << CP0C1_C2) | (1 << CP0C1_PC) | (1 << CP0C1_EP)=
,
+        .CP0_Config2 =3D MIPS_CONFIG2 | (1 << CP0C2_SU) | (6 << CP0C2_SU) =
|
+                        (4 << CP0C2_SU) | (3 << CP0C2_SU),
+        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_LPA),
+        .CP0_PageGrain =3D (1 << CP0PG_ELPA),
+        .SYNCI_Step =3D 32,
+        .CCRes =3D 2,
+        .CP0_Status_rw_bitmask =3D 0x76FBFFFF,
+        .CP1_fcr0 =3D (1 << FCR0_F64) | (1 << FCR0_PS) | (1 << FCR0_L) |
+                    (1 << FCR0_W) | (1 << FCR0_D) | (1 << FCR0_S) |
+                    (0x01 << FCR0_PRID) | (0x1 << FCR0_REV),
+        .SEGBITS =3D 42,
+        .PABITS =3D 48,
+        .insn_flags =3D CPU_MIPS64R2 | ASE_LOONGSON_MMI | ASE_LOONGSON_EXT=
,
+        .mmu_type =3D MMU_TYPE_R4000,
+    },
 #endif
 };
 const int mips_defs_number =3D ARRAY_SIZE(mips_defs);
--=20
2.26.0.rc2



