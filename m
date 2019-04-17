Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA843C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9EF206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9EF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGo9t-0002Ec-Io
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:15:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5g-0007i5-I1
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5c-0007ai-7Z
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGo5S-0007S7-Oe; Wed, 17 Apr 2019 13:11:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E55FD330279;
	Wed, 17 Apr 2019 17:11:05 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D660E19C58;
	Wed, 17 Apr 2019 17:11:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 12:11:01 -0500
Message-Id: <20190417171101.1254-3-eblake@redhat.com>
In-Reply-To: <20190417171101.1254-1-eblake@redhat.com>
References: <20190417171101.1254-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 17 Apr 2019 17:11:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/2] qemu-img: Saner printing of large file
 sizes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417171101.1ky7G4JPGaF6zzBZWXxpqYoBsXBrfaHxTrtg3yfsNhI@z>

Disk sizes close to INT64_MAX cause overflow, for some pretty
ridiculous output:

  $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info $nb=
d'
  image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
  file format: raw
  virtual size: -8388607T (9223372036854775296 bytes)
  disk size: unavailable

But there's no reason to have two separate implementations of integer
to human-readable abbreviation, where one has overflow and stops at
'T', while the other avoids overflow and goes all the way to 'E'. With
this patch, the output now claims 8EiB instead of -8388607T, which
really is the correct rounding of largest file size supported by qemu
(we could go 511 bytes larger if we used byte-accurate sizing instead
of rounding up to the next sector boundary, but that wouldn't change
the human-readable result).

Quite a few iotests need updates to expected output to match.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v3: fix 59 for vmdk [Max]
---
 block/qapi.c               | 49 +++++++++-----------------------------
 tests/qemu-iotests/043.out |  6 ++---
 tests/qemu-iotests/053.out |  2 +-
 tests/qemu-iotests/059.out | 10 ++++----
 tests/qemu-iotests/060.out | 10 ++++----
 tests/qemu-iotests/061.out | 12 +++++-----
 tests/qemu-iotests/070.out |  2 +-
 tests/qemu-iotests/082.out | 26 ++++++++++----------
 tests/qemu-iotests/084.out |  8 +++----
 tests/qemu-iotests/089.out |  2 +-
 tests/qemu-iotests/095.out |  4 ++--
 tests/qemu-iotests/104.out |  6 ++---
 tests/qemu-iotests/110.out |  6 ++---
 tests/qemu-iotests/114.out |  2 +-
 tests/qemu-iotests/126.out |  4 ++--
 tests/qemu-iotests/130.out | 10 ++++----
 tests/qemu-iotests/153.out |  2 +-
 tests/qemu-iotests/191.out |  8 +++----
 tests/qemu-iotests/195.out |  4 ++--
 tests/qemu-iotests/198.out |  4 ++--
 tests/qemu-iotests/206.out | 10 ++++----
 tests/qemu-iotests/207.out | 12 +++++-----
 tests/qemu-iotests/210.out |  8 +++----
 tests/qemu-iotests/211.out | 10 ++++----
 tests/qemu-iotests/212.out | 10 ++++----
 tests/qemu-iotests/213.out | 10 ++++----
 tests/qemu-iotests/233.out |  4 ++--
 tests/qemu-iotests/237.out | 22 ++++++++---------
 tests/qemu-iotests/242.out | 10 ++++----
 29 files changed, 123 insertions(+), 150 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 21edab34fca..110d05dc575 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -630,43 +630,14 @@ BlockStatsList *qmp_query_blockstats(bool has_query=
_nodes,
     return head;
 }

