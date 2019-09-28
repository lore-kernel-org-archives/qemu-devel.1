Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3189C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A388020863
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A388020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHie-0005iB-BA
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 14:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHdB-0008So-P8
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd7-0003zg-8f
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd6-0003w0-RN
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D85323091761
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83291600D1;
 Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 705971136420; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/27] qapi: Improve reporting of invalid flags
Date: Sat, 28 Sep 2019 20:39:27 +0200
Message-Id: <20190928183934.12459-21-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
References: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Split check_flags() off check_keys() and have check_exprs() call it
later, so its error messages gain an "in definition" line.  Tweak the
error messages.

Checking values in a function named check_keys() is unclean anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190927134639.4284-20-armbru@redhat.com>
---
 scripts/qapi/common.py                     | 22 ++++++++++++----------
 tests/qapi-schema/allow-preconfig-test.err |  3 ++-
 tests/qapi-schema/args-bad-boxed.err       |  3 ++-
 tests/qapi-schema/oob-test.err             |  3 ++-
 tests/qapi-schema/type-bypass-bad-gen.err  |  3 ++-
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8f96974f85..4f67b73684 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -915,16 +915,17 @@ def check_keys(expr, info, meta, required, optional=
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
@@ -1027,6 +1028,7 @@ def check_exprs(exprs):
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


