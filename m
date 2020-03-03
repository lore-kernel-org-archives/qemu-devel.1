Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58569C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208F321D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilLggs6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208F321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vse-0000cM-4T
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vka-0001pT-92
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkZ-0004Ly-Am
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:32 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:39370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkZ-0004LC-3A
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:31 -0500
Received: by mail-pg1-x531.google.com with SMTP id s2so665995pgv.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=31wka75p/+LkTDvlGbLqLyelOm3o2IEFpYTMuOMAQQA=;
 b=ilLggs6Pg0+r3RYAd3BAokWMyOk3kc/kpMEzbaAvkBSgbXdlcUkz+Hf4M4PU0cCWYP
 CbmR1UGRezGhpesHvuvIrcN7w4Uv6I1YWVJO13bFZ/PQLsIZpqmtbBN4fcRpRRgXLRvg
 oFPZmni38vDzG8Zy2+TY9bacvvBDoZ3MLefUNabMev0QcW+T6329Z713Slj/Iu3k6bmR
 3NHmi4HG6NmHdkkA3oexe4mD+OihumUq0XkIJkEu4n91ro27JQ0oTl4oyePTtxjoHy7T
 FgJAIx8JjrORIZJBcvuW2WWH7AJNRNtX3jUcZGaR63KCnm+nOF+88C/fVu0rO97aVKlo
 g33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=31wka75p/+LkTDvlGbLqLyelOm3o2IEFpYTMuOMAQQA=;
 b=ZluzS4ymiAr2pzMKK4HyZhyApp6e2uTldb9tJmiYcjeKtrSrYn6cDg7KJF4w2hT6su
 qZJEpGFSi8Ivpl1JB58WtI3n4xyz00iDbAa8Cwg+edfp755NRC5QdMtmdITYAiqBN91I
 KcOkvdOF9CyDmQSXYeGHlUAxJugTx3D70+bDOKlC6TtzqoIZWwz6vQHHma7X/OiBGxhd
 4UyhcTbPYeA9AMdjXZQ5da6FqnvpY22jOcHaOumcJS0SUhRA8QTTZOxd28gRpc9lr518
 FiSee7Z5Tik25WKJijFlI1kgLzgtKRy8QaSMiFCSIwaThhR6Zms8QkJ22J+TdmZzZoJr
 GY2Q==
X-Gm-Message-State: ANhLgQ1UPcK8DWPBvfK31Ji+rqP836n/ku+8ZYN/3ZNDP+7PSiwycL02
 F1A06eD/qfWvvoWffo1+uDzGUw==
X-Google-Smtp-Source: ADFU+vu3IGzBXmDZP9Ucs6XyAefiMzc8rQtbXmkGHE9pjAWGkhPOcfMD0Fk/9LihSZlJY5LitU/SGw==
X-Received: by 2002:a62:de42:: with SMTP id h63mr1612267pfg.188.1583196570022; 
 Mon, 02 Mar 2020 16:49:30 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id o6sm23908819pfg.180.2020.03.02.16.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:29 -0800 (PST)
Subject: [PULL 19/38] target/ricsv: Flush the TLB on virtulisation mode changes
Date: Mon,  2 Mar 2020 16:48:29 -0800
Message-Id: <20200303004848.136788-20-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

To ensure our TLB isn't out-of-date we flush it on all virt mode
changes. Unlike priv mode this isn't saved in the mmu_idx as all
guests share V=1. The easiest option is just to flush on all changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ccf67aca05..a8b114ae16 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -181,6 +181,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (get_field(env->virt, VIRT_ONOFF) != enable) {
+        tlb_flush(env_cpu(env));
+    }
+
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog


