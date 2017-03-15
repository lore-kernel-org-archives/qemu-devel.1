Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ut-0001Wb-Iq
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Up-0000JB-OW
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Up-0000Hc-Dw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:43 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:05 +0100
Message-Id: <1489582656-31133-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 16/47] qapi2texi: Convert to
 QAPISchemaVisitor
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

qapi2texi works with schema expression trees.  Such a tight coupling
to schema language syntax is not a good idea.  Convert it to the visitor
interface the other generators use.

No change to generated documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi2texi.py | 228 ++++++++++++++++++++++++++-------------------------
 1 file changed, 118 insertions(+), 110 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 299dcf9..6d4e757 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -123,31 +123,39 @@ def texi_format(doc):
     return "\n".join(lines)
 
 
-def texi_body(doc, only_documented=False):
-    """
-    Format the body of a symbol documentation:
-    - main body
-    - table of arguments
-    - followed by "Returns/Notes/Since/Example" sections
-    """
-    body = texi_format(str(doc.body)) + "\n"
-
-    args = ''
-    for name, section in doc.args.iteritems():
-        if not section.content and not only_documented:
-            continue        # Undocumented TODO require doc and drop
-        desc = str(section)
-        opt = ''
-        if section.optional:
-            desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
-                          '', desc)
-            opt = ' (optional)'
-        args += "@item @code{'%s'}%s\n%s\n" % (name, opt, texi_format(desc))
-    if args:
-        body += "@table @asis\n"
-        body += args
-        body += "@end table\n"
+def texi_body(doc):
+    """Format the main documentation body"""
+    return texi_format(str(doc.body)) + '\n'
 
+
+def texi_enum_value(value):
+    """Format a table of members item for an enumeration value"""
+    return "@item @code{'%s'}\n" % value.name
+
+
+def texi_member(member):
+    """Format a table of members item for an object type member"""
+    return "@item @code{'%s'}%s\n" % (
+        member.name, ' (optional)' if member.optional else '')
+
+
+def texi_members(doc, member_func, show_undocumented):
+    """Format the table of members"""
+    items = ''
+    for section in doc.args.itervalues():
+        if not section.content and not show_undocumented:
+            continue          # Undocumented TODO require doc and drop
+        desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
+                      '', str(section))
+        items += member_func(section.member) + texi_format(desc) + '\n'
+    if not items:
+        return ''
+    return '@table @asis\n' + items + '@end table\n'
+
+
+def texi_sections(doc):
+    """Format additional sections following arguments"""
+    body = ''
     for section in doc.sections:
         name, doc = (section.name, str(section))
         func = texi_format
@@ -159,94 +167,94 @@ def texi_body(doc, only_documented=False):
             body += "\n\n@b{%s:}\n" % name
 
         body += func(doc)
-
     return body
 
 
