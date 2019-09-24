Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A5C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2F9207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2F9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkvD-0002BV-4r
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0u-0001QF-FH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0k-0006zg-LV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0k-0006x1-51
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 202C818C4288
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBBE75C1B2;
 Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 544BF1136430; Tue, 24 Sep 2019 14:33:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/37] qapi: Fix excessive QAPISchemaEntity.check() recursion
Date: Tue, 24 Sep 2019 14:33:33 +0200
Message-Id: <20190924123334.30645-37-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 24 Sep 2019 12:33:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Entity checking goes back to commit ac88219a6c "qapi: New QAPISchema
intermediate representation", v2.5.0.  It's designed to work as
follows: QAPISchema.check() calls .check() for all the schema's
entities.  An entity's .check() recurses into another entity's
.check() only if the C struct generated for the former contains the C
struct generated for the latter (pointers don't count).  This is used
to detect "object contains itself".

There are two instances of this:

* An object's C struct contains its base's C struct

  QAPISchemaObjectType.check() calls self.base.check()

* An object's C struct contains its variants' C structs

  QAPISchemaObjectTypeVariants().check calls v.type.check().  Since
  commit b807a1e1e3 "qapi: Check for QAPI collisions involving variant
  members", v2.6.0.

Thus, only object types can participate in recursion.

QAPISchemaObjectType.check() is made for that: it checks @self when
called the first time, recursing into base and variants, it reports an
"contains itself" error when this recursion reaches an object being
checked, and does nothing it reaches an object that has been checked
already.

The other .check() may safely assume they get called exactly once.

Sadly, this design has since eroded:

* QAPISchemaCommand.check() and QAPISchemaEvent.check() call
  .args_type.check().  Since commit c818408e44 "qapi: Implement boxed
  types for commands/events", v2.7.0.  Harmless, since args_type can
  only be an object type.

* QAPISchemaEntity.check() calls ._ifcond.check() when inheriting the
  condition from another type.  Since commit 4fca21c1b0 qapi: leave
  the ifcond attribute undefined until check(), v3.0.0.  This makes
  simple union wrapper types recurse into the wrapped type (nothing
  else uses this condition inheritance).  The .check() of types used
  as simple union branch type get called multiple times.

* QAPISchemaObjectType.check() calls its super type's .check()
  *before* the conditional handling multiple calls.  Also since commit
  4fca21c1b0.  QAPISchemaObjectType.check()'s guard against multiple
  checking doesn't protect QAPISchemaEntity.check().

* QAPISchemaArrayType.check() calls .element_type.check().  Also since
  commit 4fca21c1b0.  The .check() of types used as array element
  types get called multiple times.

  Commit 56a4689582 "qapi: Fix array first used in a different module"
  (v4.0.0) added more code relying on this .element_type.check().

The absence of explosions suggests the .check() involved happen to be
effectively idempotent.

Fix the unwanted recursion anyway:

* QAPISchemaCommand.check() and QAPISchemaEvent.check() calling
  .args_type.check() is unnecessary.  Delete the calls.

* Fix QAPISchemaObjectType.check() to call its super type's .check()
  after the conditional handling multiple calls.

* A QAPISchemaEntity's .ifcond becomes valid at .check().  This is due
  to arrays and simple unions.

  Most types get ifcond and info passed to their constructor.

  Array types don't: they get it from their element type, which
  becomes known only in .element_type.check().

  The implicit wrapper object types for simple union branches don't:
  they get it from the wrapped type, which might be an array.

  Ditch the idea to set .ifcond in .check().  Instead, turn it into a
  property and compute it on demand.  Safe because it's only used
  after the schema has been checked.

  Most types simply return the ifcond passed to their constructor.

  Array types forward to their .element_type instead, and the wrapper
  types forward to the wrapped type.

* A QAPISchemaEntity's .module becomes valid at .check().  This is
  because computing it needs info and schema.fname, and because array
  types get it from their element type instead.

  Make it a property just like .ifcond.

Additionally, have QAPISchemaEntity.check() assert it gets called at
most once, so the design invariant will stick this time.  Neglecting
that was entirely my fault.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-19-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Commit message tidied up]
---
 scripts/qapi/common.py | 74 +++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index e2c87d1349..c199a2b58c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1155,7 +1155,7 @@ class QAPISchemaEntity(object):
     def __init__(self, name, info, doc, ifcond=3DNone):
         assert name is None or isinstance(name, str)
         self.name =3D name
-        self.module =3D None
+        self._module =3D None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
         # For implicitly defined entities, info points to a place that
