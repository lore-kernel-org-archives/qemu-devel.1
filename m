Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDA5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E01217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEYMdxA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E01217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3As-0003Rz-Qe
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 18:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39J-0001f2-3c
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39H-0004sO-Ch
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:32 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:54911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iu39H-0004r3-7f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:31 -0500
Received: by mail-pj1-x1032.google.com with SMTP id kx11so2150697pjb.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to:in-reply-to:references;
 bh=3ZBJ3lOl6bAM6O++EHYM72vy4b6t2MTsiNBFdeYBurI=;
 b=IEYMdxA3S1BERn6sPZiFD8pAcLbFnXyIWED3sMkvXxrYnPV7sS0BViHvNkLvad0DfF
 JMxpDSSSdBTeceCzf9ava/yk/SHtPV8XlhS4SMdASannEG4i4u2PziSqH4IiaV84PYnz
 K/wJKE+plqDs02njgPFh8r4VAO15TbXXyex5ul5jkwssQw1pedzuBZYu8WxVxOi9JXvb
 ZboLzhR/QbmfQE0terQD9mJKYz3UiQH1Y4R+Zotrd9PHd5a+3DteUtaxOrDI5+NZ+DmK
 7GmxZwBIY6kKQaYJ4drBZTwoMxBaoXiF8xia/dLEfugwQZEOsn3KWHXY4ksgEcOLBddP
 urcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to:in-reply-to:references;
 bh=3ZBJ3lOl6bAM6O++EHYM72vy4b6t2MTsiNBFdeYBurI=;
 b=cM/W+VkA7RRs14JMEKdOtmLjFMLxS99us/9wvS74COC4iASI8SPrhMan1CU26bCsT/
 Hy55UrfbwxvGlVuMG+fgh9yZnkHzUkT97MN9GwCDktQ4akwdRTl5SYS53XZmr9TACJ16
 v73c2bpdCXArH8mEK9L49y+1Ez2124AIdDFr4d3g0tB98drjtVSRJXHPMt5JuderbX5H
 vP0LvGksXiITpSxfvYj5XwgAkJCi/6HLESkSjFZdIlwoWA2ACiIcEZr1OW8wQbsKhkD9
 vvLKwyGqL65FhJ7k4WpG3W/5cUgrI9CYPFgtzKSRzcMfoGkbaRjLn0N8TjikePpD7C2T
 2qew==
X-Gm-Message-State: APjAAAV7DEf4FZ3XWyvia7dzoov9Mw6opQP6KPtqknhgKfO3PcsTVXAg
 CSJWsHEWpBvNN7Z/x8GpuFqd+ENjrQM=
X-Google-Smtp-Source: APXvYqxtvJS9NyZQN9Z2EZ9LfOBj6cdr+3X4Dm8phYlu8yFquxdsbxgM4hnRJ+Nj4uJhpKzIq9IoGw==
X-Received: by 2002:a17:902:265:: with SMTP id
 92mr7395675plc.188.1579650089333; 
 Tue, 21 Jan 2020 15:41:29 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id d4sm533552pjz.12.2020.01.21.15.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 15:41:28 -0800 (PST)
Subject: [PULL 5/5] target/riscv: update mstatus.SD when FS is set dirty
Date: Tue, 21 Jan 2020 14:57:02 -0800
Message-Id: <20200121225703.148465-6-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 ShihPo Hung <shihpo.hung@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
References: <20200121225703.148465-1-palmerdabbelt@google.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1032
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

From: ShihPo Hung <shihpo.hung@sifive.com>

remove the check becuase SD bit should summarize FS and XS fields
unconditionally.

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c       | 3 +--
 target/riscv/translate.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f0b1..0e34c292c5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -341,8 +341,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    dirty = (riscv_cpu_fp_enabled(env) &&
-             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
+    dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ab6a891dc3..8e40ed3ac4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -394,7 +394,7 @@ static void mark_fs_dirty(DisasContext *ctx)
 
     tmp = tcg_temp_new();
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
-    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_temp_free(tmp);
 }
-- 
2.25.0.341.g760bfbb309-goog


