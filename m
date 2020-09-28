Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105CFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B78220E65
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2m/geH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B78220E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtWO-0005ju-M0
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4X-0000jT-5l
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4Q-0002nc-97
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05siY0cHdlWfeeA7J6d3xMUvet3cGKDwDV5A5FHlLno=;
 b=d2m/geH+d6BFOXXE47N7uJB5hLeWm6P2BWoF2V2Y0zlWtYXW5V++wb4/xBodrJn9POOPqe
 bwFvyNme5+usoP+aHjHork7vsOccHmPgkVp4UkPTBqGnzGAg7yMTtvbYrj6/zA41jANZPJ
 LDn8JvNE2ewuI0C+2imvwt/+IgW0W58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-XinFjvMtOFK8Xbbi1n9JJA-1; Mon, 28 Sep 2020 09:19:49 -0400
X-MC-Unique: XinFjvMtOFK8Xbbi1n9JJA-1
Received: by mail-wm1-f72.google.com with SMTP id y18so343994wma.4
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=05siY0cHdlWfeeA7J6d3xMUvet3cGKDwDV5A5FHlLno=;
 b=ReUBIZo8nDLVOewzkXyMSG+swRmat2tEn6iJ5rlh2oYpuhdBK/SIfI3zLOyI9p4DSK
 Xe+QaOs8yDBKrmTSa8QKTdwE8HrG1OHwtLNRYl88uV/dUZUPKYyXiw8LFf8ezKfJ1VKt
 pSPq/ftaBmtXWp/7dMAyMTDxWMh6NJwvombNHLpDLizKokkCH1IFBI+Fn3GFi0SJEghK
 e8BfdeJFWRNEMiZk/zLdhYj7vJ0+dQWnaFgAChivHt3vmbm5izVqAeTYF0w16uvEGe5c
 TS+ogCBFBQC8Jgz4g6Abv+SlyZWDT7L94kmbMvEa1BFomzF7f1j5bgK9KxS5DApfI/zh
 sciQ==
X-Gm-Message-State: AOAM530+ma1/tGwBWlmVH2EeC9SgDtyIlrwkJPpLF7GqB/brZ59A27v7
 kV052p6TDYZDGuu42thGCRuPhk9myiO1jtWRVW2RER36StGPEJ8W1SJ+5AS8+l/fPMIaHYgkyqU
 mdedIleyrlDFlu8U=
X-Received: by 2002:adf:edcc:: with SMTP id v12mr1674399wro.240.1601299187948; 
 Mon, 28 Sep 2020 06:19:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKLPNwa34IqYdT5WX6CUVduVT7I5vLBBYwH0Iuh4tpURZlygsaB19A+gi4Tj394WDtQd/fyw==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr1674369wro.240.1601299187747; 
 Mon, 28 Sep 2020 06:19:47 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i26sm1370291wmb.17.2020.09.28.06.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:19:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] qemu/bswap: Replace bswapXX() by compiler
 __builtin_bswap()
Date: Mon, 28 Sep 2020 15:19:28 +0200
Message-Id: <20200928131934.739451-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928131934.739451-1-philmd@redhat.com>
References: <20200928131934.739451-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the compiler built-in function to byte swap values,
as the compiler is clever and will fold constants.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 8b01c38040c..41131d3d76e 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -27,32 +27,13 @@ static inline uint64_t bswap64(uint64_t x)
 {
     return bswap_64(x);
 }
-# else
-static inline uint16_t bswap16(uint16_t x)
-{
-    return (((x & 0x00ff) << 8) |
-            ((x & 0xff00) >> 8));
-}
-
-static inline uint32_t bswap32(uint32_t x)
-{
-    return (((x & 0x000000ffU) << 24) |
-            ((x & 0x0000ff00U) <<  8) |
-            ((x & 0x00ff0000U) >>  8) |
-            ((x & 0xff000000U) >> 24));
-}
-
-static inline uint64_t bswap64(uint64_t x)
-{
-    return (((x & 0x00000000000000ffULL) << 56) |
-            ((x & 0x000000000000ff00ULL) << 40) |
-            ((x & 0x0000000000ff0000ULL) << 24) |
-            ((x & 0x00000000ff000000ULL) <<  8) |
-            ((x & 0x000000ff00000000ULL) >>  8) |
-            ((x & 0x0000ff0000000000ULL) >> 24) |
-            ((x & 0x00ff000000000000ULL) >> 40) |
-            ((x & 0xff00000000000000ULL) >> 56));
-}
+#else
+#undef  bswap16
+#define bswap16(_x) __builtin_bswap16(_x)
+#undef  bswap32
+#define bswap32(_x) __builtin_bswap32(_x)
+#undef  bswap64
+#define bswap64(_x) __builtin_bswap64(_x)
 #endif /* ! CONFIG_MACHINE_BSWAP_H */
 
 static inline void bswap16s(uint16_t *s)
-- 
2.26.2


