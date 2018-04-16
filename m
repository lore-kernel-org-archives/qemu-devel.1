Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f80I5-0004t7-5z
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f80Hz-0005OR-Ai
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:19:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34523
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f80Hz-0005Nw-1Q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:19:07 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 16 Apr 2018 11:18:25 +0200
Message-ID: <20180416091845.7315-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] linux-user: Add ARM get_tls syscall support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_sysc=
all.h
index 94e2a42..afc0772 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -16,6 +16,7 @@ struct target_pt_regs {
 #define ARM_NR_breakpoint (ARM_NR_BASE + 1)
 #define ARM_NR_cacheflush (ARM_NR_BASE + 2)
 #define ARM_NR_set_tls	  (ARM_NR_BASE + 5)
+#define ARM_NR_get_tls    (ARM_NR_BASE + 6)
=20
 #define ARM_NR_semihosting	  0x123456
 #define ARM_NR_thumb_semihosting  0xAB
diff --git a/linux-user/main.c b/linux-user/main.c
index 8907a84..2acac36 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -720,6 +720,9 @@ void cpu_loop(CPUARMState *env)
                         case ARM_NR_breakpoint:
                             env->regs[15] -=3D env->thumb ? 2 : 4;
                             goto excp_debug;
+                        case ARM_NR_get_tls:
+                            env->regs[0] =3D cpu_get_tls(env);
+                            break;
                         default:
                             gemu_log("qemu: Unsupported ARM syscall: 0x%=
x\n",
                                      n);
--=20
2.6.3
