Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE3C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3233207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSfQr/Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3233207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRA0U-0001Vv-T6
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lM-0004E8-Oz
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lG-0006gf-5q
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXPn5xUii74xjS11lNjd9K5XsnfvPdvjfLKTDJanCHw=;
 b=MSfQr/EozVE/ZiDiegpeHZ//siYNhipQ2ecPIT9lGYdfZztHg183iSj62ex2mF/W0oxYWk
 x511Qjqub4ZtosTjjPY45XtWyHwk93TP6zv7pVW0bfUFSlA+NVC/kThlHQ58d2R3y4VM/N
 H/HG62wrBmeG/BE+h9fPi82rUulYEnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-v9YWYAgzP-KM74jQCJ_Ztg-1; Sat, 10 Oct 2020 03:57:45 -0400
X-MC-Unique: v9YWYAgzP-KM74jQCJ_Ztg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E6A51868434
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C26AE6EF4F
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/39] exec: split out non-softmmu-specific parts
Date: Sat, 10 Oct 2020 03:57:12 -0400
Message-Id: <20201010075739.951385-13-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Over the years, most parts of exec.c that were not specific to softmmu
have been moved to accel/tcg; what's left is mostly the low-level part
of the memory API, which includes RAMBlock and AddressSpaceDispatch.
However exec.c also hosts 4-500 lines of code for the target specific
parts of the CPU QOM object, plus a few functions for user-mode
emulation that do not have a better place (they are not TCG-specific so
accel/tcg/user-exec.c is not a good place either).

