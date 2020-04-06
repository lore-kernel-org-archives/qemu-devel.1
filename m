Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85AC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534BF206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgPdyyIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534BF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWEd-0004GK-EH
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrk-00034O-Sf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrj-0003bc-U2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrj-0003ak-OB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id v5so450175wrp.12
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c5He7hEp7NEVkCGvyJyOgJeDmrKWTNpgA0M1S3kv/iE=;
 b=DgPdyyILCTII19Pdnt7fkE4YNz7OZ5pbV7/56q/ppvIZNCIUPJEuU0iAR3bLl5JkNt
 vh5dCaMLkqTwE8tWhKDeb6rPSs+nClh0FbPweTghJlUVi/DOnAoRVgcPleB1wRR8Fxur
 CIdCyeWNtlSzII9ItYRVFUSDfj7mo3nVez5ldaTJBXHIoZdj+0RjE9wVfjxmSIUrvsgt
 QGomxAwpKVyFyzg4uhzZJj3+Q5WC25US6ZzHmZfW6/4W6MQqAHkAAzgbAnxmMa0wi1LM
 L+jjJ02J5f4zgVOr3EYwCQOKbv9vO1RtvW+tajtwV2qNVUbpFmZqMvF7RpowlKIWli6i
 AU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=c5He7hEp7NEVkCGvyJyOgJeDmrKWTNpgA0M1S3kv/iE=;
 b=pEBa91VlFetqPIEqbyjO5y4idxYtYGD99cUGLTIqV4h5Qi0QJSvaAqx3LLsxvs2E5f
 JCx99gXw0s21cpyzYltPnPbdKIYA8Io5t66PK6eKsmkqJuv8M1fk9H4hC0E7fXjUo8hL
 TNcrJhN5hUD3GQtC3tGXjnEqyFhcMCvx6T9pyZY3bhdNlHqlpUT9zD/WsHzl0mkZ0VaR
 NAKGTfNR41Go98VW/IaBqF45hllEd6jmWrFGt1uvUxhRvWStNcZQsfazfNF3HRjfioKE
 eW4MuRENXcyKf9t2MWvuY05gxiLE4zebqZvhn8slDQ9xAtHoad+cR/1aOWmNHU9q1PnE
 rKyQ==
X-Gm-Message-State: AGi0PuYYLPu8/IlvZriaBeo1pM/PfA+T/84GY5kw7aWZ5mOx1+scxc3+
 zFvP+0Mcr/dFmMEbINU01qNc1KWYwp0=
X-Google-Smtp-Source: APiQypK//AKIFXJDWLSisrWASMe4cOf4Ij3bf8dN8stlCKx2tBzLdj4R8lFfxWddnCJbScLWzdJ2Zg==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr336013wru.317.1586195334556; 
 Mon, 06 Apr 2020 10:48:54 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 47/54] hw/sd/milkymist-memcard: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:36 +0200
Message-Id: <20200406174743.16956-48-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 926e1af475..87294c1b71 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -280,6 +280,10 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
-- 
2.21.1