-#define NB_SUFFIXES 4
-
-static char *get_human_readable_size(char *buf, int buf_size, int64_t si=
ze)
-{
-    static const char suffixes[NB_SUFFIXES] =3D {'K', 'M', 'G', 'T'};
-    int64_t base;
-    int i;
-
-    if (size <=3D 999) {
-        snprintf(buf, buf_size, "%" PRId64, size);
-    } else {
-        base =3D 1024;
-        for (i =3D 0; i < NB_SUFFIXES; i++) {
-            if (size < (10 * base)) {
-                snprintf(buf, buf_size, "%0.1f%c",
-                         (double)size / base,
-                         suffixes[i]);
-                break;
-            } else if (size < (1000 * base) || i =3D=3D (NB_SUFFIXES - 1=
)) {
-                snprintf(buf, buf_size, "%" PRId64 "%c",
-                         ((size + (base >> 1)) / base),
-                         suffixes[i]);
-                break;
-            }
-            base =3D base * 1024;
-        }
-    }
-    return buf;
-}
-
 void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
                         QEMUSnapshotInfo *sn)
 {
-    char buf1[128], date_buf[128], clock_buf[128];
+    char date_buf[128], clock_buf[128];
     struct tm tm;
     time_t ti;
     int64_t secs;
+    char *sizing =3D NULL;

     if (!sn) {
         func_fprintf(f,
@@ -684,14 +655,15 @@ void bdrv_snapshot_dump(fprintf_function func_fprin=
tf, void *f,
                  (int)((secs / 60) % 60),
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
+        sizing =3D size_to_str(sn->vm_state_size);
         func_fprintf(f,
                      "%-10s%-20s%7s%20s%15s",
                      sn->id_str, sn->name,
-                     get_human_readable_size(buf1, sizeof(buf1),
-                                             sn->vm_state_size),
+                     sizing,
                      date_buf,
                      clock_buf);
     }
+    g_free(sizing);
 }

 static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
@@ -796,14 +768,13 @@ void bdrv_image_info_specific_dump(fprintf_function=
 func_fprintf, void *f,
 void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
                           ImageInfo *info)
 {
-    char size_buf[128], dsize_buf[128];
+    char *size_buf, *dsize_buf;
     if (!info->has_actual_size) {
-        snprintf(dsize_buf, sizeof(dsize_buf), "unavailable");
+        dsize_buf =3D g_strdup("unavailable");
     } else {
-        get_human_readable_size(dsize_buf, sizeof(dsize_buf),
-                                info->actual_size);
+        dsize_buf =3D size_to_str(info->actual_size);
     }
-    get_human_readable_size(size_buf, sizeof(size_buf), info->virtual_si=
ze);
+    size_buf =3D size_to_str(info->virtual_size);
     func_fprintf(f,
                  "image: %s\n"
                  "file format: %s\n"
@@ -812,6 +783,8 @@ void bdrv_image_info_dump(fprintf_function func_fprin=
tf, void *f,
                  info->filename, info->format, size_buf,
                  info->virtual_size,
                  dsize_buf);
+    g_free(size_buf);
+    g_free(dsize_buf);

     if (info->has_encrypted && info->encrypted) {
         func_fprintf(f, "encrypted: yes\n");
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index b37d2a38074..0280f999ce1 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -22,19 +22,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
34217728 backing_file=3DTEST_DIR/
 =3D=3D finite chain of length 3 (human) =3D=3D
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.2.base

 image: TEST_DIR/t.IMGFMT.2.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.1.base

 image: TEST_DIR/t.IMGFMT.1.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536

 =3D=3D finite chain of length 3 (json) =3D=3D
diff --git a/tests/qemu-iotests/053.out b/tests/qemu-iotests/053.out
index 8e793b6462e..8a658812327 100644
--- a/tests/qemu-iotests/053.out
+++ b/tests/qemu-iotests/053.out
@@ -9,7 +9,7 @@ wrote 512/512 bytes at offset 0
 No errors were found on the image.

 =3D=3D Checking compressed image virtual disk size =3D=3D
-virtual size: 512 (512 bytes)
+virtual size: 512 B (512 bytes)

 =3D=3D Verifying the compressed image =3D=3D
 read 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f6dce7947c9..700ad1f2906 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -16,7 +16,7 @@ can't open device TEST_DIR/t.vmdk: L1 size too big
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648 subformat=
=3DmonolithicFlat
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 2.0G (2147483648 bytes)
+virtual size: 2 GiB (2147483648 bytes)

 =3D=3D=3D Testing monolithicFlat with zeroed_grain =3D=3D=3D
 qemu-img: TEST_DIR/t.IMGFMT: Flat image can't enable zeroed grain
@@ -26,8 +26,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D214=
7483648 subformat=3DmonolithicF
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824000 subfor=
mat=3DtwoGbMaxExtentFlat
 image: TEST_DIR/t.vmdk
 file format: vmdk
-virtual size: 1.0T (1073741824000 bytes)
-disk size: 16K
+virtual size: 0.977 TiB (1073741824000 bytes)
+disk size: 16 KiB
 Format specific information:
     cid: XXXXXXXX
     parent cid: XXXXXXXX
@@ -2055,7 +2055,7 @@ can't open: Cannot use relative extent paths with V=
MDK descriptor file 'json:{"i
 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
 file format: IMGFMT
-virtual size: 16G (17179869184 bytes)
+virtual size: 16 GiB (17179869184 bytes)
 cluster_size: 65536
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2262,7 +2262,7 @@ read 512/512 bytes at offset 64931328
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4398046511104 subfor=
mat=3DmonolithicFlat
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 4.0T (4398046511104 bytes)
+virtual size: 4 TiB (4398046511104 bytes)
 wrote 512/512 bytes at offset 966367641600
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 e100000000:  0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a  ..........=
......
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index af623cfd860..4edd75b5bc0 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -13,7 +13,7 @@ write failed: Input/output error
 incompatible_features     0x2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -364,10 +364,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
67108864
 qcow2: Marking image as corrupt: Refblock at 0xffffff00000000 is not cov=
ered by the refcount structures; further corruption events will be suppre=
ssed
 qemu-img: Failed to discard unused refblocks: Input/output error
 --- Checking and retrying ---
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 No errors were found on the image.
 Image resized.
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)

 =3D=3D=3D Discarding a non-covered in-bounds refblock =3D=3D=3D

@@ -375,10 +375,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
67108864
 qcow2: Marking image as corrupt: Refblock at 0x1000000000 is not covered=
 by the refcount structures; further corruption events will be suppressed
 qemu-img: Failed to discard unused refblocks: Input/output error
 --- Checking and retrying ---
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 No errors were found on the image.
 Image resized.
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)

 =3D=3D=3D Discarding a refblock covered by an unaligned refblock =3D=3D=3D

diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 9fe1ec702f4..1aa7d37ff9b 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -495,7 +495,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864 data_file=3DTEST_DIR/t.IM
 qemu-img: Cannot downgrade an image with a data file
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -515,7 +515,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864 data_file=3DTEST_DIR/t.IM
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No s=
uch file or directory
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -528,7 +528,7 @@ Format specific information:
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required fo=
r this image
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -542,7 +542,7 @@ Format specific information:
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data data_file_raw=3Don
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -554,7 +554,7 @@ Format specific information:
 No errors were found on the image.
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -567,7 +567,7 @@ No errors were found on the image.
 qemu-img: data-file-raw cannot be set on existing images
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
diff --git a/tests/qemu-iotests/070.out b/tests/qemu-iotests/070.out
index c269d994834..287f16de2a6 100644
--- a/tests/qemu-iotests/070.out
+++ b/tests/qemu-iotests/070.out
@@ -22,6 +22,6 @@ read 18874368/18874368 bytes at offset 0
 =3D=3D=3D Verify image created by Disk2VHD can be opened =3D=3D=3D
 image: TEST_DIR/test-disk2vhd.IMGFMT
 file format: IMGFMT
-virtual size: 256M (268435456 bytes)
+virtual size: 256 MiB (268435456 bytes)
 cluster_size: 2097152
 *** done
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 915640613ff..d36938da9bb 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -6,14 +6,14 @@ Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536

 Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don TES=
T_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D4096 lazy_refcounts=3Don refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
@@ -25,7 +25,7 @@ Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_r=
efcounts=3Don -o cluster_size
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D8192 lazy_refcounts=3Don refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
@@ -37,7 +37,7 @@ Testing: create -f qcow2 -o cluster_size=3D4k,cluster_s=
ize=3D8k TEST_DIR/t.qcow2 128
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D8192 lazy_refcounts=3Doff refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192

 =3D=3D=3D create: help for -o =3D=3D=3D
@@ -278,18 +278,18 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1=
34217728 cluster_size=3D65536 lazy_
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: raw
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)

 Testing: convert -O foo -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536

 Testing: convert -O qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don TE=
ST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
@@ -300,7 +300,7 @@ Format specific information:
 Testing: convert -O qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don -o=
 cluster_size=3D8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
@@ -311,7 +311,7 @@ Format specific information:
 Testing: convert -O qcow2 -o cluster_size=3D4k,cluster_size=3D8k TEST_DI=
R/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192

 =3D=3D=3D convert: help for -o =3D=3D=3D
@@ -560,7 +560,7 @@ qemu-img: Cannot enable copy offloading when -c is us=
ed
 Testing: amend -f foo -f qcow2 -o lazy_refcounts=3Don TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -571,7 +571,7 @@ Format specific information:
 Testing: amend -f qcow2 -o size=3D130M -o lazy_refcounts=3Doff TEST_DIR/=
t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 130M (136314880 bytes)
+virtual size: 130 MiB (136314880 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -582,7 +582,7 @@ Format specific information:
 Testing: amend -f qcow2 -o size=3D8M -o lazy_refcounts=3Don -o size=3D13=
2M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 132M (138412032 bytes)
+virtual size: 132 MiB (138412032 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -593,7 +593,7 @@ Format specific information:
 Testing: amend -f qcow2 -o size=3D4M,size=3D148M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 148M (155189248 bytes)
+virtual size: 148 MiB (155189248 bytes)
 cluster_size: 65536

 =3D=3D=3D amend: help for -o =3D=3D=3D
diff --git a/tests/qemu-iotests/084.out b/tests/qemu-iotests/084.out
index 5c5ab928c9b..c2648d963f6 100644
--- a/tests/qemu-iotests/084.out
+++ b/tests/qemu-iotests/084.out
@@ -5,7 +5,7 @@ QA output created by 084
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 disk image file size in bytes: 67109888

@@ -14,13 +14,13 @@ disk image file size in bytes: 67109888
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 disk image file size in bytes: 1024
 Test 1: Maximum size (512 TB - 128 MB):
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 512T (562949819203584 bytes)
+virtual size: 512 TiB (562949819203584 bytes)
 cluster_size: 1048576

 Test 2: Size too large (512 TB - 128 MB + 64 kB)
@@ -35,7 +35,7 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': unsupport=
ed VDI image (too many bl
 Test 5: Valid Image: 64MB, Blocks In Image 64, Block Size 1MB
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576

 Test 6: Block Size !=3D 1MB; too small test (1MB - 1)
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 89e3e4340a4..20c8ce8f0ef 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -38,7 +38,7 @@ read failed: Input/output error

 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536

 =3D=3D=3D Testing option merging =3D=3D=3D
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index 8c093dfff3e..d2e393fef8e 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
7600 backing_file=3DTEST_DIR/
 =3D=3D=3D Base image info before commit and resize =3D=3D=3D
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 5.0M (5242880 bytes)
+virtual size: 5 MiB (5242880 bytes)

 =3D=3D=3D Running QEMU Live Commit Test =3D=3D=3D

@@ -23,5 +23,5 @@ virtual size: 5.0M (5242880 bytes)
 =3D=3D=3D Base image info after commit and resize =3D=3D=3D
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 100M (104857600 bytes)
+virtual size: 100 MiB (104857600 bytes)
 *** done
diff --git a/tests/qemu-iotests/104.out b/tests/qemu-iotests/104.out
index ab8d892c2ad..d854155f5b8 100644
--- a/tests/qemu-iotests/104.out
+++ b/tests/qemu-iotests/104.out
@@ -4,9 +4,9 @@ QA output created by 104
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 1.0K (1024 bytes)
+virtual size: 1 KiB (1024 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1234
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 1.5K (1536 bytes)
-***done
+virtual size: 1.5 KiB (1536 bytes)
+*** done
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 46e6a60510d..f60b26390e2 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -6,14 +6,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3Dt.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)

 =3D=3D=3D Non-reconstructable filename =3D=3D=3D

 image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio=
", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver"=
: "blkdebug", "set-state.0.new_state": 42}}
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)

 =3D=3D=3D Backing name is always relative to the backed image =3D=3D=3D
@@ -24,6 +24,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864 backing_file=3Dt.IMGFMT.b

 image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-threshold": 1}}
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
 *** done
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 1a47a526b92..0d8c5903707 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -3,7 +3,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
diff --git a/tests/qemu-iotests/126.out b/tests/qemu-iotests/126.out
index 17d03d5248b..e3c4d619162 100644
--- a/tests/qemu-iotests/126.out
+++ b/tests/qemu-iotests/126.out
@@ -11,13 +11,13 @@ Formatting 'TEST_DIR/image:base.IMGFMT', fmt=3DIMGFMT=
 size=3D67108864
 Formatting 'TEST_DIR/image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 bac=
king_file=3D./image:base.IMGFMT
 image: TEST_DIR/image:top.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: ./image:base.IMGFMT (actual path: TEST_DIR/./image:base.IM=
GFMT)

 Formatting 'base.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'file:image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing=
_file=3Dbase.IMGFMT
 image: ./image:top.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: base.IMGFMT (actual path: ./base.IMGFMT)
 *** done
diff --git a/tests/qemu-iotests/130.out b/tests/qemu-iotests/130.out
index 93020c328ee..e45285ccc31 100644
--- a/tests/qemu-iotests/130.out
+++ b/tests/qemu-iotests/130.out
@@ -4,7 +4,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)

 =3D=3D=3D HMP commit =3D=3D=3D

@@ -13,14 +13,14 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu)=20
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) commit testdisk
 (qemu)=20
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: TEST_DIR/t.IMGFMT.orig
 backing file format: raw

