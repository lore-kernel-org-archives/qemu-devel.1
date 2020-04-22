Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614DFC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9AE206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DprGUP+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9AE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR42J-0002vV-6o
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR419-0001BW-9W
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR418-0001P4-LD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:35 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:35805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR418-0001NB-6Z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:34 -0400
Received: by mail-pg1-x52c.google.com with SMTP id t11so264753pgg.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZhM8WFsngVW12JNtP5Ld2uYK1gRgB1Q32WgIlT7XOUI=;
 b=DprGUP+WVCW6pTdgkmrtT8wcIe4NKwZnaG9LfKnQ2rAE6hH8q77QZE4kmSC4cEHDxd
 slp8l490XgjNfgER5XXWfygWCvl21aZ3rd/x6KtJ1+G//Q8j5K7j81QPQFBwzWoH3Nme
 nvnZZEDIP8fRjWW5sYovk5POjSEK5pByboIWDVTcfGnv2YNldY/B/69G3HPCaUBKbfwa
 7CTpQI7590UD3g6ogRhLeQrWmp7k5Oo7mSgrMd3/ZsQVVs7K7P7kmEThNYkKiMSQ+w7I
 UhAqSeJHR9nuDyitZMR32COqlCu4Ziv332ZXiP3kU/8n7V0DJgfZ1Mjpfb8Pnoe/qUYv
 EcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZhM8WFsngVW12JNtP5Ld2uYK1gRgB1Q32WgIlT7XOUI=;
 b=YSAXqVagf/rjeKvHVJWHb22HUe1IXPwtSoF1tUtjAJrqp0VMnoIjgG/yhasXfyK53z
 uDqTd1p47O0nV8YfG5dQfBDbjrQ+sJ2cEAEsvcAyE03SwlUnBV0wobknvH/ENalWXhQq
 VbyeEa7vghPT+g8l2m54LI92Ch5oYRJ2aju2GdrgiaP0OtjmnoyKs1hLTkXfTBMqdNHO
 CCmoCL/bYEUofs7q6Z1K92FB76JlmX98dKikWsmmrJn2Evc7nnlbNeDfHT+1CYvW1DDA
 cqWraRwjWQlTiD5VUlMDPZb5nTNjy08G5VXSFqjkU9DUUjFZFSs4R4Cm77zMcZDlSNcI
 K0DQ==
X-Gm-Message-State: AGi0PuYFLTPPgZ7FIGGuOY5iXU00eXWiAZy7NAlDGlbVCSMT5Lxsp1cN
 lzRlUecoAo7nu6gf6Ax1NNqK+oslP1c=
X-Google-Smtp-Source: APiQypK8eVVG6djfTn+D3tOMCDECjvazmytqCnSg03t0P81RoHEXnzLX82ZV1QQDD2Xa0wtwW9atDw==
X-Received: by 2002:a63:5c01:: with SMTP id q1mr22984996pgb.177.1587518252394; 
 Tue, 21 Apr 2020 18:17:32 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/36] tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
Date: Tue, 21 Apr 2020 18:16:52 -0700
Message-Id: <20200422011722.13287-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::52c
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
Cc: alex.bennee@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These interfaces are now unused.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  5 -----
 tcg/tcg-op-gvec.c         | 28 ----------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index eb0d47a42b..fa8a0c8d03 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -320,11 +320,6 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i64);
 
-void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t s, uint32_t m, uint8_t x);
-void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t x);
-void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t x);
-void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t x);
-
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index de16c027b3..5a6cc19812 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1541,34 +1541,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
-void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint64_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_64, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint32_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_32, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint16_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_16, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint8_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
 void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
-- 
2.20.1


