Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B12AC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B8A207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B8A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm5H-0005z3-8T
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks2-0000Fo-3h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrw-0001UE-Ri
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrw-0001Su-BU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C571E8980E1;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2A266017E;
 Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB5C11136422; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/25] qapi: Eliminate check_keys(), rename check_known_keys()
Date: Tue, 24 Sep 2019 15:28:27 +0200
Message-Id: <20190924132830.15835-23-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
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

check_keys() has become a trivial wrapper for check_known_keys().
Eliminate it.

This makes its name available.  Rename check_known_keys().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3e9c5ae127..018e58bc50 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -757,7 +757,7 @@ def check_type(value, info, source,
                        allow_optional=3DTrue, permit_upper=3Dpermit_uppe=
r)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
             raise QAPISemError(info, "%s uses reserved name" % key_sourc=
e)
-        check_known_keys(arg, info, key_source, ['type'], ['if'])
+        check_keys(arg, info, key_source, ['type'], ['if'])
         check_if(arg, info)
         normalize_if(arg)
         check_type(arg['type'], info, key_source, allow_array=3DTrue)
@@ -800,7 +800,7 @@ def check_union(expr, info):
     for (key, value) in members.items():
         source =3D "'data' member '%s'" % key
         check_name_str(key, info, source)
-        check_known_keys(value, info, source, ['type'], ['if'])
+        check_keys(value, info, source, ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
         check_type(value['type'], info, source, allow_array=3Dnot base)
@@ -814,7 +814,7 @@ def check_alternate(expr, info):
     for (key, value) in members.items():
         source =3D "'data' member '%s'" % key
         check_name_str(key, info, source)
-        check_known_keys(value, info, source, ['type'], ['if'])
+        check_keys(value, info, source, ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
         check_type(value['type'], info, source)
@@ -834,7 +834,7 @@ def check_enum(expr, info):
=20
     for member in members:
         source =3D "'data' member"
-        check_known_keys(member, info, source, ['name'], ['if'])
+        check_keys(member, info, source, ['name'], ['if'])
         check_if(member, info)
         normalize_if(member)
         check_name(member['name'], info, source,
@@ -855,13 +855,13 @@ def check_struct(expr, info):
         for f in features:
             source =3D "'features' member"
             assert isinstance(f, dict)
-            check_known_keys(f, info, source, ['name'], ['if'])
+            check_keys(f, info, source, ['name'], ['if'])
             check_if(f, info)
             normalize_if(f)
             check_name(f['name'], info, source)
=20
=20
-def check_known_keys(value, info, source, required, optional):
+def check_keys(value, info, source, required, optional):
=20
     def pprint(elems):
         return ', '.join("'" + e + "'" for e in sorted(elems))
@@ -879,10 +879,6 @@ def check_known_keys(value, info, source, required, =
optional):
                               pprint(unknown), pprint(allowed)))
=20
=20
-def check_keys(expr, info, meta, required, optional=3D[]):
-    check_known_keys(expr, info, meta, required + [meta], optional)
-
-
 def check_flags(expr, info):
     for key in ['gen', 'success-response']:
         if key in expr and expr[key] is not False:
@@ -958,33 +954,39 @@ def check_exprs(exprs):
                 info, "documentation comment is for '%s'" % doc.symbol)
=20
         if meta =3D=3D 'enum':
-            check_keys(expr, info, 'enum', ['data'], ['if', 'prefix'])
+            check_keys(expr, info, meta,
+                       ['enum', 'data'], ['if', 'prefix'])
             normalize_enum(expr)
             check_enum(expr, info)
         elif meta =3D=3D 'union':
-            check_keys(expr, info, 'union', ['data'],
+            check_keys(expr, info, meta,
+                       ['union', 'data'],
                        ['base', 'discriminator', 'if'])
             normalize_members(expr.get('base'))
             normalize_members(expr['data'])
             check_union(expr, info)
         elif meta =3D=3D 'alternate':
-            check_keys(expr, info, 'alternate', ['data'], ['if'])
+            check_keys(expr, info, meta,
+                       ['alternate', 'data'], ['if'])
             normalize_members(expr['data'])
             check_alternate(expr, info)
         elif meta =3D=3D 'struct':
-            check_keys(expr, info, 'struct', ['data'],
-                       ['base', 'if', 'features'])
+            check_keys(expr, info, meta,
+                       ['struct', 'data'], ['base', 'if', 'features'])
             normalize_members(expr['data'])
             normalize_features(expr.get('features'))
             check_struct(expr, info)
         elif meta =3D=3D 'command':
-            check_keys(expr, info, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response',
-                        'boxed', 'allow-oob', 'allow-preconfig', 'if'])
+            check_keys(expr, info, meta,
+                       ['command'],
+                       ['data', 'returns', 'boxed', 'if',
+                        'gen', 'success-response', 'allow-oob',
+                        'allow-preconfig'])
             normalize_members(expr.get('data'))
             check_command(expr, info)
         elif meta =3D=3D 'event':
-            check_keys(expr, info, 'event', [], ['data', 'boxed', 'if'])
+            check_keys(expr, info, meta,
+                       ['event'], ['data', 'boxed', 'if'])
             normalize_members(expr.get('data'))
             check_event(expr, info)
         else:
--=20
2.21.0