@@ -31,13 +31,13 @@ wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: TEST_DIR/t.IMGFMT.orig
 backing file format: raw
 *** done
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 9747ce3c419..eb3e8dac4e1 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -449,7 +449,7 @@ _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 No conflict:
 image: null-co://
 file format: null-co
-virtual size: 1.0G (1073741824 bytes)
+virtual size: 1 GiB (1073741824 bytes)
 disk size: unavailable

 Conflict:
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index a513ccca0bb..3fc92bb56e5 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -395,13 +395,13 @@ wrote 65536/65536 bytes at offset 1048576
 }
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
 image: TEST_DIR/t.IMGFMT.ovl2
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
@@ -813,13 +813,13 @@ wrote 65536/65536 bytes at offset 1048576
 }
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
 image: TEST_DIR/t.IMGFMT.ovl2
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index 1e9330b1be5..e6df0d6781b 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -35,7 +35,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,back=
ing.node-name=3Dmid

 image: TEST_DIR/t.IMGFMT.mid
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: /dev/null
 backing file format: IMGFMT
@@ -73,7 +73,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,node=
-name=3Dtop

 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: /dev/null
 backing file format: IMGFMT
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index adb805cce9c..e86b175e39b 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -34,7 +34,7 @@ read 16777216/16777216 bytes at offset 0
 =3D=3D checking image base =3D=3D
 image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
 file format: IMGFMT
