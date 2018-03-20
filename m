Received: from eggs.gnu.org ([2001:4830:134:3::10]:42636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKhW-0001Mi-86
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKhS-0001KT-7x
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:05:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 20 Mar 2018 20:05:21 +0300
Message-Id: <20180320170521.32152-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180320170521.32152-1-vsementsov@virtuozzo.com>
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 3/3] iotests: enable shared migration cases
 in 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Shared migration for dirty bitmaps is fixed by previous patches,
so we can enable the test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/169     | 8 +++-----
 tests/qemu-iotests/169.out | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 3a8db91f6f..153b10b6e7 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -140,16 +140,14 @@ def inject_test_case(klass, name, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
     setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
 
-for cmb in list(itertools.product((True, False), repeat=3)):
+for cmb in list(itertools.product((True, False), repeat=4)):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
     name += ('_' if cmb[1] else '_not_') + 'migbitmap_'
     name += '_online' if cmb[2] else '_offline'
-
-    # TODO fix shared-storage bitmap migration and enable cases for it
-    args = list(cmb) + [False]
+    name += '_shared' if cmb[3] else '_nonshared'
 
     inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
-                     *args)
+                     *list(cmb))
 
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index 594c16f49f..b6f257674e 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-........
+................
 ----------------------------------------------------------------------
-Ran 8 tests
+Ran 16 tests
 
 OK
-- 
2.11.1
