Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC9C3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CB324649
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBr6zKFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CB324649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G04-0004lU-K3
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhO-0004mG-0L
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhM-0002OE-SL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhM-0002KN-Lo
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:36 -0500
Received: by mail-wm1-x32f.google.com with SMTP id p9so6543066wmc.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L9ug2rW4n/rgxEDf31AyiRb6p+9+e7Ktz52N1Gpec+M=;
 b=LBr6zKFHWtctf0rHkC0N0iZfUpdGE5w0QPqikDVMe8JW6S715sYvB2nVP3s6pWN3tt
 L7oq1RQvhoSsuCMxGT8wJ12AyGrfVr9nqheVEU79cf+bFnkzLR74JY7jYCHzkqh8DqZ8
 RQkxOKraWV2c+sgXGDC6sOj7gWhuOvrk87wv570CVhGoWZxRSRCkFS7CgJ11gX/BBILl
 UszDWzaYnNMbzMMul6l7omNdB8DrYHwF3USWmELZZDbOoHkKqD0ZhyIppJS3TKaEasJz
 9jDbqWjLtfuXFR4wyjKDni8C0OzWYHk2mRqfl3RpOajUnhL98AR+CKlXTQpYQ4dHNdEA
 jixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9ug2rW4n/rgxEDf31AyiRb6p+9+e7Ktz52N1Gpec+M=;
 b=anqF2uNj4SdbtS1cJSWCiG8g4HYykYp50iHYjSztqvMYo53R0w4s6z1JMJ284ixE/c
 +x02vuN2gV0RvoJ2tHvahmvICpRSwUKpVV+1mdwCS3VHmv09D/PJNGUu+s1KtQaNJEWZ
 71TAj2/+UQPjSbF3dTO71b7ktDA7TPsbdxKDNNu3tQgubSkkUIqWp+dY6sJRgQpc7Y6y
 sI8wk0OjAwD+gxqnbWEhBiqDxzYh2iXcP3RC6l9nEJiBfJ1GBBw6reSL/9tzZFKyPbDh
 i81WOKrUuMuf9oeDgbr4euWzHsRL1xwOCSq/kyG0+Zp3TLrgrqdITfTZK6Gpi4wL7YVq
 KfYw==
X-Gm-Message-State: APjAAAWBqiRsZCIC8I90YScJrX4rDHylR4D3qH3bjeopruYwy3J7Edmj
 veplETmZNT520SnCAdtELAgY4WnyzkY=
X-Google-Smtp-Source: APXvYqyz/SaWeSG+lRGMir00jkSkzHQ+csa+y41vF3v2+JhJsYOZO66xKD1mRfj2lkLFTykTkE5ZCw==
X-Received: by 2002:a1c:670a:: with SMTP id b10mr6108958wmc.2.1581604950425;
 Thu, 13 Feb 2020 06:42:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/46] hw/arm/raspi: Trivial code movement
Date: Thu, 13 Feb 2020 14:41:37 +0000
Message-Id: <20200213144145.818-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is no point in creating the SoC object before allocating the RAM.
Move the call to keep all the SoC-related calls together.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200208165645.15657-7-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7a2ca97347e..b3e6f72b55a 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -227,9 +227,6 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
         exit(1);
     }
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            board_soc_type(board_rev), &error_abort, NULL);
-
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
                                          machine->ram_size);
@@ -237,6 +234,8 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
     memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0);
 
     /* Setup the SOC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                            board_soc_type(board_rev), &error_abort, NULL);
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
-- 
2.20.1


