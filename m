Received: from eggs.gnu.org ([2001:4830:134:3::10]:56701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000pj-9q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO35-0000J0-OO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO35-0000IJ-JG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AA8D4023336
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-237.ams2.redhat.com
	[10.36.117.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 07CE81C71D
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:25 +0200
Message-Id: <20180622153228.23594-8-armbru@redhat.com>
In-Reply-To: <20180622153228.23594-1-armbru@redhat.com>
References: <20180622153228.23594-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] qapi: Open files with encoding='utf-8'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Python 2 happily reads UTF-8 files in text mode, but Python 3 requires
either UTF-8 locale or an explicit encoding passed to open().  Commit
d4e5ec877ca fixed this by setting the en_US.UTF-8 locale.  Falls apart
when the locale isn't be available.

Matthias Maier and Arfrever Frehtes Taifersar Arahesis proposed to use
binary mode instead, with manual conversion from bytes to str.  Works,
but opening with an explicit encoding is simpler, so do that.

Since Python 2's open() doesn't support the encoding parameter, we
need to suppress it with a version check.

Reported-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
Reported-by: Matthias Maier <tamiko@43-1.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180618175958.29073-2-armbru@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4b53f08627..8b6708dbf1 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -16,6 +16,7 @@ import errno
 import os
 import re
 import string
+import sys
 from collections import OrderedDict
 
 builtin_types = {
@@ -340,7 +341,10 @@ class QAPISchemaParser(object):
             return None
 
         try:
-            fobj = open(incl_fname, 'r')
+            if sys.version_info[0] >= 3:
+                fobj = open(incl_fname, 'r', encoding='utf-8')
+            else:
+                fobj = open(incl_fname, 'r')
         except IOError as e:
             raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
         return QAPISchemaParser(fobj, previously_included, info)
@@ -1493,7 +1497,11 @@ class QAPISchemaEvent(QAPISchemaEntity):
 class QAPISchema(object):
     def __init__(self, fname):
         self._fname = fname
-        parser = QAPISchemaParser(open(fname, 'r'))
+        if sys.version_info[0] >= 3:
+            f = open(fname, 'r', encoding='utf-8')
+        else:
+            f = open(fname, 'r')
+        parser = QAPISchemaParser(f)
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
         self._entity_list = []
@@ -2007,7 +2015,10 @@ class QAPIGen(object):
                 if e.errno != errno.EEXIST:
                     raise
         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
-        f = os.fdopen(fd, 'r+')
+        if sys.version_info[0] >= 3:
+            f = open(fd, 'r+', encoding='utf-8')
+        else:
+            f = os.fdopen(fd, 'r+')
         text = (self._top(fname) + self._preamble + self._body
                 + self._bottom(fname))
         oldtext = f.read(len(text) + 1)
-- 
2.17.1
