Received: from eggs.gnu.org ([209.51.188.92]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexJ-0001ms-EU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexI-0004Le-Iq
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50418 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1glexI-0003uH-5E
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 21 Jan 2019 20:08:16 +0100
Message-Id: <1548097698-28951-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/6] target/mips: Correct the second argument
 type of cpu_supports_isa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

"insn_flags" bitfield was expanded from 32-bit to 64-bit at one moment.
However, this was not reflected at the second argument of the function
cpu_supports_isa(). By chance, this did not create a wrong behavior,
since the second argument was always with the left-most half zero, but
it is still a bug waiting to happen. correct by changint the type of
the second argument to be 64-bit always.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 2 +-
 target/mips/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 03c03fd..fd22bd5 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1011,7 +1011,7 @@ int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 #define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
 
 bool cpu_supports_cps_smp(const char *cpu_type);
-bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
+bool cpu_supports_isa(const char *cpu_type, uint64_t isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
 
 /* mips_int.c */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ceaa582..b660235 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29803,7 +29803,7 @@ bool cpu_supports_cps_smp(const char *cpu_type)
     return (mcc->cpu_def->CP0_Config3 & (1 << CP0C3_CMGCR)) != 0;
 }
 
-bool cpu_supports_isa(const char *cpu_type, unsigned int isa)
+bool cpu_supports_isa(const char *cpu_type, uint64_t isa)
 {
     const MIPSCPUClass *mcc = MIPS_CPU_CLASS(object_class_by_name(cpu_type));
     return (mcc->cpu_def->insn_flags & isa) != 0;
-- 
2.7.4
