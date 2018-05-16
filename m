Received: from eggs.gnu.org ([2001:4830:134:3::10]:33372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0Rw-0006vL-6I
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0Ru-0006or-F2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:42:52 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 16 May 2018 13:42:31 -0400
Message-Id: <20180516174234.311-2-jcody@redhat.com>
In-Reply-To: <20180516174234.311-1-jcody@redhat.com>
References: <20180516174234.311-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] qemu-iotests: reduce chance of races in 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 8565c3ab537e78f3e69977ec2c609dc9417a806e ("qemu-iotests: fix
185") identified a race condition in a sub-test.

Similar issues also affect the other sub-tests.  If disk I/O completes
quickly, it races with the QMP 'quit' command.  This causes spurious
test failures because QMP events are emitted in an unpredictable order.

This test relies on QEMU internals and there is no QMP API for getting
deterministic behavior needed to make this test 100% reliable.  At the
same time, the test is useful and it would be a shame to remove it.

Add sleep 0.5 to reduce the chance of races.  This is not a real fix but
appears to reduce spurious failures in practice.

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180508135436.30140-2-stefanha@redhat.com
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/185 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 298d88d04e..975404c99d 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -118,6 +118,9 @@ _send_qemu_cmd $h \
                       'speed': 65536 } }" \
     "return"
 
+# If we don't sleep here 'quit' command races with disk I/O
+sleep 0.5
+
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
 wait=1 _cleanup_qemu
 
@@ -137,6 +140,9 @@ _send_qemu_cmd $h \
                       'speed': 65536 } }" \
     "return"
 
+# If we don't sleep here 'quit' command races with disk I/O
+sleep 0.5
+
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
 wait=1 _cleanup_qemu
 
@@ -183,6 +189,9 @@ _send_qemu_cmd $h \
                       'speed': 65536 } }" \
     "return"
 
+# If we don't sleep here 'quit' command races with disk I/O
+sleep 0.5
+
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
 wait=1 _cleanup_qemu
 
@@ -201,6 +210,9 @@ _send_qemu_cmd $h \
                       'speed': 65536 } }" \
     "return"
 
+# If we don't sleep here 'quit' command races with disk I/O
+sleep 0.5
+
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
 wait=1 _cleanup_qemu
 
-- 
2.13.6
