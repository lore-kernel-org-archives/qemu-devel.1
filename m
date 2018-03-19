Received: from eggs.gnu.org ([2001:4830:134:3::10]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exqgZ-0008LF-EF
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exqgV-0007MX-DB
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:02:31 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 19 Mar 2018 12:02:23 +0300
Message-Id: <20180319090223.23336-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180319090223.23336-1-vsementsov@virtuozzo.com>
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 3/3] iotests: enable shared migration cases
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
 tests/qemu-iotests/169 | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

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
-- 
2.11.1
