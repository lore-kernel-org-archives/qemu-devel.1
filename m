Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1614BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937A42072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwhIzd9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937A42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmpe-0003FZ-HE
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnV-0001UH-Bi
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnT-0003gN-6D
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id p15so6120999wmi.4
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ckhgHIzetD2FmHEm0FTTUKRnqskZdYevul/a5BWHNys=;
 b=MwhIzd9vmKrNrMQcJ4xyTdGkBMDODFCRnuLvsNjbU1/TLj/fr3P0cRjdLTbxkg2QZ0
 zETo7T9j/B1RF2DjsFcKSrwoBiYKBpndj9Hn6/J7H9EAwAIPQTO7Ktbb2vaV+G+V00mw
 ZmmYucRGaXnM6gNFVskqJe/1esoAxkBSjB2nYA0xMsNB2G6CgYVrK5UnZhN1ujab7m+p
 bB4acVFxaKLLW+27yBHQnnd7cnJq4vl5WJi/3dQ2pMB9aGT6mOlpctjlecWYH7+PFJuv
 SXsnDXTYSG4QA5CYK7S+7DjWs7Qo5YI9j56liOq1B8uWB1qMK9g9Hoa/foiOFK7C0Bdc
 WnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ckhgHIzetD2FmHEm0FTTUKRnqskZdYevul/a5BWHNys=;
 b=TJlfgGisyYZe9r48Ez5aMZ5KlweKwI2oaxGMI+rXVx0Bm3dnJWOe3MJAm5uJID4y+T
 XtZGp2GcUwE+R2l8JIDfZCAUqgIKfhJ9dkkFtHoC645KMd2Xu8q1y8RNplaZ2TSViTFU
 PLfSfDINd+3Tq+WjHjAWA9RNwF2nSqM0v1vCat3UWChmCY0hpaMqRjDbgYwPEx6kDCfC
 M0gCBVDkwdV9LpDeQXvLoe2VV3ln0JsX2uw1c6eEfRnkTOv5CFtx84q13P/yXMrfkKin
 g8cwZM5c0/7iGwz4lNrauvl8F6JBx5cXWG/qijk6iAqwVzCt3cDtmhs6eA/MWMEDrwgK
 QN4Q==
X-Gm-Message-State: AOAM531YQ3FQ2c9l/uSHEh5oHrmKuBb5K9L6taXgYk6X957gXk45ncJ7
 OjGUz0bQqOFjLFK6Wi9bZ92hw104kr4=
X-Google-Smtp-Source: ABdhPJw8G3qQpcBEOQOl2n1jsv9b14X+nabi32lR8Ou+QXQn4MMlOoWQ6dDih6K8nK2W55im4NDSkw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr8707586wmk.88.1602943375100; 
 Sat, 17 Oct 2020 07:02:55 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id b189sm7279971wmb.37.2020.10.17.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:02:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/44] hw/qdev-clock: Display error hint when clock is missing
 from device
Date: Sat, 17 Oct 2020 16:02:01 +0200
Message-Id: <20201017140243.1078718-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of directly aborting, display a hint to help the developer
figure out the problem (likely trying to connect a clock to a device
pre-dating the Clock API, thus not expecting clocks).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20201012095804.3335117-4-f4bug@amsat.org>
---
 hw/core/qdev-clock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 47ecb5b4fae..6a9a340d0fb 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
@@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("Can not find clock-in '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(!ncl->output);
 
     return ncl->clock;
@@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("Can not find clock-out '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(ncl->output);
 
     return ncl->clock;
-- 
2.26.2


