Received: from eggs.gnu.org ([2001:4830:134:3::10]:38180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000jJ-Di
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005wU-Vo
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005vK-P3
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:22:06 +0100
Message-Id: <20180212072207.9367-14-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 13/14] qapi-introspect: Add #if conditions
 to introspection value
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

Generated tests/test-qapi-introspect.c changes as follows:

    --- test-qapi-introspect.c.old	2018-02-11 17:36:15.039696522 +0100
    +++ tests/test-qapi-introspect.c	2018-02-11 17:36:34.455419852 +0100
    @@ -118,6 +118,9 @@ QLIT_QDICT(((QLitDictEntry[]) {
	     { "ret-type", QLIT_QSTR("14"), },
	     {}
	 })),
    +#if defined(TEST_IF_CMD)
    +#if defined(TEST_IF_STRUCT)
    +
     QLIT_QDICT(((QLitDictEntry[]) {
	     { "arg-type", QLIT_QSTR("15"), },
	     { "meta-type", QLIT_QSTR("command"), },
    @@ -125,12 +128,19 @@ QLIT_QDICT(((QLitDictEntry[]) {
	     { "ret-type", QLIT_QSTR("1"), },
	     {}
	 })),
    +#endif /* defined(TEST_IF_STRUCT) */
    +#endif /* defined(TEST_IF_CMD) */
    +
    +#if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
    +
     QLIT_QDICT(((QLitDictEntry[]) {
	     { "arg-type", QLIT_QSTR("16"), },
	     { "meta-type", QLIT_QSTR("event"), },
	     { "name", QLIT_QSTR("TestIfEvent"), },
	     {}
	 })),
    +#endif /* defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT) */
    +
     QLIT_QDICT(((QLitDictEntry[]) {
	     { "members", QLIT_QLIST(((QLitObject[]) {
		 {}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index c02df95e72..342ae09422 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -40,6 +40,12 @@ def to_qlit(obj, level=0, suppress_first_indent=False):
         ret = 'QLIT_QDICT(((QLitDictEntry[]) {\n'
         ret += ',\n'.join(elts) + '\n'
         ret += indent(level) + '}))'
+    elif isinstance(obj, tuple):
+        # Use of tuples for conditionals is a bit of a hack
+        ifcond, begin = obj
+        if begin:
+            return gen_if(ifcond)
+        return gen_endif(ifcond)
     else:
         assert False                # not implemented
     if level > 0:
@@ -101,6 +107,9 @@ extern const QLitObject %(var)s;
         # Ignore types on first pass; visit_end() will pick up used types
         return not isinstance(entity, QAPISchemaType)
 
+    def visit_ifcond(self, ifcond, begin):
+        self._qlits.append((ifcond, begin))
+
     def _name(self, name):
         if self._unmask:
             return name
-- 
2.13.6
