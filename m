Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E78C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74CD2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk94jtMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74CD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPMzR-0000Yv-Sf
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPMyZ-0008RS-C1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPMyY-0006TO-9p
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:07:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPMyY-0006R2-3q; Fri, 17 Apr 2020 05:07:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id x25so2171115wmc.0;
 Fri, 17 Apr 2020 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wQAieBuE8yjJMivs4SYjXjS+giHAnzgR8oVLYKxHI8M=;
 b=qk94jtMTSfrmALdep8OriETe7vKcWk3FFqXpiYQoKKc/jvrJjnjWN4BlclEhdpu5Lu
 qcrDNHULDgtPS4+QKD+PnMHO/lY3KPHq4hYRbjwUFXwJ1s3ZS+YFO6fiMqTJou8Rmse9
 1Rj/UMFdmiy/ctZnmHFxCjH8zaX19dXBAOnTumkfYyH6WhwZeNMcNFTvEO8GiYfjvSKM
 +bV+ko/QxIJIPy0afsZvvqoEKDj/xQ+dFzKLGhfcxAryLLru7a23aovD+mJEXAPrSK1V
 e/xnfepSIhisiZN3/o/PNdaqeHIkDbY3zPHACAW003LmeIVEwKIVVwnY5BjxIxl08n1B
 tyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wQAieBuE8yjJMivs4SYjXjS+giHAnzgR8oVLYKxHI8M=;
 b=P9fPH0GHpI+5qZy05Oxiot9FU3dhEG/pebHiibC8CUO6klaTiGrL6P4Tqrh0aSqUtU
 xULljNePLusx4On59zn2dlGIgFtUbOcOL06iNpAVmK2UWs45KQ47p+gLAg/16R8DtA+P
 B3zt9W6mMhNf2yEcc7u3d90jTvGVDiegKwRK1a8Mc9Q5azXgcyB0XZvOaTUgZNKNBljM
 6xaqWvm3Kyi7GDXYwQi2RcwBDbyk6JAsuoZ/+S5DJmoffOAXFze7zapfMlRSQQ0YzNlG
 yKhNIvv9K5jeWcFiVA7rNL5ymDtGKHXDTnCj1jvHy9LJ5dib7EwNZCnSVHSsjqJ2ydrp
 PsPg==
X-Gm-Message-State: AGi0PuYEsD9MyryIPcJrzASDqbGKBqqU5N9EK/iD82P9iU6tHJLHqrHQ
 5+Oh6Z0q9vdMzEfn/htzErIMuaCu9JU=
X-Google-Smtp-Source: APiQypKCY9U8/2WbzeAxWpz9IeuhaNRge5W8ul8i/T8Ib4y1CWqnz7JDzcMs1vX/iFaMaZzxTPdTHg==
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr1929990wmt.28.1587114472503; 
 Fri, 17 Apr 2020 02:07:52 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j13sm32266767wro.51.2020.04.17.02.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 02:07:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in gen_slbia()
Date: Fri, 17 Apr 2020 11:07:49 +0200
Message-Id: <20200417090749.14310-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Dennis Clarke <dclarke@blastwave.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes:

  $ qemu-system-ppc64 \
  -machine pseries-4.1 -cpu power9 \
  -smp 4 -m 12G -accel tcg ...
  ...
  Quiescing Open Firmware ...
  Booting Linux via __start() @ 0x0000000002000000 ...
  Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
  Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
  Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries

[*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html

Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
Reported-by: Dennis Clarke <dclarke@blastwave.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b207fb5386..0136c7e3ff 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5003,6 +5003,7 @@ static void gen_slbia(DisasContext *ctx)
     CHK_SV;
 
     gen_helper_slbia(cpu_env, t0);
+    tcg_temp_free_i32(t0);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-- 
2.21.1


