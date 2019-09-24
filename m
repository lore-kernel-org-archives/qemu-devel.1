Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C82B207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C82B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkLl-00033Z-M4
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0q-0001MO-9L
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0k-0006z7-F6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0j-0006wH-TM
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1A6C300CB2B
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A10BC60933;
 Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 44E08113642E; Tue, 24 Sep 2019 14:33:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/37] qapi: Delete useless check_exprs() code for simple union
 kind
Date: Tue, 24 Sep 2019 14:33:31 +0200
Message-Id: <20190924123334.30645-35-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
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

Commit bceae7697f "qapi script: support enum type as discriminator in
union" made check_exprs() add the implicit enum types of simple unions
to global @enum_types.  I'm not sure it was needed even then.  It's
certainly not needed now.  Delete it.

discriminator_find_enum_define() and add_name() parameter @implicit
are now dead.  Bury them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-17-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3c3154a039..7e79c42b6a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -672,26 +672,6 @@ def find_alternate_member_qtype(qapi_type):
     return None
=20
=20
-# Return the discriminator enum define if discriminator is specified as =
an
-# enum type, otherwise return None.
-def discriminator_find_enum_define(expr):
-    base =3D expr.get('base')
-    discriminator =3D expr.get('discriminator')
-
-    if not (discriminator and base):
-        return None
-
-    base_members =3D find_base_members(base)
-    if not base_members:
-        return None
-
-    discriminator_value =3D base_members.get(discriminator)
-    if not discriminator_value:
-        return None
-
-    return enum_types.get(discriminator_value['type'])
-
-
 # Names must be letters, numbers, -, and _.  They must start with letter=
,
 # except for downstream extensions which must start with __RFQDN_.
 # Dots are only valid in the downstream extension prefix.
@@ -722,7 +702,7 @@ def check_name(info, source, name, allow_optional=3DF=
alse,
         raise QAPISemError(info, "%s uses invalid name '%s'" % (source, =
name))
=20
=20
-def add_name(name, info, meta, implicit=3DFalse):
+def add_name(name, info, meta):
     global all_names
     check_name(info, "'%s'" % meta, name)
     # FIXME should reject names that differ only in '_' vs. '.'
@@ -730,7 +710,7 @@ def add_name(name, info, meta, implicit=3DFalse):
     if name in all_names:
         raise QAPISemError(info, "%s '%s' is already defined"
                            % (all_names[name], name))
-    if not implicit and (name.endswith('Kind') or name.endswith('List'))=
:
+    if name.endswith('Kind') or name.endswith('List'):
         raise QAPISemError(info, "%s '%s' should not end in '%s'"
                            % (meta, name, name[-4:]))
     all_names[name] =3D meta
@@ -1138,21 +1118,6 @@ def check_exprs(exprs):
             raise QAPISemError(info, "Definition of '%s' follows documen=
tation"
                                " for '%s'" % (name, doc.symbol))
=20
-    # Try again for hidden UnionKind enum
-    for expr_elem in exprs:
-        expr =3D expr_elem['expr']
-
-        if 'include' in expr:
-            continue
-        if 'union' in expr and not discriminator_find_enum_define(expr):
-            name =3D '%sKind' % expr['union']
-        elif 'alternate' in expr:
-            name =3D '%sKind' % expr['alternate']
-        else:
-            continue
-        enum_types[name] =3D {'enum': name}
-        add_name(name, info, 'enum', implicit=3DTrue)
-
     # Validate that exprs make sense
     for expr_elem in exprs:
         expr =3D expr_elem['expr']
--=20
2.21.0


