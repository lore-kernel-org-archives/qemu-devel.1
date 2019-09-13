Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F2C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03F5206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03F5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8s4W-0003fM-Dq
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 16:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8rxA-00061S-VQ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8rx8-0000fC-Sk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8rx8-0000d2-IS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD41B10F2E82;
 Fri, 13 Sep 2019 20:13:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2764910018F9;
 Fri, 13 Sep 2019 20:13:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97AF11138408; Fri, 13 Sep 2019 22:13:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 22:13:44 +0200
Message-Id: <20190913201349.24332-12-armbru@redhat.com>
In-Reply-To: <20190913201349.24332-1-armbru@redhat.com>
References: <20190913201349.24332-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 13 Sep 2019 20:13:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 11/16] qapi: Adjust frontend errors to say
 enum value, not member
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

For consistency with docs/devel/qapi-code-gen.txt.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                  | 11 ++++++++---
 scripts/qapi/events.py                  |  2 +-
 tests/qapi-schema/enum-clash-member.err |  2 +-
 tests/qapi-schema/enum-member-case.err  |  2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3393a049cc..a538d2f37c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1340,7 +1340,7 @@ class QAPISchemaEnumType(QAPISchemaType):
     def __init__(self, name, info, doc, ifcond, members, prefix):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
         for m in members:
-            assert isinstance(m, QAPISchemaMember)
+            assert isinstance(m, QAPISchemaEnumMember)
             m.set_owner(name)
         assert prefix is None or isinstance(prefix, str)
         self.members =3D members
@@ -1551,6 +1551,10 @@ class QAPISchemaMember(object):
         return "'%s' %s" % (self.name, self._pretty_owner())
=20
=20
+class QAPISchemaEnumMember(QAPISchemaMember):
+    role =3D 'value'
+
+
 class QAPISchemaFeature(QAPISchemaMember):
     role =3D 'feature'
=20
@@ -1807,7 +1811,8 @@ class QAPISchema(object):
         return [QAPISchemaFeature(f['name'], f.get('if')) for f in featu=
res]
=20
     def _make_enum_members(self, values):
-        return [QAPISchemaMember(v['name'], v.get('if')) for v in values=
]
+        return [QAPISchemaEnumMember(v['name'], v.get('if'))
+                for v in values]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
@@ -2223,7 +2228,7 @@ const QEnumLookup %(c_name)s_lookup =3D {
=20
 def gen_enum(name, members, prefix=3DNone):
     # append automatically generated _MAX value
-    enum_members =3D members + [QAPISchemaMember('_MAX')]
+    enum_members =3D members + [QAPISchemaEnumMember('_MAX')]
=20
     ret =3D mcgen('''
=20
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index e0abfef7b0..7062553cf3 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -194,7 +194,7 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdic=
t);
                                           self._event_emit_name))
         # Note: we generate the enum member regardless of @ifcond, to
         # keep the enumeration usable in target-independent code.
-        self._event_enum_members.append(QAPISchemaMember(name))
+        self._event_enum_members.append(QAPISchemaEnumMember(name))
=20
=20
 def gen_events(schema, output_dir, prefix):
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 5403c78507..8238d2e807 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-clash-member.json:2: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
+tests/qapi-schema/enum-clash-member.json:2: 'one_two' (value of MyEnum) =
collides with 'one-two' (value of MyEnum)
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index 3c67a3a067..5d689e92d5 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/enum-member-case.json:4: 'Value' (member of NoWayThisW=
illGetWhitelisted) should not use uppercase
+tests/qapi-schema/enum-member-case.json:4: 'Value' (value of NoWayThisWi=
llGetWhitelisted) should not use uppercase
--=20
2.21.0


