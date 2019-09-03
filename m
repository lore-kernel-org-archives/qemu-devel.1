Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858D8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518D02339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVuL41hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518D02339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BtJ-0004h2-Ti
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNB-0001c8-AL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNA-0003yn-AC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNA-0003y2-2t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:36 -0400
Received: by mail-pg1-x52e.google.com with SMTP id d1so9401843pgp.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ojSV1KHJRFOmyFtfduQlUjdioBteKBK+7oTZZ6njL2U=;
 b=WVuL41hg93slnIHJ4d59nc6vn4MZqQJ1LislX2APCainrVYohko0MQ52VI1h7l14oo
 lutgHvTi0fzxZ39XminusWgPeRq1FBYSaRgKCt6bQxOsAs1B3s6uypcRKJi8+CHHfgdO
 aPXFmacJHuyMOdT1O5O86yn9pud64U7o6iDCjCDjkfSPr3PBvSz7gmgQTYOMvjOvjtp0
 YGSazNS0W+Rjy/S9ZmxObkNYHlbRZE/LSIeoqdQs+RURCdHMowXRoKYVmD8dhzBVJH1B
 9xKHkvuykLLmAHmhAXQj278s+/89tQriHX7bUSKQCY/qDRB6CYm2UinB0NpAXwfns7S9
 c9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ojSV1KHJRFOmyFtfduQlUjdioBteKBK+7oTZZ6njL2U=;
 b=N4YHEAfdwKXpw2T3Yg7elGsOnsV7VFTcPTIVEeRhgjzGMKTlti6v4MOSR/ifuVAbkn
 897/8nwgjL9xuvbIFaeB8wX0HEgARAC6TKwaNHSQC1VeqVwY+fuo6eATL5eINQFfHSgC
 1JUY+YPpQp+u6NXtGYVXmCz97B73/R1lktgqRibG04m/b0PHRWXnRXdvqbg6cZTNXBk6
 GCrjANC8qvP/dRDXCI62MICqJ8A129gWR8b8osoEuOWDz7POaR7/+Uitf0khXniLlKgx
 lgo62//4Ayw2+LZUI+l2coV1IyfyMMrgVzIwB0KN61Efq4Vj4/dF+wXqBEkERpJVKU7n
 OCOg==
X-Gm-Message-State: APjAAAU84I1PnZ4AeIsDDhdiVNWChY0kUZR/n/AHcjDnwfjT6ECHbKAP
 m4Wquuzl/mlGO8Enoap6Ya93AWQRxak=
X-Google-Smtp-Source: APXvYqyN3s/lM8igUZj5PgEYf1fastHASscWUTgzm4mN3IYd7+bnTWs/EY+N2BSTblmT0WxsLvHf7Q==
X-Received: by 2002:a62:6045:: with SMTP id u66mr40214582pfb.261.1567526974873; 
 Tue, 03 Sep 2019 09:09:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:50 -0700
Message-Id: <20190903160858.5296-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
Subject: [Qemu-devel] [PATCH 28/36] s390x/tcg: Use guest_addr_valid()
 instead of h2g_valid() in probe_write_access()
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

If I'm not completely wrong, we are dealing with guest addresses here
and not with host addresses. Use the right check.

Fixes: c5a7392cfb96 ("s390x/tcg: Provide probe_write_access helper")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190826075112.25637-2-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 91ba2e03d9..7819aca15d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2616,7 +2616,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
-    if (!h2g_valid(addr) || !h2g_valid(addr + len - 1) ||
+    if (!guest_addr_valid(addr) || !guest_addr_valid(addr + len - 1) ||
         page_check_range(addr, len, PAGE_WRITE) < 0) {
         s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
     }
-- 
2.17.1


