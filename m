Received: from eggs.gnu.org ([2001:4830:134:3::10]:33073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fG35H-0004BA-V3
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fG35B-0001y7-WE
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  8 May 2018 14:54:35 +0100
Message-Id: <20180508135436.30140-2-stefanha@redhat.com>
In-Reply-To: <20180508135436.30140-1-stefanha@redhat.com>
References: <20180508135436.30140-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qemu-iotests: reduce chance of races in
 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
2.14.3
