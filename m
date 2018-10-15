Received: from eggs.gnu.org ([2001:4830:134:3::10]:33877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCCSa-0001kW-Vi
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCCSY-0007l7-JH
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:39:40 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-8-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <14120cdc-1517-f9af-9f35-3c78b4f634a9@redhat.com>
Date: Mon, 15 Oct 2018 19:38:45 -0400
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in
 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/15/18 10:14 AM, Max Reitz wrote:
> iotest 169 uses the 'new' module to add methods to a class.  This module
> no longer exists in Python 3.  Instead, we can use a lambda.  Best of
> all, this works in 2.7 just as well.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/169 | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> index f243db9955..e5614b159d 100755
> --- a/tests/qemu-iotests/169
> +++ b/tests/qemu-iotests/169
> @@ -23,7 +23,6 @@ import iotests
>  import time
>  import itertools
>  import operator
> -import new
>  from iotests import qemu_img
>  
>  
> @@ -144,7 +143,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>  
>  def inject_test_case(klass, name, method, *args, **kwargs):
>      mc = operator.methodcaller(method, *args, **kwargs)
> -    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
> +    setattr(klass, 'test_' + name, lambda self: mc(self))
>  
>  for cmb in list(itertools.product((True, False), repeat=4)):
>      name = ('_' if cmb[0] else '_not_') + 'persistent_'
> 

This can be simplified with:

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index e5614b159d..2199f14ae7 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -22,7 +22,6 @@ import os
 import iotests
 import time
 import itertools
-import operator
 from iotests import qemu_img


@@ -141,18 +140,15 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.check_bitmap(self.vm_b, sha256 if persistent else False)


-def inject_test_case(klass, name, method, *args, **kwargs):
-    mc = operator.methodcaller(method, *args, **kwargs)
-    setattr(klass, 'test_' + name, lambda self: mc(self))
-
 for cmb in list(itertools.product((True, False), repeat=4)):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
     name += ('_' if cmb[1] else '_not_') + 'migbitmap_'
     name += '_online' if cmb[2] else '_offline'
     name += '_shared' if cmb[3] else '_nonshared'

-    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
-                     *list(cmb))
+    setattr(TestDirtyBitmapMigration, 'test_' + name,
+            lambda self: TestDirtyBitmapMigration.do_test_migration(
+                self, *list(cmb)))


 if __name__ == '__main__':
