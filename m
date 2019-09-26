Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453ABECE589
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D06A21655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZ5YQquK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D06A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWpB-0007mU-Ew
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcK-0002nf-1Z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcI-0004ss-Kr
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcI-0004s9-EC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so2145531pfw.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8blXRqcbFbTzejzjElPQzOmrEhdRtWtBUHSTiMchkDQ=;
 b=BZ5YQquK8X6lz7nhreQWrs1k3IxNPZv0U19B3cH71OjWHgYQqz9twCd9FekBkwb1lV
 YSVlN4BPR6Dh2geSQlrSTNg6Aaw3MyAoYTEVxZE2xHfwchxFgbPMS0pryPRNFDhnRJDE
 3ljJL3NBBzDkaiXWDZxRB/peJCagVmefn6A+Cgs7u+61MuyixUoUKLMYkBU1/Y98mbbi
 jC3goPzuMX7O+shqhagS0HX/8fz0S/YdRueV1UC5ToHXBGat07X6qelwi8tLiYmREMys
 FpjHaUWJ5KFk0Veoxh5CmGcTU70LyDKGfsVOqTjPiGKaWH/OZ/Su/JcSotisgMZm5tiw
 0lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8blXRqcbFbTzejzjElPQzOmrEhdRtWtBUHSTiMchkDQ=;
 b=aRkTuBLVntM0J2lAX4LdOM6ZUKTTktZAA75ogLKgVpEOn2pprBGFgKA4hkv1IH8W9R
 kFJWnDU7YHrKzcLUn4YZ0xK31WbMETlOQ3FQZVQYypjbQnoAAT3ezuEDCsozDiFzt1Yx
 VYFjt2nm5Y5zWai7t6/+sPU0dWGAb1J4J0U5dyXWKmLKhz4ox7zdsY2RQi8b2SStyU4T
 HNLvRTQ6FZFzhe0c1Gh7EzwRtjKjcFQRlfhqG+0+x4vTApMz/ooAPC02q+gbEMa+96lh
 43KLKrufnq28i2WEfhpq5wQ05yM/sT/efEQsHV6UcXgt5DvWdQToZe8smZQ6ttYUr8dV
 lhPQ==
X-Gm-Message-State: APjAAAXMwwx2hIGEr26V8eBXPAofzADFLBG05CzIkiW9ao9tc9AL4FDB
 xJL8fWfO8WhViSyf0NZ23b9khTOMO/g=
X-Google-Smtp-Source: APXvYqwTjpNncAnu4Qz4qpAsshcwkEIKuj8BTduiWHwBTtYYPIby64LgT9ecYHf0xjOaHPG7tB00Hg==
X-Received: by 2002:aa7:8e55:: with SMTP id d21mr4495837pfr.241.1569515200991; 
 Thu, 26 Sep 2019 09:26:40 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/18] target/s390x: Remove ilen argument from
 trigger_access_exception
Date: Thu, 26 Sep 2019 09:26:14 -0700
Message-Id: <20190926162615.31168-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The single caller passes ILEN_UNWIND; pass that along to
trigger_pgm_exception directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index bf7fddb056..e6c3139c57 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -33,7 +33,7 @@
 #define FS_WRITE 0x400
 
 static void trigger_access_exception(CPUS390XState *env, uint32_t type,
-                                     uint32_t ilen, uint64_t tec)
+                                     uint64_t tec)
 {
     S390CPU *cpu = env_archcpu(env);
 
@@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
         if (type != PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
         }
-        trigger_pgm_exception(env, type, ilen);
+        trigger_pgm_exception(env, type, ILEN_UNWIND);
     }
 }
 
@@ -482,7 +482,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
+        trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
-- 
2.17.1


