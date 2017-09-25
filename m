Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwUnN-0005YP-SV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwUnI-000313-NR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:55:41 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:28024 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwUnI-00030F-BL
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:55:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 17:55:29 +0300
Message-Id: <20170925145529.188686-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] iotests: fix 181: enable postcopy-ram
 capability on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com
Cc: quintela@redhat.com, dgilbert@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Migration capabilities should be enabled on both source and
destination qemu processes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all.

After my patch

    commit 58110f0acb1a33e2bc60a2f1b26d2690a92e8a14
    Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
    Date:   Mon Jul 10 19:30:16 2017 +0300

        migration: split common postcopy out of ram postcopy

test 181 becomes broken. Sorry for that.

Actually, test 181 itself should be fixed, so, here is a fix.
The problem was noted by Kevin, and it touches also some problems
with image locking, which I don't see with my older kernel, so,
please check is this patch fixes all problems.

 tests/qemu-iotests/181     | 2 ++
 tests/qemu-iotests/181.out | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 0333dda0e3..0c91e8f9de 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -93,7 +93,9 @@ echo
 
 # Slow down migration so much that it definitely won't finish before we can
 # switch to postcopy
+# Enable postcopy-ram capability both on source and destination
 silent=yes
+_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
 _send_qemu_cmd $src 'migrate_set_speed 4k' "(qemu)"
 _send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
 _send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
diff --git a/tests/qemu-iotests/181.out b/tests/qemu-iotests/181.out
index 6534ba2a76..d58c6a9dab 100644
--- a/tests/qemu-iotests/181.out
+++ b/tests/qemu-iotests/181.out
@@ -20,7 +20,6 @@ read 65536/65536 bytes at offset 0
 
 === Do some I/O on the destination ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) qemu-io disk "read -P 0x55 0 64k"
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.11.1