-virtual size: 16M (16777216 bytes)
+virtual size: 16 MiB (16777216 bytes)
 Format specific information:
     encrypt:
         ivgen alg: plain64
@@ -76,7 +76,7 @@ Format specific information:
 =3D=3D checking image layer =3D=3D
 image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
-virtual size: 16M (16777216 bytes)
+virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
 Format specific information:
     encrypt:
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 0f1c23babba..61e7241e0bf 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -14,7 +14,7 @@

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -36,7 +36,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -58,7 +58,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 2097152
 Format specific information:
     compat: 1.1
@@ -80,7 +80,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 512
 backing file: TEST_IMG.base
 backing file format: IMGFMT
@@ -97,7 +97,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 encrypted: yes
 cluster_size: 65536
 Format specific information:
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 568e8619d0a..979d5cf745c 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -7,12 +7,12 @@

 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)


 image: TEST_IMG
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)

 =3D=3D=3D Test host-key-check options =3D=3D=3D

@@ -23,7 +23,7 @@ virtual size: 4.0M (4194304 bytes)

 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 8.0M (8388608 bytes)
+virtual size: 8 MiB (8388608 bytes)

 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "known_hosts"=
}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": =
"22"}}, "size": 4194304}}}
 {"return": {}}
@@ -32,7 +32,7 @@ virtual size: 8.0M (8388608 bytes)

 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)

 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
 {"return": {}}
