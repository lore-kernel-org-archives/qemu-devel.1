Received: from eggs.gnu.org ([209.51.188.92]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hG3jk-0006mq-Vm
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hG3jj-0004uv-T3
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:41:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Apr 2019 17:41:29 +0200
Message-Id: <20190415154129.31021-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] iotests: Fix iotests 110 and 126
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>, arbel.moshe@oracle.com, liran.alon@oracle.com, yoav.elnekave@oracle.com, mark.kanda@oracle.com, Fam Zheng <fam@euphon.net>

A recent patch results in qemu-img reporting the backing file format of
vmdk images as vmdk.  This broke iotests 110 and 126.

Fixes: "vmdk: Set vmdk parent backing_format to vmdk"
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
RFC because:
(1) I'd prefer for this patch to be squashed into the patch mentioned
    above so we avoid broken iotests.
(2) Otherwise, I'd like for the "Fixes" line to contain a commit ID,
    which isn't stable yet, though.

I'd like to mention that these aren't the only broken iotests on
block-next; 059 (with vmdk) is broken, too.  I won't send a patch for
that, though, because to me the whole patch doesn't seem quite right
when compiling qemu with -m32.
---
 tests/qemu-iotests/110 | 10 +++++++---
 tests/qemu-iotests/126 | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1ae..33b169ffd4 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -53,8 +53,12 @@ TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG_REL.base" 64M
 # qemu should be able to reconstruct the filename, so relative backing n=
ames
 # should work
+# (We have to filter the backing file format because vmdk always
+# reports it (as vmdk), whereas other image formats would do so only
+# with the backing_fmt creation option, which neither vmdk nor qcow
+# support)
 TEST_IMG=3D"json:{'driver':'$IMGFMT','file':{'driver':'file','filename':=
'$TEST_IMG'}}" \
-    _img_info | _filter_img_info
+    _img_info | _filter_img_info | grep -v 'backing file format'
=20
 echo
 echo '=3D=3D=3D Non-reconstructable filename =3D=3D=3D'
@@ -78,7 +82,7 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v 'backing file format'
=20
 echo
 echo '=3D=3D=3D Backing name is always relative to the backed image =3D=3D=
=3D'
@@ -110,7 +114,7 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v 'backing file format'
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d59..e3ee65c606 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -62,8 +62,12 @@ TOP_IMG=3D"$TEST_DIR/image:top.$IMGFMT"
 TEST_IMG=3D$BASE_IMG _make_test_img 64M
 TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
=20
-# The default cluster size depends on the image format
-TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
+# (1) The default cluster size depends on the image format
+# (2) vmdk only supports vmdk backing files, so it always reports the
+#     format of its backing file as such (but neither it nor qcow
+#     support the backing_fmt creation option, so we cannot use that to
+#     harmonize the output across all image formats this test supports)
+TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file=
 format'
=20
 _rm_test_img "$BASE_IMG"
 _rm_test_img "$TOP_IMG"
@@ -79,7 +83,7 @@ TOP_IMG=3D"file:image:top.$IMGFMT"
 TEST_IMG=3D$BASE_IMG _make_test_img 64M
 TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
=20
-TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file=
 format'
=20
 _rm_test_img "$BASE_IMG"
 _rm_test_img "image:top.$IMGFMT"
--=20
2.20.1
