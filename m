Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B4C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A018E20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p65F/NlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A018E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAde-00068b-Qi
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAac-0000YR-1B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaa-0003M4-Pk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaa-0003F0-Ij
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id n8so21058777wmc.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7QaJCv7GzRfGh0KkLLK7VCXCCrICGrOH8s1Sycp5qFA=;
 b=p65F/NlVIgSOkwUvLg80G0rnrKNGAqyMxUegZmTKBWOtpEb1Djb7+rBUJEc3okVMFa
 h5mbmNliCWWd8Ar8TXB7MonnfTe5mV9uTd97NPUmP5zop+KxLxuJENt/zR9BGFWnijQk
 GB5f0u09aArT+c36p4SmPR7vGxigDeynaMwP8dM7hJ7IzMgOLUqjf6+94cTR99ec1zg2
 rtRlYiRqxvGx0Jkg5CePRj2/DHh5z5+yU8MqPSWnOyLOCz7w23FzXjtYxoAPtaKkBa33
 V6VnIBor9lz/+mdBWL5hkDEiOBVg1BlM39toozV8EZA2uPVXDdmhDePxRP2OnyogmpE9
 VA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7QaJCv7GzRfGh0KkLLK7VCXCCrICGrOH8s1Sycp5qFA=;
 b=lxAIwQKZuc7B54PoH8C33BO8cwV0OKvaZHIgC1P50AfFMotr/ir0V3aLg/R7swNJFQ
 Uiu2e3oYigA2HwzK6LeNKaD+FeqFnG7VKQrF6TC9jaz1snoDtPiO3m+F7qbXf9w+IWG6
 Khk87/e5D3CVOSmTYfiwnHqXT/CQ1VSjpXx8EjQCta2WIyVn5qZV0n6QTcFuCcSms6/v
 xVhV+hI72NPssr79GKp3CQIdiiOQ3e3Y7iYXmOia1UsO7eslJh2D0zOsLvQiRYZoDTaW
 Z99XMaNCFy9OSwmohWX7tGU3AqCxWCaBMhcL7jyNX17H0b/W9S6lImvdPgnLh5q/BRLY
 JX2w==
X-Gm-Message-State: ANhLgQ2a6Gqjm+8Jt4HF7PN/qLQkxK+kylz/0Wl7X3mTQZ3lDKJNEsXI
 YlOmBb9brvoJF4MNvy6QttLaULeII6NgzA==
X-Google-Smtp-Source: ADFU+vsTgTCjodEg+OcPg5uOds6Zxx/GV50FSGSZDeZ2EVrOqv1GNY3GGi4tCxMlkPE1vawxT//cMQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr4811503wmi.72.1584445251089;
 Tue, 17 Mar 2020 04:40:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] m25p80: Improve command handling for Jedec commands
Date: Tue, 17 Mar 2020 11:40:36 +0000
Message-Id: <20200317114039.26914-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

When requesting JEDEC data using the JEDEC_READ command, the Linux kernel
always requests 6 bytes. The current implementation only returns three
bytes, and interprets the remaining three bytes as new commands.
While this does not matter most of the time, it is at the very least
confusing. To avoid the problem, always report up to 6 bytes of JEDEC
data. Fill remaining data with 0.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 5ff8d270c4a..53bf63856f5 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         for (i = 0; i < s->pi->id_len; i++) {
             s->data[i] = s->pi->id[i];
         }
+        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
+            s->data[i] = 0;
+        }
 
-        s->len = s->pi->id_len;
+        s->len = SPI_NOR_MAX_ID_LEN;
         s->pos = 0;
         s->state = STATE_READING_DATA;
         break;
-- 
2.20.1