@@ -47,7 +47,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'

 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 8.0M (8388608 bytes)
+virtual size: 8 MiB (8388608 bytes)

 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"ho=
st": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
 {"return": {}}
@@ -62,7 +62,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'

 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)

 =3D=3D=3D Invalid path and user =3D=3D=3D

diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index a3692ce00df..a5e88e2a824 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -14,7 +14,7 @@

 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
@@ -66,7 +66,7 @@ Format specific information:

 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
@@ -121,7 +121,7 @@ Job failed: Cannot find device=3Dthis doesn't exist n=
or node_name=3Dthis doesn't exi

 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
@@ -191,7 +191,7 @@ Job failed: The requested file size is too large
 {"error": {"class": "GenericError", "desc": "Parameter 'size' expects a =
>0 size"}}
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index 682adc2a109..b83384deea6 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -14,7 +14,7 @@

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 1048576

 [{ "start": 0, "length": 134217728, "depth": 0, "zero": true, "data": fa=
lse}]
@@ -33,7 +33,7 @@ cluster_size: 1048576

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576

 [{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": fal=
se}]
@@ -52,7 +52,7 @@ cluster_size: 1048576

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 1048576

 [{ "start": 0, "length": 3072, "depth": 0, "zero": false, "data": true, =
"offset": 1024},
@@ -75,7 +75,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 cluster_size: 1048576

 =3D=3D=3D Maximum size =3D=3D=3D
@@ -87,7 +87,7 @@ cluster_size: 1048576

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 512T (562949819203584 bytes)
+virtual size: 512 TiB (562949819203584 bytes)
 cluster_size: 1048576

 =3D=3D=3D Invalid sizes =3D=3D=3D
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
index 22810720cf9..1538d679bef 100644
--- a/tests/qemu-iotests/212.out
+++ b/tests/qemu-iotests/212.out
@@ -14,7 +14,7 @@

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)

 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D

@@ -30,7 +30,7 @@ virtual size: 128M (134217728 bytes)

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)

 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D

@@ -46,7 +46,7 @@ virtual size: 64M (67108864 bytes)

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)

 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D

