Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A73CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED3E208C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj5ggUHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED3E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt78-0001JT-6m
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxt-0001Xl-FS
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxs-0008DV-5W
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:34721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxr-0008CG-Vd
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id b128so7003121pfa.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GvMaV7tcHk1BMJ7VP3GkIN7btKhgbcJH5l/u+8AvH70=;
 b=cj5ggUHidfOL/BT0sd8EjORAvUhNGdFPkVx2xconxgmgFbD4Yq2vrE3tkMXHaqr6mr
 5qlBuqLKALdb8ir71i5e/sWUEeoDbN+JDorpcmBdp+LOZ3jaCkCPQDLNHgCizD/3cmum
 49XbqcwUFgDPdXOLS9VC4U1NwXBTOJCj86O1FQVVyH36QhdO0a57NE0RclQacTDz6oXi
 For1qR7H86kTrKEedWbKfxwpGPUD+dFLwNrrSUakEjhSbkW/0I4jnZp749idp0Fm9toZ
 Ko42D+HzMhsGD2N1wIfWFdj2rBs7qVueqZ+uP29R8ISboI16dQxZr1ZU/ZQxd3nfAkqg
 qUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GvMaV7tcHk1BMJ7VP3GkIN7btKhgbcJH5l/u+8AvH70=;
 b=ZW95F0H3NJk8XGlLO9O+D58Nr47P6YmzNcvKEv7tOgcGr0DL0clRLwx8tDBZMjUSJ8
 a4wibNksTwBJV32PP9DCFEiIbQtKNCGaRoNmXlRk/U4y64utGxlYSd9RZqdQDVxbxTpp
 zf1NG1TunT+YGATbT5apYO//UgPJpwJeK7JCV0TfOLZO3ftTTwygp2J2PFO5HXMx+r19
 bQ0WmlVn0FdA2ym6whgmg1DLfWbJLbTwf8moLh2vNM59Ow8JXZ+xhFGG2jhhDrrPdBev
 7DOf8oyNEWqm9JOr62IRTSfZyPBowzAUN47Z5EkIyrnrGMQxekIOr0sTKzI2CLxAQNrq
 L25Q==
X-Gm-Message-State: APjAAAX5Q3N7k2cAd2eaaug08115aLlcS4aJpp5E53+dUpSGvTsTdykv
 +zz33HfBZ1jXY64Dd+dwbvrLxHmk0SA=
X-Google-Smtp-Source: APXvYqxHUh+f72AyLcktyKv6xTSIWIZZeItBfXl9DtXimvcLPvAuyZj1Agfvt5PSrMSzsjX2S1MzmA==
X-Received: by 2002:a17:90a:e38b:: with SMTP id
 b11mr13329399pjz.138.1569124510414; 
 Sat, 21 Sep 2019 20:55:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/20] cputlb: Disable __always_inline__ without
 optimization
Date: Sat, 21 Sep 2019 20:54:46 -0700
Message-Id: <20190922035458.14879-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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

This forced inlining can result in missing symbols,
which makes a debugging build harder to follow.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 11 +++++++++++
 accel/tcg/cputlb.c      |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 09fc44cca4..d6d400c523 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -170,6 +170,17 @@
 # define QEMU_NONSTRING
 #endif
 
+/*
+ * Forced inlining may be desired to encourage constant propagation
+ * of function parameters.  However, it can also make debugging harder,
+ * so disable it for a non-optimizing build.
+ */
+#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
+#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
+#else
+#define QEMU_ALWAYS_INLINE
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abae79650c..2222b87764 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1281,7 +1281,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
-static inline uint64_t __attribute__((always_inline))
+static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
@@ -1530,7 +1530,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static inline void __attribute__((always_inline))
+static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
-- 
2.17.1


