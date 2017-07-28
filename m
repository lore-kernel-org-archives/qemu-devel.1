Received: from eggs.gnu.org ([2001:4830:134:3::10]:41619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zk-000466-JE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zg-0008RU-Np
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:56 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:58476)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zg-0008Qy-FV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:52 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 28 Jul 2017 14:07:44 +0100
Message-ID: <1501247265-22367-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] hw/mips: load_elf_strerror to report kernel
 loading failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

Emulated MIPS boards bail out with a simple "could not load kernel" when
a kernel could not be load, without specifying the underlying reason.
Fix that by calling load_elf_strerror.

At the same time use error_report to report the error instead of
fprintf.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/mips/mips_fulong2e.c | 15 +++++++++------
 hw/mips/mips_malta.c    | 14 ++++++++------
 hw/mips/mips_mipssim.c  |  5 +++--
 hw/mips/mips_r4k.c      |  6 ++++--
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 3f3cb32..3532399 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -110,16 +110,19 @@ static int64_t load_kernel (CPUMIPSState *env)
 {
     int64_t kernel_entry, kernel_low, kernel_high;
     int index =3D 0;
-    long initrd_size;
+    long kernel_size, initrd_size;
     ram_addr_t initrd_offset;
     uint32_t *prom_buf;
     long prom_size;
=20
-    if (load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys, N=
ULL,
-                 (uint64_t *)&kernel_entry, (uint64_t *)&kernel_low,
-                 (uint64_t *)&kernel_high, 0, EM_MIPS, 1, 0) < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                loaderparams.kernel_filename);
+    kernel_size =3D load_elf(loaderparams.kernel_filename, cpu_mips_kseg=
0_to_phys,
+                           NULL, (uint64_t *)&kernel_entry,
+                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_=
high,
+                           0, EM_MIPS, 1, 0);
+    if (kernel_size < 0) {
+        error_report("qemu: could not load kernel '%s': %s",
+                     loaderparams.kernel_filename,
+                     load_elf_strerror(kernel_size));
         exit(1);
     }
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 3487d16..8ecd544 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -794,7 +794,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* pro=
m_buf, int index,
 static int64_t load_kernel (void)
 {
     int64_t kernel_entry, kernel_high;
-    long initrd_size;
+    long kernel_size, initrd_size;
     ram_addr_t initrd_offset;
     int big_endian;
     uint32_t *prom_buf;
@@ -808,11 +808,13 @@ static int64_t load_kernel (void)
     big_endian =3D 0;
 #endif
=20
-    if (load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys, N=
ULL,
-                 (uint64_t *)&kernel_entry, NULL, (uint64_t *)&kernel_hi=
gh,
-                 big_endian, EM_MIPS, 1, 0) < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                loaderparams.kernel_filename);
+    kernel_size =3D load_elf(loaderparams.kernel_filename, cpu_mips_kseg=
0_to_phys,
+                           NULL, (uint64_t *)&kernel_entry, NULL,
+                           (uint64_t *)&kernel_high, big_endian, EM_MIPS=
, 1, 0);
+    if (kernel_size < 0) {
+        error_report("qemu: could not load kernel '%s': %s",
+                     loaderparams.kernel_filename,
+                     load_elf_strerror(kernel_size));
         exit(1);
     }
=20
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 6990b1b..07fc4c2 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -78,8 +78,9 @@ static int64_t load_kernel(void)
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
             entry =3D (int32_t)entry;
     } else {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                loaderparams.kernel_filename);
+        error_report("qemu: could not load kernel '%s': %s",
+                     loaderparams.kernel_filename,
+                     load_elf_strerror(kernel_size));
         exit(1);
     }
=20
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 690874b..2f5ced7 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -31,6 +31,7 @@
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "qemu/error-report.h"
=20
 #define MAX_IDE_BUS 2
=20
@@ -96,8 +97,9 @@ static int64_t load_kernel(void)
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
             entry =3D (int32_t)entry;
     } else {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                loaderparams.kernel_filename);
+        error_report("qemu: could not load kernel '%s': %s",
+                     loaderparams.kernel_filename,
+                     load_elf_strerror(kernel_size));
         exit(1);
     }
=20
--=20
2.7.4
