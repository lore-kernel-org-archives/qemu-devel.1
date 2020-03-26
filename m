Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7849CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3F4206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYT9Pp6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3F4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYVA-0001ZI-Ak
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKB-0006WM-Nw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKA-0001Uh-Cg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:55 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:37204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKA-0001UK-8e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:54 -0400
Received: by mail-qv1-xf43.google.com with SMTP id n1so3709465qvz.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eDLiMVv+D2ZXvXpFAK7V65+ch4hZt+k/wLuboxFFAO0=;
 b=YYT9Pp6WMOUvmhMslR+1NSHC6ths3u+8qk/dHvbW3+zTnssXCynpiZdh98+9/qhJeq
 IdkYE8WvLEKXlQovJgJR4hKGx+6nIeZmxFKtJxMbc+vdPnTMTDgxmREqqhIihU73t1Y6
 OYUXga1Xoa/4H+VrkjhJyhn4CKWxUDI7jgte6L8/mZXANZRBKh3TLhUUAFqgyOhDTVa+
 MCJF2KlXMVFeX26c23+DI7gEmrQUhX4iReaV0KbZ4/IiU58hkop4I5oogKvhGXcL19wr
 eSUTShcXIh9Uw2yJEGNSXc8AaQOQIv6bvnjfMvwOnbJBPEqShjnZfyPVkh/WojLqntNP
 bIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eDLiMVv+D2ZXvXpFAK7V65+ch4hZt+k/wLuboxFFAO0=;
 b=Jw9rkkBZUvYsBqnrzBBBIBG7dxQXtDg8DDC9FqCxLbg7GmXcCmwkjSLEjgh3VNVH71
 twvKlJIEyXcy18soOcLHb+fkQpxZxuzJpbOONzbOeTJ5eVLKh1cxUl72o1jOaqlbND48
 3rdzRY5avsrE6Cs0LZRRU0BgpYsY7f2LgXxXzvdQJ6dyIYhh/kXATe6Pc0F+0mJroPOn
 7C5DK59ODnMn/nDwOpZ7AB6igQ3dmA/bcS0w1gyQUOAdnHOG/Q4AJt3KifNJx+Tpczeo
 uCqbMNluESaLLdH8zGE4m+CIePnDNpo2GrX86VHVqiYXXlT2KnaSlRAS3b8GVlpN1v6j
 54ew==
X-Gm-Message-State: ANhLgQ2wjiulb8l4KTZ7fNc0st0TmLlY7HER+kHKF+Sxo5/FjuUZfR8y
 bMSXiyZGqwoSfb0L7Bh2k/9VOXNPudwfUA==
X-Google-Smtp-Source: ADFU+vsbR1dRojKy4aX6gcSkSvPmPfdiQJ/plUPpXqNjOGorvAZ8C3oIR/y9PaLnY99rdUgXtU+UnA==
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr10065622qvs.196.1585251472299; 
 Thu, 26 Mar 2020 12:37:52 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:51 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 15/74] cpu: define cpu_halted helpers
Date: Thu, 26 Mar 2020 15:30:57 -0400
Message-Id: <20200326193156.4322-16-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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

cpu->halted will soon be protected by cpu->lock.
We will use these helpers to ease the transition,
since right now cpu->halted has many direct callers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3f7727ec70..48b46c90ed 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -498,6 +498,30 @@ void cpu_mutex_destroy(CPUState *cpu);
  */
 bool no_cpu_mutex_locked(void);
 
+static inline uint32_t cpu_halted(CPUState *cpu)
+{
+    uint32_t ret;
+
+    if (cpu_mutex_locked(cpu)) {
+        return cpu->halted;
+    }
+    cpu_mutex_lock(cpu);
+    ret = cpu->halted;
+    cpu_mutex_unlock(cpu);
+    return ret;
+}
+
+static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
+{
+    if (cpu_mutex_locked(cpu)) {
+        cpu->halted = val;
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    cpu->halted = val;
+    cpu_mutex_unlock(cpu);
+}
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
-- 
2.17.1


