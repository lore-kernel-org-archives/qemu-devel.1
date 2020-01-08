Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546FBC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1472920848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tddqG9Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1472920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Vz-0007Y8-Ed
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I7-0003Os-PE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I6-0002mc-MY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:55 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2I6-0002m4-Gz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:54 -0500
Received: by mail-pl1-x643.google.com with SMTP id p27so535429pli.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uRKHrWARyM8biRjRhD8zM8zj3LVGuF9F2ZiUru1yT6w=;
 b=tddqG9QyGZPTspGH0T36v+NUOqtew0Gh97oipmWt8rHFKCKEntZkwjhBDMJXNxYd0O
 eplIZNwzroS2O9fr5v2qKh6LAvITJdmNVmT3tbSO6843W3JYF4ki9OV764sFAzHQxgvY
 4n4u+617x61hpYSxMiAoTv1faD+N2RygK7VbFOJ2BxV8Byx3W2c1vziY9cd6S+uPZz5t
 9YEo2Fqa7H34TyT0VKtXtt8GLa9H5dJLhD9Q7zES/nF22rs2cVqtWSIoicw+14brO5MW
 2dkpUlOnHUXE7EjPG69HhC2ezbVkNW40a0uoTqUIlYXJEts1sJ+x55hKvOTUb3/DUEMI
 g2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uRKHrWARyM8biRjRhD8zM8zj3LVGuF9F2ZiUru1yT6w=;
 b=fP/7kMSQdRDD8nHQioRQotRy83MPqd8pSHHMJOBBFZepPMgGvNy+g9W7xNwBebvQN0
 ulWOpFb8qGdRXBhkkSOWlkhtWVc4WvlahpTkG09WyuZYSQHSRnbYZGqAOSNzdJe0Ln53
 J6tRSU86T+PfLKkKmABXBdRdHNgXAoxRZxCRLb6aFsppaDKgRy+g7ueQeAt24PsK6THH
 r6OfvuRtqYPh+ddEgwh66OAVUmalhao3eKDv1WF4JHsUAm54IRpH1FXophnfm9u5I/wn
 oBAjT+zK40NogNP/1iGM3pnaRxZSTacCAJB7EEAHwRQdcBfpJcyVLOIP+ck0oaMpTg0H
 TTqg==
X-Gm-Message-State: APjAAAXIhpr3YBl17om/8sanWlSnknV+B+ErW8mYhy/v1jkG6cho2AOS
 aSPZ8zaoM3YHgJHNdQEhIgkFb+ZuxCn+vA==
X-Google-Smtp-Source: APXvYqyVZK1lc5Tf6y7oSB1AqXN/JAW9uflZZvftmOoonTjVPT5RpqAtTaZE+AxMyWLpfCJ5vSd3xw==
X-Received: by 2002:a17:902:988f:: with SMTP id
 s15mr3027147plp.98.1578455153317; 
 Tue, 07 Jan 2020 19:45:53 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] target/xtensa: Use probe_access for itlb_hit_test
Date: Wed,  8 Jan 2020 14:44:50 +1100
Message-Id: <20200108034523.17349-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't actually need the result of the read, only to probe that the
memory mapping exists.  This is exactly what probe_access does.

This is also the only user of any cpu_ld*_code_ra function.
Removing this allows the interface to be removed shortly.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/mmu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index f15bff306f..b01ff9399a 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -63,10 +63,11 @@
 void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 {
     /*
-     * Attempt the memory load; we don't care about the result but
+     * Probe the memory; we don't care about the result but
      * only the side-effects (ie any MMU or other exception)
      */
-    cpu_ldub_code_ra(env, vaddr, GETPC());
+    probe_access(env, vaddr, 1, MMU_INST_FETCH,
+                 cpu_mmu_index(env, true), GETPC());
 }
 
 void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
-- 
2.20.1


