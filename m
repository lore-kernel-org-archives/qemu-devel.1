Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA51214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA51214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWzV-0007SP-VY
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <poletaev@ispras.ru>) id 1iAWsW-0007pG-NR
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <poletaev@ispras.ru>) id 1iAWsV-0002Ky-CA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:08:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33516)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <poletaev@ispras.ru>) id 1iAWsV-0002GY-5F
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:08:03 -0400
Received: from Dimon-PC.lan02.inno (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9261E5400FC;
 Wed, 18 Sep 2019 13:07:58 +0300 (MSK)
From: Dmitry Poletaev <poletaev@ispras.ru>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 13:07:06 +0300
Message-Id: <20190918100706.19753-1-poletaev@ispras.ru>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH] Fix wrong behavior of cpu_memory_rw_debug()
 function in SMM
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
Cc: pbonzini@redhat.com, Dmitry Poletaev <poletaev@ispras.ru>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a problem, that you don't have access to the data using cpu_memory_rw_debug() function when in SMM. You can't remotely debug SMM mode program because of that for example.
Likely attrs version of get_phys_page_debug should be used to get correct asidx at the end to handle access properly.
Here the patch to fix it.

Signed-off-by: Dmitry Poletaev <poletaev@ispras.ru>
---
 target/i386/cpu.c    | 2 +-
 target/i386/cpu.h    | 3 ++-
 target/i386/helper.c | 5 ++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e0bac31e8..8ade4ed2c6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5984,7 +5984,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
-    cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
+    cc->get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug;
     cc->write_elf64_note = x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote = x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note = x86_cpu_write_elf32_note;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5f6e3a029a..bbd00d8deb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1549,7 +1549,8 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
-hwaddr x86_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+                                         MemTxAttrs *attrs);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 0fa51be646..c3a6e4fabe 100644
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
2.11.0


