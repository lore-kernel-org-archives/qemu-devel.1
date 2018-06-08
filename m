Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fRDwD-0003PI-00
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fRDwA-0002ud-Ci
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:44:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2545 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fRDw9-0002rM-0p
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:44:02 -0400
From: liujunjie <liujunjie23@huawei.com>
Date: Fri, 8 Jun 2018 17:43:24 +0800
Message-ID: <20180608094324.23288-1-liujunjie23@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] cpu hot-del: leak fix by free the relevant
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, crosthwaite.peter@gmail.com
Cc: linzhecheng@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org, liujunjie <liujunjie23@huawei.com>

THese leaks are found by ASAN with CPU hot-add and hot-del actions,
such as:
==14127==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x7fc321cb6ec0 in posix_memalign (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7ec0)
    #1 0xf756b9 in qemu_try_memalign util/oslib-posix.c:110
    #2 0xf7575b in qemu_memalign util/oslib-posix.c:126
    #3 0x7769cb in kvm_arch_init_vcpu /root/qemu/target/i386/kvm.c:1103
    #4 0x4cc4e6 in qemu_kvm_cpu_thread_fn /root/qemu/cpus.c:1201
    #5 0x7fc31cb28dc4 in start_thread (/usr/lib64/libpthread.so.0+0x7dc4)

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x7fc321cb6560 in calloc (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7560)
    #1 0x7fc31cf944d6 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x4f4d6)
    #2 0x4cc4e6 in qemu_kvm_cpu_thread_fn /root/qemu/cpus.c:1201
    #3 0x7fc31cb28dc4 in start_thread (/usr/lib64/libpthread.so.0+0x7dc4)

Direct leak of 184 byte(s) in 1 object(s) allocated from:
    #0 0x7fc321cb6560 in calloc (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7560)
    #1 0x7fc31cf944d6 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x4f4d6)
    #2 0x4cda83 in qemu_init_vcpu /root/qemu/cpus.c:1993
    #3 0x6aedbd in x86_cpu_realizefn /root/qemu/target/i386/cpu.c:4739
    #4 0x8edfc8 in device_set_realized hw/core/qdev.c:826
    #5 0xcff60c in property_set_bool qom/object.c:1928
    #6 0xd09bd2 in object_property_set_qobject qom/qom-qobject.c:27
    #7 0xd048e3 in object_property_set_bool qom/object.c:1188
    #8 0x79ad83 in qdev_device_add /root/qemu/qdev-monitor.c:627
    #9 0x79b50c in qmp_device_add /root/qemu/qdev-monitor.c:807
    #10 0xf4ca5d in do_qmp_dispatch qapi/qmp-dispatch.c:119
    #11 0xf4ce3c in qmp_dispatch qapi/qmp-dispatch.c:168
    #12 0x4e2a5a in monitor_qmp_dispatch_one /root/qemu/monitor.c:4088
    #13 0x4e2baf in monitor_qmp_bh_dispatcher /root/qemu/monitor.c:4146
    #14 0xf67ad1 in aio_bh_poll util/async.c:118
    #15 0xf724a3 in aio_dispatch util/aio-posix.c:436
    #16 0xf67270 in aio_ctx_dispatch util/async.c:261
    #17 0x7fc31cf8e999 in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x49999)

