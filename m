Received: from eggs.gnu.org ([208.118.235.92]:43552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDv3-00036f-KT
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDcB-0007tp-LK
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:21:26 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Dec 2018 15:20:20 +0300
Message-Id: <20181229122027.42245-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-1-vsementsov@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 04/11] iotests: handle -f argument correctly
 for qemu_io_silent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

Correctly rewrite default argument. After the patch, the function can
be used for other (not only default test-chosen) image format.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9595429fea..76877ad584 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -139,7 +139,12 @@ def qemu_io(*args):
 
 def qemu_io_silent(*args):
     '''Run qemu-io and return the exit code, suppressing stdout'''
-    args = qemu_io_args + list(args)
+    if '-f' in qemu_io_args and '-f' in args:
+        ind = qemu_io_args.index('-f')
+        args = qemu_io_args[:ind] + qemu_io_args[ind+2:] + list(args)
+    else:
+        args = qemu_io_args + list(args)
+
     exitcode = subprocess.call(args, stdout=open('/dev/null', 'w'))
     if exitcode < 0:
         sys.stderr.write('qemu-io received signal %i: %s\n' %
-- 
2.18.0
