Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4076AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F70B206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F70B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8s7K-0007Fx-I3
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 16:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8rx6-0005xh-3v
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8rx4-0000ZZ-JO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8rx4-0000Yh-Bk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A899B30860C2;
 Fri, 13 Sep 2019 20:13:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECD2960C57;
 Fri, 13 Sep 2019 20:13:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D06911385FD; Fri, 13 Sep 2019 22:13:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 22:13:36 +0200
Message-Id: <20190913201349.24332-4-armbru@redhat.com>
In-Reply-To: <20190913201349.24332-1-armbru@redhat.com>
References: <20190913201349.24332-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 13 Sep 2019 20:13:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 03/16] qapi: Drop support for boxed
 alternate arguments
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commands and events can define their argument type inline (default) or
by referring to another type ('boxed': true, since commit c818408e44
"qapi: Implement boxed types for commands/events", v2.7.0).  The
unboxed inline definition is an (anonymous) struct type.  The boxed
type may be a struct, union, or alternate type.

The latter is problematic: docs/interop/qemu-spec.txt requires the
value of the 'data' key to be a json-object, but any non-degenerate
alternate type has at least one branch that isn't.

Fortunately, we haven't made use of alternates in this context outside
tests/.  Drop support for them.

QAPISchemaAlternateType.is_empty() is now unused.  Drop it, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt            | 12 ++++++------
 scripts/qapi/common.py                  | 15 ++++-----------
 tests/qapi-schema/qapi-schema-test.json |  2 +-
 tests/qapi-schema/qapi-schema-test.out  |  2 +-
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index e8ec8ac1de..3d3931fb7a 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -612,9 +612,9 @@ the command.  Normally, 'data' is a dictionary for an=
 anonymous type,
 or names a struct type (possibly empty, but not a union), and its
 members are passed as separate arguments to this function.  If the
 command definition includes a key 'boxed' with the boolean value true,
-then 'data' is instead the name of any non-empty complex type
-(struct, union, or alternate), and a pointer to that QAPI type is
-passed as a single argument.
+then 'data' is instead the name of any non-empty complex type (struct
+or union), and a pointer to that QAPI type is passed as a single
+argument.
=20
 The generator also emits a marshalling function that extracts
 arguments for the user's function out of an input QDict, calls the
@@ -714,9 +714,9 @@ The generator emits a function to send the event.  No=
rmally, 'data' is
 a dictionary for an anonymous type, or names a struct type (possibly
 empty, but not a union), and its members are passed as separate
 arguments to this function.  If the event definition includes a key
-'boxed' with the boolean value true, then 'data' is instead the name of
-any non-empty complex type (struct, union, or alternate), and a
-pointer to that QAPI type is passed as a single argument.
+'boxed' with the boolean value true, then 'data' is instead the name
+of any non-empty complex type (struct or union), and a pointer to that
+QAPI type is passed as a single argument.
=20
=20
 =3D=3D=3D Features =3D=3D=3D
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 9aefcfe015..54d02458b5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -840,7 +840,7 @@ def check_command(expr, info):
=20
     args_meta =3D ['struct']
     if boxed:
-        args_meta +=3D ['union', 'alternate']
+        args_meta +=3D ['union']
     check_type(info, "'data' for command '%s'" % name,
                expr.get('data'), allow_dict=3Dnot boxed,
                allow_metas=3Dargs_meta)
@@ -858,7 +858,7 @@ def check_event(expr, info):
=20
     meta =3D ['struct']
     if boxed:
-        meta +=3D ['union', 'alternate']
+        meta +=3D ['union']
     check_type(info, "'data' for event '%s'" % name,
                expr.get('data'), allow_dict=3Dnot boxed,
                allow_metas=3Dmeta)
@@ -1690,9 +1690,6 @@ class QAPISchemaAlternateType(QAPISchemaType):
         visitor.visit_alternate_type(self.name, self.info, self.ifcond,
                                      self.variants)
=20
-    def is_empty(self):
-        return False
-
=20
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
@@ -1714,15 +1711,13 @@ class QAPISchemaCommand(QAPISchemaEntity):
         QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
-            assert (isinstance(self.arg_type, QAPISchemaObjectType) or
-                    isinstance(self.arg_type, QAPISchemaAlternateType))
+            assert isinstance(self.arg_type, QAPISchemaObjectType)
             self.arg_type.check(schema)
             if self.boxed:
                 if self.arg_type.is_empty():
                     raise QAPISemError(self.info,
                                        "Cannot use 'boxed' with empty ty=
pe")
             else:
-                assert not isinstance(self.arg_type, QAPISchemaAlternate=
Type)
                 assert not self.arg_type.variants
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
@@ -1750,15 +1745,13 @@ class QAPISchemaEvent(QAPISchemaEntity):
         QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
-            assert (isinstance(self.arg_type, QAPISchemaObjectType) or
-                    isinstance(self.arg_type, QAPISchemaAlternateType))
+            assert isinstance(self.arg_type, QAPISchemaObjectType)
             self.arg_type.check(schema)
             if self.boxed:
                 if self.arg_type.is_empty():
                     raise QAPISemError(self.info,
                                        "Cannot use 'boxed' with empty ty=
pe")
             else:
-                assert not isinstance(self.arg_type, QAPISchemaAlternate=
Type)
                 assert not self.arg_type.variants
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c6d59acc3e..0fadb4ddd7 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -180,7 +180,7 @@
 { 'event': 'EVENT_D',
   'data': { 'a' : 'EventStructOne', 'b' : 'str', '*c': 'str', '*enum3': =
'EnumOne' } }
 { 'event': 'EVENT_E', 'boxed': true, 'data': 'UserDefZero' }
-{ 'event': 'EVENT_F', 'boxed': true, 'data': 'UserDefAlternate' }
+{ 'event': 'EVENT_F', 'boxed': true, 'data': 'UserDefFlatUnion' }
=20
 # test that we correctly compile downstream extensions, as well as munge
 # ticklish names
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 85d510bc00..5470a525f5 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -252,7 +252,7 @@ event EVENT_D q_obj_EVENT_D-arg
    boxed=3DFalse
 event EVENT_E UserDefZero
    boxed=3DTrue
-event EVENT_F UserDefAlternate
+event EVENT_F UserDefFlatUnion
    boxed=3DTrue
 enum __org.qemu_x-Enum
     member __org.qemu_x-value
--=20
2.21.0


