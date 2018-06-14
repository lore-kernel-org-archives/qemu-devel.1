Received: from eggs.gnu.org ([2001:4830:134:3::10]:51643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTUQG-00068b-BM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTUQF-0001oQ-Br
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:28 -0400
Received: from tsukuyomi.43-1.org ([2a01:4f8:173:743::1:50]:50743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@kyomu.43-1.org>)
	id 1fTUQF-0001nu-4v
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:27 -0400
From: Matthias Maier <tamiko@43-1.org>
Date: Thu, 14 Jun 2018 10:43:57 -0500
Message-Id: <20180614154357.20132-3-tamiko@43-1.org>
In-Reply-To: <20180614154357.20132-1-tamiko@43-1.org>
References: <20180614154357.20132-1-tamiko@43-1.org>
Subject: [Qemu-devel] [PATCH 2/2] qapi: open files in binary mode and use
 explicit decoding/encoding in common.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, Matthias Maier <tamiko@43-1.org>

From: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

This is a different approach to fix the locale dependent encode/decode
problem in common.py utilizing the binary read/write mode [1,2] and
decode/encode with explicit UTF-8 encoding arguments [3].

This approach is preferred over the fix in commit d4e5ec877ca because it
is (a) locale independent, and (b) does not depend on the en_US.UTF_8
locale to be available.

[1] https://docs.python.org/3.6/library/stdtypes.html#bytes.decode
[2] https://docs.python.org/3.6/library/stdtypes.html#str.encode
[3] https://docs.python.org/3/howto/unicode.html

Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
Signed-off-by: Matthias Maier <tamiko@43-1.org>
---
 scripts/qapi/common.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2462fc0291..8f8ccc65c3 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -258,7 +258,7 @@ class QAPISchemaParser(object):
         self.fname = fp.name
         previously_included.append(os.path.abspath(fp.name))
         self.incl_info = incl_info
-        self.src = fp.read()
+        self.src = fp.read().decode("UTF-8")
         if self.src == '' or self.src[-1] != '\n':
             self.src += '\n'
         self.cursor = 0
@@ -340,7 +340,7 @@ class QAPISchemaParser(object):
             return None
 
         try:
-            fobj = open(incl_fname, 'r')
+            fobj = open(incl_fname, 'rb')
         except IOError as e:
             raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
         return QAPISchemaParser(fobj, previously_included, info)
@@ -1492,7 +1492,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
 class QAPISchema(object):
     def __init__(self, fname):
         self._fname = fname
-        parser = QAPISchemaParser(open(fname, 'r'))
+        parser = QAPISchemaParser(open(fname, 'rb'))
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
         self._entity_list = []
@@ -2006,14 +2006,14 @@ class QAPIGen(object):
                 if e.errno != errno.EEXIST:
                     raise
         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
-        f = os.fdopen(fd, 'r+')
+        f = os.fdopen(fd, 'r+b')
         text = (self._top(fname) + self._preamble + self._body
                 + self._bottom(fname))
-        oldtext = f.read(len(text) + 1)
+        oldtext = f.read(len(text) + 1).decode("UTF-8")
         if text != oldtext:
             f.seek(0)
             f.truncate(0)
-            f.write(text)
+            f.write(text.encode("UTF-8"))
         f.close()
 
 
-- 
2.16.4
