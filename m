Received: from eggs.gnu.org ([2001:4830:134:3::10]:55050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drthj-0006De-8M
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drthf-0000K8-MB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:30:51 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:48475)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drthe-0000Jf-Uz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:30:47 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 01:30:36 +0300
Message-Id: <150525543616.15988.18238686972036900217.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 22/22] instrument: Add API to manipulate
 guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

It includes access to the guest's memory and vCPU registers.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/Makefile.objs      |    1=20
 instrument/qemu-instr/state.h |  104 +++++++++++++++++++++++++++++++++++=
++++++
 instrument/state.c            |   73 +++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 instrument/qemu-instr/state.h
 create mode 100644 instrument/state.c

diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index d7e6c760c3..ee482bdb45 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -5,3 +5,4 @@ target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D qmp.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D control.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D trace.o
+target-obj-$(CONFIG_INSTRUMENT) +=3D state.o
diff --git a/instrument/qemu-instr/state.h b/instrument/qemu-instr/state.=
h
new file mode 100644
index 0000000000..0ae6255fe5
--- /dev/null
+++ b/instrument/qemu-instr/state.h
@@ -0,0 +1,104 @@
+/*
+ * Interface for accessing guest state.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QI__STATE_H
+#define QI__STATE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <qemu-instr/types.h>
+
+
+/**
+ * qi_mem_read_virt:
+ * @vcpu: CPU to use for address translation.
+ * @vaddr: Starting virtual address to read from.
+ * @size: Number of bytes to read.
+ * @buf: Buffer to write into.
+ *
+ * Read contents from virtual memory.
+ *
+ * Returns: Whether the range of virtual addresses to read could be tran=
slated.
+ *
+ * Warning: Even on error, some of the destination buffer might have bee=
n
+ *          modified.
+ *
+ * Precondition: The output buffer has at least "size" bytes.
+ */
+bool qi_mem_read_virt(QICPU vcpu, uint64_t vaddr, size_t size, void *buf=
);
+
+/**
+ * qi_mem_write_virt:
+ * @vcpu: CPU to use for address translation.
+ * @vaddr: Starting virtual address to write into.
+ * @size: Number of bytes to write.
+ * @buf: Buffer with the contents to write from.
+ *
+ * Write contents into virtual memory.
+ *
+ * Returns: Whether the range of virtual addresses to write could be tra=
nslated.
+ *
+ * Warning: Even on error, some of the destination memory might have bee=
n
+ *          modified.
+ * Precondition: The input buffer has at least "size" bytes.
+ */
+bool qi_mem_write_virt(QICPU vcpu, uint64_t vaddr, size_t size, void *bu=
f);
+
+/**
+ * qi_mem_virt_to_phys:
+ * @vcpu: CPU to use for address translation.
+ * @vaddr: Virtual address to translate.
+ * @paddr: Pointer to output physical address.
+ *
+ * Translate a virtual address into a physical address.
+ *
+ * Returns: Whether the address could be translated.
+ */
+bool qi_mem_virt_to_phys(QICPU vcpu, uint64_t vaddr, uint64_t *paddr);
+
+/**
+ * qi_mem_read_phys:
+ * @paddr: Starting physical address to read from.
+ * @size: Number of bytes to read.
+ * @buf: Buffer to write into.
+ *
+ * Read contents from physical memory.
+ *
+ * Returns: Whether the range of physical addresses is valid.
+ *
+ * Warning: Even on error, some of the destination buffer might have bee=
n
+ *          modified.
+ * Precondition: The output buffer has at least "size" bytes.
+ */
+bool qi_mem_read_phys(uint64_t paddr, size_t size, void *buf);
+
+/**
+ * qi_mem_write_phys:
+ * @paddr: Starting physical address to write into.
+ * @size: Number of bytes to write.
+ * @buf: Buffer with the contents to write from.
+ *
+ * Write contents into virtual memory.
+ *
+ * Returns: Whether the range of physical addresses is valid.
+ *
+ * Warning: Even on error, some of the destination memory might have bee=
n
+ *          modified.
+ *
+ * Precondition: The input buffer has at least "size" bytes.
+ */
+bool qi_mem_write_phys(uint64_t paddr, size_t size, void *buf);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__STATE_H */
diff --git a/instrument/state.c b/instrument/state.c
new file mode 100644
index 0000000000..e76fd5fbcd
--- /dev/null
+++ b/instrument/state.c
@@ -0,0 +1,73 @@
+/*
+ * Interface for accessing guest state.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/compiler.h"
+#include "cpu.h"
+#include "exec/cpu-all.h"
+#include "instrument/control.h"
+#include "instrument/error.h"
+#include "instrument/qemu-instr/state.h"
+
+
+SYM_PUBLIC bool qi_mem_read_virt(QICPU vcpu, uint64_t vaddr,
+                                 size_t size, void *buf)
+{
+    CPUState *vcpu_ =3D instr_cpu_from_qicpu(vcpu);
+    ERROR_IF_RET(!instr_get_state(), false, "called outside instrumentat=
ion");
+    ERROR_IF_RET(!vcpu_, false, "invalid QICPU");
+    return cpu_memory_rw_debug(vcpu_, vaddr, buf, size, 0) =3D=3D 0;
+}
+
+SYM_PUBLIC bool qi_mem_write_virt(QICPU vcpu, uint64_t vaddr,
+                                  size_t size, void *buf)
+{
+    CPUState *vcpu_ =3D instr_cpu_from_qicpu(vcpu);
+    ERROR_IF_RET(!instr_get_state(), false, "called outside instrumentat=
ion");
+    ERROR_IF_RET(!vcpu_, false, "invalid QICPU");
+    return cpu_memory_rw_debug(vcpu_, vaddr, buf, size, 1) =3D=3D 0;
+}
+
+SYM_PUBLIC bool qi_mem_virt_to_phys(QICPU vcpu, uint64_t vaddr, uint64_t=
 *paddr)
+{
+    CPUState *vcpu_ =3D instr_cpu_from_qicpu(vcpu);
+    ERROR_IF_RET(!instr_get_state(), false, "called outside instrumentat=
ion");
+    ERROR_IF_RET(!vcpu_, false, "invalid QICPU");
+
+#if defined(CONFIG_USER_ONLY)
+    *paddr =3D vaddr;
+    return true;
+#else
+    *paddr =3D cpu_get_phys_page_debug(vcpu_, vaddr);
+    return *paddr !=3D -1;
+#endif
+}
+
+SYM_PUBLIC bool qi_mem_read_phys(uint64_t paddr, size_t size, void *buf)
+{
+    ERROR_IF_RET(!instr_get_state(), false, "called outside instrumentat=
ion");
+#if defined(CONFIG_USER_ONLY)
+    return cpu_memory_rw_debug(NULL, paddr, buf, size, 0) =3D=3D 0;
+#else
+    cpu_physical_memory_read(paddr, buf, size);
+    return true;
+#endif
+}
+
+SYM_PUBLIC bool qi_mem_write_phys(uint64_t paddr, size_t size, void *buf=
)
+{
+    ERROR_IF_RET(!instr_get_state(), false, "called outside instrumentat=
ion");
+#if defined(CONFIG_USER_ONLY)
+    return cpu_memory_rw_debug(NULL, paddr, buf, size, 1) =3D=3D 0;
+#else
+    cpu_physical_memory_write(paddr, buf, size);
+    return true;
+#endif
+}
