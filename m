Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F13C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5084D22CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqVt7v0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5084D22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B8q-0003pP-Uk
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Arc-00038d-J2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Arb-00065G-Kz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:37:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5Arb-00064Z-EF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so17988349wrd.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PQwumxLD0naoGLveJArJ+0uz+trgPMLG7ByeUUTiw3c=;
 b=hqVt7v0A+RHc8yPlc+/akWP8XDgvXvaCpwmsl8C06sRocrkdWgnZ4fsB2UBzgf5FeW
 baJvJHoeqRruO5xRJvCqaz+xq+JxV8G2WMV9sumfMKCmU3HQ4m7eLPgFn66J2AWNH3qk
 L/i4g+q3XJgETBgyjmZ/2vV4GchANz4g6gBUUJzIGKACnJWUpmLdF0KwmyH3lPMknZMO
 R1ztMvOYpqxx6GyhY3pBySM6mKd3JvVut5axbzgkHbhaGdOQWHzCTvyqpQKtgs5dENXo
 KaKQq/jk9fZgfyi0VPw+nb7OCqJZxwDDOlDkePssbaonwHo2wv2gNRVpVnlsVGdhw/gD
 ftGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PQwumxLD0naoGLveJArJ+0uz+trgPMLG7ByeUUTiw3c=;
 b=eZStrrTHJ6wH9HtqS0wZ4dbiBYsEznAgqPYyAMNy8ikcZKUuBqrFQymJv771c+RLw7
 DsPZQHk7AeTyrl1IMdqKT15EZbtuVVFPpe/aqeXUivVLGMbB48ksgUPIH5DPm7EGRGBe
 +CswelAycBjR5PASXSsGYRXNnzgFghjHWZJx0hUXvcIJ/qE2IfyrcdJgBYDXbKfo+eua
 EdzQ3ho3hlmd0UO/+j5I4OJbslX+9fBqzHab1bKF0S4Wcjqu1UWbzcMF0/Q+HH6q8ayP
 OI4wx2VpGZyrdQOMlfAm6+/PLiZgD1cOb8xu31SiJP/0Aox5hv7D3CKliUfijyqJiY1n
 cC/w==
X-Gm-Message-State: APjAAAVtGyHaLZnhvkiq+gkrHAJl1+waBCU0GEVKcqI90CvGgq4Momtf
 tN6lVngm+nWH3sQbxwuPsCltILcGNL+Jmg==
X-Google-Smtp-Source: APXvYqxb6VFRSxmBw5yM1EvaeAJ4KQfy4lw+UlWyHv58aLXC6tn5xi88QV1KsbWpYZu8SFGnbvRkkw==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr7733455wrw.104.1567525018262; 
 Tue, 03 Sep 2019 08:36:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:32 +0100
Message-Id: <20190903153633.6651-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 20/21] target/arm: Free TCG temps in
 trans_VMOV_64_sp()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function neon_store_reg32() doesn't free the TCG temp that it
is passed, so the caller must do that. We got this right in most
places but forgot to free the TCG temps in trans_VMOV_64_sp().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190827121931.26836-1-peter.maydell@linaro.org
---
 target/arm/translate-vfp.inc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 3e8ea80493b..9ae980bef63 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -880,8 +880,10 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
         /* gpreg to fpreg */
         tmp = load_reg(s, a->rt);
         neon_store_reg32(tmp, a->vm);
+        tcg_temp_free_i32(tmp);
         tmp = load_reg(s, a->rt2);
         neon_store_reg32(tmp, a->vm + 1);
+        tcg_temp_free_i32(tmp);
     }
 
     return true;
-- 
2.20.1


