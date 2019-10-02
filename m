Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C094C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C5D2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr9czxqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C5D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiCv-00059v-SZ
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrT-0005dI-Sh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrS-0003Za-Mj
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrS-0003Yf-GR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id l3so20477996wru.7
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Iv7FZBtE0/TX/BiHDid9YIJYTMNpsBZPGfCkSfXKG8A=;
 b=Sr9czxqnWw8POXU3b8S1X3P8AfMAN71pdD2HwtRWUPv3NgdmRri6i2EXQjyolPfxZp
 S/DbTdm84l4llCSuzX12RawsZtHNHC4Hnp9UIKetulpb3x/hphBNbLpWy2/CKKIJ6tuQ
 oKCcG3hjhujBa+TJN8HN9VYvGnWc0AUSNQIUwUt9FXODZDuAC4SwqjbKW2GCG+jpSscZ
 QH5qSQUk5Rd/Y0dw3E//WRS/47mOXZPL1pmgCPiwl5wa3NX02xe+RySWZoO0N4Q+g7Yv
 4OITVTMQMd87K4rhD9Q2oln2Bb9a/hoxJ2V3oFXpir1PM0pGhIBVcLIrQVuQRN3x9F0Q
 1nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Iv7FZBtE0/TX/BiHDid9YIJYTMNpsBZPGfCkSfXKG8A=;
 b=IaLgYs6p1Zvlnx3TdnAporTRvFq3zd5gVOzUhOByo+L3oZOQAtVqxL4WYoI0cA4vpG
 oMT4mEBbmPijX5h2eF5u7DAMlx322aXdUtfLwmCL1eGhWcfITgWlo3MOBJAZxfS2VMJY
 9mIb5ChQ/LrdDPqbFyuWoweE8R7c/jsin2XT1ROz/7lns5wzfzV+aXUwchHlrST021xR
 89oErCNL+/pkIDPoi9hwiN6/nE3Mt9SNq6RCiiC1JxOB23LijD7GeOA4MyZEd3H6ZhpQ
 +TzIgzPBgoxX6qgzeM5ylXw/LvQkEAsqnrKM2e8C7pJYN2RT6AiKfJwAqMlJUXgBPPiC
 iyLA==
X-Gm-Message-State: APjAAAXYaC1GkBQcofJYZauWpaUceLydviEQyhGlqiLSM8fAcglX7N5O
 rZOsye5w9wKApH8XNDhmkGGapQUk
X-Google-Smtp-Source: APXvYqxt1HTf7IY12qsLPgIF+Mt2M2cat/FxmRwf1SNgqi45ClSfAH23MBKgFD8zcpqIeYN0sy4s5Q==
X-Received: by 2002:a5d:60c8:: with SMTP id x8mr1090729wrt.107.1570035141202; 
 Wed, 02 Oct 2019 09:52:21 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/30] Fix wrong behavior of cpu_memory_rw_debug() function in
 SMM
Date: Wed,  2 Oct 2019 18:51:48 +0200
Message-Id: <1570035113-56848-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Dmitry Poletaev <poletaev@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dmitry Poletaev <poletaev@ispras.ru>

There is a problem, that you don't have access to the data using cpu_memory_rw_debug() function when in SMM. You can't remotely debug SMM mode program because of that for example.
Likely attrs version of get_phys_page_debug should be used to get correct asidx at the end to handle access properly.
Here the patch to fix it.

Signed-off-by: Dmitry Poletaev <poletaev@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c    | 2 +-
 target/i386/cpu.h    | 3 ++-
 target/i386/helper.c | 5 ++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 313a2ef..8fcb571 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6245,7 +6245,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
-    cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
+    cc->get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug;
     cc->write_elf64_note = x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote = x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note = x86_cpu_write_elf32_note;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 033991c..eaa5395 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1690,7 +1690,8 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
-hwaddr x86_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+                                         MemTxAttrs *attrs);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 0fa51be..c3a6e4f 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -715,7 +715,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+                                         MemTxAttrs *attrs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -725,6 +726,8 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     uint32_t page_offset;
     int page_size;
 
+    *attrs = cpu_get_mem_attrs(env);
+
     a20_mask = x86_get_a20_mask(env);
     if (!(env->cr[0] & CR0_PG_MASK)) {
         pte = addr & a20_mask;
-- 
1.8.3.1



