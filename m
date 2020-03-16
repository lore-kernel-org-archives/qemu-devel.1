Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC115C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B87205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Au1jdn9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B87205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtYu-0005de-HC
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsH7-0004PO-Qs
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsH6-00025f-MM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsH6-00022r-HH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKQK/gk4+Rfzeay1FIA++WnEXh1sOGPFugrslQ2WqSM=;
 b=Au1jdn9OdAoljJHMLjmhRtQUBMryFuISLxuJr6JYVwhQ8SGcb4Lgbf8h7d+5D70iEqoYNJ
 oRiXz672D2fmuHXPIYkMMGfxsu64yxVOom2bLs4LW5b8WzKGeNjXXtWFp0WuPq13TW+zik
 1fEERVOlANiw/pdCywY4ngNmGipFR5U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-E1xAdKtEOoiRFvGSgVZy_g-1; Mon, 16 Mar 2020 12:07:28 -0400
X-MC-Unique: E1xAdKtEOoiRFvGSgVZy_g-1
Received: by mail-wr1-f72.google.com with SMTP id l16so8540364wrr.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZbHLr8MN7Y181YkXNU9q35GGyibM63M9cMs0mFzNFC4=;
 b=RP6/lUU4ttC2PWYu8FSfGYO5Xo9P44jNd/eqeL5iM0S9Kg17rgm+b/Lthz2j7INaiI
 ruY2rlkj2+ufWtXCZO+QB3TeSbQ8vvRgX7s9SmFNzINTsuf9MEHK3CGq6/FigbspW5Rm
 CT7ihxBpAUM4PLjPYKiBwmkrCLmuK36tTNNfOoonhAuEoVsA7TTxa1HfpjhMUxMtJgIO
 8nnmtHIPc0oDErGQEsYtspAf0wQi4euFjI3fDrouigSZYvn5hnk00/UPAH4IVvGFB/XR
 9aiymxNTPGUuGwWxT9o92BfMeV7OgAclpFKyCnmTtqCnxs1I50o6623zE5ASXaVWUGW2
 ZPbw==
X-Gm-Message-State: ANhLgQ0IBQQsBk1lQjC7XCPUlZOU6p6w/JwAjoLCWLKKLmxWWbfSAvMr
 o5RwwXqMBp3DAwJiyPCAGbRDP9BpEvC4oPW/icTVeAXeHreQNAKmNDrse7ZTx1hRnt0tNPB/W3L
 +l3+EBHtJepFcTIQ=
X-Received: by 2002:a1c:de82:: with SMTP id v124mr27908592wmg.70.1584374847192; 
 Mon, 16 Mar 2020 09:07:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmhZSbs8NzLKXqUjgdCfW3w9WctLHdMyXVqEBO9jZ0UEFAr0Le+jcnqG4RZo4FMyA5CMMs0Q==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr27908565wmg.70.1584374846997; 
 Mon, 16 Mar 2020 09:07:26 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id k5sm221948wmj.18.2020.03.16.09.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/19] target/arm: Move ARM_V7M Kconfig from hw/ to target/
Date: Mon, 16 Mar 2020 17:06:24 +0100
Message-Id: <20200316160634.3386-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ARM_V7M is a concept tied to the architecture. Move it to the
target/arm/ directory to keep the hardware/architecture separation
clearer.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/Kconfig     | 3 ---
 target/Kconfig     | 2 +-
 target/arm/Kconfig | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/Kconfig

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e5a876c8d1..e3d7e7694a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -285,9 +285,6 @@ config ZYNQ
     select XILINX_SPIPS
     select ZYNQ_DEVCFG
=20
-config ARM_V7M
-    bool
-
 config ALLWINNER_A10
     bool
     select AHCI
diff --git a/target/Kconfig b/target/Kconfig
index 8b13789179..130d0c7a85 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -1 +1 @@
-
+source arm/Kconfig
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
new file mode 100644
index 0000000000..e68c71a6ff
--- /dev/null
+++ b/target/arm/Kconfig
@@ -0,0 +1,2 @@
+config ARM_V7M
+    bool
--=20
2.21.1


