Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5799C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D616206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D616206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTovy-0003DA-Sq
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:43:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTooQ-0004ZB-6B
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTooN-0007Y7-QP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:35:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTooL-0007T9-T2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:35:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C2572E95A2;
	Thu, 23 May 2019 14:35:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 697296250A;
	Thu, 23 May 2019 14:35:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1539611384AA; Thu, 23 May 2019 16:35:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:35:05 +0200
Message-Id: <20190523143508.25387-2-armbru@redhat.com>
In-Reply-To: <20190523143508.25387-1-armbru@redhat.com>
References: <20190523143508.25387-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 23 May 2019 14:35:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] qemu-common: Move tcg_enabled() etc. to
 sysemu/tcg.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Other accelerators have their own headers: sysemu/hax.h, sysemu/hvf.h,
sysemu/kvm.h, sysemu/whpx.h.  Only tcg_enabled() & friends sit in
qemu-common.h.  This necessitates inclusion of qemu-common.h into
headers, which is against the rules spelled out in qemu-common.h's
file comment.

Move tcg_enabled() & friends into their own header sysemu/tcg.h, and
adjust #include directives.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                     |  1 +
 accel/tcg/cpu-exec-common.c     |  1 +
 accel/tcg/tcg-all.c             |  2 +-
 accel/tcg/translate-all.c       |  3 ++-
 bsd-user/main.c                 |  2 ++
 cpus.c                          |  1 +
 exec.c                          |  2 ++
 hw/i386/pc.c                    |  1 +
 hw/ppc/spapr_caps.c             |  2 ++
 hw/s390x/ipl.c                  |  1 +
 include/exec/ram_addr.h         |  1 +
 include/qemu-common.h           |  8 --------
 include/sysemu/tcg.h            | 19 +++++++++++++++++++
 linux-user/main.c               |  2 ++
 memory.c                        |  2 +-
 monitor.c                       |  1 +
 qemu-nbd.c                      |  1 +
 qom/cpu.c                       |  2 +-
 target/arm/cpu.c                |  2 +-
 target/i386/cpu.c               |  1 +
 target/i386/cpu.h               |  2 +-
 target/i386/helper.c            |  1 +
 target/i386/machine.c           |  2 +-
 target/ppc/translate_init.inc.c |  1 +
 target/s390x/cpu.c              |  2 +-
 target/s390x/cpu_models.c       |  1 +
 target/s390x/gdbstub.c          |  3 ++-
 target/s390x/helper.c           |  1 +
 target/s390x/interrupt.c        |  1 +
 target/s390x/machine.c          |  1 +
 target/s390x/mmu_helper.c       |  1 +
 target/s390x/sigp.c             |  2 +-
 vl.c                            |  1 +
 33 files changed, 56 insertions(+), 18 deletions(-)
 create mode 100644 include/sysemu/tcg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a6948ebc63..5250521dff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -124,6 +124,7 @@ F: include/exec/exec-all.h
 F: include/exec/helper*.h
 F: include/exec/tb-hash.h
 F: include/sysemu/cpus.h
+F: include/sysemu/tcg.h
 
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 462a1f1865..12c1e3e974 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 
 bool tcg_allowed;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3d25bdcc17..f0c95df5b8 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -26,8 +26,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "qom/object.h"
-#include "qemu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 20b59f93f4..5f832d788f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -16,9 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 
-#include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
 #include "trace.h"
@@ -55,6 +55,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "sysemu/tcg.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 6192e9d91e..5ec6f90af9 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -16,8 +16,10 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/tcg.h"
 #include "qemu-version.h"
 #include <machine/trap.h>
 
diff --git a/cpus.c b/cpus.c
index e58e7ab0f6..e45be368c6 100644
--- a/cpus.c
+++ b/cpus.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
 #include "sysemu/dma.h"
diff --git a/exec.c b/exec.c
index 4e734770c2..0bc59e9a30 100644
--- a/exec.c
+++ b/exec.c
@@ -16,6 +16,7 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 
@@ -32,6 +33,7 @@
 #endif
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d98b737b8f..06e4932d05 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -49,6 +49,7 @@
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 9b1c10baa6..6d4e80cf26 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -32,6 +33,7 @@
 #include "cpu-models.h"
 #include "kvm_ppc.h"
 #include "sysemu/qtest.h"
