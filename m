Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA54C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE432085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIi4C9Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE432085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIrq-0005lp-3Z
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIks-0005aa-FN
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkr-0004Kf-H0
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkr-0004Jw-Cq
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id j11so40045509otp.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RvvZNuwuP5zROeDoG9Y2s+/dwyJ4NAp8aFQnZB83t4Y=;
 b=ZIi4C9Ri5O551X3Mj04AvYc91YpyCO1VQNWBal4+Tar2+qCB80wA+uyHZKheh5MJSk
 Izm8KJLawVvBg1MISTeYoHmMmfYP6OO3mj4Mpru8CS199KrqyIsl9/PkGxSU9wVciNjb
 LgX+L4Xy4N0shsPOAuFkfKz5LDjsgkCN2NEWX0IqstyOVX1A+WMb/5JBYWut8j3K8yJz
 U7/+cGIqGaN8iabX+aPQ6Vh6YShX3P+SjYjU3SHITR8dvU3Jf2iVYYHp8u36AQ8fmbkb
 wAMTziFuSKhNJoIbGhV9emNinZTv/5P5JGw7/+gmpYh7RncKFziaELqCox6bSpB15Ozn
 geIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RvvZNuwuP5zROeDoG9Y2s+/dwyJ4NAp8aFQnZB83t4Y=;
 b=DzAODDMI0zin9QiQRTpcKHVxruE7E3fyokFDhbuy1GI8+5dce7H62wynxZIY3/pgc5
 AXqh9yjjoROWYuJvw8tCzaJ+KydRFIKzhYvnBhcBs1J7vTqhj2Uz8t+GgJ6+JrjSlpve
 qO8+LgVXO8EEHhW07AB9pW8TuEZGcCC81sM17KrDXKoqQ0T3Iwtac9284DPVMNG0z+Mf
 RON3xZqWZe4XFO+hW8jLvVJb8+DdyTgL5SFnU0aGewESZ5K7rJvg2YeMoJFTWUIjkvJx
 5Q4vP4Xz4OKvjx12cD0lsHdyekJ+fnnr80BUV6CLXSWGbxy/8cs4WzAzhVXLniU+c2yW
 nrDA==
X-Gm-Message-State: APjAAAXqopPhw1rMlVOu0MOROuGLGsJ/Wefy5b6bZgzU3OdY3G3tbRZH
 0VYmomVB/AVcoC1giSchXI1uRAgu
X-Google-Smtp-Source: APXvYqxs5m2ox/Ef2EKtz1vBpWex79Y7HCOADCe1j1+picSTAPB4/6P7nu+CVL5ohNaLcGRyMrUhMg==
X-Received: by 2002:a9d:711e:: with SMTP id n30mr18992937otj.97.1565410400719; 
 Fri, 09 Aug 2019 21:13:20 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:30 -0400
Message-Id: <20190810041255.6820-15-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 14/39] target/i386: introduce mnemonic
 aliases for several gvec operations
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is helpful to introduce aliases for some general gvec operations as
it makes a couple of instruction code generators simpler (added
later).

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 23550a21d3..03b49411e5 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4493,6 +4493,13 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-function"
 
+#define tcg_gen_gvec_andn(vece, dofs, aofs, bofs, oprsz, maxsz) \
+    tcg_gen_gvec_andc(vece, dofs, bofs, aofs, oprsz, maxsz)
+#define tcg_gen_gvec_cmpeq(vece, dofs, aofs, bofs, oprsz, maxsz)        \
+    tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, bofs, oprsz, maxsz)
+#define tcg_gen_gvec_cmpgt(vece, dofs, aofs, bofs, oprsz, maxsz)        \
+    tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


