Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D2EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E399D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBNhzknP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E399D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYwQ-0007ve-3Z
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLG-0008Nk-Ov
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLF-00029Y-N9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:02 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLF-00029N-IU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:01 -0400
Received: by mail-qk1-x742.google.com with SMTP id c145so8140955qke.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gacJZESnVEqf4qDD4ve/Hru1eX3df4yi6C7OwVt2hqI=;
 b=kBNhzknPUnADBAOos+I/ZAk0539ZD0y9aBnUxRzQUffxPzh1aBireyAk8kPHdMh7Ri
 yVcUqo21xbeFGC5d+cYmaBTT8jTpuPp582/61fTXXDGzFzulcVAaBlERRbMNNqRAfNMA
 JtN2B144yFlBo6rHmsDd0ml20GVV1KdzKSHpTCBGSBidZV3uUQM7sdYsB6V+JW1lyYUP
 qjTofPY0hD8KEKYbU4f9JrxeGV/dcDYfvV+7tmtpq64uKqhvQWLCtFJSeQW9khciCqm9
 W97sY8GbtbbONZHuPNTzvvbBGzifigWhXBX6ov5lqNB51KxO/i/FKNbBh110oS/7U0ca
 ozXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gacJZESnVEqf4qDD4ve/Hru1eX3df4yi6C7OwVt2hqI=;
 b=k2y91F5bL8C3HckzHNXHAz1bhdcTf/i50c+3aCbXSmngDtUM7/MJXxzlzTVnIQ1yQq
 uZ5CSzzGQXNBBif81XwzKUNkotlq1LAPLOx+BXeRfUxe5LkoVPCtLQvfyIoahCdjGGj1
 Fq04phRiQDlAtgRwjYk5dl5xauKLeYQ/J3O6F2hppOiDs6rm0u7xT9e/LLM9JuvvrneB
 RP3asucs3W82/2brEXuLdxvlfl7Tv2kHRaq0YuPXnjgjLCS7dpwsf+BzRpG4nNtWwOce
 +lHgX0azSqA46STiGrhDUsgO3sPnPdkmHjCcHhqithXmgx4f3RHiNf5IPxHEXzZbcU90
 UmYg==
X-Gm-Message-State: ANhLgQ1CA5+jkjJYKaQw/AiWTWvz+HmIyvv/uzdv386GgdSAKbd/uJ23
 zrZ/YhabjuNSaDKg1x43QtCsp2NCBWcY/Q==
X-Google-Smtp-Source: ADFU+vvJdPYuKO/NIsTjMMJoMvLouxPSroVvx43Z5Ev3tnATOKccpexNMB1h4DETKyhO08FXS7da1w==
X-Received: by 2002:a37:453:: with SMTP id 80mr10007108qke.325.1585251540096; 
 Thu, 26 Mar 2020 12:39:00 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:59 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 62/74] cpu: call .cpu_has_work with the CPU lock held
Date: Thu, 26 Mar 2020 15:31:44 -0400
Message-Id: <20200326193156.4322-63-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1c3701b142..a01c258320 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -80,7 +80,8 @@ struct TranslationBlock;
  * instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @has_work: Callback for checking if there is work to do.
+ * @has_work: Callback for checking if there is work to do. Called with the
+ * CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
@@ -799,9 +800,16 @@ const char *parse_cpu_option(const char *cpu_option);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool ret;
 
     g_assert(cc->has_work);
-    return cc->has_work(cpu);
+    if (cpu_mutex_locked(cpu)) {
+        return cc->has_work(cpu);
+    }
+    cpu_mutex_lock(cpu);
+    ret = cc->has_work(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
 }
 
 /**
-- 
2.17.1


