Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A85C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C4A206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLV3WUEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C4A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFdA-0000MI-Rr
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFXA-0004UQ-Sa
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:37 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX9-0001p3-M2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id g1so6622617ljk.7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L66Agc2lHgpy7FO0yh6pn/rfQ2aSoQ2VmphzAuOdIik=;
 b=gLV3WUEg62/kdtWNpvoTJSlJH7qX2tGv+pwUBmrjwFW0aCqglsHGH1muv/uHT/bhXP
 0ydyvC5ol32O3/u+Vdpcu8Gyr8mQ0wOqRx6fx1cA8ZLKTV4u+S0utjvRW04qwJyhfAaJ
 vtPwvXTfBLXteqvZH6nXGrRGcbvre+aEq9WHYANEE1BpRdtqscIJy6x/sqf5LIvD0Gmr
 Sp1z3btuDOFkxTdxZZ1YRUseV2aY2m+iKtcoNAs3noiDwm/yEV1QfO/Yb4C63p/qGRpp
 8pieBOeZNhZGWw4kHnY/G421Q8/fYgkhduXRmMvbfjt/0QzMa1bQ5uWxB90dnBmJtQt0
 rUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L66Agc2lHgpy7FO0yh6pn/rfQ2aSoQ2VmphzAuOdIik=;
 b=GGrSXIrIXQn/D9YtBk/kojbDEdOFJ9QkOHyU0SSSHgFtE/mFyddv7zdYjXB/zDpUg2
 pW7Gh+M6UeUWi/Y4+6oCKCHEnVgXGWugJJDtD1UyHvdKR7cNGCtm+DoFKlgE+9k4FjRN
 ajS2y/wsIhtLalgq6Gya0a2v35Eg/DYiMROk4ZDrtXzesI59IXsfwG9jjaBl9gk6yjPQ
 sC7rkkMRcIa+Wbu+O87lFMEmgU5MFqILNC0XUaUzp0gq7BpPBw+qaI3f9N4bdFiQsiOi
 1zL9t/qYesZeTJRZJTqmtd2iGGpwOOsCiIrrEXnnB4sFr6YDsuekv7+xAAKjAOlYdguC
 hMpA==
X-Gm-Message-State: AOAM533/BtoJvBYx1MwCzP0yfbgGB2s/BSe9ZvPEq9i2qLQcrY62pOrF
 9W+0+TvhmsAjyZdLft1LksHhZsPpedk=
X-Google-Smtp-Source: ABdhPJyNxUDKloW7hJl2o3zhl32Vr599/y+B7y/qw+D3U/7OrqbeyKNbmr6MFdcDv2L4TBR+Bl+X0Q==
X-Received: by 2002:a2e:a417:: with SMTP id p23mr7659908ljn.19.1589707474097; 
 Sun, 17 May 2020 02:24:34 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:33 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/19] hw/mips: Add some logging for bad register offset
 cases
Date: Sun, 17 May 2020 11:23:55 +0200
Message-Id: <20200517092357.1469-18-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Log the cases where a guest attempts read or write using bad
register offset.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 hw/mips/mips_malta.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..88869b828e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_read: Bad register offset 0x"
+                      TARGET_FMT_lx "\n", addr);
         break;
     }
     return val;
@@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "malta_fpga_write: Bad register offset 0x"
+                      TARGET_FMT_lx "\n", addr);
         break;
     }
 }
-- 
2.20.1


