Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA4FC0650E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B15620663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sgrqr4xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B15620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7iK-0006nP-Fj
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3wd-00089P-BT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3wb-0001wb-HE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:34:38 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3wZ-0001hR-EU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:34:36 -0400
Received: by mail-wr1-f44.google.com with SMTP id f9so15332764wre.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sudBZzt6fCQJ8cQwNMK19XbmjoKhOxFTcvcuBuImuhY=;
 b=sgrqr4xI0PlW1BJh2TX9dQ3LR9+J6c6sCrB9Lr8rp4MfRV0yOypHdy+fkNxJD9g7ZR
 mLAcNFodJ1temny1x38kcVxvXvEN/vzm2Xk3J5/oIzegowOE8noDuZ8YXtAcxS93ItUU
 D405K1j1Y1P5M16lciJ4SqVjIo8+bifhPhgpFyrnqF39I+xUoiNIp1OtLmRpLw5VA7vW
 FC/3EgYPnBmo8DCl4R/EXpMWsqQ8HiZSRD5VzEhKWATRImxZQyhC+fnGFl34oEjiTsLc
 8XCdIGGMvTIxL71cM8qUlozc6Xc/zf2QPuTY1q7/wNIKYAt7ceiRrBcoqrWCrvQCiZXA
 nj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sudBZzt6fCQJ8cQwNMK19XbmjoKhOxFTcvcuBuImuhY=;
 b=hTOqRZegKMRDA+2JeAF6DkJVJC+o8ahk9U0pSk7xEZQj502dsgI5pdwz8WmeMsgeVW
 u0Q7ccacJ57RGQd9EnJ9a6gNLW61cwxPKA7mX7f5KoQqo6r0z6uMkI2TnaO9jigo2hui
 VyPWRfxDvloQHBWFIwsvNjyz0TvnQuOXMVU/jGwezMB3Iu8q0ZjeSJ2vO2nLmcaD7x6h
 f8bOyuZFMZo6Y08e9dupA98VwZqJ05njV0ca3Fj42MM6LS/YwQG6YDVMLmbRIj5g8gOH
 2FXXRGjs9KVxR+IVjy5dL2b2GsicOV1Uz543AXZNJ2JxcdVYgKXZA2QgWpvnmMJJ/VeL
 DyLQ==
X-Gm-Message-State: APjAAAVJksdIrgJkcCLydENaZ6UbyIV5zoi8KILM+OFAqxSNn1zMzl4p
 TbgXYI8/KDejt8Y2JNvgzjajVFgc0SuFQg==
X-Google-Smtp-Source: APXvYqwH6x9DwXKcyIsoA/fOdzUSaJ7+QluDE2uy9psM+F7wMX7v+AuVXPNSI84rCbXPcTYFuHduLg==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr19002429wrs.225.1561999187548; 
 Mon, 01 Jul 2019 09:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:38:59 +0100
Message-Id: <20190701163943.22313-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: [Qemu-devel] [PULL 02/46] hw/arm/msf2-som: Exit when the cpu is not
 the expected one
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This machine correctly defines its default_cpu_type to cortex-m3
and report an error if the user requested another cpu_type,
however it does not exit, and this can confuse users trying
to use another core:

  $ qemu-system-arm -M emcraft-sf2 -cpu cortex-m4 -kernel test-m4.elf
  qemu-system-arm: This board can only be used with CPU cortex-m3-arm-cpu
  [output related to M3 core ...]

The CPU is indeed a M3 core:

  (qemu) info qom-tree
  /machine (emcraft-sf2-machine)
    /unattached (container)
      /device[0] (msf2-soc)
        /armv7m (armv7m)
          /cpu (cortex-m3-arm-cpu)

Add the missing exit() call to return to the shell.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 20190617160136.29930-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/msf2-som.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 8c550a8bddc..2c9984bb3b8 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -53,6 +53,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
         error_report("This board can only be used with CPU %s",
                      mc->default_cpu_type);
+        exit(1);
     }
 
     memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
-- 
2.20.1


