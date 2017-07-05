Received: from eggs.gnu.org ([2001:4830:134:3::10]:46498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWi-0004YV-JX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWc-0007Xq-Tl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:08 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWc-0007XD-Nu
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:02 -0400
Received: by mail-wm0-x242.google.com with SMTP id j85so30447249wmj.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:13 +0200
Message-Id: <1499238885-26161-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/42] include/exec/poison: Mark CONFIG_SOFTMMU
 as poisoned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

CONFIG_SOFTMMU should never be used in common code, so mark
it as poisoned, too.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1498454578-18709-6-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index b9440b6..7bfd50c 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -817,6 +817,8 @@ void cpu_interrupt(CPUState *cpu, int mask);
 
 #endif /* USER_ONLY */
 
+#ifdef NEED_CPU_H
+
 #ifdef CONFIG_SOFTMMU
 static inline void cpu_unassigned_access(CPUState *cpu, hwaddr addr,
                                          bool is_write, bool is_exec,
@@ -839,6 +841,8 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 }
 #endif
 
+#endif /* NEED_CPU_H */
+
 /**
  * cpu_set_pc:
  * @cpu: The CPU to set the program counter for.
@@ -1015,6 +1019,8 @@ void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 
+#ifdef NEED_CPU_H
+
 #ifdef CONFIG_SOFTMMU
 extern const struct VMStateDescription vmstate_cpu_common;
 #else
@@ -1029,6 +1035,8 @@ extern const struct VMStateDescription vmstate_cpu_common;
     .offset = 0,                                                            \
 }
 
+#endif /* NEED_CPU_H */
+
 #define UNASSIGNED_CPU_INDEX -1
 
 #endif
-- 
1.8.3.1
