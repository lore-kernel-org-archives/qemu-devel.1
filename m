Received: from eggs.gnu.org ([2001:4830:134:3::10]:38684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007xv-U7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007ug-KP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bZ-0007te-Ci
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:33 +0200
Message-Id: <20171002152552.27999-14-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 13/32] qapi: Use argparse to open schema
 file
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

QAPISchema.__init__() opens the schema file.  Since it doesn't bother
to catch exceptions, an invalid schema argument is reported like this:

    Traceback (most recent call last):
      File "../scripts/qapi-commands.py", line 318, in <module>
	schema = QAPISchema(args.schema)
      File "/work/armbru/qemu/scripts/qapi.py", line 1464, in __init__
	parser = QAPISchemaParser(open(fname, 'r'))
    IOError: [Errno 2] No such file or directory: 'nonexistent'

Leave it to argparse, which handles the exception like this:

    usage: qapi-commands.py [-h] [-o OUTPUT_DIR] [-p PREFIX] schema
    qapi-commands.py: error: argument schema: can't open 'nonexistent': [Errno 2] No such file or directory: 'nonexistent'

Too verbose for my taste, but let's not second-guess the standard
library.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                | 6 +++---
 scripts/qapi2texi.py           | 2 +-
 tests/qapi-schema/test-qapi.py | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 25f6c81b08..a33203e82d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1450,9 +1450,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
 
 
 class QAPISchema(object):
-    def __init__(self, fname):
+    def __init__(self, file):
         try:
-            parser = QAPISchemaParser(open(fname, 'r'))
+            parser = QAPISchemaParser(file)
             self.exprs = check_exprs(parser.exprs)
             self.docs = parser.docs
             self._entity_dict = {}
@@ -1934,7 +1934,7 @@ def common_argument_parser(builtins=False):
                         help='output directory')
     parser.add_argument('-p', '--prefix', default='', type=prefix,
                         help='prefix to add to output files')
-    parser.add_argument('schema',
+    parser.add_argument('schema', type=argparse.FileType('r'),
                         help='QAPI schema source file')
     return parser
 
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index fd90d8953e..d95d7541a3 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -282,7 +282,7 @@ def texi_schema(schema):
 def main(argv):
     """Takes schema argument, prints result to stdout"""
     parser = argparse.ArgumentParser()
-    parser.add_argument('schema',
+    parser.add_argument('schema', type=argparse.FileType('r'),
                         help='QAPI schema source file')
     args = parser.parse_args()
 
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index a7e21d016f..225417d861 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -53,7 +53,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                 print '    case %s: %s' % (v.name, v.type.name)
 
 parser = argparse.ArgumentParser()
-parser.add_argument('schema',
+parser.add_argument('schema', type=argparse.FileType('r'),
                     help='QAPI schema source file')
 args = parser.parse_args()
 
-- 
2.13.6
