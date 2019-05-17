Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8162C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F22E20873
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5NxnRF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F22E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRldW-0003Kf-O1
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:47:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbJ-0001JN-1C
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbI-0005XB-1Z
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:16 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbH-0005WC-TH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:15 -0400
Received: by mail-yb1-xb44.google.com with SMTP id t62so3219830ybi.11
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=asAnLoiLmn9O1f8JyRCjR6gJZ9RVkxFZTDo//TEA/II=;
	b=e5NxnRF1hyeOTzaapDBlxabihYu3grKGNhVleIJJ+9bO1nl89UvDsTZyfsBTRaD+SD
	XZ8ips/Z9kd8bbBgtY4zBDc71JAh2a1IiQ5oeJ0pczuhugmxT9AGpdb/W2P08Q2FViR3
	YHWyDHcmbmL8oRFTaj92P7tdMjoHwIu8Fb5n1sHw+0dIOge8gus8su3qzsKudrqvCl4u
	3DnhhSttcfkrJIYofxOE2Q6hqwzjG9rUB8fXTFRRW/RKgyk3kfwLiKO/d3XSsBNw0ojj
	H7qfeOi0zS7bSOVoFcovKoqLhXbJWBqEzoSM4Oa7ZR4h3LibHDCWcGnKZiRw1YTxXDnA
	FcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=asAnLoiLmn9O1f8JyRCjR6gJZ9RVkxFZTDo//TEA/II=;
	b=mIMB50pAsboTQmyW9rX3sVdu+DQcckaLOBRZ7JF9ZrgpZqNrmHhlUEYOKdbR0a2xWa
	g6pkjRJVTKqHBHQ0N5gXZGwrrw8+J3/Lii9c3N6o7jJ8C9NE7ROmqpWcqbscWaWnVblU
	DN8wb8iJZiHFV/KDM9udhDOVT5vwCWe8LKVSbfkLGaaSPQMY8r1PM1HAmjaV8Yzdsx2f
	jNkpQfcUVmii51s2891elzJk++gtg3oNdmAuXX5Jw3Jp98Gr9vPz5Pr8uf8kjJNiUNNJ
	g68Q5qmqnxXOAFeulN8xMDlDZuH749RL1s/p2+AEKGLGUrl9XcP7KtzdB0aA1W3sOIk5
	3cDg==
X-Gm-Message-State: APjAAAVIjGgnsfmZ4ccV4kYvi3vnmxvTVOwAWUij6VmT7VVGhnsZLLnt
	YTZTJ30bcMnlTyzGoTVHdcu6M1eXhBWucA==
X-Google-Smtp-Source: APXvYqzr8M7YvB0vj73tDQA3xc6GfIYCse9SO+XAxa9Ih3qTkzhU+PbGP8gjm/89kvucL6x64GfAXA==
X-Received: by 2002:a25:e801:: with SMTP id k1mr5960665ybd.266.1558133115287; 
	Fri, 17 May 2019 15:45:15 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:14 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:44 -0400
Message-Id: <20190517224450.15566-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU v2 05/11] risu_i386: implement missing
 CPU-specific functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

risu_i386.c is expected to implement the following functions:

- advance_pc
- get_reginfo_paramreg, set_ucontext_paramreg
- get_risuop
- get_pc

This patch adds the necessary code. We use EAX as the parameter
register and opcode "UD1 %xxx,%eax" for triggering RISU actions.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/risu_i386.c b/risu_i386.c
index 2d2f325..06d95e5 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -25,12 +25,37 @@ static int insn_is_ud2(uint32_t insn)
 
 void advance_pc(void *vuc)
 {
-    /* We assume that this is either UD1 or UD2.
-     * This would need tweaking if we want to test
-     * expected undefs on x86.
+    ucontext_t *uc = (ucontext_t *) vuc;
+
+    /*
+     * We assume that this is UD1 as per get_risuop below.
+     * This would need tweaking if we want to test expected undefs.
      */
-    ucontext_t *uc = vuc;
-    uc->uc_mcontext.gregs[REG_EIP] += 2;
+    uc->uc_mcontext.gregs[REG_E(IP)] += 3;
+}
+
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = (ucontext_t *) vuc;
+    uc->uc_mcontext.gregs[REG_E(AX)] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[REG_E(AX)];
+}
+
+int get_risuop(struct reginfo *ri)
+{
+    if ((ri->faulting_insn & 0xf8ffff) == 0xc0b90f) { /* UD1 %xxx,%eax */
+        return (ri->faulting_insn >> 16) & 7;
+    }
+    return -1;
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+    return ri->gregs[REG_E(IP)];
 }
 
 int send_register_info(int sock, void *uc)
-- 
2.20.1


