Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIK-0001VB-Vz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIH-0002VO-06
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:00 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:25 -0500
Message-Id: <20180723201748.25573-17-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 16/99] iotests: Add test for -U/force-share
 conflicts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180502202051.15493-4-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 4e7d73c5fbd97e55ffe5af02f24d1f7dbe3bbf20)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1
