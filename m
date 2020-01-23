Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF95C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9768B214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMgTWerT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9768B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuezF-0004FF-79
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucr9-0004gE-L7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucr7-0002zf-PN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucr7-0002y3-5q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id t23so2642016wmi.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hT0B8c52JW1mUBzht1lXIfl0L1BXOGqWknjA/tnJ2Qo=;
 b=EMgTWerTnHZw9W4US7EhrjC6Aar/RnGTaoK2p8EtIY9DvHQG2Q750a1NruMaqMge9u
 dhfC67J65ZCBm/vpUI8jX2ZIPkTADyCK+4BWsq57JQ+NHLU/4bn/NQU9lwK5efPMJOjx
 RmTNsZ6Fxu5HQVLrRG2ZTpY0hhGEfVe1VlypTrvL/6r5trCz33uhoQMGH/Zd/FiTxVcM
 vjer9XFpwFwrt3H4dJN0KdZo1/rRA2mKICzG3WDEI2qpHH3TIUnVNYLJ290y0ZgNiohQ
 XZIey07icLBHMhTxBa7npVAuTC79qQswSgNIYw6v+D6kDgG6ttCPNn1/27cN/dlGn0DK
 aKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=hT0B8c52JW1mUBzht1lXIfl0L1BXOGqWknjA/tnJ2Qo=;
 b=acWdGR7ZBg/kI7v2MfDdEQ7byBOs+HFoaek4/mYgGgsLf7A9GsxvRq1AZlk3E3mAdl
 iZ0cv6R4hxkehBsVcdlz+4AFPb6qY20Q+E6oap7uyZsfdE+q56+YOWHNqof2Pu47NxTP
 p+TXXrUCZ13VpZVYiGVNRztz4xFHQFfcVMNXzxk/sACxTUbkIqA+E5sEjnEMdS/zyltD
 q8a+qXMx524KI/fej2RXxT17M/ZzKa4qKMWlWsVKsusgDKsuhuc45TI+WSBHGdvHH48z
 br9m7iUYuhecd1O6gFBcDMYU6qanKKcKiVmGtuVZiHVEqiooc4FzRvijLeUiCubJeePg
 CBag==
X-Gm-Message-State: APjAAAW1rVRitYEGsK/34+KI8M6f61g7D9z1JmoF3r7n07gAsZHmiboB
 I0lLxp3cWAfVMKEsw3woub6UfAkI
X-Google-Smtp-Source: APXvYqz6/h7jEvKeSMWF7f/Y9V1ERz020TgsVuI7YGLru0jqYFr6BT5n8WuP/Mjhv3uJa/32CFUxyw==
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr4318681wmc.124.1579787347492; 
 Thu, 23 Jan 2020 05:49:07 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/59] cpu: Use cpu_class_set_parent_reset()
Date: Thu, 23 Jan 2020 14:48:05 +0100
Message-Id: <1579787342-27146-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Convert all targets to use cpu_class_set_parent_reset() with the following
coccinelle script:

@@
type CPUParentClass;
CPUParentClass *pcc;
CPUClass *cc;
identifier parent_fn;
identifier child_fn;
@@
+cpu_class_set_parent_reset(cc, child_fn, &pcc->parent_fn);
-pcc->parent_fn = cc->reset;
...
-cc->reset = child_fn;

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <157650847817.354886.7047137349018460524.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/cpu.c                | 3 +--
 target/cris/cpu.c               | 3 +--
 target/i386/cpu.c               | 3 +--
 target/lm32/cpu.c               | 3 +--
 target/m68k/cpu.c               | 3 +--
 target/microblaze/cpu.c         | 3 +--
 target/mips/cpu.c               | 3 +--
 target/moxie/cpu.c              | 3 +--
 target/nios2/cpu.c              | 3 +--
 target/openrisc/cpu.c           | 3 +--
 target/ppc/translate_init.inc.c | 3 +--
 target/riscv/cpu.c              | 3 +--
 target/s390x/cpu.c              | 3 +--
 target/sh4/cpu.c                | 3 +--
 target/sparc/cpu.c              | 3 +--
 target/tilegx/cpu.c             | 3 +--
 target/tricore/cpu.c            | 3 +--
 target/xtensa/cpu.c             | 3 +--
 18 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d62fd5f..411faaa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2707,8 +2707,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
     dc->props = arm_cpu_properties;
 
-    acc->parent_reset = cc->reset;
-    cc->reset = arm_cpu_reset;
+    cpu_class_set_parent_reset(cc, arm_cpu_reset, &acc->parent_reset);
 
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 6a857f5..17c6712 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -264,8 +264,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, cris_cpu_realizefn,
                                     &ccc->parent_realize);
 
-    ccc->parent_reset = cc->reset;
-    cc->reset = cris_cpu_reset;
+    cpu_class_set_parent_reset(cc, cris_cpu_reset, &ccc->parent_reset);
 
     cc->class_by_name = cris_cpu_class_by_name;
     cc->has_work = cris_cpu_has_work;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 41f28ce..78bdb7c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7149,8 +7149,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
                                       &xcc->parent_unrealize);
     dc->props = x86_cpu_properties;
 
-    xcc->parent_reset = cc->reset;
-    cc->reset = x86_cpu_reset;
+    cpu_class_set_parent_reset(cc, x86_cpu_reset, &xcc->parent_reset);
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b35537d..687bf35 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -218,8 +218,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, lm32_cpu_realizefn,
                                     &lcc->parent_realize);
