Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA02C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383FB20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meNjWUU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383FB20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMBvo-0005UO-D4
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 10:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jM6hK-0003Mu-6j
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jM6hJ-00015L-8o
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:38 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jM6hJ-00015B-3w
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id t4so2281831plq.12
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AJdq9EhiCdLSVcbOQth7FpH7H9G2yKavu6s15Qit3QU=;
 b=meNjWUU7Rom/eLgKvl3ccII+1Rpvdyhl4sz4sEeYFgcKwz7LO0j+ERhyd8Dnwcg38d
 uEcCZfvI23e6Uyn6dNhQYbX1k+E7pB1b16cxe2tULtwXzFITMafcXFrdELOup/CfE5T1
 U/aunolCRPyPtSR8NfOuBzq8CM41dD7HBf+vHIpSZ/XGMEsDbLOzUZvjIpKujxjUlX93
 ZOr178zR7RWOReH7o6BxQmffecaagDXYz/ykJulDuSxNKCMHU0me6Tn3hMAjShAiBmgz
 ZMoyNP8u/Q8kj3OkZzNKquEUdora4EEVV46uOXXk7cRctGqcYmBVvLPJhAlmk6efH6O5
 BI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AJdq9EhiCdLSVcbOQth7FpH7H9G2yKavu6s15Qit3QU=;
 b=X0MDUb1DXVX0+Au3AnNq8Cl/jVMXR9iwuQPAyzL4TyoYeSqH3UczW3mzTtJh82sXKG
 MVhID2beF7kueKeCqsb9gVZCyabx/mJiXuKpVBRlAZbbDodAXiyUvIVAsAFrcvgVpOiY
 +KUTIHuQY0J0EIzlCb0brNnODcU3ex+R643UTL711eTpPeWdiTTC8WbEP28hPwmML1Vv
 zaOQRz+tqPJbQG1UbZdqlcNvriq5WWedXS8+hgvTBH4o5U/PoJ83cEx6ftxfYcwuAVn5
 g+3t9tk+cUjr6+qRu7q8s/lJt1g1YmV950bJYqRNwT4ZDmxzo3RCLTWW62eQVYZI0E8p
 Qx8Q==
X-Gm-Message-State: AGi0PuZ4G5SeEDI12KvU7aQHeZKY6Q+ChB5ebDS7EoP8jJRcYKgx8uNU
 hRYOq/5cVeQ3FKNFPfZ7VEU=
X-Google-Smtp-Source: APiQypJ6igsCX/AXtGM+l+i8xJP1Np5LQDoEz/ef89vzSKG6MUg6SjdK3kdGNgq/0alqL+2oHysdpA==
X-Received: by 2002:a17:90a:582:: with SMTP id i2mr4254749pji.51.1586336916182; 
 Wed, 08 Apr 2020 02:08:36 -0700 (PDT)
Received: from software.domain.org ([104.207.149.93])
 by smtp.gmail.com with ESMTPSA id o29sm16287584pfp.208.2020.04.08.02.08.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 08 Apr 2020 02:08:35 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
Date: Wed,  8 Apr 2020 17:16:20 +0800
Message-Id: <1586337380-25217-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
X-Mailman-Approved-At: Wed, 08 Apr 2020 10:41:29 -0400
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I submitted the MIPS/fulong2e support about ten years ago, and after
that I became a MIPS kernel developer. Last year, Philippe Mathieu-
Daudé asked me that whether I can be a reviewer of MIPS/fulong2e, and I
promised that I will do some QEMU work in the next year (i.e., 2020 and
later). I think now (and also in future) I can have some spare time, so
I can finally do some real work on QEMU/MIPS. And if possible, I hope I
can be a co-maintainer of MIPS/fulong2e.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 642c8e0..3281ff2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
 Fulong 2E
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+M: Huacai Chen <chenhc@lemote.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-- 
2.7.0


