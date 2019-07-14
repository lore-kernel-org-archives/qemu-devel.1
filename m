Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B5C742D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095C520820
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzJe8QRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095C520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmcRe-0007Ts-T0
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR8-0005i1-TS
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR7-0006O7-Ta
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmcR7-0006Nb-Ng
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so14119413wrf.11
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+/eu9Ji8fYpnUOznN+zYDis1fLw1ZhoxMJAE0l0+5Bg=;
 b=UzJe8QRzH+KGTW0P/KITp2+31soeoocQ45TSMRRDS0RgGkcdAsLjIm3aeznlBWzy0Y
 V6UrX59zeP+4BbAWmUIaJLJkGLeMrC+fmwr41Kq0BrqsZfg/rC8o8BTASHl1m76db6DO
 3xp7ftmIoiZTjG5fkYtvsIhzzkUf1G3ekL8TV7v3s0Ht/awxhdPEnRxa8adW5HPTkkse
 GVwoxb/VcrbcJlcHVOHH7Dzk4acLKyjduKVfaoPYkBN1ubt/VdvwIgiBAW2llQV6gDW4
 1vCVU5yQEAdr4guejcJS8kvB3OdF3B2N87RbbbYjtVC+xgZrq/U7oKcutKeLlHpxdTJi
 h16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+/eu9Ji8fYpnUOznN+zYDis1fLw1ZhoxMJAE0l0+5Bg=;
 b=mmrGCzxDMgdjH6H6dGbHD5MiGYcwoXveGbAqxxml6wAzQxmFf5+nB+C/o+yrSOJyzJ
 405JgV3yaAGKEJNAC9q69YMKBpC8Gr68FwAWwvFTFZ+meoxfK4z+d6cDVFZVqEC7m68z
 bd/eu1DbyrZ1apKxn9BXJegJxOSC/wLFSV/jzvxdqsnh+78wvjwBEdh0yyrxFxcKgvrT
 3eaS2d06XlTjZ5yy4xm/WQCgNfplZh1imUQ9qEaPUsK1NzBjcTOdtrFpKk9M6sy9Mb42
 loAkZq6YeUyAXlH+vPzQfFWwXTVcuc9K1AMLGVn46ljuAU3O2fj0ZjZ/rX4hNcxClhfn
 FdFw==
X-Gm-Message-State: APjAAAVvLtijJr2MqEWcL1SFd7ZMZec6tA3YB2xHFAKWFDHeX5rs8eON
 VPg+oFXm9xY8Y/3qlUTICHgaPZKazai8Sw==
X-Google-Smtp-Source: APXvYqxO32eywPBX2D0g+mmG/SITwcp07xAr8f8Tgs1Xwh0jK5szcHbfBJJhKNLK7baLao3IVZg4mQ==
X-Received: by 2002:adf:f088:: with SMTP id n8mr22737575wro.58.1563102776408; 
 Sun, 14 Jul 2019 04:12:56 -0700 (PDT)
Received: from localhost.localdomain ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id f17sm12675795wmf.27.2019.07.14.04.12.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 04:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 11:12:47 +0000
Message-Id: <20190714111249.13859-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190714111249.13859-1-richard.henderson@linaro.org>
References: <20190714111249.13859-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL for-4.1 5/7] tcg: Remove cpu_ld*_code_ra
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions are not used, and are not usable in the
context of code generation, because we never have a helper
return address to pass in to them.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


