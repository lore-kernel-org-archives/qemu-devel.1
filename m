Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C07DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE13B214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcTO9ZWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE13B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0TX-00079I-FW
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07N-0000JK-H2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwk-0004N5-Su
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwk-0004MY-NG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so3962928wrx.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W2mrxFhentklW247RlP8yuKtv3QDjoQaHxNcDuVxHu8=;
 b=DcTO9ZWQhGQw5BxyhjIUs+dTigLsHsg0L3SDASyd1Vqh7WWzajlgK3p3vEfMAuOVzi
 Q5MTpb3BLWwR0sBX+eXwNoXxpZ9zC89qFtct3HXnUbZdJ+6+JdokHM1qPXfl4UAAO8TV
 cQDIvEaySMxbBjhL8bhDF5JbimZdkLkjd+MRcGxsSZJGZTsyFvWRLh2NsAOdRtMKPqJc
 5+69jxSg48ze7MvD/UjMfidTm2DudKPMAd2FPbtlvYtBwPLdR9vuubbUN3+QySv1JUP5
 tcv5FHQozJsPCHX+0bxJCbQhz0EzTNtI1s4flehD7PK3Fpc9gDyT31aIT47r7gAnIYo4
 qHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W2mrxFhentklW247RlP8yuKtv3QDjoQaHxNcDuVxHu8=;
 b=Dx+n4z7hIaYfIX7F993OFvWiGCcz0dUvZIwlE0ngltuke07bl0RawfRc1Vym6v6Dy9
 H7mePUbL3PueAVUaGJLFs2q62qI5gjNKMvJauKKwzHR0ALvrgqxCcb3uF8E5CHG/Vcvn
 AbGrTk6u6QaXig2RMoJ2fQjP/wqXqVhwvwT14KtwzD/bPoamdWXRLylGV/Ot9ThRHD5p
 ECdAY+tSLzgQUgXGnfQJ+mWqK0gxeXNrL+qmmmrfto3FdsxzVVdb0xSeRWpic9k+xJuQ
 KY7ziQQ0DbS8lQ0W31nXRUbYLxf+T78pNFWdWAbBYo1O1NauZhCJrIub8BClsiKrKnyF
 zAog==
X-Gm-Message-State: APjAAAX/VmT/I4Jx4aUXixBq0/5TNTLOKkCVrqLvsmDLNwBEWWuJCf+g
 4d30p2y9b/YGsXWTJ3fAlZ9uaw==
X-Google-Smtp-Source: APXvYqzNKQ+7RRk9Bdh33VOj3JovVph1Bk85oaNsX3FwZcvCTnkDMP+3QtxpfNrBs/r7CbqUvFS4fg==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr7406906wrw.23.1568913021586; 
 Thu, 19 Sep 2019 10:10:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a18sm21374021wrh.25.2019.09.19.10.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3354F1FF93;
 Thu, 19 Sep 2019 18:10:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 06/16] target/ppc: fix signal delivery for ppc64abi32
Date: Thu, 19 Sep 2019 18:10:05 +0100
Message-Id: <20190919171015.12681-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were incorrectly using the 64-bit AIX ABI instead of the 32-bit
SYSV ABI for setting NIP for the signal handler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - change to wording
---
 linux-user/ppc/signal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 619a56950df..5b82af6cb62 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;
 #if defined(TARGET_PPC64)
     struct target_sigcontext *sc = 0;
+#if !defined(TARGET_ABI32)
     struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
+#endif
 #endif
 
     rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
@@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->gpr[5] = (target_ulong) h2g(&rt_sf->uc);
     env->gpr[6] = (target_ulong) h2g(rt_sf);
 
-#if defined(TARGET_PPC64)
+#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
     if (get_ppc64_abi(image) < 2) {
         /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
         struct target_func_ptr *handler =
-- 
2.20.1


