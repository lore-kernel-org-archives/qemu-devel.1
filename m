Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6BAC2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D9920672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvIEB0pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D9920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36621 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWPF-0003lg-4e
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVra-0002ld-Gf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrZ-0003U7-E8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrZ-0003Th-89; Mon, 06 Apr 2020 13:48:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id j19so225358wmi.2;
 Mon, 06 Apr 2020 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F5/QTF8NoUKx5KsbybkQ+s3UGgYsvC0vkYP7rtWEAYk=;
 b=gvIEB0pi6HBHmRx29tveqnsdgj+1thhiP4vU0NT2/+oPkh+2mfgQuB3uDO5+ZDruQu
 3Yq0h9+Zm8GFqQCT7edQdK2m0BLwvRiPDT5zIHvC3p32d92udfpmcld/YaCOAPZ0qMe4
 lZrYPxhoDKdFDgE+KmxlcT9XdY2cEBWNam2h7JNgPV5+ogbiLfc2N59og21iNKyS+w79
 k3tdkUvkFEZ3FOpuDZcAho5YO4K25up1U4LvwE9VzkAXefSUCxLaOmLAlKM8tcxxyPqf
 7FbTV7DE9gFSLepFlh3q2ddqg7Zq2fbF7v2J33UC0wKlZ4z5BcR3E3wVcRyXhHx0KGK5
 yolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F5/QTF8NoUKx5KsbybkQ+s3UGgYsvC0vkYP7rtWEAYk=;
 b=aso7r3qrjOm++jpLVroY2Vg7DinXrZy8xCzJoddAoiErUQwxlz/ywmrsJvt9rBrevb
 J12GJWPvc1olb66hVPtIJFd5qXEiFIF41i4IFuLmf1+jptZ0rsRDrPsiJOb9GeWAaGMw
 JeWGadIUFkXJugrdF56rPS7y8OF5iahSbKYtwghox52CeHvyt4UgnDWGSbwBw24pI+XQ
 uG/fFhH7zlt5qxqzFm2kMMHWFZqFovtzOd38NHW3TGdm+EZmpPklpRdZWGrh5ubceUJC
 3fYgFHYCg0iB9uwl1/M0uvd2CAhATI3LU8w9mlN0thTCXUJuG2lvkxNL5Bjk9Isly3jO
 hEXA==
X-Gm-Message-State: AGi0PuYkxEirMieJC5bS2bBY0osQIlu3j+356GYS8iaqhY4NBKXySp+B
 GEtwk8dG1ntBA8avuREyX5GpJyQ7SUM=
X-Google-Smtp-Source: APiQypLN9ktGcxuUKljYM5mrxk4pa7k2cUsX4Us1lPBFmomYAs7vmehw0LyeiK9sAevjKXsPrVhtsw==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr193424wmf.168.1586195323572;
 Mon, 06 Apr 2020 10:48:43 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 41/54] hw/dma/xilinx_axidma: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:30 +0200
Message-Id: <20200406174743.16956-42-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

Then review showed this file has a 'xilinx_axidma_realize_fail'
label that calls error_propagate().  Updated the patch to use
the label.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: New cocci patch generated both transformations
    (Peter noticed v1 only catched one)
---
 hw/dma/xilinx_axidma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 018f36991b..2d36346319 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -531,6 +531,9 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
                              &local_err);
+    if (local_err) {
+        goto xilinx_axidma_realize_fail;
+    }
     object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&cs->dma,
                              object_property_allow_set_link,
@@ -540,6 +543,9 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         goto xilinx_axidma_realize_fail;
     }
     object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
+    if (local_err) {
+        goto xilinx_axidma_realize_fail;
+    }
     object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
     if (local_err) {
         goto xilinx_axidma_realize_fail;
-- 
2.21.1


