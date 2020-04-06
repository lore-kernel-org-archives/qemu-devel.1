Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96078C2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E44206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wJp5fvnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E44206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOJE-0006ct-EO
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGT-0001Qm-28
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGR-00023t-6l
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGQ-00022T-RS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369d1oB025216;
 Mon, 6 Apr 2020 09:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=sX/T02oeGexRf+emRO9VLnjkMC71nHIenHbZKIjsvEg=;
 b=wJp5fvnLESFjT83p7c5GkUQcTOATE//NAf4HpmiWJDde7AcUz0Nt8or1xHkNT0PywOpA
 FeB3pI68Km1USgpdF89QxNWLOl463P2GIm3u39D1F8xn9bWMdmuaEGGi0J0Z+MHe7fLP
 sbiYhmVjrCot8k9b8YhucCp3RyXC/SAmhw3mOzATeAScW6gsR5yH5Fehl99Ubhgwy7sE
 f1HJWF2vODGXpQJKT0XWrf44NESb19/kidC+uH4PU7CeV9Us41UhPqzNSO6RbycDlYYD
 UtrUiKuWYFk5zz3PV8qPmZORXuGxqjbRW+aAL2hVF0E7AV6VvEDZhQ0esaGGB2kfGH1R eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 306jvmwr3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cmYi092363;
 Mon, 6 Apr 2020 09:41:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 3073spk5pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369fkOK030577;
 Mon, 6 Apr 2020 09:41:46 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:45 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/36] multi-process: Add stub functions to facilate build
 of multi-process
Date: Mon,  6 Apr 2020 02:40:58 -0700
Message-Id: <3581740cf5a9eaca8c86bc28e75750be7e7b45e4.1586165555.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Add stub functions that are needed during compile time but not in
runtime.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS            |  3 ++
 accel/stubs/kvm-stub.c |  5 +++
 accel/stubs/tcg-stub.c | 98 ++++++++++++++++++++++++++++++++++++++++++
 stubs/audio.c          | 12 ++++++
 stubs/monitor.c        | 53 +++++++++++++++++++++++
 stubs/net-stub.c       | 31 +++++++++++++
 stubs/replay.c         | 14 ++++++
 stubs/vl-stub.c        | 79 ++++++++++++++++++++++++++++++++++
 stubs/vmstate.c        | 19 ++++++++
 stubs/xen-mapcache.c   | 22 ++++++++++
 10 files changed, 336 insertions(+)
 create mode 100644 stubs/audio.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/vl-stub.c
 create mode 100644 stubs/xen-mapcache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 611d9a64b0..ff59f60fdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -442,6 +442,7 @@ F: hw/pci-host/xen_igd_pt.c
 F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
+F: stubs/xen-mapcache.c
 
 Guest CPU Cores (HAXM)
 ---------------------
@@ -1898,6 +1899,7 @@ F: include/hw/audio/
 F: tests/qtest/ac97-test.c
 F: tests/qtest/es1370-test.c
 F: tests/qtest/intel-hda-test.c
+F: stubs/audio.c
 
 Block layer core
 M: Kevin Wolf <kwolf@redhat.com>
@@ -2119,6 +2121,7 @@ F: include/net/
 F: qemu-bridge-helper.c
 T: git https://github.com/jasowang/qemu.git net
 F: qapi/net.json
