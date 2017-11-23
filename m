Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxD-0004yp-VX
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxD-0001cT-33
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:27 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:22 +0100
Message-Id: <20171123020832.8165-8-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] iotests: Forbid 020 for non-file
 protocols
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

This test does funny things like TEST_IMG="TEST_IMG.base" _make_test_img
that usually only work with the file protocol.  More specifically, they
do not work with the most interesting non-file protocols, so we might as
well skip this for anything but file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/020 | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index cefe3a830e..d22ab81414 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -42,18 +42,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto generic
-_unsupported_proto vxhs
+_supported_proto file
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
 
-# NFS does not support bdrv_reopen_prepare thus qemu-img commit fails.
-if [ "$IMGPROTO" = "nfs" ]; then
-    _notrun "image protocol $IMGPROTO does not support bdrv_commit"
-fi
-
 TEST_OFFSETS="0 4294967296"
 
 TEST_IMG_SAVE="$TEST_IMG"
-- 
2.13.6
