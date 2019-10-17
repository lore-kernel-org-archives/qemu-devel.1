Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A0ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF92E20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF92E20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5aZ-0003e3-Cn
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SN-00017L-HR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5SI-00006g-4g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5SE-00004r-Nf; Thu, 17 Oct 2019 09:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0459307D976;
 Thu, 17 Oct 2019 13:04:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B8CE1001B11;
 Thu, 17 Oct 2019 13:04:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 15/18] qapi: Support empty modules
Date: Thu, 17 Oct 2019 15:02:01 +0200
Message-Id: <20191017130204.16131-16-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 13:04:34 +0000 (UTC)
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you added an include file that doesn't contain any definitions, no
source files would be generated for it. However, in other source files,
you would still get an #include for the header files of the empty
module.

The intended behaviour is that empty source files are created for empty
modules. This patch makes QAPISchema keep a list of all modules
(including empty ones) and modifies visit() to first visit all modules
in that list.

Some test reference outputs need to be updated due to the additional
visitor calls.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qapi/schema.py                   | 9 +++++++++
 tests/qapi-schema/comments.out           | 2 ++
 tests/qapi-schema/doc-bad-section.out    | 2 ++
 tests/qapi-schema/doc-good.out           | 2 ++
 tests/qapi-schema/empty.out              | 2 ++
 tests/qapi-schema/event-case.out         | 2 ++
 tests/qapi-schema/include-repetition.out | 4 ++++
 tests/qapi-schema/include-simple.out     | 3 +++
 tests/qapi-schema/indented-expr.out      | 2 ++
 tests/qapi-schema/qapi-schema-test.out   | 4 ++++
 10 files changed, 32 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 38041098bd..e1b034d67d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -749,6 +749,7 @@ class QAPISchema(object):
         self.docs =3D parser.docs
         self._entity_list =3D []
         self._entity_dict =3D {}
+        self._modules =3D [os.path.basename(fname)]
         self._predefining =3D True
         self._def_predefineds()
         self._predefining =3D False
@@ -800,6 +801,8 @@ class QAPISchema(object):
             main_info =3D main_info.parent
         fname =3D os.path.relpath(include, os.path.dirname(main_info.fna=
me))
         self._def_entity(QAPISchemaInclude(fname, info))
+        if fname not in self._modules:
+            self._modules.append(fname)
=20
     def _def_builtin_type(self, name, json_type, c_type):
         self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
@@ -1033,6 +1036,12 @@ class QAPISchema(object):
         visitor.visit_begin(self)
         module =3D None
         visitor.visit_module(module)
+
+        # Make sure that all modules are visited, even if they contain n=
o
+        # entities
+        for module in self._modules:
+            visitor.visit_module(module)
+
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
                 if entity.module !=3D module:
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 273f0f54e1..fa7e95d1cc 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,6 @@
 module None
+module comments.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index 367e2a1c3e..331237cfbe 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,4 +1,6 @@
 module None
+module doc-bad-section.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index d3bca343eb..8f3577bb21 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,4 +1,6 @@
 module None
+module doc-good.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 5b53d00702..3671cbbe59 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,4 +1,6 @@
 module None
+module empty.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index ec8a1406e4..2b2d8548e9 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,4 +1,6 @@
 module None
+module event-case.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 5423983239..ebaac1813d 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,8 @@
 module None
+module include-repetition.json
+module comments.json
+module include-repetition-sub.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 061f81e509..dea51f9738 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,7 @@
 module None
+module include-simple.json
+module include-simple-sub.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index bffdf6756d..d4cffb9c1b 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,4 +1,6 @@
 module None
+module indented-expr.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 98031da96f..93c944a2fb 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,4 +1,8 @@
 module None
+module qapi-schema-test.json
+module include/sub-module.json
+module sub-sub-module.json
+module None
 object q_empty
 enum QType
     prefix QTYPE
--=20
2.20.1


