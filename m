Received: from eggs.gnu.org ([2001:4830:134:3::10]:54012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3a-00070f-RN
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Y-0006Ln-3e
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3X-0006HS-GP
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:48 +0100
Message-Id: <20180211093607.27351-11-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/29] qapi: Touch generated files only when
 they change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

A massive number of objects depends on QAPI-generated headers.  In my
"build everything" tree, it's roughly 4800 out of 5100.  This is
particularly annoying when only some of the generated files change,
say for a doc fix.

Improve qapi-gen.py to touch its output files only if they actually
change.  Rebuild time for a QAPI doc fix drops from many minutes to a
few seconds.  Rebuilds get faster for certain code changes, too.  For
instance, adding a simple QMP event now recompiles less than 200
instead of 4800 objects.  But adding a QAPI type is as bad as ever;
we've clearly got more work to do.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8290795dc1..2e58573a39 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1951,9 +1951,16 @@ class QAPIGen(object):
             except os.error as e:
                 if e.errno != errno.EEXIST:
                     raise
-        f = open(os.path.join(output_dir, fname), 'w')
-        f.write(self._top(fname) + self._preamble + self._body
+        fd = os.open(os.path.join(output_dir, fname),
+                     os.O_RDWR | os.O_CREAT, 0666)
+        f = os.fdopen(fd, 'r+')
+        text = (self._top(fname) + self._preamble + self._body
                 + self._bottom(fname))
+        oldtext = f.read(len(text) + 1)
+        if text != oldtext:
+            f.seek(0)
+            f.truncate(0)
+            f.write(text)
         f.close()
 
 
-- 
2.13.6
