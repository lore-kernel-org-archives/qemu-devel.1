Received: from eggs.gnu.org ([2001:4830:134:3::10]:60235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXoUr-0005FQ-JA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXoUm-0003rR-OT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXoUm-0003r9-Hw
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:54:28 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 19 Jul 2017 14:54:10 +0200
Message-Id: <1500468850-15571-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1500468850-15571-1-git-send-email-thuth@redhat.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] target/s390x: Add remaining switches to
 compile with --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Adding some CONFIG_TCG tests to be finally able to compile QEMU
on s390x also without TCG.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/Makefile.objs | 6 +++---
 target/s390x/cpu.c         | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index cc2b4c9..f42cd1f 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,6 +1,6 @@
-obj-y += translate.o helper.o cpu.o interrupt.o
-obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
-obj-y += gdbstub.o cpu_models.o cpu_features.o excp_helper.o
+obj-y += cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.o
+obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
+obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_KVM) += kvm.o
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index accef03..489bc25 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -417,7 +417,9 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = s390_cpu_full_reset;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
+#ifdef CONFIG_TCG
     cc->do_interrupt = s390_cpu_do_interrupt;
+#endif
     cc->dump_state = s390_cpu_dump_state;
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
@@ -428,10 +430,12 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_s390_cpu;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
+#ifdef CONFIG_TCG
     cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
     cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
     cc->do_unaligned_access = s390x_cpu_do_unaligned_access;
 #endif
+#endif
     cc->disas_set_info = s390_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = S390_NUM_CORE_REGS;
-- 
1.8.3.1
