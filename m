Received: from eggs.gnu.org ([2001:4830:134:3::10]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDyFV-0003TQ-JW
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDyFU-0005OI-Ow
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:21:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 22:20:51 +0200
Message-Id: <20180502202051.15493-4-mreitz@redhat.com>
In-Reply-To: <20180502202051.15493-1-mreitz@redhat.com>
References: <20180502202051.15493-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] iotests: Add test for -U/force-share
 conflicts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/153     | 17 +++++++++++++++++
 tests/qemu-iotests/153.out | 16 ++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index a0fd815483..ec508c758f 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -242,6 +242,23 @@ _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
 
 _cleanup_qemu
 
+echo
+echo "== Detecting -U and force-share conflicts =="
+
+echo
+echo 'No conflict:'
+$QEMU_IMG info -U --image-opts driver=null-co,force-share=on
+echo
+echo 'Conflict:'
+$QEMU_IMG info -U --image-opts driver=null-co,force-share=off
+
+echo
+echo 'No conflict:'
+$QEMU_IO -c 'open -r -U -o driver=null-co,force-share=on'
+echo
+echo 'Conflict:'
+$QEMU_IO -c 'open -r -U -o driver=null-co,force-share=off'
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index bb721cb747..2510762ba1 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -399,4 +399,20 @@ Is another process using the image?
 Closing the other
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
+
+== Detecting -U and force-share conflicts ==
+
+No conflict:
+image: null-co://
+file format: null-co
+virtual size: 1.0G (1073741824 bytes)
+disk size: unavailable
+
+Conflict:
+qemu-img: --force-share/-U conflicts with image options
+
+No conflict:
+
+Conflict:
+-U conflicts with image options
 *** done
-- 
2.14.3