Move these parts to a new file, so that exec.c can be moved to
softmmu/physmem.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                 |   4 +-
 cpu.c                       | 452 +++++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h   |   3 +
 meson.build                 |   2 +-
 softmmu/meson.build         |   3 +-
 exec.c => softmmu/physmem.c | 454 +-----------------------------------
 6 files changed, 467 insertions(+), 451 deletions(-)
 create mode 100644 cpu.c
 rename exec.c => softmmu/physmem.c (91%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dda54f000d..7ef459a33c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -117,7 +117,6 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: softmmu/cpus.c
 F: cpus-common.c
-F: exec.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: scripts/decodetree.py
@@ -1525,6 +1524,7 @@ Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+F: cpu.c
 F: hw/core/cpu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
@@ -2284,8 +2284,8 @@ F: include/exec/ramblock.h
 F: softmmu/dma-helpers.c
 F: softmmu/ioport.c
 F: softmmu/memory.c
+F: softmmu/physmem.c
 F: include/exec/memory-internal.h
-F: exec.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 SPICE
diff --git a/cpu.c b/cpu.c
new file mode 100644
index 0000000000..0be5dcb6f3
--- /dev/null
+++ b/cpu.c
@@ -0,0 +1,452 @@
+/*
+ * Target-specific parts of the CPU object
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+
+#include "exec/target_page.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "qemu/error-report.h"
+#include "migration/vmstate.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu.h"
+#else
+#include "exec/address-spaces.h"
+#endif
+#include "sysemu/tcg.h"
+#include "sysemu/kvm.h"
+#include "sysemu/replay.h"
+#include "translate-all.h"
+#include "exec/log.h"
+
+uintptr_t qemu_host_page_size;
+intptr_t qemu_host_page_mask;
+
+#ifndef CONFIG_USER_ONLY
+static int cpu_common_post_load(void *opaque, int version_id)
+{
+    CPUState *cpu = opaque;
+
+    /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+       version_id is increased. */
+    cpu->interrupt_request &= ~0x01;
+    tlb_flush(cpu);
+
+    /* loadvm has just updated the content of RAM, bypassing the
+     * usual mechanisms that ensure we flush TBs for writes to
+     * memory we've translated code from. So we must flush all TBs,
+     * which will now be stale.
+     */
+    tb_flush(cpu);
+
+    return 0;
+}
+
+static int cpu_common_pre_load(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    cpu->exception_index = -1;
+
+    return 0;
+}
+
+static bool cpu_common_exception_index_needed(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    return tcg_enabled() && cpu->exception_index != -1;
+}
+
+static const VMStateDescription vmstate_cpu_common_exception_index = {
+    .name = "cpu_common/exception_index",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_common_exception_index_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(exception_index, CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cpu_common_crash_occurred_needed(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    return cpu->crash_occurred;
+}
+
+static const VMStateDescription vmstate_cpu_common_crash_occurred = {
+    .name = "cpu_common/crash_occurred",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_common_crash_occurred_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(crash_occurred, CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_cpu_common = {
+    .name = "cpu_common",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = cpu_common_pre_load,
+    .post_load = cpu_common_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(halted, CPUState),
+        VMSTATE_UINT32(interrupt_request, CPUState),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_cpu_common_exception_index,
+        &vmstate_cpu_common_crash_occurred,
+        NULL
+    }
+};
+#endif
+
+void cpu_exec_unrealizefn(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    tlb_destroy(cpu);
+    cpu_list_remove(cpu);
+
+#ifdef CONFIG_USER_ONLY
+    assert(cc->vmsd == NULL);
+#else
+    if (cc->vmsd != NULL) {
+        vmstate_unregister(NULL, cc->vmsd, cpu);
+    }
+    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
+        vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
+    }
+    tcg_iommu_free_notifier_list(cpu);
+#endif
+}
+
+Property cpu_common_props[] = {
+#ifndef CONFIG_USER_ONLY
+    /* Create a memory property for softmmu CPU object,
+     * so users can wire up its memory. (This can't go in hw/core/cpu.c
+     * because that file is compiled only once for both user-mode
+     * and system builds.) The default if no link is set up is to use
+     * the system address space.
+     */
+    DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+#endif
+    DEFINE_PROP_BOOL("start-powered-off", CPUState, start_powered_off, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+void cpu_exec_initfn(CPUState *cpu)
+{
+    cpu->as = NULL;
+    cpu->num_ases = 0;
+
+#ifndef CONFIG_USER_ONLY
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->memory = get_system_memory();
+    object_ref(OBJECT(cpu->memory));
+#endif
+}
+
+void cpu_exec_realizefn(CPUState *cpu, Error **errp)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    static bool tcg_target_initialized;
+
+    cpu_list_add(cpu);
+
+    if (tcg_enabled() && !tcg_target_initialized) {
+        tcg_target_initialized = true;
+        cc->tcg_initialize();
+    }
+    tlb_init(cpu);
+
+    qemu_plugin_vcpu_init_hook(cpu);
+
+#ifdef CONFIG_USER_ONLY
+    assert(cc->vmsd == NULL);
+#else /* !CONFIG_USER_ONLY */
+    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
+        vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
+    }
+    if (cc->vmsd != NULL) {
+        vmstate_register(NULL, cpu->cpu_index, cc->vmsd, cpu);
+    }
+
+    tcg_iommu_init_notifier_list(cpu);
+#endif
+}
+
+const char *parse_cpu_option(const char *cpu_option)
+{
+    ObjectClass *oc;
+    CPUClass *cc;
+    gchar **model_pieces;
+    const char *cpu_type;
+
+    model_pieces = g_strsplit(cpu_option, ",", 2);
+    if (!model_pieces[0]) {
+        error_report("-cpu option cannot be empty");
+        exit(1);
+    }
+
+    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    if (oc == NULL) {
+        error_report("unable to find CPU model '%s'", model_pieces[0]);
+        g_strfreev(model_pieces);
+        exit(EXIT_FAILURE);
+    }
+
+    cpu_type = object_class_get_name(oc);
+    cc = CPU_CLASS(oc);
+    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
+    g_strfreev(model_pieces);
+    return cpu_type;
+}
+
+#if defined(CONFIG_USER_ONLY)
+void tb_invalidate_phys_addr(target_ulong addr)
+{
+    mmap_lock();
+    tb_invalidate_phys_page_range(addr, addr + 1);
+    mmap_unlock();
+}
+
+static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
+{
+    tb_invalidate_phys_addr(pc);
+}
+#else
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
+{
+    ram_addr_t ram_addr;
+    MemoryRegion *mr;
+    hwaddr l = 1;
+
+    if (!tcg_enabled()) {
+        return;
+    }
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
+    if (!(memory_region_is_ram(mr)
+          || memory_region_is_romd(mr))) {
+        return;
+    }
+    ram_addr = memory_region_get_ram_addr(mr) + addr;
+    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
+}
+
+static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
+{
+    /*
+     * There may not be a virtual to physical translation for the pc
+     * right now, but there may exist cached TB for this pc.
+     * Flush the whole TB cache to force re-translation of such TBs.
+     * This is heavyweight, but we're debugging anyway.
+     */
+    tb_flush(cpu);
+}
+#endif
+
+/* Add a breakpoint.  */
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+                          CPUBreakpoint **breakpoint)
+{
+    CPUBreakpoint *bp;
+
+    bp = g_malloc(sizeof(*bp));
+
+    bp->pc = pc;
+    bp->flags = flags;
+
+    /* keep all GDB-injected breakpoints in front */
+    if (flags & BP_GDB) {
+        QTAILQ_INSERT_HEAD(&cpu->breakpoints, bp, entry);
+    } else {
+        QTAILQ_INSERT_TAIL(&cpu->breakpoints, bp, entry);
+    }
+
+    breakpoint_invalidate(cpu, pc);
+
+    if (breakpoint) {
+        *breakpoint = bp;
+    }
+    return 0;
+}
+
+/* Remove a specific breakpoint.  */
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
+{
+    CPUBreakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+        if (bp->pc == pc && bp->flags == flags) {
+            cpu_breakpoint_remove_by_ref(cpu, bp);
+            return 0;
+        }
+    }
+    return -ENOENT;
+}
+
+/* Remove a specific breakpoint by reference.  */
+void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint)
+{
+    QTAILQ_REMOVE(&cpu->breakpoints, breakpoint, entry);
+
+    breakpoint_invalidate(cpu, breakpoint->pc);
+
+    g_free(breakpoint);
+}
+
+/* Remove all matching breakpoints. */
+void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
+{
+    CPUBreakpoint *bp, *next;
+
+    QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
+        if (bp->flags & mask) {
+            cpu_breakpoint_remove_by_ref(cpu, bp);
+        }
+    }
+}
+
+/* enable or disable single step mode. EXCP_DEBUG is returned by the
+   CPU loop after each instruction */
+void cpu_single_step(CPUState *cpu, int enabled)
+{
+    if (cpu->singlestep_enabled != enabled) {
+        cpu->singlestep_enabled = enabled;
+        if (kvm_enabled()) {
+            kvm_update_guest_debug(cpu, 0);
+        } else {
+            /* must flush all the translated code to avoid inconsistencies */
+            /* XXX: only flush what is necessary */
+            tb_flush(cpu);
+        }
+    }
+}
+
+void cpu_abort(CPUState *cpu, const char *fmt, ...)
+{
+    va_list ap;
+    va_list ap2;
+
+    va_start(ap, fmt);
+    va_copy(ap2, ap);
+    fprintf(stderr, "qemu: fatal: ");
+    vfprintf(stderr, fmt, ap);
+    fprintf(stderr, "\n");
+    cpu_dump_state(cpu, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+    if (qemu_log_separate()) {
+        FILE *logfile = qemu_log_lock();
+        qemu_log("qemu: fatal: ");
+        qemu_log_vprintf(fmt, ap2);
+        qemu_log("\n");
+        log_cpu_state(cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_flush();
+        qemu_log_unlock(logfile);
+        qemu_log_close();
+    }
+    va_end(ap2);
+    va_end(ap);
+    replay_finish();
+#if defined(CONFIG_USER_ONLY)
+    {
+        struct sigaction act;
+        sigfillset(&act.sa_mask);
+        act.sa_handler = SIG_DFL;
+        act.sa_flags = 0;
+        sigaction(SIGABRT, &act, NULL);
+    }
+#endif
+    abort();
+}
+
+/* physical memory access (slow version, mainly for debug) */
+#if defined(CONFIG_USER_ONLY)
+int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
+                        void *ptr, target_ulong len, bool is_write)
+{
+    int flags;
+    target_ulong l, page;
+    void * p;
+    uint8_t *buf = ptr;
+
+    while (len > 0) {
+        page = addr & TARGET_PAGE_MASK;
+        l = (page + TARGET_PAGE_SIZE) - addr;
+        if (l > len)
+            l = len;
+        flags = page_get_flags(page);
+        if (!(flags & PAGE_VALID))
+            return -1;
+        if (is_write) {
+            if (!(flags & PAGE_WRITE))
+                return -1;
+            /* XXX: this code should not depend on lock_user */
+            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
+                return -1;
+            memcpy(p, buf, l);
+            unlock_user(p, addr, l);
+        } else {
+            if (!(flags & PAGE_READ))
+                return -1;
+            /* XXX: this code should not depend on lock_user */
+            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
+                return -1;
+            memcpy(buf, p, l);
+            unlock_user(p, addr, 0);
+        }
+        len -= l;
+        buf += l;
+        addr += l;
+    }
+    return 0;
+}
+#endif
+
+bool target_words_bigendian(void)
+{
+#if defined(TARGET_WORDS_BIGENDIAN)
+    return true;
+#else
+    return false;
+#endif
+}
+
+void page_size_init(void)
+{
+    /* NOTE: we can always suppose that qemu_host_page_size >=
+       TARGET_PAGE_SIZE */
+    if (qemu_host_page_size == 0) {
+        qemu_host_page_size = qemu_real_host_page_size;
+    }
+    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
+        qemu_host_page_size = TARGET_PAGE_SIZE;
+    }
+    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
+}
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index d5e285d2b5..19805ed6db 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -14,6 +14,9 @@ void cpu_list_unlock(void);
 
 void tcg_flush_softmmu_tlb(CPUState *cs);
 
