Received: from eggs.gnu.org ([2001:4830:134:3::10]:32915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T9E-0004j3-3w
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T97-0004pX-Ld
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:19:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21758
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f4T97-0004p0-Bw
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:19:21 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Fri, 6 Apr 2018 17:17:32 +0200
Message-ID: <20180406151752.10854-5-christophe.lyon@st.com>
In-Reply-To: <20180406151752.10854-1-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC 4/4] linux-user: ARM-FDPIC: Add arm get tls
 syscall support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org

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
index 00810d6..1814578 100644
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
