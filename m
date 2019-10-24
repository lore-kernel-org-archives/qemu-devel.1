Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E93CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBC220659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsXfb2AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBC220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcuq-0000aM-VT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKh-0003sQ-Ve
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKf-00069N-Vk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKf-00068s-RQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtcnjU9EvEYFbKGGJU5Jmr0b/PmBLoIb2oJdS+JlpWo=;
 b=GsXfb2AEQLuZhz5B+K2FQ8ISS1kZNo01CfXcgKMRBcRVr0plnN/+4/GAGL3IUP5/5m9AhU
 EPso9GujEje+Ffz7cyPYOeLBtCNYl3MQfXk5PhcudYRD/y/z2ejfPzlAnK6cuXgmad1P6D
 zeK8tqYXXkLVGL0JK+Puho+rzLW9evg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-O1bbrPn9Ogeso5NZPKGWrw-1; Thu, 24 Oct 2019 08:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C74476;
 Thu, 24 Oct 2019 12:35:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 467A25DC1E;
 Thu, 24 Oct 2019 12:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24B0B11328AA; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 13/19] qapi: New special feature flag "deprecated"
Date: Thu, 24 Oct 2019 14:34:52 +0200
Message-Id: <20191024123458.13505-14-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: O1bbrPn9Ogeso5NZPKGWrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike regular feature flags, the new special feature flag
"deprecated" is recognized by the QAPI generator.  For now, it's only
permitted with commands and events.  It will be put to use shortly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt                    | 6 ++++++
 scripts/qapi/schema.py                          | 6 ++++++
 tests/Makefile.include                          | 1 +
 tests/qapi-schema/features-deprecated-type.err  | 2 ++
 tests/qapi-schema/features-deprecated-type.json | 3 +++
 tests/qapi-schema/features-deprecated-type.out  | 0
 tests/qapi-schema/qapi-schema-test.json         | 4 ++--
 tests/qapi-schema/qapi-schema-test.out          | 4 ++--
 8 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index eaeedc7bd3..e6ef93544e 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -665,6 +665,12 @@ Example:
   'features': [ 'allow-negative-numbers' ] }
=20
=20
+=3D=3D=3D=3D Special features =3D=3D=3D=3D
+
+Feature "deprecated" makes a command or event as deprecated.  It is
+not supported elsewhere so far.
+
+
 =3D=3D=3D Naming rules and reserved names =3D=3D=3D
=20
 All names must begin with a letter, and contain only ASCII letters,
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 639140fceb..840d119c6d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -179,6 +179,12 @@ class QAPISchemaType(QAPISchemaEntity):
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
index ea35cd54cc..9da831b882 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -388,6 +388,7 @@ qapi-schema +=3D event-case.json
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
index fa4f3a15da..6862d8ba2c 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
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
index 1ece836d9b..494d4c25c4 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -432,7 +432,7 @@ command test-features0 q_obj_test-features0-arg -> None
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
@@ -453,4 +453,4 @@ command test-command-cond-features3 None -> None
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
 event TEST-EVENT-FEATURES1 None
     boxed=3DFalse
-    feature feature1
+    feature deprecated
--=20
2.21.0


