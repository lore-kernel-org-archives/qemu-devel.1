Received: from eggs.gnu.org ([2001:4830:134:3::10]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGU-0005U0-RS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGS-0001fJ-8i
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:46 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUGGS-0001ep-2A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:44 -0500
Received: by mail-wm0-x236.google.com with SMTP id r144so3073015wme.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:12:44 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:05:04 +0000
Message-Id: <20170119170507.16185-25-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 24/27] target-arm: introduce ARM_CP_EXIT_PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Some helpers may trigger an immediate exit of the cpu_loop. If this
happens the PC need to be rectified to ensure the restart will begin
on the next instruction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h           | 3 ++-
 target/arm/translate-a64.c | 4 ++++
 target/arm/translate.c     | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 366b619b8a..29d15fc522 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1402,7 +1402,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NZCV            (ARM_CP_SPECIAL | (3 << 8))
 #define ARM_CP_CURRENTEL       (ARM_CP_SPECIAL | (4 << 8))
 #define ARM_CP_DC_ZVA          (ARM_CP_SPECIAL | (5 << 8))
-#define ARM_LAST_SPECIAL       ARM_CP_DC_ZVA
+#define ARM_CP_EXIT_PC         (ARM_CP_SPECIAL | (6 << 8))
+#define ARM_LAST_SPECIAL       ARM_CP_EXIT_PC
 /* Used only as a terminator for ARMCPRegInfo lists */
 #define ARM_CP_SENTINEL 0xffff
 /* Mask of only the flag bits in a type field */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7e7131fe2f..98d4fac070 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1561,6 +1561,10 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_rt = cpu_reg(s, rt);
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
+    case ARM_CP_EXIT_PC:
+        /* The helper may exit the cpu_loop so ensure PC is correct */
+        gen_a64_set_pc_im(s->pc);
+        break;
     default:
         break;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4301562527..e9f46eb757 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7510,6 +7510,10 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             gen_set_pc_im(s, s->pc);
             s->is_jmp = DISAS_WFI;
             return 0;
+        case ARM_CP_EXIT_PC:
+            /* The helper may exit the cpu_loop so ensure PC is correct */
+            gen_set_pc_im(s, s->pc);
+            break;
         default:
             break;
         }
-- 
2.11.0
