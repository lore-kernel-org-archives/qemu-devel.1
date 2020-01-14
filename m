Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B04C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 20:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8687024655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 20:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irSig-0001Ey-L3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 15:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1irShy-0000V7-VJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 15:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1irShx-0005QT-95
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 15:22:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:63979)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1irShx-0005Fo-2e
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 15:22:37 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0CA1F74594E;
 Tue, 14 Jan 2020 21:22:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E859E745702; Tue, 14 Jan 2020 21:22:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 14 Jan 2020 21:13:42 +0100
Subject: [PATCH] target/m68k: Allow movec only on 68010+
To: qemu-devel@nongnu.org
Message-Id: <20200114202226.E859E745702@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The movec opcode does not exist on 68000 and should raise an
exception. Fix the feature mask to only allow movec on newer 68k CPUs.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index fcdb7bc8e4..f19da064c8 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5988,7 +5988,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(stop,      4e72, ffff);
     BASE(rte,       4e73, ffff);
     INSN(cf_movec,  4e7b, ffff, CF_ISA_A);
-    INSN(m68k_movec, 4e7a, fffe, M68000);
+    INSN(m68k_movec, 4e7a, fffe, FPU);
 #endif
     BASE(nop,       4e71, ffff);
     INSN(rtd,       4e74, ffff, RTD);
-- 
2.13.7


