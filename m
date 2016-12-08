Received: from eggs.gnu.org ([2001:4830:134:3::10]:59751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qH-00033Y-1B
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qE-000492-2x
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:49 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:22 +0100
Message-Id: <20161208175030.12269-3-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 02/10] arm/arm64: smp:
 support more than 8 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org

By adding support for launching with gicv3 we can break the 8 vcpu
limit. This patch adds support to smp code and also selects the
vgic model corresponding to the host. The vgic model may also be
manually selected by adding e.g. -machine gic-version=3D3 to
extra_params.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>

---
v8: in anticipation of get_mpidr() returning a u64 (patches will
    be in a future series), make sure we use that type everywhere
    get_mpidr is used
v5: left cpus a u32 for now. Changing to u64 requires a change to
    devicetree. Will do it later. [Andre]
v4: improved commit message
---
 arm/run                   | 19 ++++++++++++-------
 lib/arm/asm/processor.h   |  9 +++++++--
 lib/arm/asm/setup.h       |  4 ++--
 lib/arm64/asm/processor.h |  9 +++++++--
 arm/selftest.c            |  7 ++++++-
 lib/arm/setup.c           | 10 ++++++++++
 6 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/arm/run b/arm/run
index f1b04af614dc..1c40ab02eb57 100755
--- a/arm/run
+++ b/arm/run
@@ -31,13 +31,6 @@ if [ -z "$ACCEL" ]; then
 	fi
 fi
=20
-if [ "$HOST" =3D "aarch64" ] && [ "$ACCEL" =3D "kvm" ]; then
-	processor=3D"host"
-	if [ "$ARCH" =3D "arm" ]; then
-		processor+=3D",aarch64=3Doff"
-	fi
-fi
-
 qemu=3D"${QEMU:-qemu-system-$ARCH_NAME}"
 qpath=3D$(which $qemu 2>/dev/null)
=20
@@ -53,6 +46,18 @@ fi
=20
 M=3D'-machine virt'
=20
+if [ "$ACCEL" =3D "kvm" ]; then
+	if $qemu $M,\? 2>&1 | grep gic-version > /dev/null; then
+		M+=3D',gic-version=3Dhost'
+	fi
+	if [ "$HOST" =3D "aarch64" ]; then
+		processor=3D"host"
+		if [ "$ARCH" =3D "arm" ]; then
+			processor+=3D",aarch64=3Doff"
+		fi
+	fi
+fi
+
 if ! $qemu $M -device '?' 2>&1 | grep virtconsole > /dev/null; then
 	echo "$qpath doesn't support virtio-console for chr-testdev. Exiting."
 	exit 2
diff --git a/lib/arm/asm/processor.h b/lib/arm/asm/processor.h
index c831749e04de..6b0d36b87817 100644
--- a/lib/arm/asm/processor.h
+++ b/lib/arm/asm/processor.h
@@ -40,8 +40,13 @@ static inline unsigned int get_mpidr(void)
 	return read_sysreg(MPIDR);
 }
=20
-/* Only support Aff0 for now, up to 4 cpus */
-#define mpidr_to_cpu(mpidr) ((int)((mpidr) & 0xff))
+#define MPIDR_HWID_BITMASK 0xffffff
+extern int mpidr_to_cpu(uint64_t mpidr);
+
+#define MPIDR_LEVEL_SHIFT(level) \
+	(((1 << level) >> 1) << 3)
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & 0xff)
=20
 extern void start_usr(void (*func)(void *arg), void *arg, unsigned long =
sp_usr);
 extern bool is_user(void);
diff --git a/lib/arm/asm/setup.h b/lib/arm/asm/setup.h
index cb8fdbd38dd5..1de99dd184d1 100644
--- a/lib/arm/asm/setup.h
+++ b/lib/arm/asm/setup.h
@@ -10,8 +10,8 @@
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
=20
-#define NR_CPUS			8
-extern u32 cpus[NR_CPUS];
+#define NR_CPUS			255
+extern u32 cpus[NR_CPUS];	/* per-cpu IDs (MPIDRs) */
 extern int nr_cpus;
=20
 #define NR_MEM_REGIONS		8
diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
index ed59ad25007b..48abf2c9e358 100644
--- a/lib/arm64/asm/processor.h
+++ b/lib/arm64/asm/processor.h
@@ -72,8 +72,13 @@ static inline unsigned int get_mpidr(void)
 	return read_sysreg(mpidr_el1);
 }
=20
-/* Only support Aff0 for now, gicv2 only */
-#define mpidr_to_cpu(mpidr) ((int)((mpidr) & 0xff))
+#define MPIDR_HWID_BITMASK 0xff00ffffff
+extern int mpidr_to_cpu(uint64_t mpidr);
+
+#define MPIDR_LEVEL_SHIFT(level) \
+	(((1 << level) >> 1) << 3)
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & 0xff)
=20
 extern void start_usr(void (*func)(void *arg), void *arg, unsigned long =
sp_usr);
 extern bool is_user(void);
diff --git a/arm/selftest.c b/arm/selftest.c
index 196164f5313d..750e90893141 100644
--- a/arm/selftest.c
+++ b/arm/selftest.c
@@ -312,9 +312,11 @@ static bool psci_check(void)
 static cpumask_t smp_reported;
 static void cpu_report(void)
 {
+	uint64_t mpidr =3D get_mpidr();
 	int cpu =3D smp_processor_id();
=20
-	report("CPU%d online", true, cpu);
+	report("CPU(%3d) mpidr=3D%010" PRIx64,
+		mpidr_to_cpu(mpidr) =3D=3D cpu, cpu, mpidr);
 	cpumask_set_cpu(cpu, &smp_reported);
 	halt();
 }
@@ -343,6 +345,7 @@ int main(int argc, char **argv)
=20
 	} else if (strcmp(argv[1], "smp") =3D=3D 0) {
=20
+		uint64_t mpidr =3D get_mpidr();
 		int cpu;
=20
 		report("PSCI version", psci_check());
@@ -353,6 +356,8 @@ int main(int argc, char **argv)
 			smp_boot_secondary(cpu, cpu_report);
 		}
=20
+		report("CPU(%3d) mpidr=3D%010" PRIx64,
+			mpidr_to_cpu(mpidr) =3D=3D 0, 0, mpidr);
 		cpumask_set_cpu(0, &smp_reported);
 		while (!cpumask_full(&smp_reported))
 			cpu_relax();
diff --git a/lib/arm/setup.c b/lib/arm/setup.c
index 7e7b39f11dde..e52a25abd722 100644
--- a/lib/arm/setup.c
+++ b/lib/arm/setup.c
@@ -30,6 +30,16 @@ int nr_cpus;
 struct mem_region mem_regions[NR_MEM_REGIONS];
 phys_addr_t __phys_offset, __phys_end;
=20
+int mpidr_to_cpu(uint64_t mpidr)
+{
+	int i;
+
+	for (i =3D 0; i < nr_cpus; ++i)
+		if (cpus[i] =3D=3D (mpidr & MPIDR_HWID_BITMASK))
+			return i;
+	return -1;
+}
+
 static void cpu_set(int fdtnode __unused, u32 regval, void *info __unuse=
d)
 {
 	int cpu =3D nr_cpus++;
--=20
2.9.3
