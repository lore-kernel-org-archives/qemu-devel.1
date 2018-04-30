Received: from eggs.gnu.org ([2001:4830:134:3::10]:33253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qR-0006gV-CG
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qM-0006Wi-11
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:39 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:37 +0200
Message-Id: <20180430091037.13878-43-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/42] linux-user: Add ARM get_tls syscall
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>, Christophe Lyon <christophe.lyon@st.com>

From: Christophe Lyon <christophe.lyon@st.com>

Co-Authored-By: Mickaël Guêné <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180416091845.7315-1-christophe.lyon@st.com>
[lv: moved the change to linux-user/arm/cpu_loop.c]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/cpu_loop.c       | 3 +++
 linux-user/arm/target_syscall.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index d911929bf6..26928fbbb2 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -347,6 +347,9 @@ void cpu_loop(CPUARMState *env)
                         case ARM_NR_breakpoint:
                             env->regs[15] -= env->thumb ? 2 : 4;
                             goto excp_debug;
+                        case ARM_NR_get_tls:
+                            env->regs[0] = cpu_get_tls(env);
+                            break;
                         default:
                             gemu_log("qemu: Unsupported ARM syscall: 0x%x\n",
                                      n);
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index 94e2a42cb2..afc0772e19 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -16,6 +16,7 @@ struct target_pt_regs {
 #define ARM_NR_breakpoint (ARM_NR_BASE + 1)
 #define ARM_NR_cacheflush (ARM_NR_BASE + 2)
 #define ARM_NR_set_tls	  (ARM_NR_BASE + 5)
+#define ARM_NR_get_tls    (ARM_NR_BASE + 6)
 
 #define ARM_NR_semihosting	  0x123456
 #define ARM_NR_thumb_semihosting  0xAB
-- 
2.14.3
