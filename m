Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E76C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFAA22CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izdtibyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFAA22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C0O-0005e9-Th
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNC-0001dk-B0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNB-0003zi-9J
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:38 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:46267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNB-0003z4-3v
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:37 -0400
Received: by mail-pg1-x52f.google.com with SMTP id m3so9372502pgv.13
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qb+ujYL2F+DwauWM58yFrqxB8nQIAn+bvj1URM0E/1A=;
 b=izdtibyB5ELd5XFmw6SM8+8NHJ9yQFyZQYQiOZuXek3o0WFC2VT07MLoBK+MrJD/Yo
 IsRwHWkRBj/qpnpuCh4HD5yXJIwHKlplGFWdIri8MsEXpYoJXkwXw5Szv0WUop5qzSTk
 TCTrZ2Zk9Rat7GU7slX0zSVm2jmBuUWNNv/VntvnHF7yEqx7zjdvLtUQ2UeJGRICwsUG
 K90LjedCbYBskr1fSW7vBMUkhUtCs0R1JFH4aG4X89KBh3axYRWR4D3vcJFKr01CWc5Y
 oc/ns6fRz7KY1/DZJJOQUm9NZAZeP/btqCkfEx4stW2UIEuGs9RYUpA54FvJ3/xGNXLG
 kqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qb+ujYL2F+DwauWM58yFrqxB8nQIAn+bvj1URM0E/1A=;
 b=ljGl3OkPlHMC61wfPXKiDRWULcoIxwf9M32gUz8SJvE01UW7pQvpVAJ2s6oQD4UEP9
 6vvUYEVlo6JkI9cieX3ivQYgwnoB+d52EPgJNpUSjOnaJt2QavBQHTreug73qqHqcEwn
 YiH3qGh/4GWz4Jr7fekMvyxSJfP/Pned/YDaPMAELRsklLC8INOPAjXrurIcXtEU7KzP
 43Z8UygZahWBX8/YH+RxUscd11u0yssUpb8/pmtW0R4O0AJ463PZ1MGTAtyNIhUReWu4
 IMk/yMKLRqFYatFWDVdEIVNFB9bdqB08jmhnOQIPG81tW6ozrM6740sJZ+Y98yE2ulWG
 XkSA==
X-Gm-Message-State: APjAAAUmTffbjAgsUsQFEkiWsoOfPvm6Omn7xyb//Jshrm5ccd6vy2ku
 329E/j4vJ+wi9wbHHR2aObC3ecQTWpk=
X-Google-Smtp-Source: APXvYqzpPp1qH+2CIXsNm7nDfyHHt5+4j9fu1ZjcBmzOEBtuy7Crldz/KjnOnK/2VdLwg5ODQgL4Aw==
X-Received: by 2002:a62:f80a:: with SMTP id d10mr2891158pfh.98.1567526975855; 
 Tue, 03 Sep 2019 09:09:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:51 -0700
Message-Id: <20190903160858.5296-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [PATCH 29/36] s390x/tcg: Fix length calculation in
 probe_write_access()
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Hm... how did that "-" slip in (-TAGRET_PAGE_SIZE would be correct). This
currently makes us exceed one page in a single probe_write() call,
essentially leaving some memory unchecked.

Fixes: c5a7392cfb96 ("s390x/tcg: Provide probe_write_access helper")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190826075112.25637-3-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7819aca15d..4b43440e89 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2623,7 +2623,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 #else
     /* test the actual access, not just any access to the page due to LAP */
     while (len) {
-        const uint64_t pagelen = -(addr | -TARGET_PAGE_MASK);
+        const uint64_t pagelen = -(addr | TARGET_PAGE_MASK);
         const uint64_t curlen = MIN(pagelen, len);
 
         probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
-- 
2.17.1


