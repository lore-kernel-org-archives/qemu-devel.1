Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC0C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA712168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="He482V05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA712168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLJ4-0000es-HW
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFF-0004Dp-5r
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFE-0003Ss-7S
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:41 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFE-0003OF-0Y
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:40 -0500
Received: by mail-pg1-x543.google.com with SMTP id a33so16263925pgm.5
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TefutcrMB9pareM/zxzC1lVLnwDD302zB/fR5vwwqMc=;
 b=He482V05R9k0rygoGIICBNAFswxjxmfOc5nE59djzdhF6Psht9FBYdiKs0jxPfY7cz
 LMemqN1E8Kd1h1DjHwz/FLWnSNMep9IOK4R7Kch1VljgCRd9O6yEIOqkqbhAajGMWLG4
 5mOqLejmNEVqzYpyJKqQf3iNj9d0aKw8IkFGMP4sp68W+B4VEZQRviGaDxRAaw9qLd4o
 2a/kvouCtWeYBcLmQfiGrjm21xAtmGr3Cgd+CcdbaveaEBYQ+VwiTKaT7RUwbVEd9tp4
 HrM7BY3YUGUIQLFK9uyaLlNhCMBjIYnCZSO4SwCestiJ100OXAkaSxws6DvYeU+BW5D0
 OjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TefutcrMB9pareM/zxzC1lVLnwDD302zB/fR5vwwqMc=;
 b=JaOnFoi6MBKBPQAcgzbuTy/V7LASqPtDALq1/33yOEfe9kYWDX4yGnKsdSbtjL/GZl
 RPXsHLZHpr99kIPlAwlMFQe7hmBWmyGDWu9jAwGKA+F6G3Dpe0zaSH/XuUoWoWnFfXNW
 6nMm8iavOJIY7s50wQsy1r7oISwezSJ1/6ZsDitacNyLcKNAsoqK3TElBd4EPycDMvh+
 KYI0nCkbj4cPUdKTE5d8RAw1x7xjVPqMjMs9LJzViSfd3XdxSWOdlFpbwENQxx2Cz3q1
 AbRk4Rc6wVxxmWaVfOSUivvgspjaMiHkl9FyXSsKW+/GgwbvWQblB+JJA/Oh94hDuTnY
 J7tQ==
X-Gm-Message-State: APjAAAUvig8RF92sdeCfZgibPOcHonBgQNuA6HlcwTYz0cmciyZbpxwA
 4x9zemJMuITsCbfCiIOiIyvU+b0Gqbk=
X-Google-Smtp-Source: APXvYqxtqxVcXHiiZJmmjwsBdlyzVVOp0dyWFL3TP93BgavdjyYEKloCi/kmmPgyeEM3tIh3f/mwCQ==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr61537504pgl.409.1577574698647; 
 Sat, 28 Dec 2019 15:11:38 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:11:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/29] target/xtensa: Use probe_access for itlb_hit_test
Date: Sun, 29 Dec 2019 10:10:56 +1100
Message-Id: <20191228231124.18307-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't actually need the result of the read, only to probe that the
memory mapping exists.  This is exactly what probe_access does.

This is also the only user of any cpu_ld*_code_ra function.
Removing this allows the interface to be removed shortly.

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


