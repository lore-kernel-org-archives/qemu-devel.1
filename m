Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0887FC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF232053B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF232053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClwN-0005Y7-9P
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCkrz-0000CU-0l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkru-0001Rs-22
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrt-0001Qx-Ht
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 911AD30860D5;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3575A60BFB;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 791CB11385A7; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/25] qapi: Improve reporting of invalid name errors
Date: Tue, 24 Sep 2019 15:28:14 +0200
Message-Id: <20190924132830.15835-10-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
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

Split check_name() into check_name_is_str() and check_name_str(), keep
check_name() as a wrapper.

Move add_name()'s call into its caller check_exprs(), and inline.

This permits delaying check_name_str() there, so its error message
gains an "in definition" line.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                   | 20 ++++++++++++++++----
 tests/qapi-schema/bad-ident.err          |  1 +
 tests/qapi-schema/command-int.err        |  1 +
 tests/qapi-schema/redefined-builtin.err  |  1 +
 tests/qapi-schema/redefined-command.err  |  1 +
 tests/qapi-schema/redefined-event.err    |  1 +
 tests/qapi-schema/redefined-type.err     |  1 +
 tests/qapi-schema/reserved-command-q.err |  1 +
 tests/qapi-schema/reserved-type-kind.err |  1 +
 tests/qapi-schema/reserved-type-list.err |  1 +
 10 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 25818b0ea0..fdc4379eff 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -707,11 +707,22 @@ valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
=20
 def check_name(name, info, source,
                allow_optional=3DFalse, enum_member=3DFalse, permit_upper=
=3DFalse):
+    check_name_is_str(name, info, source)
+    check_name_str(name, info, source,
+                   allow_optional, enum_member, permit_upper)
+
+
+def check_name_is_str(name, info, source):
+    if not isinstance(name, str):
+        raise QAPISemError(info, "%s requires a string name" % source)
+
+
+def check_name_str(name, info, source,
+                   allow_optional=3DFalse, enum_member=3DFalse,
+                   permit_upper=3DFalse):
     global valid_name
     membername =3D name
=20
-    if not isinstance(name, str):
-        raise QAPISemError(info, "%s requires a string name" % source)
     if name.startswith('*'):
         membername =3D name[1:]
         if not allow_optional:
@@ -733,7 +744,6 @@ def check_name(name, info, source,
=20
 def add_name(name, info, meta):
     global all_names
-    check_name(name, info, "'%s'" % meta, permit_upper=3DTrue)
     # FIXME should reject names that differ only in '_' vs. '.'
     # vs. '-', because they're liable to clash in generated C.
     if name in all_names:
@@ -1148,8 +1158,10 @@ def check_exprs(exprs):
             raise QAPISemError(info, "expression is missing metatype")
         normalize_if(expr)
         name =3D expr[meta]
-        add_name(name, info, meta)
+        check_name_is_str(name, info, "'%s'" % meta)
         info.set_defn(meta, name)
+        check_name_str(name, info, "'%s'" % meta, permit_upper=3DTrue)
+        add_name(name, info, meta)
         if doc and doc.symbol !=3D name:
             raise QAPISemError(
                 info,
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index c4190602b5..6878889854 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-ident.json: In struct '*oops':
 tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional nam=
e '*oops'
diff --git a/tests/qapi-schema/command-int.err b/tests/qapi-schema/comman=
d-int.err
index 0f9300679b..56b45bf656 100644
--- a/tests/qapi-schema/command-int.err
+++ b/tests/qapi-schema/command-int.err
@@ -1 +1,2 @@
+tests/qapi-schema/command-int.json: In command 'int':
 tests/qapi-schema/command-int.json:2: built-in 'int' is already defined
diff --git a/tests/qapi-schema/redefined-builtin.err b/tests/qapi-schema/=
redefined-builtin.err
index b2757225c4..67775fdb41 100644
--- a/tests/qapi-schema/redefined-builtin.err
+++ b/tests/qapi-schema/redefined-builtin.err
@@ -1 +1,2 @@
+tests/qapi-schema/redefined-builtin.json: In struct 'size':
 tests/qapi-schema/redefined-builtin.json:2: built-in 'size' is already d=
efined
diff --git a/tests/qapi-schema/redefined-command.err b/tests/qapi-schema/=
redefined-command.err
index 82ae256e63..b77a05d354 100644
--- a/tests/qapi-schema/redefined-command.err
+++ b/tests/qapi-schema/redefined-command.err
@@ -1 +1,2 @@
+tests/qapi-schema/redefined-command.json: In command 'foo':
 tests/qapi-schema/redefined-command.json:3: command 'foo' is already def=
ined
diff --git a/tests/qapi-schema/redefined-event.err b/tests/qapi-schema/re=
defined-event.err
index 35429cb481..fd02d38157 100644
--- a/tests/qapi-schema/redefined-event.err
+++ b/tests/qapi-schema/redefined-event.err
@@ -1 +1,2 @@
+tests/qapi-schema/redefined-event.json: In event 'EVENT_A':
 tests/qapi-schema/redefined-event.json:3: event 'EVENT_A' is already def=
ined
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 06ea78c478..89acc82c2d 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1 +1,2 @@
+tests/qapi-schema/redefined-type.json: In enum 'foo':
 tests/qapi-schema/redefined-type.json:3: struct 'foo' is already defined
diff --git a/tests/qapi-schema/reserved-command-q.err b/tests/qapi-schema=
/reserved-command-q.err
index f939e044eb..0844e14b26 100644
--- a/tests/qapi-schema/reserved-command-q.err
+++ b/tests/qapi-schema/reserved-command-q.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-command-q.json: In command 'q-unix':
 tests/qapi-schema/reserved-command-q.json:5: 'command' uses invalid name=
 'q-unix'
diff --git a/tests/qapi-schema/reserved-type-kind.err b/tests/qapi-schema=
/reserved-type-kind.err
index 0a38efaad8..8d21479000 100644
--- a/tests/qapi-schema/reserved-type-kind.err
+++ b/tests/qapi-schema/reserved-type-kind.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-type-kind.json: In enum 'UnionKind':
 tests/qapi-schema/reserved-type-kind.json:2: enum 'UnionKind' should not=
 end in 'Kind'
diff --git a/tests/qapi-schema/reserved-type-list.err b/tests/qapi-schema=
/reserved-type-list.err
index 4510fa6d90..2bdd7d8a06 100644
--- a/tests/qapi-schema/reserved-type-list.err
+++ b/tests/qapi-schema/reserved-type-list.err
@@ -1 +1,2 @@
+tests/qapi-schema/reserved-type-list.json: In struct 'FooList':
 tests/qapi-schema/reserved-type-list.json:5: struct 'FooList' should not=
 end in 'List'
--=20
2.21.0


