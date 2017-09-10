Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4tH-0003oA-Gx
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4tC-0001Mu-ID
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:15:23 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:58499)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4tC-0001MZ-70
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:15:18 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:15:09 +0300
Message-Id: <150506010962.19604.7773376130922107594.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/7] trace: Add event "guest_bbl_before"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 accel/tcg/translator.c |    6 ++++++
 trace-events           |   11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index afa3af478a..91b3b0da32 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
+#include "trace-tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gen-icount.h"
 #include "exec/log.h"
@@ -91,6 +92,11 @@ void translator_loop(const TranslatorOps *ops, DisasCo=
ntextBase *db,
             }
         }
=20
+        /* Tracing before */
+        if (db->num_insns =3D=3D 1) {
+            trace_guest_bbl_before_tcg(cpu, tcg_ctx.tcg_env, db->pc_firs=
t);
+        }
+
         /* Disassemble one instruction.  The translate_insn hook should
            update db->pc_next and db->is_jmp to indicate what should be
            done next -- either exiting this loop or locate the start of
diff --git a/trace-events b/trace-events
index 1f50f56d9d..d242f54254 100644
--- a/trace-events
+++ b/trace-events
@@ -88,6 +88,17 @@ vcpu guest_cpu_exit(void)
 # Targets: all
 vcpu guest_cpu_reset(void)
=20
+
+## Guest code
+
+# @vaddr: BBL's starting virtual address
+#
+# Mark start of BBL execution (before anything gets really executed).
+#
+# Mode: user, softmmu
+# Targets: TCG(all)
+vcpu tcg guest_bbl_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vaddr=
=3D0x%016"PRIx64
+
 # @vaddr: Access' virtual address.
 # @info : Access' information (see below).
 #
