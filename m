Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE90C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C1A2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C1A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCl8Z-0007D0-7c
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCkrz-0000Cc-32
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkru-0001SB-FR
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrt-0001R0-P6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A8EBE308FF30;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FA5F5C1B2;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F9FB11385D4; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/25] qapi: Report invalid '*' prefix like any other invalid
 name
Date: Tue, 24 Sep 2019 15:28:16 +0200
Message-Id: <20190924132830.15835-12-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
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

The special "does not allow optional name" error is well meant, but
confusing in practice.  Drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                                   | 6 ++----
 tests/qapi-schema/bad-ident.err                          | 2 +-
 tests/qapi-schema/flat-union-discriminator-bad-name.err  | 2 +-
 tests/qapi-schema/flat-union-discriminator-bad-name.json | 2 +-
 tests/qapi-schema/union-optional-branch.err              | 2 +-
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 6c870da50b..39eb6de4a6 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -723,11 +723,8 @@ def check_name_str(name, info, source,
     global valid_name
     membername =3D name
=20
-    if name.startswith('*'):
+    if allow_optional and name.startswith('*'):
         membername =3D name[1:]
-        if not allow_optional:
-            raise QAPISemError(info, "%s does not allow optional name '%=
s'"
-                               % (source, name))
     # Enum members can start with a digit, because the generated C
     # code always prefixes it with the enum name
     if enum_member and membername[0].isdigit():
@@ -740,6 +737,7 @@ def check_name_str(name, info, source,
     if not permit_upper and name.lower() !=3D name:
         raise QAPISemError(
             info, "%s uses uppercase in name '%s'" % (source, name))
+    assert not membername.startswith('*')
=20
=20
 def add_name(name, info, meta):
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index 6878889854..ddc96bd3a9 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-ident.json: In struct '*oops':
-tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional nam=
e '*oops'
+tests/qapi-schema/bad-ident.json:2: 'struct' uses invalid name '*oops'
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.err b/te=
sts/qapi-schema/flat-union-discriminator-bad-name.err
index f7f64c5c1a..44e41883b1 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.err
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-discriminator-bad-name.json:7: discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
+tests/qapi-schema/flat-union-discriminator-bad-name.json:7: discriminato=
r of flat union 'MyUnion' uses invalid name '*switch'
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.json b/t=
ests/qapi-schema/flat-union-discriminator-bad-name.json
index 66376084fc..ea84b75cac 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.json
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.json
@@ -1,5 +1,5 @@
 # discriminator '*switch' isn't a member of base, 'switch' is
-# reports "does not allow optional name", which is good enough
+# reports "uses invalid name", which is good enough
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index a5677f74bc..8e9b18d7c6 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-optional-branch.json: In union 'Union':
-tests/qapi-schema/union-optional-branch.json:2: member of union 'Union' =
does not allow optional name '*a'
+tests/qapi-schema/union-optional-branch.json:2: member of union 'Union' =
uses invalid name '*a'
--=20
2.21.0


