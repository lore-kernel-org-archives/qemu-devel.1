Received: from eggs.gnu.org ([2001:4830:134:3::10]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6o-0000ot-Bs
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6n-0007WG-G5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6n-0007Uh-9C
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 872A94E4C5
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:25 -0600
Message-Id: <20180301194245.29854-11-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 10/30] qapi: Touch generated files only when
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
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

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
Message-Id: <20180211093607.27351-11-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: fix octal constant for python3]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c3ae590202a..47673928dcc 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1951,9 +1951,16 @@ class QAPIGen(object):
             except os.error as e:
                 if e.errno != errno.EEXIST:
                     raise
-        f = open(os.path.join(output_dir, fname), 'w')
-        f.write(self._top(fname) + self._preamble + self._body
+        fd = os.open(os.path.join(output_dir, fname),
+                     os.O_RDWR | os.O_CREAT, 0o666)
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
2.14.3
