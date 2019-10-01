Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119EECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF5F2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kp5NU5ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM50-00044B-AS
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlQ-0001kG-Dy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlP-0005d1-BW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlP-0005cc-6S
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id e1so4578435pgj.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T27/+7RLgsAKUaeTVz1uKZeEShCunhopOomrfELwqqY=;
 b=kp5NU5ewrUf6j+pZlpRB60fFTlIcbw89bU4zg65RlyPQJLnpb1xINweNtmyWotr3uh
 bbcCOz6tgw0zlB+OTJ1t5xRVosXuM39d/lkwv7ZTiimsfxlscmgx5nK+RspmHD4XQjDN
 nnCTgVP4m+0q2NVKVMkSRgA4BBoIvZzUcHaHhbm+ZFXLoINZEg4K1K1uZpk1Hhe2jYfS
 7D4xDFWhiA4THWuwjyGOe+le41lxU98Z8YsB50KWVvDsAYjviFX99drtEh8QuE6qECvg
 J0YQOQYKSMmpljO7P4bD3xut5OgchUzjVZ7FT+pKjNiNWmPdsDES99h+JJORxXF57owo
 BX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T27/+7RLgsAKUaeTVz1uKZeEShCunhopOomrfELwqqY=;
 b=pKdpDP3SyVCgFeZn/pc/rAoYWwJ4tnhIAIjhvw9Osht88X4LWz1zoEkfJMv82HKAZL
 YxVL5EdgB2RFJvQ2Wyecnrp3FVJWDh5RlTxjKGqhDIr+BVYU7kLKuafDA9oo7WWdVNYR
 Jx42csbByINOSIwEskXRe3O/ZdZhSQ1l8c3NIQHMlEnQQldAioJ13zG15uNmkPWtASD4
 HEWfl8IPGH99KpHiaDO+DI4/KTgvUE3p6zswV5N8UEsRuDRzVYyNLVVReKuQinugB+4D
 OKvecsdmFTGitrKXtmreTYzlrYpQgcp6sdc6Lq0193g46G2Gzcs+AZq5GO/+xCXTaCPQ
 nywQ==
X-Gm-Message-State: APjAAAXMWwn19ORRxhXuHNs13Q4LbvjirgEPoyF0H7SYH23eEpIe5vK5
 q0Xg9+4hCrtzXYoyTu1YGSYkEgkAb84=
X-Google-Smtp-Source: APXvYqz+b5m8p/UheH/VDxeTTDyHz0SxUzLdMbu9+GSfF3LoskSe/1JLq5vzlB1nG2zbboz0RiLgXA==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr31211631pgd.190.1569950197258; 
 Tue, 01 Oct 2019 10:16:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/18] target/s390x: Remove ilen argument from
 trigger_access_exception
Date: Tue,  1 Oct 2019 10:16:12 -0700
Message-Id: <20191001171614.8405-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The single caller passes ILEN_UNWIND; pass that along to
trigger_pgm_exception directly.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index df58fb73ba..09c74f17dd 100644
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
 
@@ -510,7 +510,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
+        trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
-- 
2.17.1


