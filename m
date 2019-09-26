Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992CCC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CA5222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZDj7/Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CA5222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDX5s-0001cr-8u
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcF-0002i5-Gg
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcD-0004oK-Ox
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcD-0004nF-Fg
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so2103553pfn.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k7SDLRyU0L6BXBxdXsZbeGOUPnjW/+4D7x0wD4wfAkI=;
 b=JZDj7/YlPCsHNpH4dL9ZNtZwBd7wAb5Jypy78IZD4gYMegpOZFLgOlNhEn/b2b0J6W
 cT2jQfrWR5X4tfcJiEiDV+GpOIyRpxuko8w+kFoiN7CXSqU0+nFIWd7kflXJw8NW3uoI
 fSd/GyK2w5XilQ/xPWTAWKk38oJsDxD0Gt/spBOGQYeQOQZykflPJ1lFsZ8ccSruBZ9G
 0WiHMq1rnkpXn+xoczrxSZlOni/N8FXXuVuQuD/rsIuqAw41YGm5InXyQvpV9pLgvXPA
 tmb9O96sMOvQwlNZBgTxCjFzmnHYHsFXOgsRn5iCwBXf4/6oBCBOO7RzGkCLavBOTzek
 Tkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k7SDLRyU0L6BXBxdXsZbeGOUPnjW/+4D7x0wD4wfAkI=;
 b=t5CZAcObfBeqYdMF6ykzElFnXPBVguWo5ssuj1D2KSF+GKYObNxOifZuTz/7XfqoTJ
 aK7nmtYZUlf5gdwhu+1IWEjgHS0dsBSXIqkvjjUfnJ9s0wRjlXoiZ3LLOSQM4q0A9dit
 araV+9i8ZojTJqFLATNx/7aFhTGpy07o3QwadWghbHzHsF6GwvDKgabox45tdIVsuLHt
 ArV/Jx0cdpbpPdsfTXBuBiiGfyqMJlScGjb58gn2+Owok3NlrRB+9uIh6U82RnpNXdr+
 JzfGmZjqs/qcWQwzzC6aQwO9WijZkdVKOuNVzw8HjDtSrl5+TQLENdBwNnj8e99l/2EE
 36ZQ==
X-Gm-Message-State: APjAAAU6IsLJky35qOdyhytD2AFf+IJL6s3NWQjmRL7yRNhrpzUDlMCD
 nnaLfQedcqwqD5FBUvzzP5DWDGkN/ms=
X-Google-Smtp-Source: APXvYqw+qVXsmAB0LOVpzT9JixxXxZKzeAT2rMSch2aQUdz5LxHe03PtDfUf9OMV0jT6IMd4sTvSHw==
X-Received: by 2002:a63:fc5f:: with SMTP id r31mr4192516pgk.55.1569515196055; 
 Thu, 26 Sep 2019 09:26:36 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/18] target/s390x: Simplify helper_lra
Date: Thu, 26 Sep 2019 09:26:10 -0700
Message-Id: <20190926162615.31168-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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

We currently call trigger_pgm_exception to set cs->exception_index
and env->int_pgm_code and then read the values back and then
reset cs->exception_index so that the exception is not delivered.

Instead, use the exception type that we already have directly
without ever triggering an exception that must be suppressed.

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