+F: stubs/net-stub.c
 
 Netmap network backend
 M: Luigi Rizzo <rizzo@iet.unipi.it>
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 82f118d2df..baa6b38da4 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -31,6 +31,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
+bool kvm_halt_in_kernel_allowed;
 
 int kvm_destroy_vcpu(CPUState *cpu)
 {
@@ -58,6 +59,10 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
 {
 }
 
+void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     abort();
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 677191a69c..2e4e8741fb 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,14 +11,112 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
+#include "translate-all.h"
+#include "exec/ram_addr.h"
+
+bool parallel_cpus;
 
 void tb_flush(CPUState *cpu)
 {
 }
 
+#ifdef CONFIG_MPQEMU
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
+{
+}
+
+void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end)
+{
+}
+
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end)
+{
+}
+
+void tb_invalidate_phys_page_fast(struct page_collection *pages,
+                                  tb_page_addr_t start, int len,
+                                  uintptr_t retaddr)
+{
+}
+
+void tlb_init(CPUState *cpu)
+{
+}
+
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
+
+void tlb_flush(CPUState *cpu)
+{
+}
+
+void tlb_flush_page(CPUState *cpu, target_ulong addr)
+{
+}
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
+{
+}
+
+void tcg_region_init(void)
+{
+}
+
+void tcg_register_thread(void)
+{
+}
+
+void tcg_flush_softmmu_tlb(CPUState *cs)
+{
+}
+
+void cpu_loop_exit_noexc(CPUState *cpu)
+{
+    cpu->exception_index = -1;
+    cpu_loop_exit(cpu);
+}
+
+void cpu_loop_exit(CPUState *cpu)
+{
+    cpu->can_do_io = 1;
+    siglongjmp(cpu->jmp_env, 1);
+}
+
+void cpu_reloading_memory_map(void)
+{
+}
+
+int cpu_exec(CPUState *cpu)
+{
+    return 0;
+}
+
+void cpu_exec_step_atomic(CPUState *cpu)
+{
+}
+
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
+{
+    return false;
+}
+
+void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
+{
+    cpu_loop_exit(cpu);
+}
+
+struct page_collection *
+page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
+{
+    return NULL;
+}
+
+void page_collection_unlock(struct page_collection *set)
+{
+}
+#endif
diff --git a/stubs/audio.c b/stubs/audio.c
new file mode 100644
index 0000000000..8ae3b0f568
--- /dev/null
+++ b/stubs/audio.c
@@ -0,0 +1,12 @@
+#include "qemu/osdep.h"
+#include "audio/audio.h"
+
+AudioState *audio_state_by_name(const char *name)
+{
+    return NULL;
+}
+
+const char *audio_get_id(QEMUSoundCard *card)
+{
+    return NULL;
+}
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 20786ac4ff..07b0bedaab 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -2,6 +2,28 @@
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "../monitor/monitor-internal.h"
+#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-types-qom.h"
+#include "qapi/qapi-commands-qdev.h"
+#include "hw/qdev-core.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
+#include "monitor/hmp.h"
+
+#pragma weak hmp_handle_error
+#pragma weak cur_mon
+#pragma weak monitor_vprintf
+#pragma weak monitor_printf
+#pragma weak monitor_cur_is_qmp
+#pragma weak qmp_device_list_properties
+
+__thread Monitor *cur_mon;
+
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    abort();
+}
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
@@ -16,3 +38,34 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 void monitor_fdsets_cleanup(void)
 {
 }
+
+int monitor_get_cpu_index(void)
+{
+    return -ENOSYS;
+}
+int monitor_printf(Monitor *mon, const char *fmt, ...)
+{
+    return -ENOSYS;
+}
+
+bool monitor_cur_is_qmp(void)
+{
+    return false;
+}
+
+ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
+                                                   Error **errp)
+{
+    return NULL;
+}
+
+VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
+                                                     VMChangeStateHandler *cb,
+                                                     void *opaque)
+{
+    return NULL;
+}
+
+void hmp_handle_error(Monitor *mon, Error *err)
+{
+}
diff --git a/stubs/net-stub.c b/stubs/net-stub.c
new file mode 100644
index 0000000000..cb2274ba40
--- /dev/null
+++ b/stubs/net-stub.c
@@ -0,0 +1,31 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "net/net.h"
+
+int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
+                                 NetClientDriver type, int max)
+{
+    return -ENOSYS;
+}
+
+NetClientState *net_hub_port_find(int hub_id)
+{
+    return NULL;
+}
+
+int net_hub_id_for_client(NetClientState *nc, int *id)
+{
+    return -ENOSYS;
+}
+
+int qemu_show_nic_models(const char *arg, const char *const *models)
+{
+    return -ENOSYS;
+}
+
+int qemu_find_nic_model(NICInfo *nd, const char * const *models,
+                        const char *default_model)
+{
+    return -ENOSYS;
+}
+
diff --git a/stubs/replay.c b/stubs/replay.c
index 5974ec1f50..2e3feee6a9 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -88,3 +88,17 @@ int replay_read_random(void *buf, size_t len)
 {
     return 0;
 }