@@ -65,7 +65,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)

 =3D=3D=3D Maximum size =3D=3D=3D

@@ -76,7 +76,7 @@ virtual size: 0 (0 bytes)

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 4096T (4503599627369984 bytes)
+virtual size: 4 PiB (4503599627369984 bytes)

 =3D=3D=3D Invalid sizes =3D=3D=3D

diff --git a/tests/qemu-iotests/213.out b/tests/qemu-iotests/213.out
index 169083e08ee..be4ae85180a 100644
--- a/tests/qemu-iotests/213.out
+++ b/tests/qemu-iotests/213.out
@@ -14,7 +14,7 @@

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8388608

 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
@@ -31,7 +31,7 @@ cluster_size: 8388608

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 8388608

 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
@@ -48,7 +48,7 @@ cluster_size: 8388608

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 268435456

 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
@@ -68,7 +68,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 cluster_size: 8388608

 =3D=3D=3D Maximum size =3D=3D=3D
@@ -80,7 +80,7 @@ cluster_size: 8388608

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64T (70368744177664 bytes)
+virtual size: 64 TiB (70368744177664 bytes)
 cluster_size: 67108864

 =3D=3D=3D Invalid sizes =3D=3D=3D
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 9511b6ea658..4edc2dd5cfb 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -28,11 +28,11 @@ server reported: Option 0x8 not permitted before TLS
 =3D=3D check TLS works =3D=3D
 image: nbd://127.0.0.1:PORT
 file format: nbd
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 disk size: unavailable
 image: nbd://127.0.0.1:PORT
 file format: nbd
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 disk size: unavailable
 exports available: 1
  export: ''
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
index 2aaa68f6726..a8c800bfada 100644
--- a/tests/qemu-iotests/237.out
+++ b/tests/qemu-iotests/237.out
@@ -14,7 +14,7 @@

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 5.0G (5368709120 bytes)
+virtual size: 5 GiB (5368709120 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -41,7 +41,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -68,7 +68,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -169,7 +169,7 @@ Job failed: List of extents contains unused extents

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 512 (512 bytes)
+virtual size: 512 B (512 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -189,7 +189,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 512 (512 bytes)
+virtual size: 512 B (512 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -211,7 +211,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0G (1073741824 bytes)
+virtual size: 1 GiB (1073741824 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -231,7 +231,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0G (1073741824 bytes)
+virtual size: 1 GiB (1073741824 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -253,7 +253,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 2.0G (2147483648 bytes)
+virtual size: 2 GiB (2147483648 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -273,7 +273,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 2.0G (2147483648 bytes)
+virtual size: 2 GiB (2147483648 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -295,7 +295,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 5.0G (5368709120 bytes)
+virtual size: 5 GiB (5368709120 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -323,7 +323,7 @@ Format specific information:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 5.0G (5368709120 bytes)
+virtual size: 5 GiB (5368709120 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index fbe05d71c09..7ac8404d11c 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -8,7 +8,7 @@ qemu-img info dump:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -28,7 +28,7 @@ qemu-img info dump:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -60,7 +60,7 @@ qemu-img info dump:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -100,7 +100,7 @@ qemu-img info dump:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -149,7 +149,7 @@ Unset the unknown bitmap flag '0x4' in the bitmap dir=
ectory entry:

 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
--=20
2.20.1


