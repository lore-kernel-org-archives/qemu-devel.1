Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AE4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 03:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E0D20820
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 03:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHHmAhHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E0D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBszb-0003KD-Vp
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 23:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxk-0001Kh-GX
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxj-00084M-BN
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:04 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxj-000841-5c
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:03 -0400
Received: by mail-pf1-x441.google.com with SMTP id b128so7003035pfa.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UteKEOffkWeXmOTmYpSFU6ZzU7S3qN8fl2HT/2omIaY=;
 b=MHHmAhHsEfUphd6MnrlKA/W1cnrx4nUyZ5aGfqaC/JMopaANhzppmTCapu/jQ6Dp8s
 +lLWs/weUxgmS1rNfbGKyo1PdueEW4YaP1p18I51YSJuov+twifcHXG7PfbwQPDIWEf6
 imKH4WQBcWvCfgfsU7bGEm5RLn+4hh651hrdlSE/QKsoVPVKiggmyVK334yKsSrLhaPS
 3jiAgwNxn5JWSV/XWT6899CbVp1diiGEQP6f+nEPN8u+/lvk+OWRwBybBkpOgPd5+zRj
 wol4xV5BepqGY5Gj1WedXgyxpkJT0+eLDSPf+r6efs7yzUjeC9g9YE5Ouq959/zQMzL5
 sGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UteKEOffkWeXmOTmYpSFU6ZzU7S3qN8fl2HT/2omIaY=;
 b=KRtAYrL98VVa+BtGRvGt7C0iYlw9GjH7JtP/G62ZpO8vdaW91RGZY+2FhZ597AMn9N
 PqQssqF58GM8aOdFHQfL1JD4cRGUTQwneYo/DgwpiRUZiWL1JV29f/kMTeRbCbsl+DoW
 KMQ0LriPbbpP/LTpK/dtCuxsdX5vBOaBD4Zz6Vs2on0COPoqx4/Y8PTpGwfmc5lTaZz2
 F5jT2KjSOu3Q5uXUMdSGJTgAJjEPsat6nPzH9NAHe5vb3g00TBDLqtOpmS/DokCopUVi
 SbdVruLM58eW0MuFmN6svDgzwvTtX/dC2JthIqG+P5BdYBZVFaKoROhIE+ZkWDWR4KbW
 ftUw==
X-Gm-Message-State: APjAAAVgEvLOtmdOLxJICLYmTMlt4o02JfdemoAZ/oVWo9GRihLA8dhv
 kzRrDElW1GhVOfSUbgn7AJ+uYOVo+T8=
X-Google-Smtp-Source: APXvYqxARiDvrinDkF0IxQnh2fo69K/lZeBYiEgmn0/VopSpl3XirwQo4YqSm7CIx5iwHfHoj927kg==
X-Received: by 2002:a63:465c:: with SMTP id v28mr23572735pgk.310.1569124501770; 
 Sat, 21 Sep 2019 20:55:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/20] exec: Use TARGET_PAGE_BITS_MIN for TLB flags
Date: Sat, 21 Sep 2019 20:54:39 -0700
Message-Id: <20190922035458.14879-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These bits do not need to vary with the actual page size
used by the guest.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d2d443c4f9..e0c8dc540c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -317,20 +317,24 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #if !defined(CONFIG_USER_ONLY)
 
-/* Flags stored in the low bits of the TLB virtual address.  These are
- * defined so that fast path ram access is all zeros.
+/*
+ * Flags stored in the low bits of the TLB virtual address.
+ * These are defined so that fast path ram access is all zeros.
  * The flags all must be between TARGET_PAGE_BITS and
  * maximum address alignment bit.
+ *
+ * Use TARGET_PAGE_BITS_MIN so that these bits are constant
+ * when TARGET_PAGE_BITS_VARY is in effect.
  */
 /* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS - 1))
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
 /* Set if TLB entry references a clean RAM page.  The iotlb entry will
    contain the page physical address.  */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
+#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
 /* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
+#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
-- 
2.17.1