+void tcg_iommu_init_notifier_list(CPUState *cpu);
+void tcg_iommu_free_notifier_list(CPUState *cpu);
+
 #if !defined(CONFIG_USER_ONLY)
 
 enum device_endian {
diff --git a/meson.build b/meson.build
index a280e4cf21..26230614ba 100644
--- a/meson.build
+++ b/meson.build
@@ -1372,7 +1372,7 @@ common_ss.add(files('cpus-common.c'))
 subdir('softmmu')
 
 common_ss.add(capstone)
-specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone, libpmem, libdaxctl)
+specific_ss.add(files('cpu.c', 'disas.c', 'gdbstub.c'), capstone)
 specific_ss.add(files('exec-vary.c'))
 specific_ss.add(when: 'CONFIG_TCG', if_true: files(
   'fpu/softfloat.c',
diff --git a/softmmu/meson.build b/softmmu/meson.build
index 862ab24878..8f7210b4f0 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -3,6 +3,7 @@ specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files(
   'balloon.c',
   'cpus.c',
   'cpu-throttle.c',
+  'physmem.c',
   'ioport.c',
   'memory.c',
   'memory_mapping.c',
@@ -19,7 +20,7 @@ softmmu_ss.add(files(
   'bootdevice.c',
   'dma-helpers.c',
   'qdev-monitor.c',
-), sdl)
+), sdl, libpmem, libdaxctl)
 
 softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
 softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
diff --git a/exec.c b/softmmu/physmem.c
similarity index 91%
rename from exec.c
rename to softmmu/physmem.c
index bca441f7fd..e319fb2a1e 100644
--- a/exec.c
+++ b/softmmu/physmem.c
@@ -1,5 +1,5 @@
 /*
- *  Virtual page mapping
+ * RAM allocation and memory access
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
@@ -28,10 +28,8 @@
 #include "tcg/tcg.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
-#if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
 #include "hw/xen/xen.h"
-#endif
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
@@ -40,9 +38,6 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
-#if defined(CONFIG_USER_ONLY)
-#include "qemu.h"
-#else /* !CONFIG_USER_ONLY */
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
@@ -56,7 +51,6 @@
 #include <linux/falloc.h>
 #endif
 
-#endif
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
 #include "translate-all.h"
@@ -83,7 +77,6 @@
 
 //#define DEBUG_SUBPAGE
 
-#if !defined(CONFIG_USER_ONLY)
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
  * are protected by the ramlist lock.
  */
@@ -96,12 +89,6 @@ AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
 static MemoryRegion io_mem_unassigned;
-#endif
-
-uintptr_t qemu_host_page_size;
-intptr_t qemu_host_page_mask;
-
-#if !defined(CONFIG_USER_ONLY)
 
 typedef struct PhysPageEntry PhysPageEntry;
 
@@ -179,10 +166,6 @@ struct DirtyBitmapSnapshot {
     unsigned long dirty[];
 };
 
-#endif
-
-#if !defined(CONFIG_USER_ONLY)
-
 static void phys_map_node_reserve(PhysPageMap *map, unsigned nodes)
 {
     static unsigned alloc_hint = 16;
@@ -661,7 +644,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     }
 }
 
