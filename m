Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97655C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB1620637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If6XkH5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB1620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDVE1-00047m-Cb
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXk-0005Zu-RW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXi-0002VY-SW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXh-0002Lh-9I
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7ZSBZCNo/ZgAY5gyqS52uAcS239rFzvOxIBhE8+2aY=;
 b=If6XkH5ldXjnJZd5+HuPss49O/LjdQIv8oA2RoVPiej8DH8aYZyzMo2dPM9qctTVgdm4nC
 YEslD0rx+R+wV+O7natKyKy5b4LIm7SM5M8SEDCulYDKJ3Z2oDSVg8coXUul78MWLsuasW
 5B5KVziugUS2H6lyIhH9xCPMp4NGaXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-VgFFqBkANIGBufjdKzPY3A-1; Sun, 15 Mar 2020 10:46:59 -0400
X-MC-Unique: VgFFqBkANIGBufjdKzPY3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83E53189D6C5;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D4A12708B;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5A00113523D; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/34] qapi: New special feature flag "deprecated"
Date: Sun, 15 Mar 2020 15:46:44 +0100
Message-Id: <20200315144653.22660-26-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike regular feature flags, the new special feature flag
"deprecated" is recognized by the QAPI generator.  For now, it's only
permitted with commands, events, and struct members.  It will be put
to use shortly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt                    | 6 ++++++
 scripts/qapi/schema.py                          | 6 ++++++
 tests/Makefile.include                          | 1 +
 tests/qapi-schema/features-deprecated-type.err  | 2 ++
 tests/qapi-schema/features-deprecated-type.json | 3 +++
 tests/qapi-schema/features-deprecated-type.out  | 0
 tests/qapi-schema/qapi-schema-test.json         | 6 +++---
 tests/qapi-schema/qapi-schema-test.out          | 6 +++---
 8 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index a1ef1cfd61..823adbabda 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -683,6 +683,12 @@ Intended use is to have each feature string signal tha=
t this build of
 QEMU shows a certain behaviour.
=20
=20
+=3D=3D=3D=3D Special features =3D=3D=3D=3D
+
+Feature "deprecated" makes a command, event, or struct member as
+deprecated.  It is not supported elsewhere so far.
+
+
 =3D=3D=3D Naming rules and reserved names =3D=3D=3D
=20
 All names must begin with a letter, and contain only ASCII letters,
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 6ee3677215..78309a00f0 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -193,6 +193,12 @@ class QAPISchemaType(QAPISchemaEntity):
             return None
         return self.name
=20
+    def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
+        if 'deprecated' in [f.name for f in self.features]:
+            raise QAPISemError(
+                self.info, "feature 'deprecated' is not supported for type=
s")
+
     def describe(self):
         assert self.meta
         return "%s type '%s'" % (self.meta, self.name)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 67e8fcddda..d1340301b2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -242,6 +242,7 @@ qapi-schema +=3D event-case.json
 qapi-schema +=3D event-member-invalid-dict.json
 qapi-schema +=3D event-nest-struct.json
 qapi-schema +=3D features-bad-type.json
+qapi-schema +=3D features-deprecated-type.json
 qapi-schema +=3D features-duplicate-name.json
 qapi-schema +=3D features-if-invalid.json
 qapi-schema +=3D features-missing-name.json
diff --git a/tests/qapi-schema/features-deprecated-type.err b/tests/qapi-sc=
hema/features-deprecated-type.err
new file mode 100644
index 0000000000..af4ffe20aa
--- /dev/null
+++ b/tests/qapi-schema/features-deprecated-type.err
@@ -0,0 +1,2 @@
+features-deprecated-type.json: In struct 'S':
+features-deprecated-type.json:2: feature 'deprecated' is not supported for=
 types
diff --git a/tests/qapi-schema/features-deprecated-type.json b/tests/qapi-s=
chema/features-deprecated-type.json
new file mode 100644
index 0000000000..4b5bf5b86e
--- /dev/null
+++ b/tests/qapi-schema/features-deprecated-type.json
@@ -0,0 +1,3 @@
+# Feature 'deprecated' is not supported for types
+{ 'struct': 'S', 'data': {},
+  'features': [ 'deprecated' ] }
diff --git a/tests/qapi-schema/features-deprecated-type.out b/tests/qapi-sc=
hema/features-deprecated-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index f576c337af..6b1f05afa7 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -258,7 +258,7 @@
   'data': { 'foo': 'int' },
   'features': [] }
 { 'struct': 'FeatureStruct1',
-  'data': { 'foo': { 'type': 'int', 'features': [ 'member-feature1' ] } },
+  'data': { 'foo': { 'type': 'int', 'features': [ 'deprecated' ] } },
   'features': [ 'feature1' ] }
 { 'struct': 'FeatureStruct2',
   'data': { 'foo': 'int' },
@@ -308,7 +308,7 @@
   'features': [] }
=20
 { 'command': 'test-command-features1',
-  'features': [ 'feature1' ] }
+  'features': [ 'deprecated' ] }
 { 'command': 'test-command-features3',
   'features': [ 'feature1', 'feature2' ] }
=20
@@ -322,4 +322,4 @@
                                               'defined(TEST_IF_COND_2)'] }=
 ] }
=20
 { 'event': 'TEST-EVENT-FEATURES1',
-  'features': [ 'feature1' ] }
+  'features': [ 'deprecated' ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index cd863ae966..891b4101e0 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -359,7 +359,7 @@ object FeatureStruct0
     member foo: int optional=3DFalse
 object FeatureStruct1
     member foo: int optional=3DFalse
-        feature member-feature1
+        feature deprecated
     feature feature1
 object FeatureStruct2
     member foo: int optional=3DFalse
@@ -419,7 +419,7 @@ command test-features0 q_obj_test-features0-arg -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command test-command-features1 None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
-    feature feature1
+    feature deprecated
 command test-command-features3 None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     feature feature1
@@ -440,7 +440,7 @@ command test-command-cond-features3 None -> None
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
 event TEST-EVENT-FEATURES1 None
     boxed=3DFalse
-    feature feature1
+    feature deprecated
 module include/sub-module.json
 include sub-sub-module.json
 object SecondArrayRef
--=20
2.21.1


