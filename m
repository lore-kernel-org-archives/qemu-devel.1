Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97948C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7022420644
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7022420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ACp-0005bq-Vw
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i9A5E-00053t-NW
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i9A5B-0004zv-8k
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i9A5A-0004rL-EG
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFD8518C8921;
 Sat, 14 Sep 2019 15:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 109065FCA2;
 Sat, 14 Sep 2019 15:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95EDF11385A7; Sat, 14 Sep 2019 17:35:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 14 Sep 2019 17:34:51 +0200
Message-Id: <20190914153506.2151-5-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-1-armbru@redhat.com>
References: <20190914153506.2151-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Sat, 14 Sep 2019 15:35:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/19] tests/qapi-schema: Demonstrate broken
 discriminator errors
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

When the union definition's base is an object, some error messages
show it as an OrderedDict.  Oops.  Mark FIXME.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/flat-union-invalid-discriminator.err     | 2 +-
 tests/qapi-schema/flat-union-invalid-discriminator.json    | 6 ++----
 tests/qapi-schema/flat-union-invalid-if-discriminator.err  | 2 +-
 tests/qapi-schema/flat-union-invalid-if-discriminator.json | 6 ++----
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index 5f4055614e..947a6b73aa 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-discriminator.json:13: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
+tests/qapi-schema/flat-union-invalid-discriminator.json:11: Discriminato=
r 'enum_wrong' is not a member of base struct 'OrderedDict([('enum1', {'t=
ype': 'TestEnum'})])'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json b/te=
sts/qapi-schema/flat-union-invalid-discriminator.json
index 48b94c3a4d..de86cf0760 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.json
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.json
@@ -1,9 +1,7 @@
+# FIXME error message shows base as OrderedDict
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
-{ 'struct': 'TestBase',
-  'data': { 'enum1': 'TestEnum' } }
-
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
@@ -11,7 +9,7 @@
   'data': { 'integer': 'int' } }
=20
 { 'union': 'TestUnion',
-  'base': 'TestBase',
+  'base': { 'enum1': 'TestEnum' },
   'discriminator': 'enum_wrong',
   'data': { 'value1': 'TestTypeA',
             'value2': 'TestTypeB' } }
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
index 0c94c9860d..ec04c4840c 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-if-discriminator.json:13: The discr=
iminator TestBase.enum1 for union TestUnion must not be conditional
+tests/qapi-schema/flat-union-invalid-if-discriminator.json:11: The discr=
iminator OrderedDict([('enum1', OrderedDict([('type', 'TestEnum'), ('if',=
 'FOO')]))]).enum1 for union TestUnion must not be conditional
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.json b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.json
index 618ec36396..bbaa9a3f82 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.json
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.json
@@ -1,9 +1,7 @@
+# FIXME error message shows base as OrderedDict
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
-{ 'struct': 'TestBase',
-  'data': { 'enum1': { 'type': 'TestEnum', 'if': 'FOO' } } }
-
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
@@ -11,7 +9,7 @@
   'data': { 'integer': 'int' } }
=20
 { 'union': 'TestUnion',
-  'base': 'TestBase',
+  'base': { 'enum1': { 'type': 'TestEnum', 'if': 'FOO' } },
   'discriminator': 'enum1',
   'data': { 'value1': 'TestTypeA',
             'value2': 'TestTypeB' } }
--=20
2.21.0


