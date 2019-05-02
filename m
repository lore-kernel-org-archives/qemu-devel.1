Received: from eggs.gnu.org ([209.51.188.92]:53007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMBSO-0004YS-OX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMBSN-0006IQ-Mm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:09:00 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 16:08:22 +0300
Message-Id: <20190502130822.46858-2-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502130822.46858-1-shmuel.eiderman@oracle.com>
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to vmdk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, fam@euphon.net, eblake@redhat.com
Cc: shmuel.eiderman@oracle.com, arbel.moshe@oracle.com

Commit b69864e ("vmdk: Support version=3 in VMDK descriptor files")
fixed the probe function to correctly guess vmdk descriptors with
version=3.

This solves the issue where vmdk snapshot with parent vmdk descriptor
containing "version=3" would be treated as raw instead vmdk.

In the future case where a new vmdk version is introduced, we will again
experience this issue, even if the user will provide "-f vmdk" it will
only apply to the tip image and not to the underlying "misprobed" parent
image.

The code in vmdk.c already assumes that the backing file of vmdk must be
vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
vmdk).

So let's make it official by supplying the backing_format as vmdk.

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-By: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
---
 block/vmdk.c           | 2 ++
 tests/qemu-iotests/110 | 6 +++---
 tests/qemu-iotests/126 | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8dec6ef767..de8cb859f8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name);
         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
                 bs->auto_backing_file);
+        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
+                "vmdk");
     }
 
 out:
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1ae..982569dbc5 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -54,7 +54,7 @@ _make_test_img -b "$TEST_IMG_REL.base" 64M
 # qemu should be able to reconstruct the filename, so relative backing names
 # should work
 TEST_IMG="json:{'driver':'$IMGFMT','file':{'driver':'file','filename':'$TEST_IMG'}}" \
-    _img_info | _filter_img_info
+    _img_info | _filter_img_info | grep -v "backing file format"
 
 echo
 echo '=== Non-reconstructable filename ==='
@@ -78,7 +78,7 @@ TEST_IMG="json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v "backing file format"
 
 echo
 echo '=== Backing name is always relative to the backed image ==='
@@ -110,7 +110,7 @@ TEST_IMG="json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v "backing file format"
 
 
 # success, all done
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d59..1f7618c8a5 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -63,7 +63,7 @@ TEST_IMG=$BASE_IMG _make_test_img 64M
 TEST_IMG=$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
 
 # The default cluster size depends on the image format
-TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size\|backing file format'
 
 _rm_test_img "$BASE_IMG"
 _rm_test_img "$TOP_IMG"
@@ -79,7 +79,7 @@ TOP_IMG="file:image:top.$IMGFMT"
 TEST_IMG=$BASE_IMG _make_test_img 64M
 TEST_IMG=$TOP_IMG _make_test_img -b "$BASE_IMG"
 
-TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size\|backing file format'
 
 _rm_test_img "$BASE_IMG"
 _rm_test_img "image:top.$IMGFMT"
-- 
2.13.3
