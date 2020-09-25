Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E5C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CFC206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ko3LEYbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CFC206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpbW-0005vE-Mj
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpX5-0001Cg-4Q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:12 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:34081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpX2-0005TI-SV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:10 -0400
Received: by mail-pg1-x535.google.com with SMTP id u24so2879597pgi.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xmBcp07NP8phRH9qOFxSa7PTiYpPJFfrWoI6zCboVds=;
 b=ko3LEYbfIrE/DeacDsw+Wid2M96lbzNGTN80dOSZQJrsPw4lzYW6jFQx9n5QxrRlLJ
 QCRElx8aYddKN2gtEUajC51/uylClb++mJuZVYzTnO3tU4Jg2vJTp1EtYd1LYVG1PcuP
 USsqc7xCWG8takqxo2jTyH0qcV/wGuZYNC+o/c4JptMiMuhmi/7302n+515PN/U7Iehb
 zNOJzNr9llMTmvYW8myrdwqd8jFD3C6QTnTjwk9xYJkcuvNkqHyw2NRmZI2X7mODOo2s
 0R4vjl0CyWvdO97prv9FUnhnY37JrpiTZMU5qy2KQRI2kukM+zZhsJDh3cYiQVzFp26l
 yK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xmBcp07NP8phRH9qOFxSa7PTiYpPJFfrWoI6zCboVds=;
 b=NE+aLgneg+q+f8hWuLcsiMkQys6UPVRpJnTjf3anlzY3TnTCJvHbzZu6RKRqyiGl8A
 h+jW4GSgl+UgR3Ct+caqAGz11lQJDmF6Y6lsgH/TSreXpqd+I8PPEYAubx9TlRUYs3sx
 txNBttZlX1xOg6Tq9tHZWU6siK9Zh4sazaZjaJdJsMgSSjgOig7cq9IuDhTYex+6qHWu
 kR/Rr4oZ7PDXwkGp8zfKa/y0odfMIWRApcGau4cXjERBPGa1YjX9bX1MFZ0HNRi3xjmA
 yMpt5ULuTxpEt4jPkGhmplAdlfXqT01k71PqQJgKWSIooAGJqg5j7RBaePzFxv5GbcnN
 wNFg==
X-Gm-Message-State: AOAM533Keq6Smtb8mWF/dOjnaRf9kFNy0OHAk2WX7Vh//MaNdyAMLa/+
 npR6Il3kTiqEhNimdhrRM9zcchF4xmGRzA==
X-Google-Smtp-Source: ABdhPJz4AwxGcDbWaX/mrrOvsZtcZK54EF53hd4dWti6BHsNytk2mG8Cvja39VqRwcygiVKhcpRElA==
X-Received: by 2002:a17:902:82c2:b029:d1:f36a:ab97 with SMTP id
 u2-20020a17090282c2b02900d1f36aab97mr5042903plz.64.1601047264057; 
 Fri, 25 Sep 2020 08:21:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:21:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] softfloat: Use ppc64 assembly for {add, sub}{192,
 256}
Date: Fri, 25 Sep 2020 08:20:47 -0700
Message-Id: <20200925152047.709901-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 14 ++++++++++++++
 fpu/softfloat.c                | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 969a486fd2..d26cfaf267 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -449,6 +449,13 @@ static inline void
         : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
         : "rZ"(a0), "rZ"(a1), "rZ"(a2), "rZ"(b0), "rZ"(b1), "rZ"(b2)
         : "cc");
+#elif defined(__powerpc64__)
+    asm("addc %2, %5, %8\n\t"
+        "adde %1, %4, %7\n\t"
+        "adde %0, %3, %6"
+        : "=r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "r"(a0), "r"(a1), "r"(a2), "r"(b0), "r"(b1), "r"(b2)
+        : "ca");
 #else
     uint64_t z0, z1, z2;
     int8_t carry0, carry1;
@@ -521,6 +528,13 @@ static inline void
         : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
         : "rZ"(a0), "rZ"(a1), "rZ"(a2), "rZ"(b0), "rZ"(b1), "rZ"(b2)
         : "cc");
+#elif defined(__powerpc64__)
+    asm("subfc %2, %8, %5\n\t"
+        "subfe %1, %7, %4\n\t"
+        "subfe %0, %6, %3"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "r"(a0), "r"(a1), "r"(a2), "r"(b0), "r"(b1), "r"(b2)
+        : "ca");
 #else
     uint64_t z0, z1, z2;
     int8_t borrow0, borrow1;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 07dc17caad..9af75b9146 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7370,6 +7370,18 @@ static void sub256(UInt256 *r, UInt256 *a, UInt256 *b)
           [b0] "rZ"(b->w[0]), [b1] "rZ"(b->w[1]),
           [b2] "rZ"(b->w[2]), [b3] "rZ"(b->w[3])
         : "cc");
+#elif defined(__powerpc64__)
+    asm("subfc %[r3], %[b3], %[a3]\n\t"
+        "subfe %[r2], %[b2], %[a2]\n\t"
+        "subfe %[r1], %[b1], %[a1]\n\t"
+        "subfe %[r0], %[b0], %[a0]"
+        : [r0] "=&r"(r->w[0]), [r1] "=&r"(r->w[1]),
+          [r2] "=&r"(r->w[2]), [r3] "=&r"(r->w[3])
+        : [a0] "r"(a->w[0]), [a1] "r"(a->w[1]),
+          [a2] "r"(a->w[2]), [a3] "r"(a->w[3]),
+          [b0] "r"(b->w[0]), [b1] "r"(b->w[1]),
+          [b2] "r"(b->w[2]), [b3] "r"(b->w[3])
+        : "ca");
 #else
     bool borrow = false;
 
@@ -7407,6 +7419,13 @@ static void neg256(UInt256 *a)
         "ngc  %0, %0"
         : "+r"(a->w[0]), "+r"(a->w[1]), "+r"(a->w[2]), "+r"(a->w[3])
         : : "cc");
+#elif defined(__powerpc64__)
+    asm("subfic %3, %3, 0\n\t"
+        "subfze %2, %2\n\t"
+        "subfze %1, %1\n\t"
+        "subfze %0, %0"
+        : "+r"(a->w[0]), "+r"(a->w[1]), "+r"(a->w[2]), "+r"(a->w[3])
+        : : "ca");
 #else
     /*
      * Recall that -X - 1 = ~X, and that since this is negation,
@@ -7457,6 +7476,14 @@ static void add256(UInt256 *a, UInt256 *b)
         : "+r"(a->w[0]), "+r"(a->w[1]), "+r"(a->w[2]), "+r"(a->w[3])
         : "rZ"(b->w[0]), "rZ"(b->w[1]), "rZ"(b->w[2]), "rZ"(b->w[3])
         : "cc");
+#elif defined(__powerpc64__)
+    asm("addc %3, %3, %7\n\t"
+        "adde %2, %2, %6\n\t"
+        "adde %1, %1, %5\n\t"
+        "adde %0, %0, %4"
+        : "+r"(a->w[0]), "+r"(a->w[1]), "+r"(a->w[2]), "+r"(a->w[3])
+        :  "r"(b->w[0]),  "r"(b->w[1]),  "r"(b->w[2]),  "r"(b->w[3])
+        : "ca");
 #else
     bool carry = false;
 
-- 
2.25.1


