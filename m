Received: from eggs.gnu.org ([2001:4830:134:3::10]:48805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eh-0000FQ-7t
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3ef-0007fM-87
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 16:14:51 +0200
Message-Id: <20181015141453.32632-8-mreitz@redhat.com>
In-Reply-To: <20181015141453.32632-1-mreitz@redhat.com>
References: <20181015141453.32632-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

iotest 169 uses the 'new' module to add methods to a class.  This module
no longer exists in Python 3.  Instead, we can use a lambda.  Best of
all, this works in 2.7 just as well.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/169 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index f243db9955..e5614b159d 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -23,7 +23,6 @@ import iotests
 import time
 import itertools
 import operator
-import new
 from iotests import qemu_img
 
 
@@ -144,7 +143,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
 def inject_test_case(klass, name, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
-    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
+    setattr(klass, 'test_' + name, lambda self: mc(self))
 
 for cmb in list(itertools.product((True, False), repeat=4)):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
-- 
2.17.1
