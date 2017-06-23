Received: from eggs.gnu.org ([2001:4830:134:3::10]:59059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLW-0000IP-Lo
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLV-0007QW-W7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:00 +0200
Message-Id: <1498234919-27316-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/61] qemu-iotests: Allow starting new qemu
 after cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

After _cleanup_qemu(), test cases should be able to start the next qemu
process and call _cleanup_qemu() for that one as well. For this to work
cleanly, we need to improve the cleanup so that the second invocation
doesn't try to kill the qemu instances from the first invocation a
second time (which would result in error messages).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.qemu | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 7a78a00..76ef298 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -222,5 +222,8 @@ function _cleanup_qemu()
         rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
         eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
         eval "exec ${QEMU_OUT[$i]}<&-"
+
+        unset QEMU_IN[$i]
+        unset QEMU_OUT[$i]
     done
 }
-- 
1.8.3.1
