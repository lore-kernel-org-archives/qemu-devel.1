Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4XpB-0007ga-0A
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Xp9-0006vB-Hh
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 29 Apr 2017 14:14:13 -0500
Message-Id: <20170429191419.30051-4-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-1-eblake@redhat.com>
References: <20170429191419.30051-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v11 3/9] qemu-io: Switch 'map' output to
 byte-based reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Mixing byte offset and sector allocation counts is a bit
confusing.  Also, reporting n/m sectors, where m decreases
according to the remaining size of the file, isn't really
adding any useful information; and reporting an offset at
both the front and end of the line, with large amounts of
whitespace, is pointless.  Update the output to use byte
counts and shorter lines, then adjust the affected tests
(./check -qcow2 102, ./check -vpc 146).

Note that 'qemu-io map' is MUCH weaker than 'qemu-img map';
the former only shows which regions of the active layer are
allocated, without regards to where the allocation comes from
or whether the allocated portion is known to read as zero
(because it is using the weaker bdrv_is_allocated()); while the
latter (especially in --output=json mode) reports more details
from bdrv_get_block_status().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v11: rebase to occur before test 179, shrink the output
v10: rebase to updated test 179
v9: new patch
---
 qemu-io-cmds.c             | 11 ++++++-----
 tests/qemu-iotests/102.out |  4 ++--
 tests/qemu-iotests/146.out | 30 +++++++++++++++---------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 1e0ebb4..4b2278f 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1868,7 +1868,7 @@ static int map_f(BlockBackend *blk, int argc, char **argv)
 {
     int64_t offset;
     int64_t nb_sectors, total_sectors;
-    char s1[64];
+    char s1[64], s2[64];
     int64_t num;
     int ret;
     const char *retstr;
@@ -1894,10 +1894,11 @@ static int map_f(BlockBackend *blk, int argc, char **argv)
         }

         retstr = ret ? "    allocated" : "not allocated";
-        cvtstr(offset << 9ULL, s1, sizeof(s1));
-        printf("[% 24" PRId64 "] % 8" PRId64 "/% 8" PRId64 " sectors %s "
-               "at offset %s (%d)\n",
-               offset << 9ULL, num, nb_sectors, retstr, s1, ret);
+        cvtstr(num << BDRV_SECTOR_BITS, s1, sizeof(s1));
+        cvtstr(offset << BDRV_SECTOR_BITS, s2, sizeof(s2));
+        printf("%s (0x%" PRIx64 ") bytes %s at offset %s (0x%" PRIx64 ")\n",
+               s1, num << BDRV_SECTOR_BITS, retstr,
+               s2, offset << BDRV_SECTOR_BITS);

         offset += num;
         nb_sectors -= num;
diff --git a/tests/qemu-iotests/102.out b/tests/qemu-iotests/102.out
index eecde16..ccf172a 100644
--- a/tests/qemu-iotests/102.out
+++ b/tests/qemu-iotests/102.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image resized.
-[                       0]      128/     128 sectors     allocated at offset 0 bytes (1)
+64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
 Offset          Length          Mapped to       File

 === Testing map on an image file truncated outside of qemu ===
@@ -17,5 +17,5 @@ wrote 65536/65536 bytes at offset 0
 Image resized.
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) qemu-io drv0 map
-[                       0]      128/     128 sectors     allocated at offset 0 bytes (1)
+64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
 *** done
diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
index 4f334d8..db6b296 100644
--- a/tests/qemu-iotests/146.out
+++ b/tests/qemu-iotests/146.out
@@ -2,39 +2,39 @@ QA output created by 146

 === Testing VPC Autodetect ===

-[                       0]  266334240/ 266334240 sectors not allocated at offset 0 bytes (0)
+126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)

 === Testing VPC with current_size force ===

-[                       0]  266338304/ 266338304 sectors not allocated at offset 0 bytes (0)
+127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)

 === Testing VPC with chs force ===

-[                       0]  266334240/ 266334240 sectors not allocated at offset 0 bytes (0)
+126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)

 === Testing Hyper-V Autodetect ===

-[                       0]  266338304/ 266338304 sectors not allocated at offset 0 bytes (0)
+127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)

 === Testing Hyper-V with current_size force ===

-[                       0]  266338304/ 266338304 sectors not allocated at offset 0 bytes (0)
+127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)

 === Testing Hyper-V with chs force ===

-[                       0]  266334240/ 266334240 sectors not allocated at offset 0 bytes (0)
+126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)

 === Testing d2v Autodetect ===

-[                       0]   514560/  514560 sectors     allocated at offset 0 bytes (1)
+251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)

 === Testing d2v with current_size force ===

-[                       0]   514560/  514560 sectors     allocated at offset 0 bytes (1)
+251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)

 === Testing d2v with chs force ===

-[                       0]   514560/  514560 sectors     allocated at offset 0 bytes (1)
+251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)

 === Testing Image create, default ===

@@ -42,15 +42,15 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296

 === Read created image, default opts ====

-[                       0]  8389584/ 8389584 sectors not allocated at offset 0 bytes (0)
+4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)

 === Read created image, force_size_calc=chs ====

-[                       0]  8389584/ 8389584 sectors not allocated at offset 0 bytes (0)
+4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)

 === Read created image, force_size_calc=current_size ====

-[                       0]  8389584/ 8389584 sectors not allocated at offset 0 bytes (0)
+4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)

 === Testing Image create, force_size ===

@@ -58,13 +58,13 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296 forc

 === Read created image, default opts ====

-[                       0]  8388608/ 8388608 sectors not allocated at offset 0 bytes (0)
+4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)

 === Read created image, force_size_calc=chs ====

-[                       0]  8388608/ 8388608 sectors not allocated at offset 0 bytes (0)
+4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)

 === Read created image, force_size_calc=current_size ====

-[                       0]  8388608/ 8388608 sectors not allocated at offset 0 bytes (0)
+4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
 *** done
-- 
2.9.3