+
+bool replay_has_checkpoint(void)
+{
+    return false;
+}
+
+int replay_get_instructions(void)
+{
+    return 0;
+}
+
+void replay_account_executed_instructions(void)
+{
+}
diff --git a/stubs/vl-stub.c b/stubs/vl-stub.c
new file mode 100644
index 0000000000..fff72be201
--- /dev/null
+++ b/stubs/vl-stub.c
@@ -0,0 +1,79 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/uuid.h"
+#include "sysemu/sysemu.h"
+#include "exec/cpu-common.h"
+#include "exec/gdbstub.h"
+#include "sysemu/replay.h"
+#include "disas/disas.h"
+#include "sysemu/runstate.h"
+
+bool tcg_allowed;
+bool xen_allowed;
+bool boot_strict;
+bool qemu_uuid_set;
+
+int mem_prealloc;
+int smp_cpus;
+int vga_interface_type = VGA_NONE;
+int smp_cores = 1;
+int smp_threads = 1;
+int icount_align_option;
+int boot_menu;
+
+unsigned int max_cpus;
+const uint32_t arch_type;
+const char *mem_path;
+uint8_t qemu_extra_params_fw[2];
+uint8_t *boot_splash_filedata;
+size_t boot_splash_filedata_size;
+struct syminfo *syminfos;
+
+ram_addr_t ram_size;
+MachineState *current_machine;
+QemuUUID qemu_uuid;
+
+int runstate_is_running(void)
+{
+    return 0;
+}
+
+void runstate_set(RunState new_state)
+{
+}
+
+void vm_state_notify(int running, RunState state)
+{
+}
+
+bool qemu_vmstop_requested(RunState *r)
+{
+    return false;
+}
+
+void qemu_system_debug_request(void)
+{
+}
+
+char *qemu_find_file(int type, const char *name)
+{
+    return NULL;
+}
+
+void gdb_set_stop_cpu(CPUState *cpu)
+{
+}
+
+void replay_enable_events(void)
+{
+}
+
+void replay_disable_events(void)
+{
+}
+
+#ifdef TARGET_I386
+void x86_cpu_list(void)
+{
+}
+#endif
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index cc4fe41dfc..c7c015ac58 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -1,7 +1,9 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
+#include "migration/misc.h"
 
 const VMStateDescription vmstate_dummy = {};
+const VMStateInfo vmstate_info_timer;
 
 int vmstate_register_with_alias_id(VMStateIf *obj,
                                    uint32_t instance_id,
@@ -23,3 +25,20 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     return true;
 }
+
+void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
+{
+}
+
+void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
+{
+}
+
+void vmstate_register_ram_global(MemoryRegion *mr)
+{
+}
+
+bool migration_is_idle(void)
+{
+    return true;
+}
diff --git a/stubs/xen-mapcache.c b/stubs/xen-mapcache.c
new file mode 100644
index 0000000000..af5c031727
--- /dev/null
+++ b/stubs/xen-mapcache.c
@@ -0,0 +1,22 @@
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
+#include "sysemu/xen-mapcache.h"
+
+#ifdef CONFIG_XEN
+
+void xen_invalidate_map_cache_entry(uint8_t *buffer)
+{
+}
+
+uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size, uint8_t lock, bool dma)
+{
+    return NULL;
+}
+
+ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+{
+    return 0;
+}
+
+#endif
-- 
2.25.GIT


