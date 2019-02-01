Received: from eggs.gnu.org ([209.51.188.92]:39541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboN-00084N-SD
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboK-0000IG-DV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:09 +0100
Message-Id: <20190201163518.31157-19-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/27] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

We define 54 macros for the powers of two >=3D 1024.  We use six, in six
macro definitions.  Four of them could just as well use the common MiB
macro, so do that.  The remaining two can't, because they get passed
to stringify.  Replace the macro by the literal number there.
Slightly harder to read in one instance (1048576 vs. S_1MiB), so add a
comment there.  The other instance is a wash: 65536 vs S_64KiB.  65536
has been good enough for more than seven years there.

This effectively reverts commit 540b8492618 and 1240ac558d3.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h        | 10 +++---
 include/qemu/units.h | 73 --------------------------------------------
 block/vdi.c          |  3 +-
 3 files changed, 7 insertions(+), 79 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 438a1dee9e..32cce9eee2 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -50,11 +50,11 @@
=20
 /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_REFTABLE_SIZE S_8MiB
+#define QCOW_MAX_REFTABLE_SIZE (8 * MiB)
=20
 /* 32 MB L1 table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_L1_SIZE S_32MiB
+#define QCOW_MAX_L1_SIZE (32 * MiB)
=20
 /* Allow for an average of 1k per snapshot table entry, should be plenty=
 of
  * space for snapshot names and IDs */
@@ -81,15 +81,15 @@
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
=20
 #ifdef CONFIG_LINUX
-#define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
+#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
 #define DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
 #else
-#define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
+#define DEFAULT_L2_CACHE_MAX_SIZE (8 * MiB)
 /* Cache clean interval is currently available only on Linux, so must be=
 0 */
 #define DEFAULT_CACHE_CLEAN_INTERVAL 0
 #endif
=20
-#define DEFAULT_CLUSTER_SIZE S_64KiB
+#define DEFAULT_CLUSTER_SIZE 65536
=20
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
diff --git a/include/qemu/units.h b/include/qemu/units.h
index 1c959d182e..692db3fbb2 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -17,77 +17,4 @@
 #define PiB     (INT64_C(1) << 50)
 #define EiB     (INT64_C(1) << 60)
=20
-/*
- * The following lookup table is intended to be used when a literal stri=
ng of
- * the number of bytes is required (for example if it needs to be string=
ified).
- * It can also be used for generic shortcuts of power-of-two sizes.
- * This table is generated using the AWK script below:
- *
- *  BEGIN {
- *      suffix=3D"KMGTPE";
- *      for(i=3D10; i<64; i++) {
- *          val=3D2**i;
- *          s=3Dsubstr(suffix, int(i/10), 1);
- *          n=3D2**(i%10);
- *          pad=3D21-int(log(n)/log(10));
- *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
- *      }
- *  }
- */
-
-#define S_1KiB                  1024
-#define S_2KiB                  2048
-#define S_4KiB                  4096
-#define S_8KiB                  8192
-#define S_16KiB                16384
-#define S_32KiB                32768
-#define S_64KiB                65536
-#define S_128KiB              131072
-#define S_256KiB              262144
-#define S_512KiB              524288
-#define S_1MiB               1048576
-#define S_2MiB               2097152
-#define S_4MiB               4194304
-#define S_8MiB               8388608
-#define S_16MiB             16777216
-#define S_32MiB             33554432
-#define S_64MiB             67108864
-#define S_128MiB           134217728
-#define S_256MiB           268435456
-#define S_512MiB           536870912
-#define S_1GiB            1073741824
-#define S_2GiB            2147483648
-#define S_4GiB            4294967296
-#define S_8GiB            8589934592
-#define S_16GiB          17179869184
-#define S_32GiB          34359738368
-#define S_64GiB          68719476736
-#define S_128GiB        137438953472
-#define S_256GiB        274877906944
-#define S_512GiB        549755813888
-#define S_1TiB         1099511627776
-#define S_2TiB         2199023255552
-#define S_4TiB         4398046511104
-#define S_8TiB         8796093022208
-#define S_16TiB       17592186044416
-#define S_32TiB       35184372088832
-#define S_64TiB       70368744177664
-#define S_128TiB     140737488355328
-#define S_256TiB     281474976710656
-#define S_512TiB     562949953421312
-#define S_1PiB      1125899906842624
-#define S_2PiB      2251799813685248
-#define S_4PiB      4503599627370496
-#define S_8PiB      9007199254740992
-#define S_16PiB    18014398509481984
-#define S_32PiB    36028797018963968
-#define S_64PiB    72057594037927936
-#define S_128PiB  144115188075855872
-#define S_256PiB  288230376151711744
-#define S_512PiB  576460752303423488
-#define S_1EiB   1152921504606846976
-#define S_2EiB   2305843009213693952
-#define S_4EiB   4611686018427387904
-#define S_8EiB   9223372036854775808
-
 #endif
diff --git a/block/vdi.c b/block/vdi.c
index 0c34f6bae4..e1c42ad732 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -85,7 +85,8 @@
 #define BLOCK_OPT_STATIC "static"
=20
 #define SECTOR_SIZE 512
-#define DEFAULT_CLUSTER_SIZE S_1MiB
+#define DEFAULT_CLUSTER_SIZE 1048576
+/* Note: can't use 1 * MiB, because it's passed to stringify() */
=20
 #if defined(CONFIG_VDI_DEBUG)
 #define VDI_DEBUG 1
--=20
2.20.1
