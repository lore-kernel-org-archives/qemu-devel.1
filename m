Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A326F206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3hvHo/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A326F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR65-0006K0-P4
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxP-0008Ht-FY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxO-00056f-E0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxO-00055q-7F
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id n15so8332451wrw.13
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+Zh/gX39d2aODor2i37S4XUBcuebSWFiBNOGzJcNTac=;
 b=R3hvHo/isdyZDbF1nswPYthyCedaWwTQ2XS7kwLhmhZX7RAdWoQWJ0C4zjQqs2dvbB
 fSjo1nqAiB7W52o5BBrul395LO8tjgcGUxnGggtqHQjJ1Y69FHwOCPCbltATc4SE4Kth
 S03WXnCHBEgGoIdQAI6NIaf9nIHSV1yTZ2aVEMj0xB7ihmeto0GQEwrFIz5MzNThLyR9
 IqmP4n4KnN1+BcXTcE0eUdByj/A9bYAbgAyVncG8zhrG1ft1sIKip514qryn6ptkxOEw
 x0kbQrZVAnFFHvOTDmywYxgtSRRNGP3ubP7Xrse53M41NemnkZpWtvQB4pKUPIWNRmHR
 dkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Zh/gX39d2aODor2i37S4XUBcuebSWFiBNOGzJcNTac=;
 b=rSrrsD6dXqmj94x3OXT7/KjLnm6JgCmo6RwGhE7WLkONkh/qkIiS/IVA81Bu5YB4i4
 7pzr8CPnqcw0XKpkBebkxthYs7iaG3mWjCcb69B4AaQM6mnw90SwGz2gCcNpZr8X4Iue
 RHCoxbmhtqSR7F6me20OyR1AGVClmAb7YIAzl+0VNK4cKD91RQJvEYS9SjirGGxkIHVP
 JoSJOlWB1m2pbXbjLaBk+zCtaCTNQWLJQGEclEyh4G3SGheOVyKI1qe1ABtDI0Jy0qxg
 bF4gNygfIWxoT3nhFyjbFsv1pMtrdXTYPA2oFoXf8Fid4lteViDlU9AKmEeaZIZpJkon
 3/eQ==
X-Gm-Message-State: ANhLgQ11qnhUT50MKzudrv6UmT2AD59aRcVYnggUVBP4ohlL8tj4IUtT
 +1H2K5vqtUTDXVUSujyCh+S1u/k1zxWbBw==
X-Google-Smtp-Source: ADFU+vu2c7KWvvBEU3lbCYgDv8sB3DhFuJOEWKn/0LDuqpKcmJyPvIXPaSpblWvN4s4XKlH0k0f6yQ==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr11745907wro.244.1584031512238; 
 Thu, 12 Mar 2020 09:45:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] hw/arm/cubieboard: make sure SOC object isn't leaked
Date: Thu, 12 Mar 2020 16:44:32 +0000
Message-Id: <20200312164459.25924-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

From: Igor Mammedov <imammedo@redhat.com>

SOC object returned by object_new() is leaked in current code.
Set SOC parent explicitly to board and then unref to SOC object
to make sure that refererence returned by object_new() is taken
care of.

The SOC object will be kept alive by its parent (machine) and
will be automatically freed when MachineState is destroyed.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Andrew Jones <drjones@redhat.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200303091254.22373-1-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/cubieboard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 871b1beef4c..d791817646b 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -54,6 +54,9 @@ static void cubieboard_init(MachineState *machine)
     }
 
     a10 = AW_A10(object_new(TYPE_AW_A10));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
+                              &error_abort);
+    object_unref(OBJECT(a10));
 
     object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
     if (err != NULL) {
-- 
2.20.1


