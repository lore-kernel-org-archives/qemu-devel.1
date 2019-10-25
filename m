Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024F4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C338A206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UH1syymH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C338A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtzr-0005tX-Jd
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN8-00088S-2l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-0003Hv-Ul
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN5-0003CF-Dc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id s1so974280wro.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p0/8VjboGQtbPpCK+UTcACIJfDHT1FU/+NDtOrh1cRU=;
 b=UH1syymHb6VlfpNc/Fvk498HXtLxWtZHl8uMAjiOK4ti5GKPYnf3oIm0BhMjlk32pN
 YeLShB4srmVpebIh6sPLhfGJRc9nWtEscpRK+zG9k2Em8VVowsYNADs2Gmx9YQ+iiVu3
 s0x8MHya6eKWbXmJeDF+Xqv3sNOx/lOM+TIO5P1Q9c2ARL/dKztbhy5qmJClUMnkOzaL
 5+Eztr+SnyIzePoEqD4t45UOYqI6buTX+VWevBds1e6R5LI1AOHtAvmsby/qkSfmgUC6
 HnWHC0kD/OQC0CZKIIfUo1raiA2bDiZGn2jfOmuOQ92ij6/GgtixKYmNiXC+lHXGbQQk
 MzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p0/8VjboGQtbPpCK+UTcACIJfDHT1FU/+NDtOrh1cRU=;
 b=LfUVs58pDlWhMtDGJjWWsp1UeLyWmryADzGcRfcBqyTjHY6FdXX06L7Cyn9hufd9AH
 75tC5ukj3Pz5Xqudj6GiUHI5mND4LhE5cogKGFUM07hqaq9b84MuZO399ThoORqXhUq6
 shfYt1sgkq1nopWQ6KtvKopdGOvQUSPv9XJkzMErkU8z+Kvn0P7k6vnjbM/pStI6ZtJf
 OQ2ggU9T3OKo7oYStu+t9uK4n3V3JakqUqiJ73unM2vTPRLxtWLekGGEl0XG5nxZKFv7
 9MY4Nk8NkmQgt31tMoup+5uChFC1Xd0aotmhw+ugdYC2fo1Ew7/dr6kYJRhH6pXavwqw
 lLpA==
X-Gm-Message-State: APjAAAUeuJcytMJRH3xnElIpEJ4S9OZk8/yBSitR27ptBM7DMziCWpVz
 nkTPR29ae85vbY/me2koTDgxpg==
X-Google-Smtp-Source: APXvYqxtOo5bt6dYdURQwMdLhAq/6EvcnErF+legx+/9aw/GFhq1gTHTN6JuM+M7T/u4NFNxQt649g==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr1378225wrp.182.1571986004315; 
 Thu, 24 Oct 2019 23:46:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm1280482wra.70.2019.10.24.23.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E29A1FFA5;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 17/73] trace: expand mem_info:size_shift to 4 bits
Date: Fri, 25 Oct 2019 07:36:17 +0100
Message-Id: <20191025063713.23374-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This will allow us to trace 32k-long memory accesses (although our
maximum is something like 256 bytes at the moment).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: expanded to 3->4 bits]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/trace-events b/trace-events
index 20821ba545c..22133dfd3fa 100644
--- a/trace-events
+++ b/trace-events
@@ -149,7 +149,7 @@ vcpu guest_cpu_reset(void)
 # Access information can be parsed as:
 #
 # struct mem_info {
-#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes */
+#     uint8_t size_shift : 4; /* interpreted as "1 << size_shift" bytes */
 #     bool    sign_extend: 1; /* sign-extended */
 #     uint8_t endianness : 1; /* 0: little, 1: big */
 #     bool    store      : 1; /* wheter it's a store operation */
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index 3444fbc5968..1a010c1b277 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -10,10 +10,10 @@
 #ifndef TRACE__MEM_INTERNAL_H
 #define TRACE__MEM_INTERNAL_H
 
-#define TRACE_MEM_SZ_SHIFT_MASK 0x7 /* size shift mask */
-#define TRACE_MEM_SE (1ULL << 3)    /* sign extended (y/n) */
-#define TRACE_MEM_BE (1ULL << 4)    /* big endian (y/n) */
-#define TRACE_MEM_ST (1ULL << 5)    /* store (y/n) */
+#define TRACE_MEM_SZ_SHIFT_MASK 0xf /* size shift mask */
+#define TRACE_MEM_SE (1ULL << 4)    /* sign extended (y/n) */
+#define TRACE_MEM_BE (1ULL << 5)    /* big endian (y/n) */
+#define TRACE_MEM_ST (1ULL << 6)    /* store (y/n) */
 
 static inline uint8_t trace_mem_build_info(
     int size_shift, bool sign_extend, MemOp endianness, bool store)
-- 
2.20.1


