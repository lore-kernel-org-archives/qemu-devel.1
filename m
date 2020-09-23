Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0334C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33010214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/B10cBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33010214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLBnE-0007be-T7
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1kLBlY-0006jp-QT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:53:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1kLBlR-0001Es-NX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:53:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id p16so448376pgi.9
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=xRUr7wjRtTS7mPNtoSMKD7vsR1qzI0GIQ70U0OhkUj4=;
 b=J/B10cBXinbSUdX2d/Tmp+pUQk+k+pkP2b0Dj4gPfSXXAbO2XhaC9DAqAtabCNyPbm
 2/1mR9E4LZKZenJsjPo4n+0Bk1iQmVaJUr5dUA2bubwFnFiD6CaeZ/qEeYJozjOSDE8w
 TmspCP+lNlyHQDSrj61SENXiEd1faEGUW23nv0vOMElWpPVD4TIZIN9wIOPV2f9/xJAh
 Uh8xOUauxS0KtJNG9uLjPnQwEjfR4nlXBCldFC8Mr+0Vo0WPaJiT2lWxObECO51OBIFl
 WaHqwSTqv93sypCTVDbUbPNJHTu9DtLkYPAILzVdI8BYMdVRWGCirSz4kpARWBXP8ng7
 TQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xRUr7wjRtTS7mPNtoSMKD7vsR1qzI0GIQ70U0OhkUj4=;
 b=kVLH/7wF559elhCIDyVMlWHe5+qPeaYGVbeoFSUEJvWinSDflLt6bQ8D/tatdziKN2
 AOg5T7qeWje8Hj54f3Mp3RWAO5qHdWk6n3gLCdQ/vEUXD9JuRVRFLPrpD1tsDAZDgYpy
 A8GJnhTuofmozRjq8EeeMb8j+NU31TRgRF8ZJSaJDVE6GWS4Of2wClS4lhrjZItRZBzi
 z4xx8L/mveUiKrjZ/ePUfxHS987NPM/lagbKQ9P7guh2f16jB7p2LukjMTsNh/jLimtO
 0yhOUUNm14st/1g46sIWjdPjsG1hnH6PdtEsWVeUO+fc/gNSsqL0tiMisVUjJQCygQ0X
 R1tg==
X-Gm-Message-State: AOAM530rMcU745WrxQ+yePRuyUdbxspetxNYnMmWtzDkR44JH1NFbHXN
 cOlhK0WZq1+npi4XGCH8Ebo=
X-Google-Smtp-Source: ABdhPJwD4WcpMmmIN+5SCO9OiDZ3aD9D28r+X3M+CygzrV3tV86OxWrW2AMcNBAKC4AVakMvz4oSEQ==
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr1322867pge.386.1600894399454; 
 Wed, 23 Sep 2020 13:53:19 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net.
 [67.188.192.166])
 by smtp.gmail.com with ESMTPSA id 134sm534686pfa.93.2020.09.23.13.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 13:53:19 -0700 (PDT)
Date: Wed, 23 Sep 2020 13:53:17 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 1/2] qemu/atomic: Update coding style to make
 checkpatch.pl happier
Message-ID: <20200923205317.GA85735@Carlos-MBP>
References: <20200923151901.745277-1-philmd@redhat.com>
 <20200923151901.745277-2-philmd@redhat.com>
 <20200923182714.GA70694@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200923182714.GA70694@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=carenas@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

will be also nice to squash the following on top for a complete clean
checkpatch version, as the original patch introduces at least 1 issue

Carlo
--- >8 ---
Subject: fixup! [PATCH 1/2] qemu/atomic.h: rename atomic_ to qatomic_

fixes:

ERROR: Macros with multiple statements should be enclosed in a do - while loop
+#define qatomic_rcu_read__nocheck(ptr, valptr)           \
+    __atomic_load(ptr, valptr, __ATOMIC_RELAXED);        \
     smp_read_barrier_depends();

false positive:

ERROR: memory barrier without comment
+#define qatomic_xchg(ptr, i)    (smp_mb(), __sync_lock_test_and_set(ptr, i))

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 include/qemu/atomic.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 87b85f9f6d..be47e083be 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -149,9 +149,10 @@
 #define qatomic_rcu_read__nocheck(ptr, valptr)           \
     __atomic_load(ptr, valptr, __ATOMIC_CONSUME);
 #else
-#define qatomic_rcu_read__nocheck(ptr, valptr)           \
+#define qatomic_rcu_read__nocheck(ptr, valptr) do {      \
     __atomic_load(ptr, valptr, __ATOMIC_RELAXED);        \
-    smp_read_barrier_depends();
+    smp_read_barrier_depends();                          \
+} while (0)
 #endif
 
 #define qatomic_rcu_read(ptr)                          \
-- 
2.28.0.681.g6f77f65b4e


