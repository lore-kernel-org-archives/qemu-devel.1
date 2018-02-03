Received: from eggs.gnu.org ([2001:4830:134:3::10]:58645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPw-0001w7-8z
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPs-0000RL-5k
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtPr-0000Q4-Tx
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:20 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  3 Feb 2018 09:43:06 +0100
Message-Id: <20180203084315.20497-6-armbru@redhat.com>
In-Reply-To: <20180203084315.20497-1-armbru@redhat.com>
References: <20180203084315.20497-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 05/14] hw/mips: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, eblake@redhat.com, f4bug@amsat.org, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 13 ++++++-------
 hw/mips/mips_jazz.c     |  4 ++--
 hw/mips/mips_malta.c    | 16 +++++++---------
 hw/mips/mips_mipssim.c  | 11 +++++------
 hw/mips/mips_r4k.c      | 16 +++++++---------
 5 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 725e25a134..f68c625666 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -120,7 +120,7 @@ static int64_t load_kernel (CPUMIPSState *env)
                            (uint64_t *)&kernel_low, (uint64_t *)&kernel_=
high,
                            0, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -134,17 +134,16 @@ static int64_t load_kernel (CPUMIPSState *env)
         if (initrd_size > 0) {
             initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD=
_PAGE_MASK;
             if (initrd_offset + initrd_size > ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s=
'\n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'=
",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
                                      initrd_offset, ram_size - initrd_of=
fset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -338,7 +337,7 @@ static void mips_fulong2e_init(MachineState *machine)
=20
     isa_bus =3D vt82c686b_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 0))=
;
     if (!isa_bus) {
-        fprintf(stderr, "vt82c686b_init error\n");
+        error_report("vt82c686b_init error");
         exit(1);
     }
=20
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 0d2c0683ba..596f3c210e 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -268,10 +268,10 @@ static void mips_jazz_init(MachineState *machine,
             sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
             break;
         } else if (is_help_option(nd->model)) {
-            fprintf(stderr, "qemu: Supported NICs: dp83932\n");
+            error_report("Supported NICs: dp83932");
             exit(1);
         } else {
-            fprintf(stderr, "qemu: Unsupported NIC: %s\n", nd->model);
+            error_report("Unsupported NIC: %s", nd->model);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 37f19428d6..7ca8ba2086 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -812,7 +812,7 @@ static int64_t load_kernel (void)
                            NULL, (uint64_t *)&kernel_entry, NULL,
                            (uint64_t *)&kernel_high, big_endian, EM_MIPS=
, 1, 0);
     if (kernel_size < 0) {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -846,9 +846,8 @@ static int64_t load_kernel (void)
             initrd_offset =3D (loaderparams.ram_low_size - initrd_size -=
 131072
                              - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
             if (kernel_high >=3D initrd_offset) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s=
'\n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'=
",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
@@ -856,8 +855,8 @@ static int64_t load_kernel (void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -1034,9 +1033,8 @@ void mips_malta_init(MachineState *machine)
=20
     /* allocate RAM */
     if (ram_size > (2048u << 20)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d MB, maximum =
2048 MB\n",
-                ((unsigned int)ram_size / (1 << 20)));
+        error_report("Too much memory for this machine: %dMB, maximum 20=
48MB",
+                     ((unsigned int)ram_size / (1 << 20)));
         exit(1);
     }
=20
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index e5d3654586..e0ba5efc84 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -78,7 +78,7 @@ static int64_t load_kernel(void)
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
             entry =3D (int32_t)entry;
     } else {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -92,17 +92,16 @@ static int64_t load_kernel(void)
         if (initrd_size > 0) {
             initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD=
_PAGE_MASK;
             if (initrd_offset + initrd_size > loaderparams.ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s=
'\n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'=
",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
                 initrd_offset, loaderparams.ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 244bd41813..830ee7732c 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -98,7 +98,7 @@ static int64_t load_kernel(void)
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
             entry =3D (int32_t)entry;
     } else {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -112,9 +112,8 @@ static int64_t load_kernel(void)
         if (initrd_size > 0) {
             initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD=
_PAGE_MASK;
             if (initrd_offset + initrd_size > ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s=
'\n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'=
",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
@@ -122,8 +121,8 @@ static int64_t load_kernel(void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -196,9 +195,8 @@ void mips_r4k_init(MachineState *machine)
=20
     /* allocate RAM */
     if (ram_size > (256 << 20)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d MB, maximum =
256 MB\n",
-                ((unsigned int)ram_size / (1 << 20)));
+        error_report("Too much memory for this machine: %dMB, maximum 25=
6MB",
+                     ((unsigned int)ram_size / (1 << 20)));
         exit(1);
     }
     memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_=
size);
--=20
2.13.6
