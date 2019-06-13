Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F345C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 04:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D382133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 04:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dL/heaFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D382133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbHAj-00036F-5I
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 00:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbHA3-0002E8-1H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbHA2-000620-3O
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:16:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbHA1-00060B-TL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:16:26 -0400
Received: by mail-pg1-x544.google.com with SMTP id l19so7537395pgh.9
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 21:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E8T9QYRxQ8oYv/LyVXgALpcOgOYN25OmkK0wh8S8+x0=;
 b=dL/heaFlr/FFCB1z+6v7NecnLByMyoHiXjFYWo0Af3W8XYO8HjuAX8yARNZPnC5j9q
 zxImcmcGh0gzoVlOmD8YFiIspdTeyKCb/IPMXZFu322WNTZCUvGFTx52gJKUZZnxT8K9
 xFqyaCY1qkepKNuLJ6LDs9QN0OiQgttFlIrGq13qBylBkMv+dQfOLMOZJ8S06nWwv/Qr
 vIUrepLze5Ccx9NRCaDAtuNORGU4i0ucIi2ZovePBUd24Vr9YYGp4nl/YfkBQ7zZSa7t
 cbyetP5o4n0kWTAOpbj7rR97s+7mIYh1g3PirJzlfDbxXvGIpJU8n9ZiQZRm7KyXMdzK
 hQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E8T9QYRxQ8oYv/LyVXgALpcOgOYN25OmkK0wh8S8+x0=;
 b=thlSBQ/Z1kNKNHY7aFoyzgmsf9MwH8W8FqhnXwaN7EPrMH/4723wLUV0KCgKomgwSJ
 GyVrtxkH6+O7MzKavPmhIZ4H2GZd4/S8jr1o21mED3c4iHoa/BnggaCbUN0znkMHQiET
 +Ny+/BO0cZfi49tGbOp3bC/h+AzfWign1Zkk0vVQGz0SBHx6ej2ieZXuDvkQgymhDU5p
 8TO+bNO9IbC6FX/POwjg/VgOZ576B/y1Cn4T2ybPJDyEG9vRc8anqHAqSf1sVVO+069F
 QzOQYOMtTmjV5mRg6evY1hXgU60vGdpgKk5fIVO68ka+rfVS99PsHZ4RHDMT7gGvitla
 hriw==
X-Gm-Message-State: APjAAAX9vO0dParZBnEjy1N+1h4eM75IYS5NIUVYS/T5huqVD/0f55no
 tehLsG1abI5A/gTIMOh5T3gj6OMX82Q=
X-Google-Smtp-Source: APXvYqx/vWPyT2W6ivzX9UF0Zr5/vCwUPmmuhipHmf+xFfB9NXjCjCFa/Lc9k8VBFX9/dT92R257wA==
X-Received: by 2002:a17:90a:23a4:: with SMTP id
 g33mr2874252pje.115.1560399384524; 
 Wed, 12 Jun 2019 21:16:24 -0700 (PDT)
Received: from localhost.localdomain
 (50-247-96-158-static.hfc.comcastbusiness.net. [50.247.96.158])
 by smtp.gmail.com with ESMTPSA id m19sm1301262pff.153.2019.06.12.21.16.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 21:16:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 21:16:19 -0700
Message-Id: <20190613041619.32102-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613041619.32102-1-richard.henderson@linaro.org>
References: <20190613041619.32102-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 1/1] tcg: Fix typos in helper_gvec_sar{8, 32,
 64}v
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The loop is written with scalars, not vectors.
Use the correct type when incrementing.

Fixes: 5ee5c14cacd
Reported-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 3b6052fe97..51cb29ca79 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
         uint8_t sh = *(uint8_t *)(b + i) & 7;
         *(int8_t *)(d + i) = *(int8_t *)(a + i) >> sh;
     }
@@ -898,7 +898,7 @@ void HELPER(gvec_sar32v)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
         uint8_t sh = *(uint32_t *)(b + i) & 31;
         *(int32_t *)(d + i) = *(int32_t *)(a + i) >> sh;
     }
@@ -910,7 +910,7 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
         uint8_t sh = *(uint64_t *)(b + i) & 63;
         *(int64_t *)(d + i) = *(int64_t *)(a + i) >> sh;
     }
-- 
2.17.1


