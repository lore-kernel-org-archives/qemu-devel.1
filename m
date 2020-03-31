Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB1520781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGKhM70M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB1520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEZt-000150-Qv
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU6-0002Th-Hc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU5-0006Mm-GC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU5-0006MF-9v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id u10so25300335wro.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vchyfqhHHsr5zdUX8gddP8/yCJaBZyi/7DsQU28Nx7E=;
 b=CGKhM70MIOYp3EQdgCnw1t+7WJMcow5uwPOYP6OTiHgoJLEo9CqbvyL+l1WHDsMqMl
 8QUkgUBKH0MHB3z4ezDA1ecDJ6LLhunj3CoMVk5aNNwHq37/HkuVapbwU4hiJpDZ4t8G
 7kvHpOCPtGSDi6MqV/zFZCZ9D4hxwQzLSYI+3ZrRjLbCrXM217BFtN/hf7BwVuV4kfsb
 BzGftEo/IF1Gw5weCQbIvdMfexqIpkA6yORjniqEt1S2gk43Dnev+mxo+oo1Kw+IJBmC
 gXh7hZba1SUgIymxUi1xOmb4kD/X9Yt7f/1xD6zRRyc1HimhW7Pc8cEYPtVamd9fa4KV
 BFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vchyfqhHHsr5zdUX8gddP8/yCJaBZyi/7DsQU28Nx7E=;
 b=lpwIZh7+vTQ/xA0Bj+CgPnbMu6SFxhoItOD+5UxvweKNNuVaed7ycVwXJvopFn3Sfb
 UK+TWTnvj78f6po23MrgWpKpHBiLF2Wnla0Iw/TWxO/pXlG+/plsKiL0GBf59P7yGRpT
 BYSQJSnSXsIAV36yqSTVRoqc4Q9RfL80R5wfU2wo5cjn0qlbDYk91frAqXybPdL5JbEa
 3X4hz78/FzSqFwKnQQwyIIb//wWdBRmiKi+Vi2LW0j+c/yJ+ZpE2FdOQzn07/10skwjl
 SkHrSfVfOAc1fPmUBs4PVQlDKQ8S8EUfCqhANLwJALZYefFZZy1pHNrFM/At+E7G4RSQ
 PQrQ==
X-Gm-Message-State: ANhLgQ3IF6aQZ30pQ3aS2xBBNWHOLXfqyIRfXr5MkIi1IBk7hIQPEFrc
 oXSUrXEKQAZt61GJT/obBaE81/Y1meQ=
X-Google-Smtp-Source: ADFU+vvkPiCIRDHwZIEZ+4lbePZE4C4/smpCL610+d5P3owpR9u1b2OI0k6Cx1Ljbgk0kq86xhhI/A==
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr18658671wra.98.1585651864193; 
 Tue, 31 Mar 2020 03:51:04 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm26042830wrn.31.2020.03.31.03.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 5/7] hw/timer/grlib_gptimer: Display frequency in
 decimal
Date: Tue, 31 Mar 2020 12:50:46 +0200
Message-Id: <20200331105048.27989-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
References: <20200331105048.27989-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 29fda7870e..96a6c9138c 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -19,7 +19,7 @@ slavio_timer_mem_writel_invalid(uint64_t addr) "invalid write address 0x%"PRIx64
 grlib_gptimer_enable(int id, uint32_t count) "timer:%d set count 0x%x and run"
 grlib_gptimer_disabled(int id, uint32_t config) "timer:%d Timer disable config 0x%x"
 grlib_gptimer_restart(int id, uint32_t reload) "timer:%d reload val: 0x%x"
-grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:0x%x freq: 0x%x"
+grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:0x%x freq:%uHz"
 grlib_gptimer_hit(int id) "timer:%d HIT"
 grlib_gptimer_readl(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
 grlib_gptimer_writel(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
-- 
2.21.1


