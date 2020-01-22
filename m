Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E771BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4B72087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dv1SAZUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4B72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6IQ-0004AP-R4
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 22:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65y-000615-Bc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65x-0002ql-42
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:18 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:44304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65w-0002qQ-Ui
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:17 -0500
Received: by mail-pg1-x535.google.com with SMTP id x7so2621402pgl.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OC7OFlyDpMmCOREVcuHdNbrSQHKywa5Jyi9QRDoEIWg=;
 b=dv1SAZUqUI16gtonxdk2iR1y9ISk84nd3FrJEN6Hp3+97AIz59flEaAS2npyywRBZc
 ZMFoUISEkBw0qztqoBJvvXV0iPS/klbAwhXykL/Ym5WJND3fxJJkJaBcqv78uRJME6Mo
 NKECewEmCwKPmwWO2JukdEhB0p/ohOdsoy9DOJ4J8QjbkdlxLTJCT7gW6bJ4s6LtCSAl
 4Pudh6+ZUvRniWHKsMI3pMFDH2v0tpyaghaZC4/nRNDxEC3McOoSnmg1HGw2dNZQrlwd
 Mi6PKnDRRQTi/b6acIjAzvfE2/ququzX9k2RunC7vEr4GXT+ypOPrJBniLCbrzOh2VQr
 q2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OC7OFlyDpMmCOREVcuHdNbrSQHKywa5Jyi9QRDoEIWg=;
 b=KqGRYVRTGhTerGxfIC4nJE9s8bskqn2dXgQnAoDRDwVRBhws5FD3wpYCd6fUINzLNp
 Jvpve4TKkUuOZu5LSHOIxoGKs8iQzl04e54omS3J7hMjUzDaJCHOkqZCz47Vl8TcYl0x
 DxqjMmtH344kCKIZPb+/kLNWR34FLI4va5YAGWweniA0i/1PtZc4eZYG6GeygGedTng4
 raOAsWrrCmT4r0V7yotswTKBjKDOLAbyK8R8zMTMzFsZFfiHZtrmlSZnzje2jG0xHYRG
 BS1Iuc09JbJvIOu8pu0EScaI3NAPb+RHIJQs1sDK5wM0Dd54cbwhVFmrP91hEw81QngC
 vt3Q==
X-Gm-Message-State: APjAAAXnAROPcynO3u4akuRgNHRZc+9Zcso+eVhbo/MhdGZFgUQlGPJW
 ZAZ1rSjsTmq4Be9/dn86GBkImFwcPj4=
X-Google-Smtp-Source: APXvYqzB9eoLmdc7W2OzykHfwjg53N3KWzgOuh2VHwMuKwy3lH/cPiw4Nr0lA/jLPYAHsXHMvDMRtw==
X-Received: by 2002:a63:1210:: with SMTP id h16mr8626507pgl.171.1579661415758; 
 Tue, 21 Jan 2020 18:50:15 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:50:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] cputlb: Initialize tlbs as flushed
Date: Tue, 21 Jan 2020 16:49:44 -1000
Message-Id: <20200122024946.28484-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's little point in leaving these data structures half initialized,
and relying on a flush to be done during reset.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 360495468e..5a35386224 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -240,6 +240,7 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
     fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
     fast->table = g_new(CPUTLBEntry, n_entries);
     desc->iotlb = g_new(CPUIOTLBEntry, n_entries);
+    tlb_mmu_flush_locked(desc, fast);
 }
 
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
@@ -260,8 +261,8 @@ void tlb_init(CPUState *cpu)
 
     qemu_spin_init(&env_tlb(env)->c.lock);
 
-    /* Ensure that cpu_reset performs a full flush.  */
-    env_tlb(env)->c.dirty = ALL_MMUIDX_BITS;
+    /* All tlbs are initialized flushed. */
+    env_tlb(env)->c.dirty = 0;
 
     for (i = 0; i < NB_MMU_MODES; i++) {
         tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
-- 
2.20.1


