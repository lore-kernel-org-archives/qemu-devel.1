Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC9C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916B52084D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ky/B2GUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916B52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccPZ-0000du-Rm
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hccOf-0008Ux-N5
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hccOe-0003lI-Mh
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:09:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hccOe-0003kn-Et
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:09:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id 81so4482501pfy.13
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=GlX1ghA7K5MFvwvh9tPMB+W8XhZilfwCsvalOImEzfU=;
 b=ky/B2GUF4GDrPl1jrYJvQsj70VpxNq1w6bFADjDNE2Yj9V9LUsh7aJaaRWlqvlJE82
 T+q+SziYY6QARNH2UNxLc3y69DqMQe/pVSAzDMi5tzrI8/g+0Cu0JlNsWiyhhXS4e0oY
 SmgWIj97YQvy83IZpINJIcEyLxyQhYkmc88eaPuI90YXlu1iof4LywWtigI5bnE1/eLq
 Y2alGliZSaj2jmx228Xt8ocxIdYJlntT9rHPMjJI6pT8QUGpFcOd7FF2dIG2mMXiFyUp
 ag9Bl0x03CGs30aGqJBmDA+CtxJUMqNrJRSLgCq2Ifo2RALKhYwko3/JWKoymifvbE8z
 Citw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=GlX1ghA7K5MFvwvh9tPMB+W8XhZilfwCsvalOImEzfU=;
 b=F+/v4Yw/nU/0LgMoZxCrpuhODIloAuxKAs9r5kJ4820QI7RDT5ElRj4E3CXa8Wganm
 htz4Jex1alYpbLyDClBQfixsAGIU2YXXFZU5ZqxAMQZLbKy8NDXamfS/0olpqcSMBLsk
 3wwotKViDptCucf8enhyLN2pNlJUyLgDXjiME1/r8miiRfSHfrPVvVi6cQ+c+v8NFob+
 V9fxVhC7B/0WNhLfdP5BJkQVDfgdZtQi13uIXSS8IjRyRissiIc867lOi2myIlALcMWl
 lWHUlemmgelhOVf4oMGTgMlWGLcP3+zN4sXTxGWwZgaKbXYnb/SxWRMXXBCpwNjnI9zM
 PqOw==
X-Gm-Message-State: APjAAAWqOYwImzOCwOgfruuKfH5+sMKTyQW+SjRNedc5nujG7UbR4n6T
 Z0jTZf8c7z00tb6I06GOW5MIbgHMgfY=
X-Google-Smtp-Source: APXvYqymZYGwNp/jTOM7EcuF3Lqvs3ZQR+sYqCeqbfzTrmuO4MliuBg0uQeyW8zPuuFWBEGs9r0cww==
X-Received: by 2002:a17:90a:25e6:: with SMTP id
 k93mr23101891pje.100.1560719343105; 
 Sun, 16 Jun 2019 14:09:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id i3sm9620320pfo.138.2019.06.16.14.09.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 16 Jun 2019 14:09:00 -0700
Message-Id: <20190616210900.17814-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190616210900.17814-1-richard.henderson@linaro.org>
References: <20190616210900.17814-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 2/2] tcg: Remove cpu_ld*_code_ra
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

These functions are not used, and are not usable in the
context of code generation, because we never have a helper
return address to pass in to them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_useronly_template.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index e65733f7e2..8c7a2c6cd7 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -72,6 +72,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 }
 
+#ifndef CODE_ACCESS
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   abi_ptr ptr,
@@ -83,6 +84,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     clear_helper_retaddr();
     return ret;
 }
+#endif
 
 #if DATA_SIZE <= 2
 static inline int
@@ -96,6 +98,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
 }
 
+#ifndef CODE_ACCESS
 static inline int
 glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   abi_ptr ptr,
@@ -107,7 +110,8 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     clear_helper_retaddr();
     return ret;
 }
-#endif
+#endif /* CODE_ACCESS */
+#endif /* DATA_SIZE <= 2 */
 
 #ifndef CODE_ACCESS
 static inline void
-- 
2.17.1


