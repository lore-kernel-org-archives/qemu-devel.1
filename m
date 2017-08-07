Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1deipl-00019h-3W
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1deipj-00034h-Pa
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:16:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  7 Aug 2017 17:16:30 +0300
Message-Id: <20170807141630.105066-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com

185 iotest is broken.

How to test:
> i=0; while ./check -qcow2 -nocache 185; do ((i+=1)); echo N = $i; \
  done; echo N = $i

finished for me like this:

185 2s ... - output mismatch (see 185.out.bad)
--- /work/src/qemu/master/tests/qemu-iotests/185.out    2017-07-14 \
    15:14:29.520343805 +0300
+++ 185.out.bad 2017-08-07 16:51:02.231922900 +0300
@@ -37,7 +37,7 @@
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
     "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
    "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
        "len": 4194304, "offset": 4194304, "speed": 65536, "type": \
            "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
    "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
        "len": 0, "offset": 0, "speed": 65536, "type": "mirror"}}

 === Start backup job and exit qemu ===

Failures: 185
Failed 1 of 1 tests
N = 8

It doesn't seems logical to expect the constant offset on cancel,
so let filter it out.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/185     | 2 +-
 tests/qemu-iotests/185.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 0eda371f27..446d78447e 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -157,7 +157,7 @@ _send_qemu_cmd $h \
     "return"
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
-wait=1 _cleanup_qemu
+wait=1 _cleanup_qemu | _filter_block_job_offset
 
 echo
 echo === Start backup job and exit qemu ===
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 57eaf8d699..f51af627fe 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -37,7 +37,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": OFFSET, "speed": 65536, "type": "mirror"}}
 
 === Start backup job and exit qemu ===
 
-- 
2.11.1
