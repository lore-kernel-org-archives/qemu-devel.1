Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A928C7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650A320725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQLSRNBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650A320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ewF-0006w7-JQ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqP-0006aS-QM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqO-0002RT-Qj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqO-0002Qy-Jt; Mon, 17 Feb 2020 06:45:44 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so19378521wru.3;
 Mon, 17 Feb 2020 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OGYngzYgREXVWzhCGP1KWkhVF6aFvpDG4pbFEluMwuQ=;
 b=QQLSRNBaRAbOPnzZTq2kaydk6Q7gCayLTtsryRjJKNprdH6mGkp5syAr+WkKiCdj4a
 hcjUXLMjwCR7J+TKLoFZtZFYMomQFVX20za4c7Ty87vR/nMnsfCyA68JBmQTWacZtS3v
 hwZOGH1V8QqauiyDXodPyED+wyc+14N6XRIbrVDPNVuf8Hyp8H5sbTb2YWEEoapT/Vm0
 Ow1HN/GN0fWdtagKdMWTYfXl7Rg9/E6BBjWCqexffmtS261uuKUAZwXfmLPjeyrD7f0O
 MYOVy7q6lBy5lfLNrd6AJNkf4shWuJVSsgpDKtsN+Cmn4RLS3UvGQ7+KtQ10mDFWiNfS
 tREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OGYngzYgREXVWzhCGP1KWkhVF6aFvpDG4pbFEluMwuQ=;
 b=p6AaJOrqv0FfsqIQ8Eeo+V84qibI+hsHADc8eQtDHw6CicNmV86x3z7OCfdN4ASaUD
 zJJ8DcpXsgmvyzGxley9q5u1sHDRCVdvMqf+n0tHhSJnzUuCrBbU0Ti6LiReeVknLJI+
 qawDYpJS1CqA5et/Q5MxArN3tOiyYZoFJftZIXKynKTW3EUUbII1ZA2bJWkiV/Lz8C46
 cTMwBfhVu3HNZ4qQn9226ImJZDWle5GvK7qFtBFT6/EcjHMHPQcBqh3kcDvpNmZPvGom
 HK60eQx/Iab01C31FDQ4LvDDcdy3fjfAONXkRsBjkc+e5mtRjycwy4O5PyYfynNshLUQ
 0xew==
X-Gm-Message-State: APjAAAWfXfdunK0uCTbVyANX+DlUQjBBWvcHbp7G5L9ojNh/KoN3GTvj
 E0I3CMQ9f1bQdv5K8OdurXrPYKoz6E0=
X-Google-Smtp-Source: APXvYqzq2oDUO2lb2hEx/6O9Ukt0YBDRakzjPGVtbENKrR3Z57qbU+bDa515P2Ir7eUnvEtw0TGEdg==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr20501096wrv.291.1581939943462; 
 Mon, 17 Feb 2020 03:45:43 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/13] hw/arm/bcm2836: Restrict BCM283XClass declaration to
 C source
Date: Mon, 17 Feb 2020 12:45:26 +0100
Message-Id: <20200217114533.17779-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No code out of bcm2836.c uses (or requires) this declarations.
Move it locally to the C source file.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h | 12 ------------
 hw/arm/bcm2836.c         | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 92a6544816..acc75bf553 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -42,16 +42,4 @@ typedef struct BCM283XState {
     BCM2835PeripheralState peripherals;
 } BCM283XState;
 
-typedef struct BCM283XInfo BCM283XInfo;
-
-typedef struct BCM283XClass {
-    DeviceClass parent_class;
-    const BCM283XInfo *info;
-} BCM283XClass;
-
-#define BCM283X_CLASS(klass) \
-    OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
-#define BCM283X_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
-
 #endif /* BCM2836_H */
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 38e2941bab..24109fef1d 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,6 +16,15 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 
+typedef struct BCM283XInfo BCM283XInfo;
+
+typedef struct BCM283XClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    const BCM283XInfo *info;
+} BCM283XClass;
+
 struct BCM283XInfo {
     const char *name;
     const char *cpu_type;
@@ -24,6 +33,11 @@ struct BCM283XInfo {
     int clusterid;
 };
 
+#define BCM283X_CLASS(klass) \
+    OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
+#define BCM283X_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
+
 static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2836,
-- 
2.21.1