-static void tcg_iommu_free_notifier_list(CPUState *cpu)
+void tcg_iommu_free_notifier_list(CPUState *cpu)
 {
     /* Destroy the CPU's notifier list */
     int i;
@@ -675,6 +658,11 @@ static void tcg_iommu_free_notifier_list(CPUState *cpu)
     g_array_free(cpu->iommu_notifiers, true);
 }
 
+void tcg_iommu_init_notifier_list(CPUState *cpu)
+{
+    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
+}
+
 /* Called from RCU critical section */
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
@@ -732,91 +720,6 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
 translate_fail:
     return &d->map.sections[PHYS_SECTION_UNASSIGNED];
 }
-#endif
-
-#if !defined(CONFIG_USER_ONLY)
-
-static int cpu_common_post_load(void *opaque, int version_id)
-{
-    CPUState *cpu = opaque;
-
-    /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-       version_id is increased. */
-    cpu->interrupt_request &= ~0x01;
-    tlb_flush(cpu);
-
-    /* loadvm has just updated the content of RAM, bypassing the
-     * usual mechanisms that ensure we flush TBs for writes to
-     * memory we've translated code from. So we must flush all TBs,
-     * which will now be stale.
-     */
-    tb_flush(cpu);
-
-    return 0;
-}
-
-static int cpu_common_pre_load(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    cpu->exception_index = -1;
-
-    return 0;
-}
-
-static bool cpu_common_exception_index_needed(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    return tcg_enabled() && cpu->exception_index != -1;
-}
-
-static const VMStateDescription vmstate_cpu_common_exception_index = {
-    .name = "cpu_common/exception_index",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = cpu_common_exception_index_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT32(exception_index, CPUState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static bool cpu_common_crash_occurred_needed(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    return cpu->crash_occurred;
-}
-
-static const VMStateDescription vmstate_cpu_common_crash_occurred = {
-    .name = "cpu_common/crash_occurred",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = cpu_common_crash_occurred_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_BOOL(crash_occurred, CPUState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-const VMStateDescription vmstate_cpu_common = {
-    .name = "cpu_common",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_load = cpu_common_pre_load,
-    .post_load = cpu_common_post_load,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT32(halted, CPUState),
-        VMSTATE_UINT32(interrupt_request, CPUState),
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections = (const VMStateDescription*[]) {
-        &vmstate_cpu_common_exception_index,
-        &vmstate_cpu_common_crash_occurred,
-        NULL
-    }
-};
 
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
@@ -860,155 +763,7 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
     /* Return the AddressSpace corresponding to the specified index */
     return cpu->cpu_ases[asidx].as;
 }
-#endif
-
-void cpu_exec_unrealizefn(CPUState *cpu)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    tlb_destroy(cpu);
-    cpu_list_remove(cpu);
-
-    if (cc->vmsd != NULL) {
-        vmstate_unregister(NULL, cc->vmsd, cpu);
-    }
-    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-        vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
-    }
-#ifndef CONFIG_USER_ONLY
-    tcg_iommu_free_notifier_list(cpu);
-#endif
-}
-
-Property cpu_common_props[] = {
-#ifndef CONFIG_USER_ONLY
-    /* Create a memory property for softmmu CPU object,
-     * so users can wire up its memory. (This can't go in hw/core/cpu.c
-     * because that file is compiled only once for both user-mode
-     * and system builds.) The default if no link is set up is to use
-     * the system address space.
-     */
-    DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
-#endif
-    DEFINE_PROP_BOOL("start-powered-off", CPUState, start_powered_off, false),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-void cpu_exec_initfn(CPUState *cpu)
-{
-    cpu->as = NULL;
-    cpu->num_ases = 0;
-
-#ifndef CONFIG_USER_ONLY
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->memory = system_memory;
-    object_ref(OBJECT(cpu->memory));
-#endif
-}
-
-void cpu_exec_realizefn(CPUState *cpu, Error **errp)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    static bool tcg_target_initialized;
-
-    cpu_list_add(cpu);
-
-    if (tcg_enabled() && !tcg_target_initialized) {
-        tcg_target_initialized = true;
-        cc->tcg_initialize();
-    }
-    tlb_init(cpu);
-
-    qemu_plugin_vcpu_init_hook(cpu);
-
-#ifdef CONFIG_USER_ONLY
-    assert(cc->vmsd == NULL);
-#else /* !CONFIG_USER_ONLY */
-    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-        vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
-    }
-    if (cc->vmsd != NULL) {
-        vmstate_register(NULL, cpu->cpu_index, cc->vmsd, cpu);
-    }
-
-    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
-#endif
-}
-
-const char *parse_cpu_option(const char *cpu_option)
-{
-    ObjectClass *oc;
-    CPUClass *cc;
-    gchar **model_pieces;
-    const char *cpu_type;
-
-    model_pieces = g_strsplit(cpu_option, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("-cpu option cannot be empty");
-        exit(1);
-    }
-
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
-    }
-
-    cpu_type = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
-    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-    return cpu_type;
-}
-
-#if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr)
-{
-    mmap_lock();
-    tb_invalidate_phys_page_range(addr, addr + 1);
-    mmap_unlock();
-}
-
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
-{
-    tb_invalidate_phys_addr(pc);
-}
-#else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
-{
-    ram_addr_t ram_addr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-
-    if (!tcg_enabled()) {
-        return;
-    }
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
-    if (!(memory_region_is_ram(mr)
-          || memory_region_is_romd(mr))) {
-        return;
-    }
-    ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
-}
 
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
-{
-    /*
-     * There may not be a virtual to physical translation for the pc
-     * right now, but there may exist cached TB for this pc.
-     * Flush the whole TB cache to force re-translation of such TBs.
-     * This is heavyweight, but we're debugging anyway.
-     */
-    tb_flush(cpu);
-}
-#endif
-
-#ifndef CONFIG_USER_ONLY
 /* Add a watchpoint.  */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint)
