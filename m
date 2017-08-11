Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZv-0001Lg-Fi
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZs-00033i-Rl
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:36 +0200
Message-Id: <20170811140536.2792-8-kwolf@redhat.com>
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] qemu-iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

185 can sometimes produce wrong output like this:

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

This is because, under heavy load, the quit can happen before the first
iteration of the mirror request has occurred.  To make sure we've had
time to iterate, let's just add a sleep for 0.5 seconds before quitting.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/185 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 0eda371f27..f5b47e4c1a 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -156,6 +156,10 @@ _send_qemu_cmd $h \
                       'speed': 65536 } }" \
     "return"
 
+# If we don't sleep here 'quit' command may be handled before
+# the first mirror iteration is done
+sleep 0.5
+
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
 wait=1 _cleanup_qemu
 
-- 
2.13.4
