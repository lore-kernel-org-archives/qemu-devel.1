Received: from eggs.gnu.org ([2001:4830:134:3::10]:41503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNC5P-0002Yd-0l
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNC5L-0003FU-VH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNC5L-0003FB-P9
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:19 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Jun 2017 07:52:05 +0200
Message-Id: <1497937927-19738-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1497937927-19738-1-git-send-email-thuth@redhat.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] include/exec/poison: Mark
 CONFIG_SOFTMMU as poisoned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>

CONFIG_SOFTMMU should never be used in common code, so mark
it as poisoned, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/poison.h | 1 +
 include/qom/cpu.h     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 32707cd..41cd2eb 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -87,6 +87,7 @@
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_VHOST_NET
 #pragma GCC poison CONFIG_KVM
+#pragma GCC poison CONFIG_SOFTMMU
 
 #endif
 #endif
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb68..c41e1e3 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -783,6 +783,8 @@ bool cpu_throttle_active(void);
  */
 int cpu_throttle_get_percentage(void);
 
+#ifdef NEED_CPU_H
+
 #ifndef CONFIG_USER_ONLY
 
 typedef void (*CPUInterruptHandler)(CPUState *, int);
@@ -829,6 +831,8 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 }
 #endif
 
+#endif /* NEED_CPU_H */
+
 /**
  * cpu_set_pc:
  * @cpu: The CPU to set the program counter for.
@@ -1005,6 +1009,8 @@ void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 
+#ifdef NEED_CPU_H
+
 #ifdef CONFIG_SOFTMMU
 extern const struct VMStateDescription vmstate_cpu_common;
 #else
@@ -1019,6 +1025,8 @@ extern const struct VMStateDescription vmstate_cpu_common;
     .offset = 0,                                                            \
 }
 
+#endif /* NEED_CPU_H */
+
 #define UNASSIGNED_CPU_INDEX -1
 
 #endif
-- 
1.8.3.1