@@ -1117,123 +872,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
     }
     return ret;
 }
-#endif /* !CONFIG_USER_ONLY */
-
-/* Add a breakpoint.  */
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
-                          CPUBreakpoint **breakpoint)
-{
-    CPUBreakpoint *bp;
-
-    bp = g_malloc(sizeof(*bp));
-
-    bp->pc = pc;
-    bp->flags = flags;
-
-    /* keep all GDB-injected breakpoints in front */
-    if (flags & BP_GDB) {
-        QTAILQ_INSERT_HEAD(&cpu->breakpoints, bp, entry);
-    } else {
-        QTAILQ_INSERT_TAIL(&cpu->breakpoints, bp, entry);
-    }
-
-    breakpoint_invalidate(cpu, pc);
-
-    if (breakpoint) {
-        *breakpoint = bp;
-    }
-    return 0;
-}
-
-/* Remove a specific breakpoint.  */
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
-{
-    CPUBreakpoint *bp;
-
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        if (bp->pc == pc && bp->flags == flags) {
-            cpu_breakpoint_remove_by_ref(cpu, bp);
-            return 0;
-        }
-    }
-    return -ENOENT;
-}
 
-/* Remove a specific breakpoint by reference.  */
-void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint)
-{
-    QTAILQ_REMOVE(&cpu->breakpoints, breakpoint, entry);
-
-    breakpoint_invalidate(cpu, breakpoint->pc);
-
-    g_free(breakpoint);
-}
-
-/* Remove all matching breakpoints. */
-void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
-{
-    CPUBreakpoint *bp, *next;
-
-    QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
-        if (bp->flags & mask) {
-            cpu_breakpoint_remove_by_ref(cpu, bp);
-        }
-    }
-}
-
-/* enable or disable single step mode. EXCP_DEBUG is returned by the
-   CPU loop after each instruction */
-void cpu_single_step(CPUState *cpu, int enabled)
-{
-    if (cpu->singlestep_enabled != enabled) {
-        cpu->singlestep_enabled = enabled;
-        if (kvm_enabled()) {
-            kvm_update_guest_debug(cpu, 0);
-        } else {
-            /* must flush all the translated code to avoid inconsistencies */
-            /* XXX: only flush what is necessary */
-            tb_flush(cpu);
-        }
-    }
-}
-
-void cpu_abort(CPUState *cpu, const char *fmt, ...)
-{
-    va_list ap;
-    va_list ap2;
-
-    va_start(ap, fmt);
-    va_copy(ap2, ap);
-    fprintf(stderr, "qemu: fatal: ");
-    vfprintf(stderr, fmt, ap);
-    fprintf(stderr, "\n");
-    cpu_dump_state(cpu, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
-    if (qemu_log_separate()) {
-        FILE *logfile = qemu_log_lock();
-        qemu_log("qemu: fatal: ");
-        qemu_log_vprintf(fmt, ap2);
-        qemu_log("\n");
-        log_cpu_state(cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
-        qemu_log_flush();
-        qemu_log_unlock(logfile);
-        qemu_log_close();
-    }
-    va_end(ap2);
-    va_end(ap);
-    replay_finish();
-#if defined(CONFIG_USER_ONLY)
-    {
-        struct sigaction act;
-        sigfillset(&act.sa_mask);
-        act.sa_handler = SIG_DFL;
-        act.sa_flags = 0;
-        sigaction(SIGABRT, &act, NULL);
-    }
-#endif
-    abort();
-}
-
-#if !defined(CONFIG_USER_ONLY)
 /* Called from RCU critical section */
 static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
 {
@@ -1420,9 +1059,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
     return section - d->map.sections;
 }
-#endif /* defined(CONFIG_USER_ONLY) */
-
-#if !defined(CONFIG_USER_ONLY)
 
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
                             uint16_t section);
@@ -3023,52 +2659,6 @@ MemoryRegion *get_system_io(void)
     return system_io;
 }
 
