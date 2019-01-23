Received: from eggs.gnu.org ([209.51.188.92]:54153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXL-000235-Fs
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXJ-0007cy-Q6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:39 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53626 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmGXI-0006xZ-Qt
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:37 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 23 Jan 2019 12:15:55 +0100
Message-Id: <1548242160-16039-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/9] target/mips: Correct the second
 argument type of cpu_supports_isa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

"insn_flags" bitfield was expanded from 32-bit to 64-bit in commit
f9c9cd63e3. However, this was not reflected on the second argument
of the function cpu_supports_isa(). By chance, this did not create
some wrong behavior, since the left-most halves of all instances of
the second argument are currently all zeros. However, this is still
a bug waiting to happen. Correct this by changing the type of the
second argument to be always 64-bit.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 2 +-
 target/mips/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index c4da7df..473d26d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1173,7 +1173,7 @@ int cpu_mips_signal_handler(int host_signum, void *=
pinfo, void *puc);
 #define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
=20
 bool cpu_supports_cps_smp(const char *cpu_type);
-bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
+bool cpu_supports_isa(const char *cpu_type, uint64_t isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
=20
 /* mips_int.c */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2140ecd..b362b03 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29883,7 +29883,7 @@ bool cpu_supports_cps_smp(const char *cpu_type)
     return (mcc->cpu_def->CP0_Config3 & (1 << CP0C3_CMGCR)) !=3D 0;
 }
=20
-bool cpu_supports_isa(const char *cpu_type, unsigned int isa)
+bool cpu_supports_isa(const char *cpu_type, uint64_t isa)
 {
     const MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(object_class_by_name(cpu_=
type));
     return (mcc->cpu_def->insn_flags & isa) !=3D 0;
--=20
2.7.4
