Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFBBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC332343A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujKY9P2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC332343A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B6F-00009g-VU
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArW-0002wh-2s
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArU-000604-FW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArU-0005zX-7t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id g207so14752246wmg.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xlVfa4X6hgu0Qn72UxF4DtuCgLqcTN2WoNHXseq96d4=;
 b=ujKY9P2v5YCHnJzMvyPvXblDgaUyDasFclg/wwG2Er/Hsty0EXCSswXrE0eAfiKfTX
 mZS/JFWypyn/50URYp/xiRLqlt2pHfApU04QCLWoHnpjvImyXJkyZAAaz5PcHyKAJayU
 3zQes/E2pAUOS/CpzRPvEbP+DhCqhaukDCexSTTvgrw3ZYGKXMPM7Ia5PVKdqAerwOL0
 ZWYcpcib2wTp8lRQ9ulhTcNATbiTd5tzNGYND5ByhUdhsIDQ4XUkh/Vlal/IfXGa7u2u
 F+5lYhgIGUuw6Bw4MXPksxscoxNhQaN4mlEpPUt/yANRh+BBO9WJpchMu5CaxvnqB6+3
 0KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xlVfa4X6hgu0Qn72UxF4DtuCgLqcTN2WoNHXseq96d4=;
 b=TMqswbo+aw52/yfOVXOrMQsTdVdCb8NDJUmEnYCSqhO1sO46I5rULCXetcf0fZIS93
 /pCvKQ7bNHs8Wn9mx3mq9BhyFK3vvVXQKeY1jsrUUloBukztJekkyhvYUg58h2egFXmw
 ZeCvAgZ3SCeTZzvodO0EGCvjXAvrlJjK5vVcsAL0XVegEXADA38MdfhvXyLIQ3nvoZph
 lD6xOu8gsRjrEauh+y6m1eX30sp/AJSWxIHe1qn/BCy4/P+veayrHe3jGVFOdsWSVMeH
 Jk7HHv8WCuAG4wscvW3IU+Lu6ANWXhbXVCgiRxZT8oSlgjkWs0Ymq7OHk4CC83X39LHT
 Jdog==
X-Gm-Message-State: APjAAAUzTGsgUl61eMPGddaJiuO3dE11xx2VBhfOqkJCWlk1PQKMx9dd
 lgSWBkudqnDEmfV2zE/CRIVqfGhorC/8lg==
X-Google-Smtp-Source: APXvYqx8PpmJRf//JZ9GrCdTFZMzXhhVRG8+yR6+xTff1ifLIkttG0Cv2OJlz32rNAY/xZfqhwNVmQ==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr869715wmc.6.1567525011013;
 Tue, 03 Sep 2019 08:36:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:25 +0100
Message-Id: <20190903153633.6651-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 13/21] hw/arm/fsl-imx: Add the cpu as child of
 the SoC object
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Child properties form the composition tree. All objects need to be
a child of another object. Objects can only be a child of one object.

Respect this with the i.MX SoC, to get a cleaner composition tree.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190823143249.8096-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx25.c | 4 +++-
 hw/arm/fsl-imx31.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 2b2fdb203a2..3cb5a8fdfd7 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -36,7 +36,9 @@ static void fsl_imx25_init(Object *obj)
     FslIMX25State *s = FSL_IMX25(obj);
     int i;
 
-    object_initialize(&s->cpu, sizeof(s->cpu), ARM_CPU_TYPE_NAME("arm926"));
+    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
+                            ARM_CPU_TYPE_NAME("arm926"),
+                            &error_abort, NULL);
 
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 6760de3c8c1..55e90d104bc 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -33,7 +33,9 @@ static void fsl_imx31_init(Object *obj)
     FslIMX31State *s = FSL_IMX31(obj);
     int i;
 
-    object_initialize(&s->cpu, sizeof(s->cpu), ARM_CPU_TYPE_NAME("arm1136"));
+    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
+                            ARM_CPU_TYPE_NAME("arm1136"),
+                            &error_abort, NULL);
 
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
-- 
2.20.1


