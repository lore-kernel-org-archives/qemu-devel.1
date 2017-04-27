Received: from eggs.gnu.org ([2001:4830:134:3::10]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW4-0007a6-Se
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW2-00047F-Bp
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:44 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:17 -0500
Message-Id: <20170427014626.11553-9-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v10 08/17] qemu-io: Switch 'map' output to
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
adding any useful information.  Update the output to use
byte counts, and adjust the affected tests (./check -qcow2 102,
./check -vpc 146).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v10: rebase to updated test 179
v9: new patch
---
 qemu-io-cmds.c             |  5 ++---
 tests/qemu-iotests/102.out |  4 ++--
 tests/qemu-iotests/146.out | 30 +++++++++++++++---------------
 tests/qemu-iotests/179.out | 22 +++++++++++-----------
 4 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 34f6707..40a3f2d 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1895,9 +1895,8 @@ static int map_f(BlockBackend *blk, int argc, char **argv)

         retstr = ret ? "    allocated" : "not allocated";
         cvtstr(offset << 9ULL, s1, sizeof(s1));
-        printf("[% 24" PRId64 "] % 8" PRId64 "/% 8" PRId64 " sectors %s "
-               "at offset %s (%d)\n",
-               offset << 9ULL, num, nb_sectors, retstr, s1, ret);
+        printf("[% 24" PRId64 "] % 16" PRId64 " bytes %s at offset %s (%d)\n",
+               offset << 9ULL, num << 9ULL, retstr, s1, ret);

         offset += num;
         nb_sectors -= num;
diff --git a/tests/qemu-iotests/102.out b/tests/qemu-iotests/102.out
index eecde16..0e0ae4c 100644
--- a/tests/qemu-iotests/102.out
+++ b/tests/qemu-iotests/102.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image resized.
-[                       0]      128/     128 sectors     allocated at offset 0 bytes (1)
+[                       0]            65536 bytes     allocated at offset 0 bytes (1)
 Offset          Length          Mapped to       File

 === Testing map on an image file truncated outside of qemu ===
@@ -17,5 +17,5 @@ wrote 65536/65536 bytes at offset 0
 Image resized.
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) qemu-io drv0 map
-[                       0]      128/     128 sectors     allocated at offset 0 bytes (1)
+[                       0]            65536 bytes     allocated at offset 0 bytes (1)
 *** done
diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
index 4f334d8..d4e2f62 100644
--- a/tests/qemu-iotests/146.out
+++ b/tests/qemu-iotests/146.out
@@ -2,39 +2,39 @@ QA output created by 146

 === Testing VPC Autodetect ===

-[                       0]  266334240/ 266334240 sectors not allocated at offset 0 bytes (0)
+[                       0]     136363130880 bytes not allocated at offset 0 bytes (0)

 === Testing VPC with current_size force ===

-[                       0]  266338304/ 266338304 sectors not allocated at offset 0 bytes (0)
+[                       0]     136365211648 bytes not allocated at offset 0 bytes (0)

 === Testing VPC with chs force ===

-[                       0]  266334240/ 266334240 sectors not allocated at offset 0 bytes (0)
+[                       0]     136363130880 bytes not allocated at offset 0 bytes (0)

 === Testing Hyper-V Autodetect ===

-[                       0]  266338304/ 266338304 sectors not allocated at offset 0 bytes (0)
+[                       0]     136365211648 bytes not allocated at offset 0 bytes (0)

 === Testing Hyper-V with current_size force ===

-[                       0]  266338304/ 266338304 sectors not allocated at offset 0 bytes (0)
+[                       0]     136365211648 bytes not allocated at offset 0 bytes (0)

 === Testing Hyper-V with chs force ===

-[                       0]  266334240/ 266334240 sectors not allocated at offset 0 bytes (0)
+[                       0]     136363130880 bytes not allocated at offset 0 bytes (0)

 === Testing d2v Autodetect ===

-[                       0]   514560/  514560 sectors     allocated at offset 0 bytes (1)
+[                       0]        263454720 bytes     allocated at offset 0 bytes (1)

 === Testing d2v with current_size force ===

-[                       0]   514560/  514560 sectors     allocated at offset 0 bytes (1)
+[                       0]        263454720 bytes     allocated at offset 0 bytes (1)

 === Testing d2v with chs force ===