+#include "sysemu/tcg.h"
 
 #include "hw/ppc/spapr.h"
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b93750c14e..1f3aef051b 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "cpu.h"
 #include "elf.h"
 #include "hw/loader.h"
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 574427a505..507050a2e7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -24,6 +24,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "hw/xen/xen.h"
+#include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 
 struct RAMBlock {
diff --git a/include/qemu-common.h b/include/qemu-common.h
index f891e05e7e..d7f4a4e7eb 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -77,14 +77,6 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
     sendto(sockfd, buf, len, flags, destaddr, addrlen)
 #endif
 
-extern bool tcg_allowed;
-void tcg_exec_init(unsigned long tb_size);
-#ifdef CONFIG_TCG
-#define tcg_enabled() (tcg_allowed)
-#else
-#define tcg_enabled() 0
-#endif
-
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
new file mode 100644
index 0000000000..7d116d2e80
--- /dev/null
+++ b/include/sysemu/tcg.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU TCG support
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef SYSEMU_TCG_H
+#define SYSEMU_TCG_H
+
+extern bool tcg_allowed;
+void tcg_exec_init(unsigned long tb_size);
+#ifdef CONFIG_TCG
+#define tcg_enabled() (tcg_allowed)
+#else
+#define tcg_enabled() 0
+#endif
+
+#endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 3d2230320b..dae193fa7e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -16,8 +16,10 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/tcg.h"
 #include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
diff --git a/memory.c b/memory.c
index 3071c4bdad..fd32a1da29 100644
--- a/memory.c
+++ b/memory.c
@@ -15,7 +15,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
@@ -30,6 +29,7 @@
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/monitor.c b/monitor.c
index 6428eb3b7e..3650ceb574 100644
--- a/monitor.c
+++ b/monitor.c
@@ -53,6 +53,7 @@
 #include "sysemu/hw_accel.h"
 #include "authz/list.h"
 #include "qapi/util.h"
+#include "sysemu/tcg.h"
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 081fcf74d5..25ce71e160 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -21,6 +21,7 @@
 #include <libgen.h>
 #include <pthread.h>
 
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index 3c5493c96c..eea08ccbae 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/notify.h"
@@ -30,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8eee1d8c59..27c8a09da4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -24,7 +24,6 @@
 #include "qapi/visitor.h"
 #include "cpu.h"
 #include "internals.h"
-#include "qemu-common.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
@@ -32,6 +31,7 @@
 #endif
 #include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
 #include "disas/capstone.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2df56fa977..7548212f09 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -47,6 +47,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f612681331..d6b78d46b3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,7 +24,7 @@
 #ifndef I386_CPU_H
 #define I386_CPU_H
 
-#include "qemu-common.h"
+#include "sysemu/tcg.h"
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 96336055f3..a3059a471b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -25,6 +25,7 @@
 #include "kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
 #include "hw/i386/apic_internal.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..1150967b97 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "hw/hw.h"
@@ -10,6 +9,7 @@
 #include "hyperv.h"
 
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 
 #include "qemu/error-report.h"
 
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ad5e14b16f..f44e966a61 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -24,6 +24,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/tcg.h"
 #include "cpu-models.h"
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b1df63d82c..3ee24b8541 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -26,7 +26,6 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -39,6 +38,7 @@
 #include "hw/hw.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat.h"
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 21ea819483..7478b04621 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index df147596ce..3bb448cb48 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -17,14 +17,15 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu/bitops.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/tcg.h"
 
 int s390_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 3c8f0a7615..1415478818 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -28,6 +28,7 @@
 #include "sysemu/hw_accel.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #endif
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index a17eff5ebc..f6cffb4371 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -14,6 +14,7 @@
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "hw/s390x/ioinst.h"
 #include "tcg_s390x.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index cb792aa103..1392fd5eb4 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -21,6 +21,7 @@
 #include "kvm_s390x.h"
 #include "tcg_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 
 static int cpu_post_load(void *opaque, int version_id)
 {
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 145b62a7ef..95cc87bd64 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -22,6 +22,7 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "trace.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c1f9245797..6873377661 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -9,13 +9,13 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-misc.h"
 
diff --git a/vl.c b/vl.c
index 201144b162..8ec5979137 100644
--- a/vl.c
+++ b/vl.c
@@ -30,6 +30,7 @@
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
 #include "sysemu/seccomp.h"
+#include "sysemu/tcg.h"
 
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
-- 
2.17.2


