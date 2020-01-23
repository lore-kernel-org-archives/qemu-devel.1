Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5A5207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSgySUIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5A5207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugOc-0002T5-40
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRX-0000CA-Pl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRW-0003fD-I5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:51 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:34460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRW-0003eB-Bj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id s144so2119888wme.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0v6Oo7itTA9z3UlsukmW0dxT629fmHL/fJ9CqJZVM0Q=;
 b=NSgySUIjhH0gassV4TETqVw55UdiMwbDFtil0y49U7CDKBGjFm7w39zgqDB9cXXo0F
 sO9omRtAkGpTU/m9C8jpzXihTnSZUVMsjGMNWvXU20Fr+v1g7S4Aydpk8qDDLg/FV5NJ
 AZe3x/jpx3jYF6DqMKV7AgrOBemL1R0k6h+pq8Gb63GS8ggeeviFwn4wP3eXht2VJ3nV
 wtdIFm98T3qFTeqAjeb4kgo8dBRfWDt9yZBfEVWc0ImEGqEHUha9jNyNTSQ1FtEI4Ugi
 X/CmuHpysSk6xWrSGuw3Y7VTNXgy6x2B5Gn8awzheHJXuToiwfSHF3HbOAAALoRgEyK7
 Sm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0v6Oo7itTA9z3UlsukmW0dxT629fmHL/fJ9CqJZVM0Q=;
 b=ajSA/agUJATfNKVQWAe6cRg8ET/tA1cnMWfgq8rt21mwelE/s3tD5pYIa9Z0o8agAC
 t0gqGY9IKDqA/wq6L7PES9J7IQ7kFnf/Ps5KOIooEomBy40+Fc47C+2d6gROc5og2sdc
 Ep3P8r/71kSDgGtKiMB0TLAB7+ByUQHI330uQkDSb0FRjm+dTIGYMVSVDeaBFOB/g2la
 FOhRju8WQ8UrDccppzXBqkNrNrf/6zpiDrfiXRQH1p1YszDzXz2ydX868+lSB7YcvCUG
 ItK7a1eKVscyCA+TyCzXEIZT//7ccVO4ttDFkAXXKUbm2aXUdZM3+OF55IWOJI2XbIj/
 zK4Q==
X-Gm-Message-State: APjAAAX9SFC8IvJoJD8riDEVgILe6KrtBWLIDSFs87WwXLn0b9Nsktkg
 RU/Ra666NpGz2apZDbDWwOjJRCQaf8PTww==
X-Google-Smtp-Source: APXvYqyYPZNZthOxtxEUploezbUx+7q+VQ1bCfTHo9NKm/4smRBj9eMpezUF/89ry+2+COpxcdm7pQ==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr4789067wmg.34.1579793449227; 
 Thu, 23 Jan 2020 07:30:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] hw/acpi: Remove extra indent in ACPI GED hotplug cb
Date: Thu, 23 Jan 2020 15:30:27 +0000
Message-Id: <20200123153041.4248-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Keqian Zhu <zhukeqian1@huawei.com>

There is extra indent in ACPI GED hotplug cb that should be
deleted.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Message-id: 20200120012755.44581-2-zhukeqian1@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/generic_event_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9cee90cc706..55eb29d80a5 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -175,7 +175,7 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
     AcpiGedState *s = ACPI_GED(hotplug_dev);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
+        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
     } else {
         error_setg(errp, "virt: device plug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
-- 
2.20.1


