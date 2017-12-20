Received: from eggs.gnu.org ([2001:4830:134:3::10]:60925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAn-0007ab-8D
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAm-0006ty-3x
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:53 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Dec 2017 09:24:12 -0800
Message-ID: <9aa072d1fc7269e42020cd31f4716efd71261187.1513790495.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513790494.git.alistair.francis@xilinx.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 15/29] hw/moxie: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Anthony Green <green@moxielogic.com>

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
Cc: Anthony Green <green@moxielogic.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
V2:
 - Split hw patch into individual directories

 hw/moxie/moxiesim.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 3c3ba9d8c5..4f8e84a149 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -60,8 +61,8 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *load=
er_params)
                            0, 0);
=20
     if (kernel_size <=3D 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                loader_params->kernel_filename);
+        error_report("could not load kernel '%s'",
+                     loader_params->kernel_filename);
         exit(1);
     }
=20
@@ -74,9 +75,8 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *load=
er_params)
             initrd_offset =3D (kernel_high + ~TARGET_PAGE_MASK)
               & TARGET_PAGE_MASK;
             if (initrd_offset + initrd_size > loader_params->ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s'\=
n",
-                        loader_params->initrd_filename);
+                error_report("memory too small for initial ram disk '%s'",
+                             loader_params->initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loader_params->initrd_file=
name,
@@ -84,8 +84,8 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *load=
er_params)
                                               ram_size);
         }
         if (initrd_size =3D=3D (target_ulong)-1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loader_params->initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loader_params->initrd_filename);
             exit(1);
         }
     }
--=20
2.14.1
