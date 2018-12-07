Received: from eggs.gnu.org ([2001:4830:134:3::10]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhz-0007Ak-Bk
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhx-0006HI-Qg
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:54:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Dec 2018 12:53:43 +0100
Message-Id: <20181207115343.6747-6-kwolf@redhat.com>
In-Reply-To: <20181207115343.6747-1-kwolf@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/5] vmdk: Reject excess extents in
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Clarify that the number of extents provided in BlockdevCreateOptionsVmdk
must match the number of extents that will actually be used. Providing
more extents will result in an error now.

This requires adapting the test case to provide the right number of
extents.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       |  3 ++-
 block/vmdk.c               | 29 ++++++++++++++++++++++++-----
 tests/qemu-iotests/237     |  6 +++++-
 tests/qemu-iotests/237.out | 13 +++++++------
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0793550cf2..afdd2f89a2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4068,7 +4068,8 @@
 #               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
 #               monolithicFlat, only one entry is required; for
 #               twoGbMaxExtent* formats, the number of entries required =
is
-#               calculated as extent_number =3D virtual_size / 2GB.
+#               calculated as extent_number =3D virtual_size / 2GB. Prov=
iding
+#               more extents than will be used is an error.
 # @subformat    The subformat of the VMDK image. Default: "monolithicSpa=
rse".
 # @backing-file The path of backing file. Default: no backing file is us=
ed.
 # @adapter-type The adapter type used to fill in the descriptor. Default=
: ide.
diff --git a/block/vmdk.c b/block/vmdk.c
index 5a162ee85c..682ad93aa1 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1970,6 +1970,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t s=
ize,
 {
     int extent_idx;
     BlockBackend *blk =3D NULL;
+    BlockBackend *extent_blk;
     Error *local_err =3D NULL;
     char *desc =3D NULL;
     int ret =3D 0;
@@ -2107,7 +2108,6 @@ static int coroutine_fn vmdk_co_do_create(int64_t s=
ize,
     }
     extent_idx =3D 1;
     while (created_size < size) {
-        BlockBackend *extent_blk;
         int64_t cur_size =3D MIN(size - created_size, extent_size);
         extent_blk =3D extent_fn(cur_size, extent_idx, flat, split, comp=
ress,
                                zeroed_grain, opaque, errp);
@@ -2121,6 +2121,17 @@ static int coroutine_fn vmdk_co_do_create(int64_t =
size,
         extent_idx++;
         blk_unref(extent_blk);
     }
+
+    /* Check whether we got excess extents */
+    extent_blk =3D extent_fn(-1, extent_idx, flat, split, compress, zero=
ed_grain,
+                           opaque, NULL);
+    if (extent_blk) {
+        blk_unref(extent_blk);
+        error_setg(errp, "List of extents contains unused extents");
+        ret =3D -EINVAL;
+        goto exit;
+    }
+
     /* generate descriptor file */
     desc =3D g_strdup_printf(desc_template,
                            g_random_int(),
@@ -2181,6 +2192,12 @@ static BlockBackend *vmdk_co_create_opts_cb(int64_=
t size, int idx,
     char *ext_filename =3D NULL;
     char *rel_filename =3D NULL;
=20
+    /* We're done, don't create excess extents. */
+    if (size =3D=3D -1) {
+        assert(errp =3D=3D NULL);
+        return NULL;
+    }
+
     if (idx =3D=3D 0) {
         rel_filename =3D g_strdup_printf("%s%s", data->prefix, data->pos=
tfix);
     } else if (split) {
@@ -2342,10 +2359,12 @@ static BlockBackend *vmdk_co_create_cb(int64_t si=
ze, int idx,
     blk_set_allow_write_beyond_eof(blk, true);
     bdrv_unref(bs);
=20
-    ret =3D vmdk_init_extent(blk, size, flat, compress, zeroed_grain, er=
rp);
-    if (ret) {
-        blk_unref(blk);
-        blk =3D NULL;
+    if (size !=3D -1) {
+        ret =3D vmdk_init_extent(blk, size, flat, compress, zeroed_grain=
, errp);
+        if (ret) {
+            blk_unref(blk);
+            blk =3D NULL;
+        }
     }
     return blk;
 }
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index e04a1ac6be..251771d7fb 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -20,6 +20,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
+import math
 import iotests
 from iotests import imgfmt
=20
@@ -222,12 +223,15 @@ with iotests.FilePath('t.vmdk') as disk_path, \
             iotests.log("=3D %s %d =3D" % (subfmt, size))
             iotests.log("")
=20
+            num_extents =3D math.ceil(size / 2.0**31)
+            extents =3D [ "ext%d" % (i) for i in range(1, num_extents + =
1) ]
+
             vm.launch()
             blockdev_create(vm, { 'driver': imgfmt,
                                   'file': 'node0',
                                   'size': size,
                                   'subformat': subfmt,
-                                  'extents': ['ext1', 'ext2', 'ext3'] })
+                                  'extents': extents })
             vm.shutdown()
=20
             iotests.img_info_log(disk_path)
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
index 1aa9aad349..241c864369 100644
--- a/tests/qemu-iotests/237.out
+++ b/tests/qemu-iotests/237.out
@@ -154,6 +154,7 @@ Job failed: Extent [0] not specified
=20
 {"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "monolithicFlat"}}}
 {"return": {}}
+Job failed: List of extents contains unused extents
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
@@ -161,7 +162,7 @@ Job failed: Extent [0] not specified
=20
 =3D twoGbMaxExtentFlat 512 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "=
subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -181,7 +182,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 512 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "=
subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -203,7 +204,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentFlat 1073741824 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 1073741824, "subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 107374=
1824, "subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -223,7 +224,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 1073741824 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 1073741824, "subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 107374=
1824, "subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -245,7 +246,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentFlat 2147483648 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 2147483648, "subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 214748=
3648, "subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -265,7 +266,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 2147483648 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 2147483648, "subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 214748=
3648, "subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
--=20
2.19.2
