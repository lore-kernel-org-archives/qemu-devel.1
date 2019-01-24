Received: from eggs.gnu.org ([209.51.188.92]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gme51-0000pz-63
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gme50-0004mU-5O
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:25:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 15:25:25 +0300
Message-Id: <20190124122525.145968-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190124122525.145968-1-vsementsov@virtuozzo.com>
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] iotest: fix 169: do not run qmp_cont in
 RUN_STATE_FINISH_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, lcapitulino@redhat.com, dgilbert@redhat.com

qmp_cont fails if vm in RUN_STATE_FINISH_MIGRATE, so let's wait for
final RUN_STATE_POSTMIGRATE. Also, while being here, check qmp_cont
result.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/169 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 527aebd0cb..7e06cc1145 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -102,12 +102,17 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             event = self.vm_a.event_wait('MIGRATION')
             if event['data']['status'] == 'completed':
                 break
+        while True:
+            result = self.vm_a.qmp('query-status')
+            if (result['return']['status'] == 'postmigrate'):
+                break
 
         # test that bitmap is still here
         removed = (not migrate_bitmaps) and persistent
         self.check_bitmap(self.vm_a, False if removed else sha256)
 
-        self.vm_a.qmp('cont')
+        result = self.vm_a.qmp('cont')
+        self.assert_qmp(result, 'return', {})
 
         # test that bitmap is still here after invalidation
         self.check_bitmap(self.vm_a, sha256)
-- 
2.18.0
