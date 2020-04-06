Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52109C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254AD206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8xkEx52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254AD206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWBo-0006eR-8w
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrO-0002SV-Lx
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrM-0003LU-NA
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrM-0003Kv-H5; Mon, 06 Apr 2020 13:48:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id 31so507523wre.5;
 Mon, 06 Apr 2020 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+O8FSNw/XveJvWULa4+Jfl3G5r6TBg2LXwiWGWDolCA=;
 b=c8xkEx5253ZlB+tHpoFgXdeE6lpIRb05XoVmVIrsvgGN7C/XgCsb1tHBxhbhmpJeqX
 Yfj7RP84XVticQ5WoWAkf3g96ghqBAxHqc1rSJXm32uFY+KwPKQj4RpgHYK/B7E77M/i
 Dbndx73PkhXjIP0Bb0n6TvOQR5TCjiTF+/cU/aQ2ntvKX1iYzrgVA3Q0GaCS8bo19bAX
 r6LQtnznge9/pGOhSvs4WqcLeFOKVjHOzl0Okpeka/IoHFWrueYZuPfrroVWKwFfV0XP
 Z5v121RLVkegmcC9nfeRUw/aSv61rF4dXUiDkZrFAiN8C1qvHropKCc2UxuZATBdk8nn
 rN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+O8FSNw/XveJvWULa4+Jfl3G5r6TBg2LXwiWGWDolCA=;
 b=aLDUIbGbRmHZ6a3Ff3SI/T7FRNQ+7BJCxKXn42eTaW6PH4DLFzIHeIUIqo7o7QG83H
 nXSjWBfpP4PBIVC9ccJ5TG26b3+U3W2PFIYegE2vBcXjsIVeFuGC8TZVUnAXQ+xGGHCR
 2UkfxLlzGAszUtlDqMdUrxXJ4dudrUPn51d/G/I+b57IlwzxGsBgbhdOvU2SUaHHWV+z
 HUmalE/aUMkACxkBhisW/V9bhKWTbWlTqv1KzrK6GOw1pDkKelmbbbgnFMni0EGXy+dw
 kGxh/C0dYLkYs0wanbL6hNhUxZb4cdti/0/+zi17TvYHBmPMultA6PX9b7POBLRZXyYQ
 HpnQ==
X-Gm-Message-State: AGi0PubS8I95C3nFJz1g+wAV1zFv+X7ZhuEBsQB7odfdlcLukSvMxbra
 Ql+iPDEPyJjin3nm7u4hWCRlUeTbXQ8=
X-Google-Smtp-Source: APiQypKkX0vnL4MDsxAOGu63ql2Q1nV98knENmX2pZypRz7cVNiIbMk/Xu/11dcJB+1V3n1wbXEvdQ==
X-Received: by 2002:adf:90ea:: with SMTP id i97mr339112wri.123.1586195311425; 
 Mon, 06 Apr 2020 10:48:31 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 33/54] hw/intc/arm_gicv3_its_kvm: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:22 +0200
Message-Id: <20200406174743.16956-34-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:ARM cores" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index ad0ebabc87..3d2c4e22f5 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -101,7 +101,11 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     /* explicit init of the ITS */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                      KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true, &error_abort);
+                      KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /* register the base address */
     kvm_arm_register_device(&s->iomem_its_cntrl, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
-- 
2.21.1


