Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15168C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC78B20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC78B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClDA-0003UL-Dk
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks1-0000Ec-9x
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrw-0001Tx-O2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrv-0001Sf-SK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A15633086211;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C853D6012E;
 Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9995411384DA; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/25] qapi: Move context-free checking to the proper place
Date: Tue, 24 Sep 2019 15:28:22 +0200
Message-Id: <20190924132830.15835-18-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
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

QAPISchemaCommand.check() and QAPISchemaEvent().check() check 'data'
is present when 'boxed': true.  That's context-free.  Move to
check_command() and check_event().

Tweak the error message while there.

check_exprs() & friends now check exactly what qapi-code-gen.txt calls
the second layer of syntax.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                  | 16 ++++++++--------
 tests/qapi-schema/event-boxed-empty.err |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index ac4c898e51..7577120f12 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -767,10 +767,12 @@ def check_type(value, info, source,
=20
 def check_command(expr, info):
     name =3D expr['command']
+    args =3D expr.get('data')
     boxed =3D expr.get('boxed', False)
=20
-    check_type(expr.get('data'), info,
-               "'data' for command '%s'" % name,
+    if boxed and args is None:
+        raise QAPISemError(info, "'boxed': true requires 'data'")
+    check_type(args, info, "'data' for command '%s'" % name,
                allow_dict=3Dnot boxed)
     check_type(expr.get('returns'), info,
                "'returns' for command '%s'" % name,
@@ -779,10 +781,12 @@ def check_command(expr, info):
=20
 def check_event(expr, info):
     name =3D expr['event']
+    args =3D expr.get('data')
     boxed =3D expr.get('boxed', False)
=20
-    check_type(expr.get('data'), info,
-               "'data' for event '%s'" % name,
+    if boxed and args is None:
+        raise QAPISemError(info, "'boxed': true requires 'data'")
+    check_type(args, info, "'data' for event '%s'" % name,
                allow_dict=3Dnot boxed)
=20
=20
@@ -1691,8 +1695,6 @@ class QAPISchemaCommand(QAPISchemaEntity):
                     self.info,
                     "command's 'data' can take %s only with 'boxed': tru=
e"
                     % self.arg_type.describe())
-        elif self.boxed:
-            raise QAPISemError(self.info, "use of 'boxed' requires 'data=
'")
         if self._ret_type_name:
             self.ret_type =3D schema.resolve_type(
                 self._ret_type_name, self.info, "command's 'returns'")
@@ -1740,8 +1742,6 @@ class QAPISchemaEvent(QAPISchemaEntity):
                     self.info,
                     "event's 'data' can take %s only with 'boxed': true"
                     % self.arg_type.describe())
-        elif self.boxed:
-            raise QAPISemError(self.info, "use of 'boxed' requires 'data=
'")
=20
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index 9c691b7d97..931c10b036 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/event-boxed-empty.json: In event 'FOO':
-tests/qapi-schema/event-boxed-empty.json:2: use of 'boxed' requires 'dat=
a'
+tests/qapi-schema/event-boxed-empty.json:2: 'boxed': true requires 'data=
'
--=20
2.21.0


