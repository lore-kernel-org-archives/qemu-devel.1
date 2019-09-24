Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7567C20640
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7567C20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm3n-0004XI-TY
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks2-0000Gm-O4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrw-0001U3-ML
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrv-0001SG-QF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41441C04BD48;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D838260C44;
 Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0EB81138408; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/25] qapi: Improve reporting of invalid flags
Date: Tue, 24 Sep 2019 15:28:24 +0200
Message-Id: <20190924132830.15835-20-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
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

Split check_flags() off check_keys() and have check_exprs() call it
later, so its error messages gain an "in definition" line.  Tweak the
error messages.

Checking values in a function named check_keys() is unclean anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                     | 22 ++++++++++++----------
 tests/qapi-schema/allow-preconfig-test.err |  3 ++-
 tests/qapi-schema/args-bad-boxed.err       |  3 ++-
 tests/qapi-schema/oob-test.err             |  3 ++-
 tests/qapi-schema/type-bypass-bad-gen.err  |  3 ++-
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index fe99e59153..4bfc007833 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -910,16 +910,17 @@ def check_keys(expr, info, meta, required, optional=
=3D[]):
     required =3D required + [meta]
     source =3D "%s '%s'" % (meta, name)
     check_known_keys(expr, info, source, required, optional)
-    for (key, value) in expr.items():
-        if key in ['gen', 'success-response'] and value is not False:
-            raise QAPISemError(info,
-                               "'%s' of %s '%s' should only use false va=
lue"
-                               % (key, meta, name))
-        if (key in ['boxed', 'allow-oob', 'allow-preconfig']
-                and value is not True):
-            raise QAPISemError(info,
-                               "'%s' of %s '%s' should only use true val=
ue"
-                               % (key, meta, name))
+
+
+def check_flags(expr, info):
+    for key in ['gen', 'success-response']:
+        if key in expr and expr[key] is not False:
+            raise QAPISemError(
+                info, "flag '%s' may only use false value" % key)
+    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
+        if key in expr and expr[key] is not True:
+            raise QAPISemError(
+                info, "flag '%s' may only use true value" % key)
=20
=20
 def normalize_enum(expr):
@@ -1022,6 +1023,7 @@ def check_exprs(exprs):
             assert False, 'unexpected meta type'
=20
         check_if(expr, info)
+        check_flags(expr, info)
=20
         if doc:
             doc.check_expr(expr)
diff --git a/tests/qapi-schema/allow-preconfig-test.err b/tests/qapi-sche=
ma/allow-preconfig-test.err
index 700d583306..2a4e6ce663 100644
--- a/tests/qapi-schema/allow-preconfig-test.err
+++ b/tests/qapi-schema/allow-preconfig-test.err
@@ -1 +1,2 @@
-tests/qapi-schema/allow-preconfig-test.json:2: 'allow-preconfig' of comm=
and 'allow-preconfig-test' should only use true value
+tests/qapi-schema/allow-preconfig-test.json: In command 'allow-preconfig=
-test':
+tests/qapi-schema/allow-preconfig-test.json:2: flag 'allow-preconfig' ma=
y only use true value
diff --git a/tests/qapi-schema/args-bad-boxed.err b/tests/qapi-schema/arg=
s-bad-boxed.err
index ad0d417321..31d39038fc 100644
--- a/tests/qapi-schema/args-bad-boxed.err
+++ b/tests/qapi-schema/args-bad-boxed.err
@@ -1 +1,2 @@
-tests/qapi-schema/args-bad-boxed.json:2: 'boxed' of command 'foo' should=
 only use true value
+tests/qapi-schema/args-bad-boxed.json: In command 'foo':
+tests/qapi-schema/args-bad-boxed.json:2: flag 'boxed' may only use true =
value
diff --git a/tests/qapi-schema/oob-test.err b/tests/qapi-schema/oob-test.=
err
index 35b60f7480..3c2ba6e0fd 100644
--- a/tests/qapi-schema/oob-test.err
+++ b/tests/qapi-schema/oob-test.err
@@ -1 +1,2 @@
-tests/qapi-schema/oob-test.json:2: 'allow-oob' of command 'oob-command-1=
' should only use true value
+tests/qapi-schema/oob-test.json: In command 'oob-command-1':
+tests/qapi-schema/oob-test.json:2: flag 'allow-oob' may only use true va=
lue
diff --git a/tests/qapi-schema/type-bypass-bad-gen.err b/tests/qapi-schem=
a/type-bypass-bad-gen.err
index a83c3c655d..1077651896 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.err
+++ b/tests/qapi-schema/type-bypass-bad-gen.err
@@ -1 +1,2 @@
-tests/qapi-schema/type-bypass-bad-gen.json:2: 'gen' of command 'foo' sho=
uld only use false value
+tests/qapi-schema/type-bypass-bad-gen.json: In command 'foo':
+tests/qapi-schema/type-bypass-bad-gen.json:2: flag 'gen' may only use fa=
lse value
--=20
2.21.0


