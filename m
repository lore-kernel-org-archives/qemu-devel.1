Received: from eggs.gnu.org ([2001:4830:134:3::10]:57313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENOq-0003Wa-Ni
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENOp-0007bq-7s
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:40:16 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 13 Nov 2017 14:35:57 -0800
Message-ID: <a78b2c8879bded4abe59b71d7e9fb172e784a35d.1510612380.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510612380.git.alistair.francis@xilinx.com>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 24/29] hw/sparc*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V2:
 - Split hw patch into individual directories

 hw/sparc/leon3.c     | 16 +++++++---------
 hw/sparc/sun4m.c     | 16 +++++++---------
 hw/sparc64/niagara.c |  4 ++--
 hw/sparc64/sun4u.c   | 10 +++++-----
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 8c66d5af24..bba3aa3dee 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -139,9 +140,8 @@ static void leon3_generic_hw_init(MachineState *machine=
)
=20
     /* Allocate RAM */
     if ((uint64_t)ram_size > (1UL << 30)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d, maximum 1G\n"=
,
-                (unsigned int)(ram_size / (1024 * 1024)));
+        error_report("Too much memory for this machine: %d, maximum 1G",
+                     (unsigned int)(ram_size / (1024 * 1024)));
         exit(1);
     }
=20
@@ -167,19 +167,18 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
     }
=20
     if (bios_size > prom_size) {
-        fprintf(stderr, "qemu: could not load prom '%s': file too big\n",
-                filename);
+        error_report("could not load prom '%s': file too big", filename);
         exit(1);
     }
=20
     if (bios_size > 0) {
         ret =3D load_image_targphys(filename, 0x00000000, bios_size);
         if (ret < 0 || ret > prom_size) {
-            fprintf(stderr, "qemu: could not load prom '%s'\n", filename);
+            error_report("could not load prom '%s'", filename);
             exit(1);
         }
     } else if (kernel_filename =3D=3D NULL && !qtest_enabled()) {
-        fprintf(stderr, "Can't read bios image %s\n", filename);
+        error_report("Can't read bios image %s", filename);
         exit(1);
     }
     g_free(filename);
@@ -192,8 +191,7 @@ static void leon3_generic_hw_init(MachineState *machine=
)
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, &entry, NULL=
, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         if (bios_size <=3D 0) {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 24c2b8a555..e9e0ef0630 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -260,8 +260,7 @@ static unsigned long sun4m_load_kernel(const char *kern=
el_filename,
                                               KERNEL_LOAD_ADDR,
                                               RAM_size - KERNEL_LOAD_ADDR)=
;
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
=20
@@ -272,8 +271,8 @@ static unsigned long sun4m_load_kernel(const char *kern=
el_filename,
                                               INITRD_LOAD_ADDR,
                                               RAM_size - INITRD_LOAD_ADDR)=
;
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         }
@@ -681,7 +680,7 @@ static void prom_init(hwaddr addr, const char *bios_nam=
e)
         ret =3D -1;
     }
     if (ret < 0 || ret > PROM_SIZE_MAX) {
-        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
+        error_report("could not load prom '%s'", bios_name);
         exit(1);
     }
 }
@@ -747,10 +746,9 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size,
=20
     /* allocate RAM */
     if ((uint64_t)RAM_size > max_mem) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d, maximum %d\n"=
,
-                (unsigned int)(RAM_size / (1024 * 1024)),
-                (unsigned int)(max_mem / (1024 * 1024)));
+        error_report("Too much memory for this machine: %d, maximum %d",
+                     (unsigned int)(RAM_size / (1024 * 1024)),
+                     (unsigned int)(max_mem / (1024 * 1024)));
         exit(1);
     }
     dev =3D qdev_create(NULL, "memory");
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 7a723326c5..996ce2ada0 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -152,8 +152,8 @@ static void niagara_init(MachineState *machine)
             dinfo->is_default =3D 1;
             rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, =
-1);
         } else {
-            fprintf(stderr, "qemu: could not load ram disk '%s'\n",
-                    blk_bs(blk)->filename);
+            error_report("could not load ram disk '%s'",
+                         blk_bs(blk)->filename);
             exit(1);
         }
     }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1672f256e7..1fd1c3c861 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -166,8 +167,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_fi=
lename,
                                               RAM_size - KERNEL_LOAD_ADDR)=
;
         }
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         /* load initrd above kernel */
@@ -179,8 +179,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_fi=
lename,
                                                *initrd_addr,
                                                RAM_size - *initrd_addr);
             if ((int)*initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         }
@@ -327,7 +327,7 @@ static void prom_init(hwaddr addr, const char *bios_nam=
e)
         ret =3D -1;
     }
     if (ret < 0 || ret > PROM_SIZE_MAX) {
-        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
+        error_report("could not load prom '%s'", bios_name);
         exit(1);
     }
 }
--=20
2.14.1
