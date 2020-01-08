Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8950EC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5210120848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNyhk+s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5210120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2aQ-0004CD-Ov
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JS-0005SR-BM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JR-00048u-4S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:18 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:33878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2JQ-00048O-VJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:17 -0500
Received: by mail-pg1-x534.google.com with SMTP id r11so883783pgf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UQQL71nxDv+NQizXBLJ7meGttjVPXVB9/ApNcux5IwY=;
 b=NNyhk+s//Dqr3R8gpv/NmUGeYAyamg36eUKOIuBnhPZG3UW4h1BAsP1WUhsYoFwm+n
 rbnlwJ8KGOcqT2dD0gagfhRa8mxrWgIomADWpzqtwIprtkxUzHi/PQuaeB5k5tAmPedw
 KqFzOdoPzZU8hOoqlv22iTY+PfJQ7uxXrX3IPokqH53V0xxMhAmywf64hWYcxsfWdCu5
 /+rVC+FOY5XyWCNkT9y/5kMCP1vlXOblXrBscxUwhxovtJfNpwxwc9fpMWBGksJoQvHI
 EL0ppfgSmZKOg0H53TmT7yK/+UMKQwdIjxLGfigtuy12eBkGUJmRq0QvPbgNJyVip+WM
 zy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UQQL71nxDv+NQizXBLJ7meGttjVPXVB9/ApNcux5IwY=;
 b=YTm93He4zl5t6JgzKW9xAeKC5JprszXq10+ltuWYuzGUkSlTd704q4c3VSV9nJtZnu
 XeX66m0wTFJR/vLgI2VrfjWPf6oKy2MRO++VxFQYJyD2639lnegbjBhRR0LO0RPkCNoH
 OFygId4OSXfzJ5wDKJNsfwuzyKdJ7h37nSJiNGoPmvHjKR7MTWi8RE3ZWZ+uk/ZDyMVV
 jWjoye1GfIBCFkK43jAsVfKXud5ZJgOKLgKSJ2AN2+wpJi4qKBc7PNuBa6vmR2l6EQJv
 SEzsA5VFTyX60lyHEMjuAyLZnXlf5aFQu3zWbqBggXDhah68S+RHRqz4NT06ugHJKLNh
 pJTg==
X-Gm-Message-State: APjAAAUy1gc1NZ5TUU7C/fpDTxBdPFiDIizLsea/RtL+8BgZONXQY91r
 UvNZ9oHqiuSMVLg1KRN1WoltFyPJieRAcw==
X-Google-Smtp-Source: APXvYqyWZxXPSi/PHBCVyxKiXBF4zFOJez9e3UKZu1+aV9NDhkitq3RAOh8zfSDi7VTiGEvwvXHsUw==
X-Received: by 2002:aa7:8dd0:: with SMTP id j16mr2933068pfr.186.1578455235792; 
 Tue, 07 Jan 2020 19:47:15 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Wed,  8 Jan 2020 14:45:16 +1100
Message-Id: <20200108034523.17349-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are only two uses.  Within dcbz_common, the local variable
mmu_idx already contains the epid computation, and we can avoid
repeating it for the store.  Within helper_icbiep, the usage is
trivially expanded using PPC_TLB_EPID_LOAD.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h        |  2 --
 target/ppc/mem_helper.c | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 103bfe9dc2..8ebeaba649 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -951,8 +951,6 @@ struct ppc_radix_page_info {
  * + real/paged mode combinations. The other two modes are for
  * external PID load/store.
  */
-#define MMU_MODE8_SUFFIX _epl
-#define MMU_MODE9_SUFFIX _eps
 #define PPC_TLB_EPID_LOAD 8
 #define PPC_TLB_EPID_STORE 9
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1351b53f28..56855f2381 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     } else {
         /* Slow path */
         for (i = 0; i < dcbz_size; i += 8) {
-            if (epid) {
-#if !defined(CONFIG_USER_ONLY)
-                /* Does not make sense on USER_ONLY config */
-                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
-#endif
-            } else {
-                cpu_stq_data_ra(env, addr + i, 0, retaddr);
-            }
+            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
     }
 }
@@ -216,7 +209,7 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
 #if !defined(CONFIG_USER_ONLY)
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_epl_ra(env, addr, GETPC());
+    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
 #endif
 }
 
-- 
2.20.1