-def texi_alternate(expr, doc):
-    """Format an alternate to texi"""
-    body = texi_body(doc)
-    return TYPE_FMT(type="Alternate",
-                    name=doc.symbol,
-                    body=body)
-
-
-def texi_union(expr, doc):
-    """Format a union to texi"""
-    discriminator = expr.get("discriminator")
-    if discriminator:
-        union = "Flat Union"
-    else:
-        union = "Simple Union"
-
-    body = texi_body(doc)
-    return TYPE_FMT(type=union,
-                    name=doc.symbol,
-                    body=body)
-
-
-def texi_enum(expr, doc):
-    """Format an enum to texi"""
-    body = texi_body(doc, True)
-    return TYPE_FMT(type="Enum",
-                    name=doc.symbol,
-                    body=body)
-
-
-def texi_struct(expr, doc):
-    """Format a struct to texi"""
-    body = texi_body(doc)
-    return TYPE_FMT(type="Struct",
-                    name=doc.symbol,
-                    body=body)
-
-
-def texi_command(expr, doc):
-    """Format a command to texi"""
-    body = texi_body(doc)
-    return MSG_FMT(type="Command",
-                   name=doc.symbol,
-                   body=body)
-
-
-def texi_event(expr, doc):
-    """Format an event to texi"""
-    body = texi_body(doc)
-    return MSG_FMT(type="Event",
-                   name=doc.symbol,
-                   body=body)
-
-
-def texi_expr(expr, doc):
-    """Format an expr to texi"""
-    (kind, _) = expr.items()[0]
-
-    fmt = {"command": texi_command,
-           "struct": texi_struct,
-           "enum": texi_enum,
-           "union": texi_union,
-           "alternate": texi_alternate,
-           "event": texi_event}[kind]
-
-    return fmt(expr, doc)
-
-
-def texi(docs):
-    """Convert QAPI schema expressions to texi documentation"""
-    res = []
-    for doc in docs:
-        expr = doc.expr
-        if not expr:
-            res.append(texi_body(doc))
-            continue
-        try:
-            doc = texi_expr(expr, doc)
-            res.append(doc)
-        except:
-            print >>sys.stderr, "error at @%s" % doc.info
-            raise
-
-    return '\n'.join(res)
+def texi_entity(doc, member_func=texi_member, show_undocumented=False):
+    return (texi_body(doc)
+            + texi_members(doc, member_func, show_undocumented)
+            + texi_sections(doc))
+
+
+class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
+    def __init__(self):
+        self.out = None
+        self.cur_doc = None
+
+    def visit_begin(self, schema):
+        self.out = ''
+
+    def visit_enum_type(self, name, info, values, prefix):
+        doc = self.cur_doc
+        if self.out:
+            self.out += '\n'
+        self.out += TYPE_FMT(type='Enum',
+                             name=doc.symbol,
+                             body=texi_entity(doc,
+                                              member_func=texi_enum_value,
+                                              show_undocumented=True))
+
+    def visit_object_type(self, name, info, base, members, variants):
+        doc = self.cur_doc
+        if not variants:
+            typ = 'Struct'
+        elif variants._tag_name:        # TODO unclean member access
+            typ = 'Flat Union'
+        else:
+            typ = 'Simple Union'
+        if self.out:
+            self.out += '\n'
+        self.out += TYPE_FMT(type=typ,
+                             name=doc.symbol,
+                             body=texi_entity(doc))
+
+    def visit_alternate_type(self, name, info, variants):
+        doc = self.cur_doc
+        if self.out:
+            self.out += '\n'
+        self.out += TYPE_FMT(type='Alternate',
+                             name=doc.symbol,
+                             body=texi_entity(doc))
+
+    def visit_command(self, name, info, arg_type, ret_type,
+                      gen, success_response, boxed):
+        doc = self.cur_doc
+        if self.out:
+            self.out += '\n'
+        self.out += MSG_FMT(type='Command',
+                            name=doc.symbol,
+                            body=texi_entity(doc))
+
+    def visit_event(self, name, info, arg_type, boxed):
+        doc = self.cur_doc
+        if self.out:
+            self.out += '\n'
+        self.out += MSG_FMT(type='Event',
+                            name=doc.symbol,
+                            body=texi_entity(doc))
+
+    def symbol(self, doc, entity):
+        self.cur_doc = doc
+        entity.visit(self)
+        self.cur_doc = None
+
+    def freeform(self, doc):
+        assert not doc.args
+        if self.out:
+            self.out += '\n'
+        self.out += texi_body(doc) + texi_sections(doc)
+
+
+def texi_schema(schema):
+    """Convert QAPI schema documentation to Texinfo"""
+    gen = QAPISchemaGenDocVisitor()
+    gen.visit_begin(schema)
+    for doc in schema.docs:
+        if doc.symbol:
+            gen.symbol(doc, schema.lookup_entity(doc.symbol))
+        else:
+            gen.freeform(doc)
+    return gen.out
 
 
 def main(argv):
@@ -259,7 +267,7 @@ def main(argv):
     if not qapi.doc_required:
         print >>sys.stderr, ("%s: need pragma 'doc-required' "
                              "to generate documentation" % argv[0])
-    print texi(schema.docs)
+    print texi_schema(schema)
 
 
 if __name__ == "__main__":
-- 
2.7.4
