Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13255C2D0EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55D12074D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecBrk1q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55D12074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHVtp-0007n6-04
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHVsx-0007MY-PU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHVsw-0004lj-Cf
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:01:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHVsv-0004eB-BB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:01:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so8704274wrx.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dqLqRQ4b0SR5ODbR+9qMmow31WjM5Vry9omXjfMMazw=;
 b=ecBrk1q5TSqvNxbmz8psUz04AafImfd9hjKQ+yggV3bDIUpHcrkXFGTBhbDCYPeGYO
 LvxGR4TKSg0MO/qG1RnVbj3+1E0MCjuUXsxo7QO4fnYp2nClkmr3LO0N1+5F0bep6pIY
 2sXw+Gp+Yy7Wgkv4Y6defQAc2VIgIcHlMUU5egtVWzgEgxA/KQVMb3bkv4uzi/X8p2B3
 NWRwPUBY2OBUGF6O2rTl0Qukm4sKiLHbLQdl9Ryxe/Jq0HbnkMLqn6tf6d3cJ5od8EW4
 VyMBlS/0sQhXptON53hvkkD5vU0pLItFKrpvx9N4NrT+/3GeQpWpOvVJyvA4J2c9dSqv
 aL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dqLqRQ4b0SR5ODbR+9qMmow31WjM5Vry9omXjfMMazw=;
 b=F6xMCVTtBgfjvW2vmF9ktUfgZGKc7YMRyTZf/LVTGBE7nblt6/Y3tXjeKEwvYwBFht
 GTLGM8dePMsYfIw5DZgp4r3FO8dkDhXyCg6GHsmr3wljebbGYyhM8uei0mkq0tG6OYNx
 0GecQ+q0ETK1lUvzyeic+KRQuWlcn54VbDCHJO5bmgjPmrhD+C52OCc32ObVqBEsa7g9
 s3Pt+rDSZVEr7/X95GfGlzOE8+dWepVhmYOl91KRByCk2IQiv76lK+eFh9JClURW39x5
 CirR+ERhvsGxjUbxWzoFlEUXnS8d1nGBGk9u/SYat20IgXuDWGgeqf/uFjFzP9quqwOo
 O3eA==
X-Gm-Message-State: ANhLgQ0+korkY2ouiaiKxTKnmPKgPSFGvwfnRvWoGIWjMgg+tCuKxWy4
 inz7FPpr8JhpQLlnRRxVib78Yg==
X-Google-Smtp-Source: ADFU+vtXAMgmXxPKKcRWXG6PtSOphvHTiW6L0wPQuigWeLWyU/1rjIjRh6i2Q+3EGPLu0haUKCVvsg==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr9940802wrw.87.1585242095139;
 Thu, 26 Mar 2020 10:01:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm4717549wro.72.2020.03.26.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 10:01:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1DE0F1FF7E;
 Thu, 26 Mar 2020 17:01:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
Date: Thu, 26 Mar 2020 17:01:21 +0000
Message-Id: <20200326170121.13045-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deep inside the FreeBSD netmap headers we end up including stdatomic.h
which clashes with qemu's atomic functions which are modelled along
the C11 standard. To avoid a massive rename lets just ifdef around the
problem.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/atomic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f9cd24c8994..ff72db51154 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -208,11 +208,14 @@
 /* Provide shorter names for GCC atomic builtins, return old value */
 #define atomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST)
 #define atomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST)
+
+#ifndef atomic_fetch_add
 #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
+#endif
 
 #define atomic_inc_fetch(ptr)    __atomic_add_fetch(ptr, 1, __ATOMIC_SEQ_CST)
 #define atomic_dec_fetch(ptr)    __atomic_sub_fetch(ptr, 1, __ATOMIC_SEQ_CST)
@@ -392,11 +395,14 @@
 /* Provide shorter names for GCC atomic builtins.  */
 #define atomic_fetch_inc(ptr)  __sync_fetch_and_add(ptr, 1)
 #define atomic_fetch_dec(ptr)  __sync_fetch_and_add(ptr, -1)
+
+#ifndef atomic_fetch_add
 #define atomic_fetch_add(ptr, n) __sync_fetch_and_add(ptr, n)
 #define atomic_fetch_sub(ptr, n) __sync_fetch_and_sub(ptr, n)
 #define atomic_fetch_and(ptr, n) __sync_fetch_and_and(ptr, n)
 #define atomic_fetch_or(ptr, n) __sync_fetch_and_or(ptr, n)
 #define atomic_fetch_xor(ptr, n) __sync_fetch_and_xor(ptr, n)
+#endif
 
 #define atomic_inc_fetch(ptr)  __sync_add_and_fetch(ptr, 1)
 #define atomic_dec_fetch(ptr)  __sync_add_and_fetch(ptr, -1)
-- 
2.20.1


