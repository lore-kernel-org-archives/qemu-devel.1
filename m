Received: from eggs.gnu.org ([2001:4830:134:3::10]:46400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR5-0005Gu-Ne
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR4-0005pn-E3
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Apr 2017 20:17:09 -0500
Message-Id: <20170411011718.9152-5-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-1-eblake@redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 04/13] qemu-io: Switch 'map' output to
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Mixing byte offset and sector allocation counts is a bit
confusing.  Also, reporting n/m sectors, where m decreases
according to the remaining size of the file, isn't really
adding any useful information.  Update the output to use
byte counts, and adjust the affected tests (./check -qcow2 102,
./check -vpc 146).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-io-cmds.c             |  5 ++---
 tests/qemu-iotests/102.out |  4 ++--
 tests/qemu-iotests/146.out | 30 +++++++++++++++---------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index df7297f..ed79c30 100644
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
-- 
2.9.3
