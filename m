Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8801C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF7C2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzIkzCRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF7C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM2d-0002A5-Q6
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlK-0001fe-Ki
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlJ-0005Zu-KP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlJ-0005ZW-FS
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id y5so8478713pfo.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vJYZZP2e9BNSzbbwHk+HhznESdz192Yke+3plcKoZ6o=;
 b=XzIkzCRUjUk4HEBRS0gpgM6RZkrUiM/UgAAhxXtu674ygOePLxt8JTj79MXXOFvew7
 5cXaQzauSFgEschhQrGI0wXw1Wkxp5GBh23/aZey20wOwOph/GKmADniiOY8gvAXm2CW
 lJt1CmkNY6Om98QILFzTsvU1td0FJTfuqblnYGeNFYVcAqMoT72biGxmQ0Z88BkVM/P0
 3XcMkXJVXsYR8FOTSmeWNrGEA5cQzQx1H6OOgha61GE1fXErdyKKzvolysqdlv7+Jqop
 aWQKN6ZsXR0nD5+LzMxhyIDyXGQXvm6sif+rHftS1dE6iPahzk/K2xVq6DHB2oJhoKeO
 1ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vJYZZP2e9BNSzbbwHk+HhznESdz192Yke+3plcKoZ6o=;
 b=leOdgKdvWEEX53p7jSSzJIkTLiCqJ1mT5wq7N3qEefzypFhQBEfIkkNFMVX6ulbtYY
 hu/D1VetCTV6nlXtKnhKdZUqRrVxdIUL4N0r86/QYDTLK5HvBNM4cVmXnssr5r/RQ2O5
 QZxlNEA6pVEbGc8NtahMFpvKRHqSdf4165ZbP8iaL6ZCbMZkzEO3CrI0Qcw36gvEl9DM
 blOayinKD4+DVDVBrNrHT3zw0A7pAQ1ixzkZmlGMGqwiH10BfLJsTyVCcPjCZn6yL9B8
 qI/Qx4iiXUn061UTRJgucoHC9yGr86q1Pz+eS/kIUHFj5YlSZszTK1ZmuUq0xOnjjART
 uRDQ==
X-Gm-Message-State: APjAAAWIU9Plv7TrVPn6TaxD8ZOTx9xXhQEPb5pJ5CIvcw9fk6O0L+Yd
 diC9kRRzmkaPmW0sxEh0oh2xIbDYNOE=
X-Google-Smtp-Source: APXvYqxv7IwaWxZmWlDXpwqz47GxXnLt0piwx0c0vv3kFU4F+yUHlG0+QJb7lFs9YAag0XCKb8glfw==
X-Received: by 2002:a17:90a:fe04:: with SMTP id
 ck4mr6872581pjb.74.1569950191808; 
 Tue, 01 Oct 2019 10:16:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/18] target/s390x: Simplify helper_lra
Date: Tue,  1 Oct 2019 10:16:08 -0700
Message-Id: <20191001171614.8405-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

We currently call trigger_pgm_exception to set cs->exception_index
and env->int_pgm_code and then read the values back and then
reset cs->exception_index so that the exception is not delivered.

Instead, use the exception type that we already have directly
without ever triggering an exception that must be suppressed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e15aa296dd..4254548935 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2361,34 +2361,23 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = env_cpu(env);
-    uint32_t cc = 0;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret, tec;
-    int old_exc, flags, exc;
+    int flags, exc, cc;
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
         tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
     }
 
-    old_exc = cs->exception_index;
     exc = mmu_translate(env, addr, 0, asc, &ret, &flags, &tec);
     if (exc) {
-        /*
-         * We don't care about ILEN or TEC, as we're not going to
-         * deliver the exception -- thus resetting exception_index below.
-         * TODO: clean this up.
-         */
-        trigger_pgm_exception(env, exc, ILEN_UNWIND);
         cc = 3;
-    }
-    if (cs->exception_index == EXCP_PGM) {
-        ret = env->int_pgm_code | 0x80000000;
+        ret = exc | 0x80000000;
     } else {
+        cc = 0;
         ret |= addr & ~TARGET_PAGE_MASK;
     }
-    cs->exception_index = old_exc;
 
     env->cc_op = cc;
     return ret;
-- 
2.17.1


