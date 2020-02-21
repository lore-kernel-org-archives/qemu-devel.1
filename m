Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F7C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BA32073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5rKSUSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BA32073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j584v-0003Lb-GP
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5821-0006UA-TR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5820-0002U7-RX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:49 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5820-0002Tj-LS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id m16so1974598wrx.11
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CH19MfiE/v2T7HEX2v6F3oXsrclEX9/NAMZTm7XbSuc=;
 b=V5rKSUSa3NoY6J0K/3r1WBTfdW58Dc8IJV83TJYgCCtxHcoE1mN1H4QIXLqjxGccR8
 ORuJH+ct4/Qaq4FYJx4/aawrDGzHfdFBaPYo37qEj7eulB14/Vv6DErwZnNwYjXbIJxJ
 Ct5OEXI5EBu5UA+UTZVWdgujbZLQkTul1WXDyxswXKXWGSSM6z/WhYPf5xCscLH1JcZB
 qg9hMtsCqBmY7FcA0pGeG4InIVs7b/E67fEp1ysiaAmeXAz1Cdj3nZ1bL2eLnMEEbhxD
 QwrihcR2b1dVaeU/45L3yhZ/74eBrr2o5AonBWMV/NdPj6kxPupz1UlIZ9F1lBT5Krtv
 oi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CH19MfiE/v2T7HEX2v6F3oXsrclEX9/NAMZTm7XbSuc=;
 b=lTlsl8lcjTBkBD/ntptY1sE1FtTs0KzxDnI80wrIuXJRwlt3wLGKUj8Xvb2tt0YcSi
 eG0bwy+TKdfyG5S4chihtee7qgdC/gAlqPfO4Ccxa+LDCNUcxaH9aVSVvjV2hWYoecRI
 4Qe8fDNuPPILcmKODdXpRwgeDofmjDIt5+mXmReTv3xG0nHXgG4Rzs89uSC/Z35R7R+u
 ZYBovatWYBUsHDlIpmHDVSbSxL/euTZ/ewlt0T8EISXoDf6yzAuEmUo/4fyQuy60CvuS
 b2edAdqbr1S/0o3KsGrddEupHAHesZwu1GF9SHt8vEP6cJJAAiMJMGhPpKPV4ZxgyFKq
 d9gg==
X-Gm-Message-State: APjAAAVjaWx110htZfK1qufVFZux0YUhxcMew097gw17IR4iaWIk0ESw
 rG04ivYDJfv0EotNYNKjcmMIok8tOFA/mg==
X-Google-Smtp-Source: APXvYqyvalDmHXL4QM+9PdfpDLTvd2MHnEhr7gZCgg0j6H//u8knKln1QRmOf3QJ2sYU+vQCX/dLjQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr46475467wre.383.1582290467353; 
 Fri, 21 Feb 2020 05:07:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/52] mainstone: Make providing flash images non-mandatory
Date: Fri, 21 Feb 2020 13:06:52 +0000
Message-Id: <20200221130740.7583-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

Up to now, the mainstone machine only boots if two flash images are
provided. This is not really necessary; the machine can boot from initrd
or from SD without it. At the same time, having to provide dummy flash
images is a nuisance and does not add any real value. Make it optional.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200217210824.18513-1-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mainstone.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index b01ce3ce08c..6e64dfab506 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -138,19 +138,10 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
     /* There are two 32MiB flash devices on the board */
     for (i = 0; i < 2; i ++) {
         dinfo = drive_get(IF_PFLASH, 0, i);
-        if (!dinfo) {
-            if (qtest_enabled()) {
-                break;
-            }
-            error_report("Two flash images must be given with the "
-                         "'pflash' parameter");
-            exit(1);
-        }
-
         if (!pflash_cfi01_register(mainstone_flash_base[i],
                                    i ? "mainstone.flash1" : "mainstone.flash0",
                                    MAINSTONE_FLASH,
-                                   blk_by_legacy_dinfo(dinfo),
+                                   dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                    sector_len, 4, 0, 0, 0, 0, be)) {
             error_report("Error registering flash memory");
             exit(1);
-- 
2.20.1


