Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE7EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B95221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="DW5g0qjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B95221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkxD-0004kB-5V
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknk-0001Yd-TO; Fri, 25 Sep 2020 06:18:06 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknh-0007Sp-TQ; Fri, 25 Sep 2020 06:18:04 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 08C2BC61424;
 Fri, 25 Sep 2020 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029041;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYIO6oVFxUZV1TH9x+9OCm3cGZXkpXFo/VqRcUn44+U=;
 b=DW5g0qjJIUMvhhgTBWSkRp+9YOyVNrwX/TP5EYfA9pPjQkKw4xKeLN3MSNEh5ScPFyHrsz
 NGZkXToXVrQ4VgC6E6iKmkeB8/EqM3i4iydCSaODOPMDqu1xtd0yAgQ+caGy11LnD2Bgjy
 zE+guOKG/BER9sTPEXjFevFEIs6z0PPPr2tgmwBI2xvGjMZQzDMx5gemd96iAoTjNmTw7a
 hUlh5VdfCNUMm3sTMOStOyz6Gbsiv+AonGiJzSVMg78KEMq1FWy5UzMp1+UUGCeCkbsCwa
 e+euD6wI4Cq3DYAsMV1KHVkLxW43dB2B38Szm2apup60oYERn38NACX+1KH52w==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/14] hw/arm/bcm2835_peripherals: connect the UART clock
Date: Fri, 25 Sep 2020 12:17:31 +0200
Message-Id: <20200925101731.2159827-15-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029041;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYIO6oVFxUZV1TH9x+9OCm3cGZXkpXFo/VqRcUn44+U=;
 b=Aj75JlhH/otuCtkq4rHuO8rkZ1y1YmCKr6nxnldTCBp2pdnqhPc5BMFOeJSXWWviXcJC+f
 gCne17Goy45PTbFyltcgeJK/zdDvLftHFwbzxh9PhKQKRvQv9Ho+q7jafOuPxmHr3n8Jhl
 QebBDH2fgUYE0/6NosS2GaaAy5WWM8mtFd9cyGyXCOB1iAeLYtqLCelEt8RLqQdkbUjNFl
 kH9YGs9GDlm92Xr/ji2olgHyZ+sQDJUoJ3GRWry22EKmM/9qa8yUB6MGaxw9hfhybOvLhb
 EQqGiaySnlq7hDIUKHTqXELGVIJ2mXfncJHplhXskMvnV9w9980X9vJC8CLFYg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029041; a=rsa-sha256; cv=none;
 b=dyaLWTww/X8AwLKqegqfKpDMeoo40HdqROuBVcSkNUZvT333OEohA5CHKidBgtgK9MkUQ6nejgfcVPKIC5EGg7kUKQWmUTHfAFGiIaYKOoY7uzQECeY6Ilxv+5AMtLzXSaQoW4pTyM7zIFT9nGZ0ByoM6MqFF7kXcW9YzfNUR+OjaWV5DkQWnJnT2fTjXC0Naq1ZomoUe8bv7kR5Ak+iYZ2JvIJb3FbevTKJx/zb12HXkRjc2udg2mGUOmOOX+m/0GIZna9VPZL1laMBqKmEFwJofyN+AAqJXLfSBX7My0LDYcq3mNpS3A9cz53u0pKfa3+gs/gN5ZNJRcUcq+S8uQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect the 'uart-out' clock from the cprman to the PL011 instance.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/arm/bcm2835_peripherals.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 958aadeeb9..9e4e85c3ad 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -167,10 +167,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cprman), errp)) {
         return;
     }
     memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
+    qdev_connect_clock_in(DEVICE(&s->uart0), "clk",
+                          qdev_get_clock_out(DEVICE(&s->cprman), "uart-out"));
 
     memory_region_add_subregion(&s->peri_mr, ARMCTRL_IC_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
-- 
2.28.0


