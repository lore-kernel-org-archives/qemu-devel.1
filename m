Received: from eggs.gnu.org ([208.118.235.92]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdO5-0004p8-Lb
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdKD-00037w-Dz
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdKC-00035B-Bb
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:24 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:23 +0100
Message-Id: <20180202130336.24719-9-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 08/21] qapi: Touch generated files only
 when they change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

A massive number of objects depends on QAPI-generated headers.  In my
"build everything" tree, it's roughly 4500 out of 4800.  This is
particularly annoying when only some of the generated files change,
say for a doc fix.

Improve qapi-gen.py to touch its output files only if they actually
change.  Rebuild time for a QAPI doc fix drops from many minutes to a
few seconds.  Rebuilds get faster for certain code changes, too.  For
instance, adding a simple QMP event now recompiles less than 200
instead of 4500 objects.  But adding a QAPI type is as bad as ever; we
clearly got more work to do.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index cfa2671ca3..be0fcc548a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1944,9 +1944,16 @@ class QAPIGen(object):
             except os.error as e:
                 if e.errno != errno.EEXIST:
                     raise
-        f = open(os.path.join(output_dir, fname), 'w')
-        f.write(self.top(fname) + self._preamble + self._body
+        fd = os.open(os.path.join(output_dir, fname),
+                     os.O_RDWR | os.O_CREAT, 0666)
+        f = os.fdopen(fd, 'r+')
+        text = (self.top(fname) + self._preamble + self._body
                 + self.bottom(fname))
+        oldtext = f.read(len(text) + 1)
+        if text != oldtext:
+            f.seek(0)
+            f.truncate(0)
+            f.write(text)
         f.close()
 
 
-- 
2.13.6
