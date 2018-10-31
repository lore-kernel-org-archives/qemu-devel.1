Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQU-0002HQ-N3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQT-0003ze-R7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:13 -0300
Message-Id: <20181031003120.26771-9-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] iotests: 'new' module replacement in 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Max Reitz <mreitz@redhat.com>

iotest 169 uses the 'new' module to add methods to a class.  This module
no longer exists in Python 3.  Instead, we can use a lambda.  Best of
all, this works in 2.7 just as well.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181022135307.14398-8-mreitz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qemu-iotests/169 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 69850c4c67..527aebd0cb 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -23,7 +23,6 @@ import iotests
 import time
 import itertools
 import operator
-import new
 import re
 from iotests import qemu_img
 
@@ -204,7 +203,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
 def inject_test_case(klass, name, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
-    setattr(klass, 'test_' + method + name, new.instancemethod(mc, None, klass))
+    setattr(klass, 'test_' + method + name, lambda self: mc(self))
 
 for cmb in list(itertools.product((True, False), repeat=4)):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
-- 
2.18.0.rc1.1.g3f1ff2140
