Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA09C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957F121670
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jh98iGdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957F121670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktA1-00048p-RP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7N-0003Ag-CT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7M-0006cx-4J
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:25 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkt7L-0006bd-OX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id c14so10356594plo.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+/eu9Ji8fYpnUOznN+zYDis1fLw1ZhoxMJAE0l0+5Bg=;
 b=jh98iGdhaXofjN6j69x+9KeAwyGF7XZbss/H8xiLI0YeVZ/9CBYdHwDbszuwIq3wtm
 T4NQvsOnWEdn7yUdf2I0H4stFL4Kz9HyxtCMf6R7K6dTN2H5uLevjQYUIK8TrhLj/QVR
 +wxCfWVSj9etLTy7VIfGzkgK8Hy7M71N5G8O1VbxJy9knedQKNLVeptMoefQ9G6Iwyj3
 fD4UuSj6w4elGbhYaKMvQsnbwc705+uQTJVC5Ja4WCbA+qa13KnGR0BGaTtaAe5kammP
 G6Hm2G2WFgWFu8E4i9RGZxYb7JNyjUAvxLq+TD6xPzIIp39xjFfCMVv8jHqfd37vRPXH
 a7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+/eu9Ji8fYpnUOznN+zYDis1fLw1ZhoxMJAE0l0+5Bg=;
 b=hwKRN6+UFK1DQg6gdbM6hTqn/Ihmv8UzFDva2uHXPUH0WQsaDTn4r0417k/ZxjjHwm
 wgxduFEv+CjZtiR7uY8iemUIJV99hicSgo5r7LRMh6ySLBHYSRgkhDHRjTx95MtrjOuW
 eYG4oxW6MzZaDY2rtcIUEccLqMH7uKkyAHoI+b0p/Xm4B8Y4QJ30P8uh0cSg0pg0KxBc
 IYfSCDJUr7YmOUAH4q6eFCcMar38Fla+9dJuyvFJB52Ib8+43UClKVDCIWGOLoDB0BML
 JaHF+VKCfO8AjCRzggD2ZRBdvS+Gac548KUeAYdBnWRfQDRueVyOTr2DcebtB195p6Jt
 3Lew==
X-Gm-Message-State: APjAAAVbeyGeiTDbTPy/nxaSOQIQ7cIxtkox6OJIzq3xAFD2TWZPRYOY
 a9PtklOlWYRKzBFkj3UHwOlhrSg+1IA=
X-Google-Smtp-Source: APXvYqx97Z7nD9LERDym+3x2bNuAJvQvDmH8+mIlwKU1WV8340G0j9b2q+I/8JZuAiHRGaMtNvixOw==
X-Received: by 2002:a17:902:9688:: with SMTP id
 n8mr32595831plp.227.1562690242075; 
 Tue, 09 Jul 2019 09:37:22 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id v8sm19225231pgs.82.2019.07.09.09.37.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:37:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 18:36:54 +0200
Message-Id: <20190709163656.3100-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709163656.3100-1-richard.henderson@linaro.org>
References: <20190709163656.3100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 3/5] tcg: Remove cpu_ld*_code_ra
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
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