-#endif /* !defined(CONFIG_USER_ONLY) */
-
-/* physical memory access (slow version, mainly for debug) */
-#if defined(CONFIG_USER_ONLY)
-int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, bool is_write)
-{
-    int flags;
-    target_ulong l, page;
-    void * p;
-    uint8_t *buf = ptr;
-
-    while (len > 0) {
-        page = addr & TARGET_PAGE_MASK;
-        l = (page + TARGET_PAGE_SIZE) - addr;
-        if (l > len)
-            l = len;
-        flags = page_get_flags(page);
-        if (!(flags & PAGE_VALID))
-            return -1;
-        if (is_write) {
-            if (!(flags & PAGE_WRITE))
-                return -1;
-            /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
-                return -1;
-            memcpy(p, buf, l);
-            unlock_user(p, addr, l);
-        } else {
-            if (!(flags & PAGE_READ))
-                return -1;
-            /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
-                return -1;
-            memcpy(buf, p, l);
-            unlock_user(p, addr, 0);
-        }
-        len -= l;
-        buf += l;
-        addr += l;
-    }
-    return 0;
-}
-
-#else
-
 static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
                                      hwaddr length)
 {
@@ -3857,18 +3447,7 @@ int qemu_target_page_bits_min(void)
 {
     return TARGET_PAGE_BITS_MIN;
 }
-#endif
-
-bool target_words_bigendian(void)
-{
-#if defined(TARGET_WORDS_BIGENDIAN)
-    return true;
-#else
-    return false;
-#endif
-}
 
-#ifndef CONFIG_USER_ONLY
 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
     MemoryRegion*mr;
@@ -3998,23 +3577,6 @@ bool ramblock_is_pmem(RAMBlock *rb)
     return rb->flags & RAM_PMEM;
 }
 
-#endif
-
-void page_size_init(void)
-{
-    /* NOTE: we can always suppose that qemu_host_page_size >=
-       TARGET_PAGE_SIZE */
-    if (qemu_host_page_size == 0) {
-        qemu_host_page_size = qemu_real_host_page_size;
-    }
-    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
-        qemu_host_page_size = TARGET_PAGE_SIZE;
-    }
-    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
-}
-
-#if !defined(CONFIG_USER_ONLY)
-
 static void mtree_print_phys_entries(int start, int end, int skip, int ptr)
 {
     if (start == end - 1) {
@@ -4147,5 +3709,3 @@ bool ram_block_discard_is_required(void)
 {
     return qatomic_read(&ram_block_discard_disabled) < 0;
 }
-
-#endif
-- 
2.26.2



