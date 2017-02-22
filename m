Received: from eggs.gnu.org ([2001:4830:134:3::10]:37927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV9-00035i-9s
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV6-00085v-PH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:26 +1100
Message-Id: <20170222063348.32176-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/43] spapr: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_ovec.c | 17 +++--------------
 hw/ppc/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 0bcf311..41df4c3 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,18 +16,9 @@
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 #include <libfdt.h>
=20
-/* #define DEBUG_SPAPR_OVEC */
-
-#ifdef DEBUG_SPAPR_OVEC
-#define DPRINTFN(fmt, ...) \
-    do { fprintf(stderr, fmt "\n", ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTFN(fmt, ...) \
-    do { } while (0)
-#endif
-
 #define OV_MAXBYTES 256 /* not including length byte */
 #define OV_MAXBITS (OV_MAXBYTES * BITS_PER_BYTE)
=20
@@ -210,8 +201,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_ulo=
ng table_addr, int vector)
     for (i =3D 0; i < vector_len; i++) {
         uint8_t entry =3D ldub_phys(&address_space_memory, addr + i);
         if (entry) {
-            DPRINTFN("read guest vector %2d, byte %3d / %3d: 0x%.2x",
-                     vector, i + 1, vector_len, entry);
+            trace_spapr_ovec_parse_vector(vector, i + 1, vector_len, ent=
ry);
             guest_byte_to_bitmap(entry, ov->bitmap, i * BITS_PER_BYTE);
         }
     }
@@ -245,8 +235,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
     for (i =3D 1; i < vec_len + 1; i++) {
         vec[i] =3D guest_byte_from_bitmap(ov->bitmap, (i - 1) * BITS_PER=
_BYTE);
         if (vec[i]) {
-            DPRINTFN("encoding guest vector byte %3d / %3d: 0x%.2x",
-                     i, vec_len, vec[i]);
+            trace_spapr_ovec_populate_dt(i, vec_len, vec[i]);
         }
     }
=20
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f04bb1d..43d265f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -56,6 +56,10 @@ spapr_drc_realize_child(uint32_t index, char *childnam=
e) "drc: 0x%"PRIx32", chil
 spapr_drc_realize_complete(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_unrealize(uint32_t index) "drc: 0x%"PRIx32
=20
+# hw/ppc/spapr_ovec.c
+spapr_ovec_parse_vector(int vector, int byte, uint16_t vec_len, uint8_t =
entry) "read guest vector %2d, byte %3d / %3d: 0x%.2x"
+spapr_ovec_populate_dt(int byte, uint16_t vec_len, uint8_t entry) "encod=
ing guest vector byte %3d / %3d: 0x%.2x"
+
 # hw/ppc/spapr_rtas.c
 spapr_rtas_set_indicator_invalid(uint32_t index) "sensor index: 0x%"PRIx=
32
 spapr_rtas_set_indicator_not_supported(uint32_t index, uint32_t type) "s=
ensor index: 0x%"PRIx32", type: %"PRIu32
--=20
2.9.3
