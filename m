Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCAC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BA0205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="LggFfnaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BA0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflHW-0006DY-DW
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hflAQ-0001D2-SJ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hflAN-0007ld-4E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:07:20 -0400
Received: from telepax.uni-paderborn.de ([131.234.189.14]:50786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hflAJ-0007g5-C6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W8OiDWXvhhBXnBnezRJGstX02qXPlNoorrxhyjQkvts=; b=LggFfnaJVroXNDyfu93FVG06eL
 tLzyx5dPyoRUTsCf2rRvmXNvZAlE9FeeDM//qDeNjPjV5HlY+DT04g2z0rbxkNCwoE5C6nlxgElsJ
 q/JAgq0Igjaa3AX9XAzmV1M1nzQjtJFqQQXcwZUmc87eAj5VVIh28eeziKL4jHm3UhZA=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 15:06:57 +0200
Message-Id: <20190625130658.24895-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190625130658.24895-1-kbastian@mail.uni-paderborn.de>
References: <20190625130658.24895-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.25.125716, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.14
Subject: [Qemu-devel] [PULL 4/5] tricore: sync ctx.hflags with tb->flags
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
Cc: peter.maydell@linaro.org, Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Georg Hofstetter <georg.hofstetter@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20190624070339.4408-5-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5d4febf1c0..c79566e56a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8810,6 +8810,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     ctx.singlestep_enabled = cs->singlestep_enabled;
     ctx.bstate = BS_NONE;
     ctx.mem_idx = cpu_mmu_index(env, false);
+    ctx.hflags = (uint32_t)tb->flags;
 
     tcg_clear_temp_count();
     gen_tb_start(tb);
-- 
2.22.0


