Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA020C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83A5206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83A5206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJbT-000470-27
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iIJJj-0002Ry-T2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iIJJi-00031n-ES
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:16:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iIJJg-0002zv-Gz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:16:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so1666583plr.8
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 14:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=H8fNamXSWGVsAQ92a4GC/hqc7AkmkMqrSnuj2ieP89M=;
 b=B8HzRIVb7OlvW3SV0QdE+mJmPirZxAIXGS7E7CzEKGKMVztstP0X+kR+yEPKJZ3vkj
 9pdAQVc5o4NSv9/vur51AmQZqOnFBVnNI9wtQxKksSVdC8kdW2URTHi4cMmbSDT2/qFf
 x0+FkD+c0RuE7LaShZX+avSoaB7oM23HbNhku7MPXoKeJQJImMyHIPjSb1P4k1Nl6CE0
 AMSlzPojQshS7nwlWy7YU8u0Aeh5z6BgJ6AFlOPtkDIMDYwt19tQuEGMUHHxkVNYv0RW
 yxsO55gC9ldRWiZVmYiDgCYfKBJkfa1TnlKCgYkwkIh8XxVqUtPpnTjTtXiZ1S+737+t
 S6nA==
X-Gm-Message-State: APjAAAUGS+z/ynSYaCbVt4sW+6AbsT+d0wnqprd1ibBpjaBUnayyx1Ep
 cVpNu1FYZg3gOoRHpatjVvqPw4UpndI=
X-Google-Smtp-Source: APXvYqw+f8eixv2AE2dlkWm8FE1Q5gaynqq37O0wzyb/PfVA0NR0LLyAiNqBmi2V+jNFfIFAajwUsQ==
X-Received: by 2002:a17:902:9a41:: with SMTP id
 x1mr5090007plv.331.1570655771648; 
 Wed, 09 Oct 2019 14:16:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id l62sm4341432pfl.167.2019.10.09.14.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 14:16:09 -0700 (PDT)
Subject: [PATCH] RISC-V: fcvt can set fflags, so set FS accordingly
Date: Wed,  9 Oct 2019 14:15:41 -0700
Message-Id: <20191009211541.9937-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: qemu-riscv@nongnu.org
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
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
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A user pinged me to say "my floating point heavy code works in user mode
but not system mode", which I'm guessing is the result of a lazy FP
save/restore issue as those still crop up from time to time as long tail
bugs.  I figured it was worth giving the FP stuff a look to see if
anything jumps out, and it turns out that there is a bug: converting
float to integer can set the invalid flag, which is supposed to mark FS
as dirty, but the emulation routine doesn't do so.

This patch unconditionally marks FS as dirty for fcvt instructions that
convert into X registers (fcvt into F registers already did so).  I
haven't actually tried to manifest a bug here, but as far as I can tell
the soft float stuff does set the invalid flag.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn_trans/trans_rvd.inc.c | 2 ++
 target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index 393fa0248c..8611e95486 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -371,6 +371,7 @@ static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a)
     gen_helper_fcvt_l_d(t0, cpu_env, cpu_fpr[a->rs1]);
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
+    mark_fs_dirty(ctx);
     return true;
 }
 
@@ -384,6 +385,7 @@ static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a)
     gen_helper_fcvt_lu_d(t0, cpu_env, cpu_fpr[a->rs1]);
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
+    mark_fs_dirty(ctx);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 172dbfa919..87a250a3f2 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -237,6 +237,7 @@ static bool trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a)
     gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a->rs1]);
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
+    mark_fs_dirty(ctx);
 
     return true;
 }
@@ -251,6 +252,7 @@ static bool trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a)
     gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a->rs1]);
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
+    mark_fs_dirty(ctx);
 
     return true;
 }
@@ -389,6 +391,7 @@ static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
     gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
+    mark_fs_dirty(ctx);
     return true;
 }
 
@@ -402,6 +405,7 @@ static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
     gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
+    mark_fs_dirty(ctx);
     return true;
 }
 
-- 
2.21.0


