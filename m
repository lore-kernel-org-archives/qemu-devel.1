Received: from eggs.gnu.org ([2001:4830:134:3::10]:43415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOf-0007qj-C2
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOe-0007ad-Bq
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnQOe-0007a7-37
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:40 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 15:24:26 +0100
Message-Id: <20170831142430.16665-2-berrange@redhat.com>
In-Reply-To: <20170831142430.16665-1-berrange@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] qapi: convert to use python print
 function instead of statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

Get Py2 + 3 compatibility by using the print function
instead of print statement. This works for 2.6 onwards.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py      | 12 ++++++------
 scripts/qapi2texi.py |  9 +++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8aa2775f12..a60b79c126 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from __future__ import print_function
 import errno
 import getopt
 import os
@@ -1476,7 +1477,7 @@ class QAPISchema(object):
             self._def_exprs()
             self.check()
         except QAPIError as err:
-            print >>sys.stderr, err
+            print (err, file=sys.stderr)
             exit(1)
 
     def _def_entity(self, ent):
@@ -1936,7 +1937,7 @@ def parse_command_line(extra_options='', extra_long_options=[]):
                                        ['source', 'header', 'prefix=',
                                         'output-dir='] + extra_long_options)
     except getopt.GetoptError as err:
-        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
+        print ("%s: %s" % (sys.argv[0], str(err)), file=sys.stderr)
         sys.exit(1)
 
     output_dir = ''
@@ -1950,9 +1951,8 @@ def parse_command_line(extra_options='', extra_long_options=[]):
         if o in ('-p', '--prefix'):
             match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
             if match.end() != len(a):
-                print >>sys.stderr, \
-                    "%s: 'funny character '%s' in argument of --prefix" \
-                    % (sys.argv[0], a[match.end()])
+                print ("%s: 'funny character '%s' in argument of --prefix" \
+                       % (sys.argv[0], a[match.end()]), file=sys.stderr)
                 sys.exit(1)
             prefix = a
         elif o in ('-o', '--output-dir'):
@@ -1969,7 +1969,7 @@ def parse_command_line(extra_options='', extra_long_options=[]):
         do_h = True
 
     if len(args) != 1:
-        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0]
+        print ("%s: need exactly one argument" % sys.argv[0], file=sys.stderr)
         sys.exit(1)
     fname = args[0]
 
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index a317526e51..9c57b01bb4 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -4,6 +4,7 @@
 # This work is licensed under the terms of the GNU LGPL, version 2+.
 # See the COPYING file in the top-level directory.
 """This script produces the documentation of a qapi schema in texinfo format"""
+from __future__ import print_function
 import re
 import sys
 
@@ -285,15 +286,15 @@ def texi_schema(schema):
 def main(argv):
     """Takes schema argument, prints result to stdout"""
     if len(argv) != 2:
-        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv[0]
+        print ("%s: need exactly 1 argument: SCHEMA" % argv[0], file=sys.stderr)
         sys.exit(1)
 
     schema = qapi.QAPISchema(argv[1])
     if not qapi.doc_required:
-        print >>sys.stderr, ("%s: need pragma 'doc-required' "
-                             "to generate documentation" % argv[0])
+        print ("%s: need pragma 'doc-required' "
+               "to generate documentation" % argv[0], file=sys.stderr)
         sys.exit(1)
-    print texi_schema(schema)
+    print (texi_schema(schema))
 
 
 if __name__ == '__main__':
-- 
2.13.5
