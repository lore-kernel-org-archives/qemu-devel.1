Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E59C7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7749206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXIUOD/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7749206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eu2-0003KB-R4
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqJ-0006Qi-Cp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqI-0002K7-E0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqI-0002IN-7c; Mon, 17 Feb 2020 06:45:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so19314236wrh.5;
 Mon, 17 Feb 2020 03:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CQieaLe+XzdG/scqrmf0SdvellEvi4/sJOsfkTjUk/k=;
 b=IXIUOD/tMMjlZo2zjX9iGESFe/AKtsDvRbx/V/mhLn3FuF42j6ZcuBvCJtqv/b9lrN
 vZK4CNKbTZnZzbFN9DAwiTMlp5OWHCpktH38QBI05Vzm5TQGW8JynuIVYxCGLjNy7qdN
 bVkSf3cROrY2WGaZZFKFq3cHSEDqHu7KeLivWZqmtR6QykTuq6GoIFXEIPgIH8iQ/1TR
 ypGAkGM7lkxSeWBGVR43IFUe2COBUjCcdx11eVonxxAw17JNXMiQXfhxjZqydbSjeStJ
 YydpEdzBvFWCaqr2Qk0Ar44ZRKPnbKbHrifH47c4EBJihaOBQ2W9E7bT+qtOFfuKXW9J
 q2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CQieaLe+XzdG/scqrmf0SdvellEvi4/sJOsfkTjUk/k=;
 b=pxeIHzmNdiiqDaw8+l4YK8Rl+wIsKk8kpNTECsSGAwTDJnB8AWm4Y1/GNKX5/C/5CJ
 NoZSUriqYYlWwXG6xrNUOmBLv1kTv2MTqSkqjLz26UE9+P8+TzXEx1L+mZ9eccFkpdC3
 ZAFdXG5JcIzbXvnXDm0Tqh0cvEDndmS3Cy4Q0gfo9FxrhXgtAxEO8c9moqkr+h5o5EGi
 e8Jubr2lRAwFMBlH1kUHB4P/YEzYIbmDiVrygSfHLBuBGjKkJ9z9sgHeULUVtWUStB6A
 vkkxa1t1MOOZcsTnCA6Ru4Mr8R8NBPipjf1c7+WzmvjxYkNmKWfcexMM5yvvtcX7ctHr
 oIGg==
X-Gm-Message-State: APjAAAViVpFNv2Ub8nC/HC8JE9N1a0maxQ0maiIByHrvuQw5g1gNRPoY
 MgGtGgIwLe/MvtfsjnPFyzzXbxrNpZ4=
X-Google-Smtp-Source: APXvYqyCyTaSKoOnUMXxlNNSRIZtMwfx7erIGg+tbxIRjMLG/vF1Cc1ozev3c6CJPx+/z7ZhQmHNrA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr22952522wrc.175.1581939937009; 
 Mon, 17 Feb 2020 03:45:37 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/13] hw/arm/raspi: Remove
 ignore_memory_transaction_failures on the raspi2
Date: Mon, 17 Feb 2020 12:45:21 +0100
Message-Id: <20200217114533.17779-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 1c3db49d39 added the raspi3, which uses the same peripherals
than the raspi2 (but with different ARM cores). The raspi3 was
introduced without the ignore_memory_transaction_failures flag.
Almost 2 years later, the machine is usable running U-Boot and
Linux.
In commit 00cbd5bd74 we mapped a lot of unimplemented devices,
commit d442d95f added thermal block and commit 0e5bbd7406 the
system timer.
As we are happy with the raspi3, let's remove this flag on the
raspi2.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 90ad9b8115..221356933e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -324,9 +324,6 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
-    if (board_version(board_rev) == 2) {
-        mc->ignore_memory_transaction_failures = true;
-    }
 };
 
 static const TypeInfo raspi_machine_types[] = {
-- 
2.21.1


