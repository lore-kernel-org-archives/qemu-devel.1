Received: from eggs.gnu.org ([2001:4830:134:3::10]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHt0p-0001bN-T4
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHt0l-0006rM-TU
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:57:27 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:22:39 +0100
Message-ID: <1481894559-13974-4-git-send-email-marcin.krzeminski@nokia.com>
In-Reply-To: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
References: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 3/3] exec: Allow to change Address Space from
 board level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, rfsw-patches@mlist.nokia.com

From: Marcin Krzeminski <marcin.krzeminski@nokia.com>

By introduction of CPUAddressSpace table it is not possible
to change address space for CPU from board code. In my case
Cortex-M3 core has it own address space that is created at board
level, then updated by changing cpu->as. For current code cpu->as
is used only at init, so changing it does not change actual
address space.

Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
---
 exec.c            | 8 ++++++++
 include/qom/cpu.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/exec.c b/exec.c
index 08c558e..9c6e302 100644
--- a/exec.c
+++ b/exec.c
@@ -628,6 +628,14 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
     /* Return the AddressSpace corresponding to the specified index */
     return cpu->cpu_ases[asidx].as;
 }
+
+void cpu_set_address_space(CPUState *cpu, AddressSpace *as, int asidx)
+{
+    /* Return the AddressSpace corresponding to the specified index */
+    if (asidx < cpu->num_ases) {
+        cpu->cpu_ases[asidx].as = as;
+    }
+}
 #endif
 
 void cpu_exec_unrealizefn(CPUState *cpu)
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e..7e2ead8 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -964,6 +964,7 @@ void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
  * specifies which address space to read.
  */
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx);
+void cpu_set_address_space(CPUState *cpu, AddressSpace *as, int asidx);
 
 void QEMU_NORETURN cpu_abort(CPUState *cpu, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
-- 
2.7.4