Direct leak of 64 byte(s) in 2 object(s) allocated from:
    #0 0x7fc321cb6560 in calloc (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7560)
    #1 0x7fc31cf944d6 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x4f4d6)
    #2 0x4cda1f in qemu_init_vcpu /root/qemu/cpus.c:1997
    #3 0x6aedbd in x86_cpu_realizefn /root/qemu/target/i386/cpu.c:4739
    #4 0x8edfc8 in device_set_realized hw/core/qdev.c:826
    #5 0xcff60c in property_set_bool qom/object.c:1928
    #6 0xd09bd2 in object_property_set_qobject qom/qom-qobject.c:27
    #7 0xd048e3 in object_property_set_bool qom/object.c:1188
    #8 0x79ad83 in qdev_device_add /root/qemu/qdev-monitor.c:627
    #9 0x79b50c in qmp_device_add /root/qemu/qdev-monitor.c:807
    #10 0xf4ca5d in do_qmp_dispatch qapi/qmp-dispatch.c:119
    #11 0xf4ce3c in qmp_dispatch qapi/qmp-dispatch.c:168
    #12 0x4e2a5a in monitor_qmp_dispatch_one /root/qemu/monitor.c:4088
    #13 0x4e2baf in monitor_qmp_bh_dispatcher /root/qemu/monitor.c:4146
    #14 0xf67ad1 in aio_bh_poll util/async.c:118
    #15 0xf724a3 in aio_dispatch util/aio-posix.c:436
    #16 0xf67270 in aio_ctx_dispatch util/async.c:261
    #17 0x7fc31cf8e999 in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x49999)

SUMMARY: AddressSanitizer: 8440 byte(s) leaked in 5 allocation(s).

The relevant members in CPU Structure are freed to fix leak. Meanwhile, although the
VMChangeStateEntry added in kvm_arch_init_vcpu does not be reportd by ASAN since it still
in vm_change_state_head, it's not longer used after hot-del, so free it, too.

Signed-off-by: liujunjie <liujunjie23@huawei.com>
Signed-off-by: linzhecheng <linzhecheng@huawei.com>
---
 accel/kvm/kvm-all.c  |  3 +++
 cpus.c               |  6 ++++++
 include/sysemu/kvm.h |  1 +
 target/i386/cpu.h    |  2 ++
 target/i386/kvm.c    | 19 ++++++++++++++++++-
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ffee68e..a0491dc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -305,6 +305,9 @@ int kvm_destroy_vcpu(CPUState *cpu)
     vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
     vcpu->kvm_fd = cpu->kvm_fd;
     QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
+#ifdef TARGET_I386
+    kvm_arch_destroy_vcpu(cpu);
+#endif
 err:
     return ret;
 }
diff --git a/cpus.c b/cpus.c
index d1f1629..cbe28d6 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1842,6 +1842,12 @@ void cpu_remove_sync(CPUState *cpu)
     qemu_mutex_unlock_iothread();
     qemu_thread_join(cpu->thread);
     qemu_mutex_lock_iothread();
+    g_free(cpu->thread);
+    cpu->thread = NULL;
+    g_free(cpu->halt_cond);
+    cpu->halt_cond = NULL;
+    g_free(cpu->cpu_ases);
+    cpu->cpu_ases = NULL;
 }
 
 /* For temporary buffers for forming a name */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 0b64b8e..eb277f4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -380,6 +380,7 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 #ifdef TARGET_I386
 #define KVM_HAVE_MCE_INJECTION 1
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
+void kvm_arch_destroy_vcpu(CPUState *cs);
 #endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6645046..d6b8137 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -32,6 +32,7 @@
 #endif
 
 #include "exec/cpu-defs.h"
+typedef struct vm_change_state_entry VMChangeStateEntry;
 
 /* The x86 has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
@@ -1330,6 +1331,7 @@ typedef struct CPUX86State {
     uint64_t xss;
 
     TPRAccess tpr_access_type;
+    VMChangeStateEntry *vmstate;
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 44f7073..1ae5330 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1041,7 +1041,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    qemu_add_vm_change_state_handler(cpu_update_state, env);
+    env->vmstate = qemu_add_vm_change_state_handler(cpu_update_state, env);
 
     c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
     if (c) {
@@ -1115,6 +1115,23 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return r;
 }
 
+void kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    if (has_xsave && env->kvm_xsave_buf) {
+        qemu_vfree(env->kvm_xsave_buf);
+        env->kvm_xsave_buf = NULL;
+    }
+    g_free(cpu->kvm_msr_buf);
+    cpu->kvm_msr_buf = NULL;
+    if (env->vmstate) {
+        qemu_del_vm_change_state_handler(env->vmstate);
+        env->vmstate = NULL;
+    }
+}
+
 void kvm_arch_reset_vcpu(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
-- 
1.8.3.1
