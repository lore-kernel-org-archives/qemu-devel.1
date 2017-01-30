Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cY96L-0003Gw-3v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cY96G-00058d-5W
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:22:21 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:23322 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cY96F-000523-Qr
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:22:16 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 30 Jan 2017 13:22:10 +0300
Message-Id: <1485771730-19849-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] mirror: restore offset after zeroing out
 the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If explicit zeroing out before mirroring is required for the target image,
it moves the block job offset counter to EOF, then offset and len counters
count the image size twice.

There is no harm but confusing stats (e.g. for 1G image the completion
counter starts from 1G and increases to 2G)

The patch fixed that problem by resetting the offset counter.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Jeff Cody <jcody@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c             | 3 +++
 tests/qemu-iotests/094.out | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 301ba92..94915e8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -587,6 +587,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }
 
         mirror_wait_for_all_io(s);
+
+        /* offset has moved to EOF, restore it */
+        s->common.offset = 0;
     }
 
     /* First part, loop on the sectors and initialize the dirty bitmap.  */
diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index b66dc07..522a20c 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -3,9 +3,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 *** done
-- 
2.7.4