@@ -1164,21 +1164,27 @@ class QAPISchemaEntity(object):
         self.info =3D info
         self.doc =3D doc
         self._ifcond =3D ifcond or []
+        self._checked =3D False
=20
     def c_name(self):
         return c_name(self.name)
=20
     def check(self, schema):
-        if isinstance(self._ifcond, QAPISchemaType):
-            # inherit the condition from a type
-            typ =3D self._ifcond
-            typ.check(schema)
-            self.ifcond =3D typ.ifcond
-        else:
-            self.ifcond =3D self._ifcond
+        assert not self._checked
         if self.info:
-            self.module =3D os.path.relpath(self.info['file'],
-                                          os.path.dirname(schema.fname))
+            self._module =3D os.path.relpath(self.info['file'],
+                                           os.path.dirname(schema.fname)=
)
+        self._checked =3D True
+
+    @property
+    def ifcond(self):
+        assert self._checked
+        return self._ifcond
+
+    @property
+    def module(self):
+        assert self._checked
+        return self._module
=20
     def is_implicit(self):
         return not self.info
@@ -1353,9 +1359,16 @@ class QAPISchemaArrayType(QAPISchemaType):
         QAPISchemaType.check(self, schema)
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
-        self.element_type.check(schema)
-        self.module =3D self.element_type.module
-        self.ifcond =3D self.element_type.ifcond
+
+    @property
+    def ifcond(self):
+        assert self._checked
+        return self.element_type.ifcond
+
+    @property
+    def module(self):
+        assert self._checked
+        return self.element_type.module
=20
     def is_implicit(self):
         return True
@@ -1402,13 +1415,20 @@ class QAPISchemaObjectType(QAPISchemaType):
         self.features =3D features
=20
     def check(self, schema):
-        QAPISchemaType.check(self, schema)
-        if self.members is False:               # check for cycles
+        # This calls another type T's .check() exactly when the C
+        # struct emitted by gen_object() contains that T's C struct
+        # (pointers don't count).
+        if self.members is not None:
+            # A previous .check() completed: nothing to do
+            return
+        if self._checked:
+            # Recursed: C struct contains itself
             raise QAPISemError(self.info,
                                "Object %s contains itself" % self.name)
-        if self.members is not None:            # already checked
-            return
-        self.members =3D False                    # mark as being checke=
d
+
+        QAPISchemaType.check(self, schema)
+        assert self._checked and self.members is None
+
         seen =3D OrderedDict()
         if self._base_name:
             self.base =3D schema.lookup_type(self._base_name)
@@ -1420,10 +1440,11 @@ class QAPISchemaObjectType(QAPISchemaType):
             m.check_clash(self.info, seen)
             if self.doc:
                 self.doc.connect_member(m)
-        self.members =3D seen.values()
+        members =3D seen.values()
+
         if self.variants:
             self.variants.check(schema, seen)
-            assert self.variants.tag_member in self.members
+            assert self.variants.tag_member in members
             self.variants.check_clash(self.info, seen)
=20
         # Features are in a name space separate from members
@@ -1434,6 +1455,8 @@ class QAPISchemaObjectType(QAPISchemaType):
         if self.doc:
             self.doc.check()
=20
+        self.members =3D members  # mark completed
+
     # Check that the members of this type do not cause duplicate JSON me=
mbers,
     # and update seen to track the members seen so far. Report any error=
s
     # on behalf of info, which is not necessarily self.info
@@ -1442,6 +1465,15 @@ class QAPISchemaObjectType(QAPISchemaType):
         for m in self.members:
             m.check_clash(info, seen)
=20
+    @property
+    def ifcond(self):
+        assert self._checked
+        if isinstance(self._ifcond, QAPISchemaType):
+            # Simple union wrapper type inherits from wrapped type;
+            # see _make_implicit_object_type()
+            return self._ifcond.ifcond
+        return self._ifcond
+
     def is_implicit(self):
         # See QAPISchema._make_implicit_object_type(), as well as
         # _def_predefineds()
@@ -1658,7 +1690,6 @@ class QAPISchemaCommand(QAPISchemaEntity):
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert isinstance(self.arg_type, QAPISchemaObjectType)
-            self.arg_type.check(schema)
             assert not self.arg_type.variants or self.boxed
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
@@ -1687,7 +1718,6 @@ class QAPISchemaEvent(QAPISchemaEntity):
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert isinstance(self.arg_type, QAPISchemaObjectType)
-            self.arg_type.check(schema)
             assert not self.arg_type.variants or self.boxed
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
--=20
2.21.0


