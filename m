Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0EFECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D87820854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P489Nrtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D87820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxxd-0000n1-96
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvF-0007JC-Pp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvE-0005v7-JJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvE-0005tQ-CU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id b24so16248784wmj.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3VokXMxF70KROu8ZB6/KdoZUveks1jnXB+njMViY1Lk=;
 b=P489Nrtc0/IjWNc/qVw4q4crfquK2QE4UExH/Lovs+pJLl3Nj+uinUGcT+gW7L4RQA
 ZzjuBS2A3wSmiy2UQ1RPCMSv/SMntyLEG8FeOAV6fXyG/lPRe5CtC7wFWAngzBa3vPOS
 GRJgpvu50OQBp4ACoeiE+Ubc4+Xd8/XxZyRc/8VWq9xxx5ptaBQGyI0+yx1kS7eSf/eu
 LqL9h+e+yI4sWj5fuWqPi8w9N9+TfNWD6ykbkOUm1jOM2G3K3A3BCFUZ+lSZciI/FbHg
 oEQmbsf/4fV9mwCyb7t8DJ1yN+r+trAHDQj9hVEI5H9vChqigM6+m8Slnzl8JXMTSorc
 8zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3VokXMxF70KROu8ZB6/KdoZUveks1jnXB+njMViY1Lk=;
 b=jVg5N24kyQ/NQ3akYTUy7LgnQKotD+ZLx2WfNHPA9t7iNbhFXKsCzFW13TxrVyYQFV
 BQf0euMStNCJcSr8JXYUH5E+4CVTkbUpcLFYq0Rc1G2VzRodgVSccoxnxRYz6wKWjmDL
 Ssf9YFDa+CLS1Nr03mt7b66Kq3TlMNtDmzbWkP0a9g4Zwmylx6sYVL+jEW2N6t1vNqmi
 Icik3ayob5aT44D0qfj484fu12oBYw3i6yj6D+e0yh54mcbSHstq7/3kwY/U1wEEAvrF
 kftkEH0eywzGuH8ZA9tYHaVclEqt1Y/Dp8jUNnQvxsaTo2jCe7ojAaycxrNBmdmK3U/s
 3anw==
X-Gm-Message-State: APjAAAWzxpHl3LCO2+Y4T8txT80ELOuD3M3a/hwD/nbeNaFBkI76e/0M
 dqCHVLEhOJuv6I69wGhfHl8Skw==
X-Google-Smtp-Source: APXvYqxf/56M32Y6pon7F0z+ImOBfcVukqc5jwSJSMimvpU7n1fHNNG4jH3c7HJWl8ZkFMZpS7Rs/g==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr15411791wmi.175.1571050190323; 
 Mon, 14 Oct 2019 03:49:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z22sm18266704wmf.2.2019.10.14.03.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 227711FF8C;
 Mon, 14 Oct 2019 11:49:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 01/55] trace: expand mem_info:size_shift to 4 bits
Date: Mon, 14 Oct 2019 11:48:54 +0100
Message-Id: <20191014104948.4291-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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

---
v5
  - return the tweaks to mem-internal.h
---
 trace-events         | 2 +-
 trace/mem-internal.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/trace-events b/trace-events
index 20821ba545..22133dfd3f 100644
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
index 3444fbc596..1a010c1b27 100644
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


