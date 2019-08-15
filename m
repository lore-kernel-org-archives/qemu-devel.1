Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCCC41514
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090F820C01
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i18PKs9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090F820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Ki-0006fG-1W
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DO-000641-8Z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DM-0008LQ-F1
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:10 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:38759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DM-0008L2-7E
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:08 -0400
Received: by mail-yw1-xc41.google.com with SMTP id f187so297266ywa.5
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kaNCwyHpMkNqwSgvSmZLjSKWRlicmlM9lWRJ1+7uU/s=;
 b=i18PKs9kAB+aesQk/ykKmHNkcijYR0HggrGlzPjb+F8SlNkNb3uie4EjTh604BFd/H
 zaAYJhD25d+Byz8LbivmmDWVn4bx3IulpsXLiJLt8xKvr+X90P0aRPzzXqLtRcQq4Gnt
 Ki4VmkCNOJCLh12qw3ySoW6Anm/oHybfwP2Rh2YX+GGHPoxmv1XkAMunpkukY3zv0NFR
 tmAISwofY0AhA6yYBsxIIeo4nU9dRkzddc+q5OeG6VKSGjn5ECn7QbhQc39hbm3yZnTv
 gS0j5tEAB6MKccHH61678NfUohbw6sPMrSEeZKoCQHG51h2D17ke4w5xJKRxRE6RGbnk
 Ug+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kaNCwyHpMkNqwSgvSmZLjSKWRlicmlM9lWRJ1+7uU/s=;
 b=UAVH0oMY5PRYSO8XPi1EMGH0jYcJpDGpNRdfALrew73ZzX7jWHumUKGJpcygheGEsM
 V1h8k89i28kAyt3o6tXnRDdrRYAIQtoucy7OMOTXdBA2m8Y5EgP7CyA2zzTuW3vKLzxx
 NFIBkhbKPAQpb2LrytcQLrGtjQ+pRd+NJb6ayVHvKRpwoPirgQGc6yYIk2xdeN3hohge
 TiE8+m3Wzwo/dLl1iJgWW+ie1PpKStQVjTQDlfdm987QvDsnfIzrlGdvrXNifX3JRl2r
 EbrG+GN7yEz5tKdE9s/PM7Whx7plPRzRQJ9eqa4XrQFmhsyI4/p4JNcCuljheVXzKczv
 SlFw==
X-Gm-Message-State: APjAAAVfbAstsNkKxpke9GJXH4YcSCjWBY2kZ0gY1CbYYZ7pbAE/LD/6
 6zPKtQ2NaxULhjkssW97qTThNelJ
X-Google-Smtp-Source: APXvYqxlPh6VMLgXUn/k7xDuIJIEz9lLTjXo+8PRoBCHryw5NjVgH8u64+y0m4JIRaqRFVOLlsQOIg==
X-Received: by 2002:a81:7dc3:: with SMTP id y186mr1557771ywc.223.1565835007594; 
 Wed, 14 Aug 2019 19:10:07 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:56 -0400
Message-Id: <20190815020928.9679-15-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v3 14/46] target/i386: introduce mnemonic
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index e9741cd7f7..6296a02991 100644
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


