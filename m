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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A68C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AF52084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfpkyiMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AF52084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5KS-0006MF-1v
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DH-0005x6-Q9
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DG-0008Gu-IS
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:03 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:44674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DG-0008Ge-Dr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:02 -0400
Received: by mail-yb1-xb43.google.com with SMTP id y21so390995ybi.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BWSlg2XWPB5KNiph56wA0+SaeyPUczXhg2Xv+22oFtY=;
 b=dfpkyiMWtkCg/fE5DbKa65sf9ecrbEg9OmZM3+hEdam7y/hkneYRXMAMDVr6wfj/lN
 ViPpOXk5CJD7bCeZXHxy/twqfkozOIUCCtHcVEPgsg34we2itkAe7tmkKDt1eqMIysxs
 mb6BliU8w3ajXgeEjtGjdXqE6Vx7Jk5Suo+b5IHP8iyQrgQvRpzUwBnFdVFu/YGp3yeq
 Y+kRTbkCvBvyQZNLmj7nsCKLWKDGO+Or9xyKAhsc0KVtuEntEQEhGqfz2pKt9fdPwvEW
 5eMazjbUAs4Q7hQEyydQ+UGE8BubEMB96dEncmwdpX26+B5lsUTDT+UmgPNWKwy4gGHz
 oW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWSlg2XWPB5KNiph56wA0+SaeyPUczXhg2Xv+22oFtY=;
 b=NA0ivrspCd07Gmz01DcVqbhyastaLj8I5lrh6pjW7FOtshb+5J3FculAjjIpjGvSY3
 zwGVQ6D2s5Cdb9uQ0IV/T2qNXMvoE5LMXTuRBWeCM5aN6ZUzFsw8r2vWWqAOz/xlaiz2
 JW7E42Uwv9VEgICwjB/q7773I6NWvGh5bRqYicnnIrW/5H0/wE0Y9FWO3s7wYjTZbfNZ
 i22H6AT2YEv7aqzXN75vGG/E0vJq89hp3/dw3oVXkmV5AS0lI9tkgV3b81E9qnqY9IE7
 z0STA4vFOqTxNKM4VMURlSSuDKOL9R4bbHKqiiSrycRFU1bGb/jrsVCJC1mm9340US1Z
 7u3w==
X-Gm-Message-State: APjAAAVCp9lkNc5wmaYzfZd++R8keH72D6bUzKL4ueySAAehG4Z5vmdU
 6aN3lu46DoSEf5LgVLroQ3KRIrZs
X-Google-Smtp-Source: APXvYqxGvSNCenwBvsYGq/FTMtLTQ96oaC0D/tkhrVh3eqZnYKiIm2000z0uw02zP7VpPkyK9vszEw==
X-Received: by 2002:a25:6302:: with SMTP id x2mr2049397ybb.6.1565835001834;
 Wed, 14 Aug 2019 19:10:01 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:01 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:50 -0400
Message-Id: <20190815020928.9679-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v3 08/46] target/i386: make variable b1
 const
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

The variable b1 does not change value once assigned. Make this fact
explicit by marking it const.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b1ba2fc3e5..8bf39b73c4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3042,7 +3042,7 @@ static const struct SSEOpHelper_eppi sse_op_table7[256] = {
 
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
-    int b1, op1_offset, op2_offset, is_xmm, val;
+    int op1_offset, op2_offset, is_xmm, val;
     int modrm, mod, rm, reg;
     SSEFunc_0_epp sse_fn_epp;
     SSEFunc_0_eppi sse_fn_eppi;
@@ -3051,14 +3051,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     TCGMemOp ot;
 
     b &= 0xff;
-    if (s->prefix & PREFIX_DATA)
-        b1 = 1;
-    else if (s->prefix & PREFIX_REPZ)
-        b1 = 2;
-    else if (s->prefix & PREFIX_REPNZ)
-        b1 = 3;
-    else
-        b1 = 0;
+    const int b1 =
+        s->prefix & PREFIX_DATA ? 1
+        : s->prefix & PREFIX_REPZ ? 2
+        : s->prefix & PREFIX_REPNZ ? 3
+        : 0;
     sse_fn_epp = sse_op_table1[b][b1];
     if (!sse_fn_epp) {
         goto unknown_op;
-- 
2.20.1


