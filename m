Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujWx-0006N8-0Q
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujO7-0004qp-QY
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujO7-0004n9-Fr
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 274C7B5CB
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 21:10:48 +0200
Message-Id: <20180828191048.29806-7-armbru@redhat.com>
In-Reply-To: <20180828191048.29806-1-armbru@redhat.com>
References: <20180828191048.29806-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We consciously chose in commit 1a9a507b to hide QAPI type names
from the introspection output on the wire, but added a command
line option -u to unmask the type name when doing a debug build.
The unmask option still remains useful to some other forms of
automated analysis, so it will not be removed; however, when it
is not in use, the generated .c file can be hard to read.  At
the time when we first introduced masking, the generated file
consisted only of a monolithic C string, so there was no clean
way to inject any comments.

Later, in commit 7d0f982b, we switched the generation to output
a QLit object, in part to make it easier for future addition of
conditional compilation.  In fact, commit d626b6c1 took advantage
of this by passing a tuple instead of a bare object for encoding
the output of conditionals.  By extending that tuple, we can now
interject strategic comments.

For now, type name debug aid comments are only output once per
meta-type, rather than at all uses of the number used to encode
the type within the introspection data.  But this is still a lot
more convenient than having to regenerate the file with the
unmask operation temporarily turned on - merely search the
generated file for '"NNN" =' to learn the corresponding source
name and associated definition of type NNN.

The generated qapi-introspect.c changes only with the addition
of comments, such as:

| @@ -14755,6 +15240,7 @@
|          { "name", QLIT_QSTR("[485]"), },
|          {}
|      })),
| +    /* "485" = QCryptoBlockInfoLUKSSlot */
|      QLIT_QDICT(((QLitDictEntry[]) {
|          { "members", QLIT_QLIST(((QLitObject[]) {
|              QLIT_QDICT(((QLitDictEntry[]) {

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180827213943.33524-3-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, update to qapi-code-gen.txt corrected]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt |  3 +++
 scripts/qapi/introspect.py   | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 304c12d0ae..53eaf01f34 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1428,6 +1428,7 @@ Example:
             { "name", QLIT_QSTR("MY_EVENT"), },
             {}
         })),
+        /* "0" = q_obj_my-command-arg */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
                 QLIT_QDICT(((QLitDictEntry[]) {
@@ -1441,6 +1442,7 @@ Example:
             { "name", QLIT_QSTR("0"), },
             {}
         })),
+        /* "1" = UserDefOne */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
                 QLIT_QDICT(((QLitDictEntry[]) {
@@ -1460,6 +1462,7 @@ Example:
             { "name", QLIT_QSTR("1"), },
             {}
         })),
+        /* "2" = q_empty */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
                 {}
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 43e81a0693..67d6106f77 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -19,12 +19,17 @@ def to_qlit(obj, level=0, suppress_first_indent=False):
         return level * 4 * ' '
 
     if isinstance(obj, tuple):
-        ifobj, ifcond = obj
-        ret = gen_if(ifcond)
+        ifobj, extra = obj
+        ifcond = extra.get('if')
+        comment = extra.get('comment')
+        ret = ''
+        if comment:
+            ret += indent(level) + '/* %s */\n' % comment
+        if ifcond:
+            ret += gen_if(ifcond)
         ret += to_qlit(ifobj, level)
-        endif = gen_endif(ifcond)
-        if endif:
-            ret += '\n' + endif
+        if ifcond:
+            ret += '\n' + gen_endif(ifcond)
         return ret
 
     ret = ''
@@ -137,11 +142,21 @@ const QLitObject %(c_name)s = %(c_string)s;
         return self._name(typ.name)
 
     def _gen_qlit(self, name, mtype, obj, ifcond):
+        extra = {}
         if mtype not in ('command', 'event', 'builtin', 'array'):
+            if not self._unmask:
+                # Output a comment to make it easy to map masked names
+                # back to the source when reading the generated output.
+                extra['comment'] = '"%s" = %s' % (self._name(name), name)
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
-        self._qlits.append((obj, ifcond))
+        if ifcond:
+            extra['if'] = ifcond
+        if extra:
+            self._qlits.append((obj, extra))
+        else:
+            self._qlits.append(obj)
 
     def _gen_member(self, member):
         ret = {'name': member.name, 'type': self._use_type(member.type)}
-- 
2.17.1