-[                       0]   514560/  514560 sectors     allocated at offset 0 bytes (1)
+[                       0]        263454720 bytes     allocated at offset 0 bytes (1)

 === Testing Image create, default ===

@@ -42,15 +42,15 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296

 === Read created image, default opts ====

-[                       0]  8389584/ 8389584 sectors not allocated at offset 0 bytes (0)
+[                       0]       4295467008 bytes not allocated at offset 0 bytes (0)

 === Read created image, force_size_calc=chs ====

-[                       0]  8389584/ 8389584 sectors not allocated at offset 0 bytes (0)
+[                       0]       4295467008 bytes not allocated at offset 0 bytes (0)

 === Read created image, force_size_calc=current_size ====

-[                       0]  8389584/ 8389584 sectors not allocated at offset 0 bytes (0)
+[                       0]       4295467008 bytes not allocated at offset 0 bytes (0)

 === Testing Image create, force_size ===

@@ -58,13 +58,13 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296 forc

 === Read created image, default opts ====

-[                       0]  8388608/ 8388608 sectors not allocated at offset 0 bytes (0)
+[                       0]       4294967296 bytes not allocated at offset 0 bytes (0)

 === Read created image, force_size_calc=chs ====

-[                       0]  8388608/ 8388608 sectors not allocated at offset 0 bytes (0)
+[                       0]       4294967296 bytes not allocated at offset 0 bytes (0)

 === Read created image, force_size_calc=current_size ====

-[                       0]  8388608/ 8388608 sectors not allocated at offset 0 bytes (0)
+[                       0]       4294967296 bytes not allocated at offset 0 bytes (0)
 *** done
diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
index 2c3071b..33e9e3d 100644
--- a/tests/qemu-iotests/179.out
+++ b/tests/qemu-iotests/179.out
@@ -44,17 +44,17 @@ wrote 2097152/2097152 bytes at offset 60817408
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 62914560
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[                       0]     4096/  131072 sectors not allocated at offset 0 bytes (0)
-[                 2097152]     4096/  126976 sectors     allocated at offset 2 MiB (1)
-[                 4194304]     4096/  122880 sectors not allocated at offset 4 MiB (0)
-[                 6291456]     4096/  118784 sectors     allocated at offset 6 MiB (1)
-[                 8388608]     4096/  114688 sectors not allocated at offset 8 MiB (0)
-[                10485760]     4096/  110592 sectors     allocated at offset 10 MiB (1)
-[                12582912]     4096/  106496 sectors not allocated at offset 12 MiB (0)
-[                14680064]     4096/  102400 sectors     allocated at offset 14 MiB (1)
-[                16777216]     4096/   98304 sectors not allocated at offset 16 MiB (0)
-[                18874368]    77824/   94208 sectors     allocated at offset 18 MiB (1)
-[                58720256]    16384/   16384 sectors not allocated at offset 56 MiB (0)
+[                       0]          2097152 bytes not allocated at offset 0 bytes (0)
+[                 2097152]          2097152 bytes     allocated at offset 2 MiB (1)
+[                 4194304]          2097152 bytes not allocated at offset 4 MiB (0)
+[                 6291456]          2097152 bytes     allocated at offset 6 MiB (1)
+[                 8388608]          2097152 bytes not allocated at offset 8 MiB (0)
+[                10485760]          2097152 bytes     allocated at offset 10 MiB (1)
+[                12582912]          2097152 bytes not allocated at offset 12 MiB (0)
+[                14680064]          2097152 bytes     allocated at offset 14 MiB (1)
+[                16777216]          2097152 bytes not allocated at offset 16 MiB (0)
+[                18874368]         39845888 bytes     allocated at offset 18 MiB (1)
+[                58720256]          8388608 bytes not allocated at offset 56 MiB (0)
 [{ "start": 0, "length": 18874368, "depth": 1, "zero": true, "data": false},
 { "start": 18874368, "length": 2097152, "depth": 1, "zero": false, "data": true, "offset": OFFSET},
 { "start": 20971520, "length": 2097152, "depth": 1, "zero": true, "data": false},
-- 
2.9.3