-    lcc->parent_reset = cc->reset;
-    cc->reset = lm32_cpu_reset;
+    cpu_class_set_parent_reset(cc, lm32_cpu_reset, &lcc->parent_reset);
 
     cc->class_by_name = lm32_cpu_class_by_name;
     cc->has_work = lm32_cpu_has_work;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f276335..f0653cd 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -273,8 +273,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 
     device_class_set_parent_realize(dc, m68k_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset = cc->reset;
-    cc->reset = m68k_cpu_reset;
+    cpu_class_set_parent_reset(cc, m68k_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9cfd744..71d88f6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -292,8 +292,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, mb_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset = cc->reset;
-    cc->reset = mb_cpu_reset;
+    cpu_class_set_parent_reset(cc, mb_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbcf7ca..6cd6b96 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -189,8 +189,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset = cc->reset;
-    cc->reset = mips_cpu_reset;
+    cpu_class_set_parent_reset(cc, mips_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 48996d0..cf47bc7 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -101,8 +101,7 @@ static void moxie_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, moxie_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset = cc->reset;
-    cc->reset = moxie_cpu_reset;
+    cpu_class_set_parent_reset(cc, moxie_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = moxie_cpu_class_by_name;
 
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index ca9c7a6..bbdbc0c 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -188,8 +188,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, nios2_cpu_realizefn,
                                     &ncc->parent_realize);
     dc->props = nios2_properties;
-    ncc->parent_reset = cc->reset;
-    cc->reset = nios2_cpu_reset;
+    cpu_class_set_parent_reset(cc, nios2_cpu_reset, &ncc->parent_reset);
 
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 506aec6..5cd04da 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -150,8 +150,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
                                     &occ->parent_realize);
-    occ->parent_reset = cc->reset;
-    cc->reset = openrisc_cpu_reset;
+    cpu_class_set_parent_reset(cc, openrisc_cpu_reset, &occ->parent_reset);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d33d65d..5ffd07c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10873,8 +10873,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_always;
     dc->props = ppc_cpu_properties;
 
-    pcc->parent_reset = cc->reset;
-    cc->reset = ppc_cpu_reset;
+    cpu_class_set_parent_reset(cc, ppc_cpu_reset, &pcc->parent_reset);
 
     cc->class_by_name = ppc_cpu_class_by_name;
     pcc->parent_parse_features = cc->parse_features;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d37861a..d6f1872 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -462,8 +462,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, riscv_cpu_realize,
                                     &mcc->parent_realize);
 
-    mcc->parent_reset = cc->reset;
-    cc->reset = riscv_cpu_reset;
+    cpu_class_set_parent_reset(cc, riscv_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work = riscv_cpu_has_work;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 625daee..ca487f5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -456,12 +456,11 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     dc->props = s390x_cpu_properties;
     dc->user_creatable = true;
 
-    scc->parent_reset = cc->reset;
+    cpu_class_set_parent_reset(cc, s390_cpu_reset_full, &scc->parent_reset);
 #if !defined(CONFIG_USER_ONLY)
     scc->load_normal = s390_cpu_load_normal;
 #endif
     scc->reset = s390_cpu_reset;
-    cc->reset = s390_cpu_reset_full;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
 #ifdef CONFIG_TCG
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index d0a7707..70c8d81 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -214,8 +214,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, superh_cpu_realizefn,
                                     &scc->parent_realize);
 
-    scc->parent_reset = cc->reset;
-    cc->reset = superh_cpu_reset;
+    cpu_class_set_parent_reset(cc, superh_cpu_reset, &scc->parent_reset);
 
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bc65929..9c306e5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -859,8 +859,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
                                     &scc->parent_realize);
     dc->props = sparc_cpu_properties;
 
-    scc->parent_reset = cc->reset;
-    cc->reset = sparc_cpu_reset;
+    cpu_class_set_parent_reset(cc, sparc_cpu_reset, &scc->parent_reset);
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 2b2a7cc..cd422a0 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -142,8 +142,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
                                     &tcc->parent_realize);
 
-    tcc->parent_reset = cc->reset;
-    cc->reset = tilegx_cpu_reset;
+    cpu_class_set_parent_reset(cc, tilegx_cpu_reset, &tcc->parent_reset);
 
     cc->class_by_name = tilegx_cpu_class_by_name;
     cc->has_work = tilegx_cpu_has_work;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index df807c1..85bc9f0 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -153,8 +153,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, tricore_cpu_realizefn,
                                     &mcc->parent_realize);
 
-    mcc->parent_reset = cc->reset;
-    cc->reset = tricore_cpu_reset;
+    cpu_class_set_parent_reset(cc, tricore_cpu_reset, &mcc->parent_reset);
     cc->class_by_name = tricore_cpu_class_by_name;
     cc->has_work = tricore_cpu_has_work;
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c65dcf9..4856aee 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -184,8 +184,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
                                     &xcc->parent_realize);
 
-    xcc->parent_reset = cc->reset;
-    cc->reset = xtensa_cpu_reset;
+    cpu_class_set_parent_reset(cc, xtensa_cpu_reset, &xcc->parent_reset);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work = xtensa_cpu_has_work;
-- 
1.8.3.1



