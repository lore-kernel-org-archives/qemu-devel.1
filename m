Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA739C4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9187220640
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9187220640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm23-0002mS-22
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCkrt-00006M-Pk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrr-0001QE-Tb
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrr-0001Pl-LG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE6AC10C093F;
 Tue, 24 Sep 2019 13:28:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D121519C70;
 Tue, 24 Sep 2019 13:28:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C354113865F; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/25] qapi: Tighten QAPISchemaFOO.check() assertions
Date: Tue, 24 Sep 2019 15:28:06 +0200
Message-Id: <20190924132830.15835-2-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 24 Sep 2019 13:28:34 +0000 (UTC)
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we introduced the QAPISchema intermediate representation (commit
ac88219a6c7), we took a shortcut: we left check_exprs() & friends
alone instead of moving semantic checks into the
QAPISchemaFOO.check().  check_exprs() still checks and reports errors,
and the .check() assert check_exprs() did the job.  There are a few
gaps, though.

QAPISchemaArrayType.check() neglects to assert the element type is not
an array.  Add the assertion.

QAPISchemaObjectTypeVariants.check() neglects to assert the tag member
is not optional.  Add the assertion.

It neglects to assert the tag member is not conditional.  Add the
assertion.

It neglects to assert we actually have variants.  Add the assertion.

It asserts the variants are object types, but neglects to assert they
don't have variants.  Tighten the assertion.

QAPISchemaObjectTypeVariants.check_clash() has the same issue.
However, it can run only after .check().  Delete the assertion instead
of tightening it.

QAPISchemaAlternateType.check() neglects to assert the branch types
don't conflict.  Fixing that isn't trivial, so add just a TODO comment
for now.  It'll be resolved later in this series.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index b00caacca3..155b87b825 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1362,6 +1362,7 @@ class QAPISchemaArrayType(QAPISchemaType):
         QAPISchemaType.check(self, schema)
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
+        assert not isinstance(self.element_type, QAPISchemaArrayType)
=20
     @property
     def ifcond(self):
@@ -1606,6 +1607,8 @@ class QAPISchemaObjectTypeVariants(object):
             self.tag_member =3D seen[c_name(self._tag_name)]
             assert self._tag_name =3D=3D self.tag_member.name
         assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+        assert not self.tag_member.optional
+        assert self.tag_member.ifcond =3D=3D []
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
             cases =3D set([v.name for v in self.variants])
@@ -1615,20 +1618,21 @@ class QAPISchemaObjectTypeVariants(object):
                                                     m.ifcond)
                     v.set_owner(self.tag_member.owner)
                     self.variants.append(v)
+        assert self.variants
         for v in self.variants:
             v.check(schema)
             # Union names must match enum values; alternate names are
             # checked separately. Use 'seen' to tell the two apart.
             if seen:
                 assert v.name in self.tag_member.type.member_names()
-                assert isinstance(v.type, QAPISchemaObjectType)
+                assert (isinstance(v.type, QAPISchemaObjectType)
+                        and not v.type.variants)
                 v.type.check(schema)
=20
     def check_clash(self, info, seen):
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
             # branch do not affect another branch
-            assert isinstance(v.type, QAPISchemaObjectType)
             v.type.check_clash(info, dict(seen))
=20
=20
@@ -1659,6 +1663,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
         seen =3D {}
         for v in self.variants.variants:
             v.check_clash(self.info, seen)
+            # TODO check conflicting qtypes
             if self.doc:
                 self.doc.connect_member(v)
         if self.doc:
--=20
2.21.0


