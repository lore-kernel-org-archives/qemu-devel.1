Received: from eggs.gnu.org ([2001:4830:134:3::10]:33385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dfSkQ-0001mK-6i
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dfSkO-0006wj-WA
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:18:14 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:24108 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dfSkO-0006tv-KC
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:18:12 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  9 Aug 2017 18:17:57 +0300
Message-Id: <20170809151757.15743-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 for 2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

185 can sometimes produce wrong output like this:

=========================================
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
=========================================

This is because quite happens before first mirror request is done
(and, in specified case, even before block-job len field is set).
To prevent it let's just add a sleep for 0.3 seconds before quite.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: just add a sleep instead of filtering output (proposed by Kevin)

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
2.11.1
