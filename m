Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298CC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB86214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB86214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkjO-00068e-Pr
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0r-0001Nd-Ox
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0j-0006x2-Df
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0i-0006uc-Hl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A016A18C8931
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A53D60C80;
 Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D06BF1136422; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/37] tests/qapi-schema: Demonstrate broken discriminator
 errors
Date: Tue, 24 Sep 2019 14:33:19 +0200
Message-Id: <20190924123334.30645-23-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
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

When the union definition's base is an object, some error messages
show it as an OrderedDict.  Oops.  Mark FIXME.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-5-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


