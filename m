Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CAC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F0F218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oa42g3Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F0F218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOKA-0000nW-ST
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjOI1-0008UJ-If
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjOHw-0001EJ-GZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:30:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjOHs-0000fB-VE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:30:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so9941221wrt.6
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PebQMvSZ92TFluRNO4o+ZkgjsCXPtsulLqJ0GRfAHk0=;
 b=Oa42g3Umrxns9EyJgqiuMhdbbM/WSIgE3WzsPle0pxK0HFg4mrsPrNat4lAqLqhYmu
 Nn51HmeNVFxKei4huEtS2tsZHGiB14iiNOGlVnpjzkmoLQsSPkRknkHreH0JsmtYOh6e
 5xpvbIKAd/Z6e+UCDYjoEXtsj0SiNqTdUG1OakP/gkjuyGBKMvOehZ3USoKISPHt62dG
 RXLND5n6hd3ybK3XASRbql046x0dqtbFOULhyeciey7cgxJErP8gixwZhKtjd4ABFDGf
 QKeGrgSTdv5/ViJCHvWNGb9yS3asV8+C7olijGB+2iWELY8Sar0g0ScTieBCRqiSijgH
 8s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PebQMvSZ92TFluRNO4o+ZkgjsCXPtsulLqJ0GRfAHk0=;
 b=IsqiW2hbQDCG7wmrDHRXhDQJ2KYEHROLXgqVmIVixwGOHOIJHwGvZz4pjsq1DFJAbO
 D+EICK1H9FcE6147eqlSpxhf/SIPcn30nAGVHIAq5jwGQl+3atLwgi64ifNbwh61cRMc
 fCQlnga4QNq+4atCl8i2u4jEOSif1MaypSQ20sV1ZffZ49Jsmlu/bCsOEAfc0WCHPO6Z
 lhiAyy/sJEJPO8n8UrXNa7KQh3ql/ODDwIu4pev+8j3t/KtLwS1+ULYZ/dl+DxBfT5wD
 5BoVCYkBnw6DOr4BF6zUx9TGu7z9CT6yladmDTFmA89MrEmSHE1SK2J94P0sguf2HfMa
 /wHQ==
X-Gm-Message-State: APjAAAV0csIm+NluVmOh1kuirVSF2pwVxLzuc9kLQCDIAVraeGfbNc8A
 Azc6OyAztkasVBLl7+szYpAfSQ==
X-Google-Smtp-Source: APXvYqxqZi9FGlieHnciJqesfg4vgaRj8gqrk0f75HH7Pb0z949bBgz94/nvTW6Ke0t092VkCGAHVw==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr4186283wrr.338.1562333400997; 
 Fri, 05 Jul 2019 06:30:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g131sm5730407wmf.37.2019.07.05.06.30.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 06:30:00 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 20E631FF87;
 Fri,  5 Jul 2019 14:30:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 14:29:54 +0100
Message-Id: <20190705132954.19500-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH for 4.1] gdbstub: revert to previous set_reg
 behaviour
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jon Doron <arilou@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The refactoring of handle_set_reg missed the fact we previously had
responded with an empty packet when we were not using XML based
protocols. This broke the fallback behaviour for architectures that
don't have registers defined in QEMU's gdb-xml directory.

Revert to the previous behaviour and clean up the commentary for what
is going on.

Fixes: 62b3320bddd
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Jon Doron <arilou@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 gdbstub.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index ea3349d1aa..b6df7ee25a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1669,12 +1669,23 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+/*
+ * handle_set/get_reg
+ *
+ * Older gdb are really dumb, and don't use 'G/g' if 'P/p' is available.
+ * This works, but can be very slow. Anything new enough to understand
+ * XML also knows how to use this properly. However to use this we
+ * need to define a local XML file as well as be talking to a
+ * reasonably modern gdb. Responding with an empty packet will cause
+ * the remote gdb to fallback to older methods.
+ */
+
 static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
 
     if (!gdb_has_xml) {
-        put_packet(gdb_ctx->s, "E00");
+        put_packet(gdb_ctx->s, "");
         return;
     }
 
@@ -1694,11 +1705,6 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
 
-    /*
-     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-     * This works, but can be very slow.  Anything new enough to
-     * understand XML also knows how to use this properly.
-     */
     if (!gdb_has_xml) {
         put_packet(gdb_ctx->s, "");
         return;
-- 
2.20.1


