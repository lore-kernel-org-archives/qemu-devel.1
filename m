Received: from eggs.gnu.org ([2001:4830:134:3::10]:33067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMOL-0002Qe-FU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMOH-00065D-KT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:46:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMOH-000657-GC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:46:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id e11-v6so5349299qtp.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 06:46:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Jun 2018 10:46:10 -0300
Message-Id: <20180622134610.23713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] exec: Move hw_error() to the CPU namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

hw_error() is only meant for CPU errors (since it dumps the CPU state).

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Thomas, do you think this is the correct place for this function?

    $ git grep hw_error hw/ | wc -l
    145

work to do...

Patchew will throw many errors :)

Change suggested here:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06478.html

 include/exec/cpu-all.h | 9 +++++++++
 include/hw/hw.h        | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7fa726b8e3..467026da1b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -345,4 +345,13 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 int cpu_exec(CPUState *cpu);
 
+/**
+ * hw_error:
+ * @fmt: printf-style format string
+ * @args: optional arguments for format string
+ *
+ * Report a CPU hardware error, dump the CPUs state, finally abort.
+ */
+void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+
 #endif /* CPU_ALL_H */
diff --git a/include/hw/hw.h b/include/hw/hw.h
index ab4950c312..65fa6d32f8 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -15,6 +15,4 @@
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 
-void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-
 #endif
-- 
2.18.0.rc2
