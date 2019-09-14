Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D3C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDA520717
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9A9l-0001sR-Sm
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i9A59-0004xU-VP
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i9A57-0004x1-RO
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i9A53-0004tG-Uh
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E70B81DB0;
 Sat, 14 Sep 2019 15:35:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 352729CAA;
 Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A969C1138406; Sat, 14 Sep 2019 17:35:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 14 Sep 2019 17:34:57 +0200
Message-Id: <20190914153506.2151-11-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-1-armbru@redhat.com>
References: <20190914153506.2151-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sat, 14 Sep 2019 15:35:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 10/19] qapi: Fix broken discriminator error
 messages
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

check_union() checks the discriminator exists in base and makes sense.
Two error messages mention the base.  These are broken for anonymous
bases, as demonstrated by tests flat-union-invalid-discriminator and
flat-union-invalid-if-discriminator.err.  The third one doesn't
bother.

First broken when commit ac4338f8eb "qapi: Allow anonymous base for
flat union" (v2.6.0) neglected to adjust the "not a member of base"
error message.  Commit ccadd6bcba "qapi: Add 'if' to implicit struct
members" (v4.0.0) then cloned the flawed error message.

Dumb them down not to mention the base.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                                   | 9 ++++-----
 tests/qapi-schema/flat-union-invalid-discriminator.err   | 2 +-
 tests/qapi-schema/flat-union-invalid-discriminator.json  | 1 -
 .../qapi-schema/flat-union-invalid-if-discriminator.err  | 2 +-
 .../qapi-schema/flat-union-invalid-if-discriminator.json | 1 -
 tests/qapi-schema/flat-union-optional-discriminator.err  | 2 +-
 tests/qapi-schema/union-base-empty.err                   | 2 +-
 7 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index ef7c7be4fd..a58e904978 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -877,14 +877,13 @@ def check_union(expr, info):
         discriminator_value =3D base_members.get(discriminator)
         if not discriminator_value:
             raise QAPISemError(info,
-                               "Discriminator '%s' is not a member of ba=
se "
-                               "struct '%s'"
-                               % (discriminator, base))
+                               "Discriminator '%s' is not a member of 'b=
ase'"
+                               % discriminator)
         if discriminator_value.get('if'):
             raise QAPISemError(
                 info,
-                "The discriminator %s.%s for union %s must not be condit=
ional"
-                % (base, discriminator, name))
+                "The discriminator '%s' for union %s must not be conditi=
onal"
+                % (discriminator, name))
         enum_define =3D enum_types.get(discriminator_value['type'])
         # Do not allow string discriminator
         if not enum_define:
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index 947a6b73aa..495d5a520e 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-discriminator.json:11: Discriminato=
r 'enum_wrong' is not a member of base struct 'OrderedDict([('enum1', {'t=
ype': 'TestEnum'})])'
+tests/qapi-schema/flat-union-invalid-discriminator.json:10: Discriminato=
r 'enum_wrong' is not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json b/te=
sts/qapi-schema/flat-union-invalid-discriminator.json
index de86cf0760..c4fce97362 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.json
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.json
@@ -1,4 +1,3 @@
-# FIXME error message shows base as OrderedDict
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
index ec04c4840c..cc5c3fb80b 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-if-discriminator.json:11: The discr=
iminator OrderedDict([('enum1', OrderedDict([('type', 'TestEnum'), ('if',=
 'FOO')]))]).enum1 for union TestUnion must not be conditional
+tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: The discr=
iminator 'enum1' for union TestUnion must not be conditional
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.json b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.json
index bbaa9a3f82..e49992b798 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.json
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.json
@@ -1,4 +1,3 @@
-# FIXME error message shows base as OrderedDict
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index 8b4a4ba847..45f5407c34 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:7: Discriminato=
r 'switch' is not a member of base struct 'Base'
+tests/qapi-schema/flat-union-optional-discriminator.json:7: Discriminato=
r 'switch' is not a member of 'base'
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
index 7695806d81..9453720ede 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1 +1 @@
-tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a=
 member of base struct 'Empty'
+tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a=
 member of 'base'
--=20
2.21.0


