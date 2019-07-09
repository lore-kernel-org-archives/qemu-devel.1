Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299F0C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0CF214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hcw2+UwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0CF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmM3-0002Gz-8Q
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJQ-00070F-Vq
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJP-0001xU-3d
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:24 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkmJO-0001tL-M3
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:23 -0400
Received: by mail-io1-xd41.google.com with SMTP id q22so19834992iog.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GlX1ghA7K5MFvwvh9tPMB+W8XhZilfwCsvalOImEzfU=;
 b=Hcw2+UwBgkll2NGyXaZofgHSi0VosxBMRToLyCRg31MJyEYgk41VvS+vvK6NqS1Pmy
 D3PpF4E7FeHa1gNEm6Fx+KohEpzuO9ef3V5Uf8O7dU9ACuV0ezdcW9LZqSTl8j3nfEJR
 mPfa56HWHf2jrKwIi+yZ2CyXR9vyXrQbRiGqkB4mAXb0VWNEPMUAF4qTkavJxJBBmqLK
 2hcRdPxbCgpjdZXcda/sIKjf+/5HezhBVzKyxKDlPEzBuHwxFWvFpps1uc9PXXmTn8ng
 c74hnb9ASHXQXj4vKrMFCkPodim2UajeIPSuzZgQGtQChxBglFOy9A3vYVxoTYE3uL3T
 197g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GlX1ghA7K5MFvwvh9tPMB+W8XhZilfwCsvalOImEzfU=;
 b=RUsRoLOVg12Gb/SXrYNyJADlYfoOtrR95Dhb9NYJSqNYE25KbRNsRLhu14wOAQnn3q
 Jqq+D1scJn+g2hHxwJud9AMAugYR62ep/idRN7J3/KsdRhgfIuOFg6qxWqdccuR7n7ey
 zW/nKNrTXnRUZs5+Wg3D4wgWxKA+CKqRw/Svkvx0EjwmEi81HEHZyLopoJlCnpZaZexd
 bRWtJVRrnhQNYrDUvE0AHugr1OhHY70MPinei/6PxfzeSFFlkNZ28Z5EpwHKC8Rn2S2K
 IWpVG62GzskEDqZu6Qv4IOUdZjypG/k2oNsDnVcfZtiqZ9XviNH1/7bAKgsuyLNxH+y9
 Xu1Q==
X-Gm-Message-State: APjAAAUcTTn5QLmv+MtrUyCPNBrK9k8fcEIp9Cd1+uz/TI0Rd75hQ85H
 //lYoaxsWfqelfQfyfc70L6ghMatdP0=
X-Google-Smtp-Source: APXvYqyEoSwDcgx+6jnGaPeSWKMSvSbHpyp6qKOMwqVvVGOfpB0b3zmM1kAtqj300Tr99E+ViOKSMQ==
X-Received: by 2002:a02:c492:: with SMTP id t18mr27107880jam.67.1562664076190; 
 Tue, 09 Jul 2019 02:21:16 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id c17sm17613817ioo.82.2019.07.09.02.21.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:21:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 11:20:47 +0200
Message-Id: <20190709092049.13771-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709092049.13771-1-richard.henderson@linaro.org>
References: <20190709092049.13771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: [Qemu-devel] [PATCH 3/5] tcg: Remove cpu_ld*_code_ra
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


