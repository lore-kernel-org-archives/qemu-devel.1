Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE2C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698C0207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KadpEd2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698C0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJO0-0007Tc-PM
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irJJs-0001ve-QC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irJJo-0006VX-Sa
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:21:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irJJo-0006VJ-Ow
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578997264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4cGs+iq5K+32q0R4n8g4l7sNjgTjSBhSD/sRlHEoBM=;
 b=KadpEd2csbQXDnRl9UIPAnGEo29uyWwrQm6SWPmMSOvehHqwlPSCC4VIycP8upUBWdg5YB
 wf+eVs7id+5JZ4X7vI69Tk0TjzdIfc5PYSymLWhz9GlME07wYuF2hCg7cCAP+3jt9b7kCK
 ra+Z2gzNko/khky01Z6d+HACPJOTAn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-qEHURjOCM866ft0Rgghrcg-1; Tue, 14 Jan 2020 05:20:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C88778045F3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:20:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FABD19C5B;
 Tue, 14 Jan 2020 10:20:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72FAD11366C2; Tue, 14 Jan 2020 11:20:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] qapi: Fix code generation for empty modules
Date: Tue, 14 Jan 2020 11:20:54 +0100
Message-Id: <20200114102055.24058-6-armbru@redhat.com>
In-Reply-To: <20200114102055.24058-1-armbru@redhat.com>
References: <20200114102055.24058-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qEHURjOCM866ft0Rgghrcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

When a sub-module doesn't contain any definitions, we don't generate
code for it, but we do generate the #include.

We generate code only for modules that get visited.
QAPISchema.visit() visits only modules that have definitions.  It can
visit modules multiple times.

Clean this up as follows.  Collect entities in their QAPISchemaModule.
Have QAPISchema.visit() call QAPISchemaModule.visit() for each module.
Have QAPISchemaModule.visit() call .visit_module() for itself, and
QAPISchemaEntity.visit() for each of its entities.  This way, we visit
each module exactly once.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191120182551.23795-6-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/schema.py                   | 24 +++++++++++++-----------
 tests/qapi-schema/empty.out              |  1 +
 tests/qapi-schema/include-repetition.out |  6 ++----
 tests/qapi-schema/qapi-schema-test.out   | 24 ++++++++++--------------
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0f2e0dcfce..0bfc5256fb 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -68,6 +68,7 @@ class QAPISchemaEntity(object):
     def _set_module(self, schema, info):
         assert self._checked
         self._module =3D schema.module_by_fname(info and info.fname)
+        self._module.add_entity(self)
=20
     def set_module(self, schema):
         self._set_module(schema, self.info)
@@ -77,11 +78,6 @@ class QAPISchemaEntity(object):
         assert self._checked
         return self._ifcond
=20
-    @property
-    def module(self):
-        assert self._module or not self.info
-        return self._module
-
     def is_implicit(self):
         return not self.info
=20
@@ -142,6 +138,16 @@ class QAPISchemaVisitor(object):
 class QAPISchemaModule(object):
     def __init__(self, name):
         self.name =3D name
+        self._entity_list =3D []
+
+    def add_entity(self, ent):
+        self._entity_list.append(ent)
+
+    def visit(self, visitor):
+        visitor.visit_module(self.name)
+        for entity in self._entity_list:
+            if visitor.visit_needed(entity):
+                entity.visit(visitor)
=20
=20
 class QAPISchemaInclude(QAPISchemaEntity):
@@ -1093,10 +1099,6 @@ class QAPISchema(object):
     def visit(self, visitor):
         visitor.visit_begin(self)
         module =3D None
-        for entity in self._entity_list:
-            if visitor.visit_needed(entity):
-                if entity.module !=3D module:
-                    module =3D entity.module
-                    visitor.visit_module(module.name)
-                entity.visit(visitor)
+        for mod in self._module_dict.values():
+            mod.visit(visitor)
         visitor.visit_end()
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 5b53d00702..69666c39ad 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -9,3 +9,4 @@ enum QType
     member qdict
     member qlist
     member qbool
+module empty.json
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema/i=
nclude-repetition.out
index 5423983239..0b654ddebb 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -11,15 +11,13 @@ enum QType
     member qbool
 module include-repetition.json
 include comments.json
+include include-repetition-sub.json
+include comments.json
 module comments.json
 enum Status
     member good
     member bad
     member ugly
-module include-repetition.json
-include include-repetition-sub.json
 module include-repetition-sub.json
 include comments.json
 include comments.json
-module include-repetition.json
-include comments.json
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 3660e75a48..9bd3c4a490 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -153,9 +153,6 @@ object q_obj_sizeList-wrapper
     member data: sizeList optional=3DFalse
 object q_obj_anyList-wrapper
     member data: anyList optional=3DFalse
-module sub-sub-module.json
-array StatusList Status
-module qapi-schema-test.json
 object q_obj_StatusList-wrapper
     member data: StatusList optional=3DFalse
 enum UserDefListUnionKind
@@ -193,17 +190,6 @@ object UserDefListUnion
     case any: q_obj_anyList-wrapper
     case user: q_obj_StatusList-wrapper
 include include/sub-module.json
-module include/sub-module.json
-include sub-sub-module.json
-module sub-sub-module.json
-enum Status
-    member good
-    member bad
-    member ugly
-module include/sub-module.json
-object SecondArrayRef
-    member s: StatusList optional=3DFalse
-module qapi-schema-test.json
 command user_def_cmd None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 object q_obj_user_def_cmd1-arg
@@ -435,3 +421,13 @@ command test-command-cond-features3 None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     feature feature1
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+module include/sub-module.json
+include sub-sub-module.json
+object SecondArrayRef
+    member s: StatusList optional=3DFalse
+module sub-sub-module.json
+array StatusList Status
+enum Status
+    member good
+    member bad
+    member ugly
--=20
2.21.1


