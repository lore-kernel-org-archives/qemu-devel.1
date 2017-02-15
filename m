Received: from eggs.gnu.org ([2001:4830:134:3::10]:58930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3KY-0000pY-8G
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3KX-0006UB-DO
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:26 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:50353)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ce3KX-0006U1-7P
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:25:25 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Wed, 15 Feb 2017 17:23:50 +0000
Message-ID: <1487179434-13306-5-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1487179434-13306-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487179434-13306-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/8] target-mips: Provide function to test
 if a CPU supports an ISA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@imgtec.com>

From: Paul Burton <paul.burton@imgtec.com>

Provide a new cpu_supports_isa function which allows callers to
determine whether a CPU supports one of the ISA_ flags, by testing
whether the associated struct mips_def_t sets the ISA flags in its
insn_flags field.

An example use of this is to allow boards which generate bootloader code
to determine the properties of the CPU that will be used, for example
whether the CPU is 64 bit or which architecture revision it implements.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Leon Alrae <leon.alrae@imgtec.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e1c78f5..4a4747a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -815,6 +815,7 @@ int cpu_mips_signal_handler(int host_signum, void *pi=
nfo, void *puc);
=20
 #define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
 bool cpu_supports_cps_smp(const char *cpu_model);
+bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
=20
 /* TODO QOM'ify CPU reset and remove */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7f8ecf4..8b4a072 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20233,6 +20233,16 @@ bool cpu_supports_cps_smp(const char *cpu_model)
     return (def->CP0_Config3 & (1 << CP0C3_CMGCR)) !=3D 0;
 }
=20
+bool cpu_supports_isa(const char *cpu_model, unsigned int isa)
+{
+    const mips_def_t *def =3D cpu_mips_find_by_name(cpu_model);
+    if (!def) {
+        return false;
+    }
+
+    return (def->insn_flags & isa) !=3D 0;
+}
+
 void cpu_set_exception_base(int vp_index, target_ulong address)
 {
     MIPSCPU *vp =3D MIPS_CPU(qemu_get_cpu(vp_index));
--=20
2.7.4
