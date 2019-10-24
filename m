Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2E12166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0Rv2iwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2E12166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcEP-0007M8-Az
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatM-00012D-EH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004r2-OR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004mr-Dt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RoDle9Zl6Br9Wi+V5CQIJNW09ClfW6am574Q+oXI2ow=;
 b=g0Rv2iwgf4WNr42I/vHuJ+x5Ki1lJs/29MbS5+XKsOSSt+SVpYiPTJPjzu9P8bFlIli0n2
 aNk4e0ekp4GGJVQRl3bzSya4jFLs2T+WUj/EMIMK+CRp/j0zr+tpQw8d9kLOc/NRDtmWxI
 Qkv4VDWIq7EmM1bj8KsXR8keejauyDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-KXMHNDqtN6GtoXhD3Uao4g-1; Thu, 24 Oct 2019 07:02:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEE2780183E;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 732231001B20;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65F88113294D; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/19] qapi: Fix doc comment checking for commands and events
Date: Thu, 24 Oct 2019 13:02:29 +0200
Message-Id: <20191024110237.30963-12-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KXMHNDqtN6GtoXhD3Uao4g-1
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a command's 'data' is an object, its doc comment describes the
arguments defined there.  When 'data' names a type, the doc comment
does not describe arguments.  Instead, the doc generator inserts a
pointer to the named type.

An event's doc comment works the same.

We don't actually check doc comments for commands and events.
Instead, QAPISchema._def_command() forwards the doc comment to the
implicit argument type, where it gets checked.  Works because the
check only cares for the implicit argument type's members.

Not only is this needlessly hard to understand, it actually falls
apart in two cases:

* When 'data' is empty, there is nothing to forward to, and the doc
  comment remains unchecked.  Demonstrated by test doc-bad-event-arg.

* When 'data' names a type, we can't forward, as the type has its own
  doc comment.  The command or event's doc comment remains unchecked.
  Demonstrated by test doc-bad-boxed-command-arg.

The forwarding goes back to commit 069fb5b250 "qapi: Prepare for
requiring more complete documentation", put to use in commit
816a57cd6e "qapi: Fix detection of bogus member documentation".  That
fix was incomplete.

To fix this, make QAPISchemaCommand and QAPISchemaEvent check doc
comments, and drop the forwarding of doc comments to implicit argument
types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/net.json                                 |  2 --
 scripts/qapi/doc.py                           |  1 +
 scripts/qapi/schema.py                        | 24 +++++++++++++++--
 .../qapi-schema/doc-bad-boxed-command-arg.err |  1 +
 .../doc-bad-boxed-command-arg.json            |  1 -
 .../qapi-schema/doc-bad-boxed-command-arg.out | 26 -------------------
 tests/qapi-schema/doc-bad-event-arg.err       |  1 +
 tests/qapi-schema/doc-bad-event-arg.json      |  1 -
 tests/qapi-schema/doc-bad-event-arg.out       | 19 --------------
 9 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 728990f4fb..4c96137811 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -723,8 +723,6 @@
 # Trigger generation of broadcast RARP frames to update network switches.
 # This can be useful when network bonds fail-over the active slave.
 #
-# @params: AnnounceParameters giving timing and repetition count of announ=
ce
-#
 # Example:
 #
 # -> { "execute": "announce-self",
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index c8c4bda153..6f1c17f71f 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -185,6 +185,7 @@ def texi_members(doc, what, base=3DNone, variants=3DNon=
e,
=20
 def texi_arguments(doc, boxed_arg_type):
     if boxed_arg_type:
+        assert not doc.args
         return ('\n@b{Arguments:} the members of @code{%s}\n'
                 % boxed_arg_type.name)
     return texi_members(doc, 'Arguments')
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c16dce1fe0..06e37c9c49 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -739,6 +739,16 @@ class QAPISchemaCommand(QAPISchemaEntity):
         for f in self.features:
             f.check_clash(self.info, seen)
=20
+    def connect_doc(self, doc=3DNone):
+        doc =3D doc or self.doc
+        if doc:
+            if self.arg_type and self.arg_type.is_implicit():
+                self.arg_type.connect_doc(doc)
+
+    def check_doc(self):
+        if self.doc:
+            self.doc.check()
+
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
         visitor.visit_command(self.name, self.info, self.ifcond,
@@ -775,6 +785,16 @@ class QAPISchemaEvent(QAPISchemaEntity):
                     "event's 'data' can take %s only with 'boxed': true"
                     % self.arg_type.describe())
=20
+    def connect_doc(self, doc=3DNone):
+        doc =3D doc or self.doc
+        if doc:
+            if self.arg_type and self.arg_type.is_implicit():
+                self.arg_type.connect_doc(doc)
+
+    def check_doc(self):
+        if self.doc:
+            self.doc.check()
+
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
         visitor.visit_event(self.name, self.info, self.ifcond,
@@ -1026,7 +1046,7 @@ class QAPISchema(object):
         features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, ifcond, 'arg', self._make_members(data, i=
nfo))
+                name, info, None, ifcond, 'arg', self._make_members(data, =
info))
         if isinstance(rets, list):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
@@ -1042,7 +1062,7 @@ class QAPISchema(object):
         ifcond =3D expr.get('if')
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, ifcond, 'arg', self._make_members(data, i=
nfo))
+                name, info, None, ifcond, 'arg', self._make_members(data, =
info))
         self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, data, bo=
xed))
=20
     def _def_exprs(self, exprs):
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.err b/tests/qapi-s=
chema/doc-bad-boxed-command-arg.err
index e69de29bb2..e1101b1667 100644
--- a/tests/qapi-schema/doc-bad-boxed-command-arg.err
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.err
@@ -0,0 +1 @@
+doc-bad-boxed-command-arg.json:9: the following documented members are not=
 in the declaration: a
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.json b/tests/qapi-=
schema/doc-bad-boxed-command-arg.json
index 2c265d2ca3..bd143241ec 100644
--- a/tests/qapi-schema/doc-bad-boxed-command-arg.json
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.json
@@ -1,5 +1,4 @@
 # Boxed arguments are not to be documented with the command
-# BUG: not rejected
=20
 ##
 # @Args:
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.out b/tests/qapi-s=
chema/doc-bad-boxed-command-arg.out
index 4ccd788253..e69de29bb2 100644
--- a/tests/qapi-schema/doc-bad-boxed-command-arg.out
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.out
@@ -1,26 +0,0 @@
-module None
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module doc-bad-boxed-command-arg.json
-object Args
-    member a: int optional=3DFalse
-command cmd-boxed Args -> None
-    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
-doc symbol=3DArgs
-    body=3D
-
-    arg=3Da
-an argument
-doc symbol=3Dcmd-boxed
-    body=3D
-
-    arg=3Da
-bogus
diff --git a/tests/qapi-schema/doc-bad-event-arg.err b/tests/qapi-schema/do=
c-bad-event-arg.err
index e69de29bb2..114ff4a3c7 100644
--- a/tests/qapi-schema/doc-bad-event-arg.err
+++ b/tests/qapi-schema/doc-bad-event-arg.err
@@ -0,0 +1 @@
+doc-bad-event-arg.json:3: the following documented members are not in the =
declaration: a
diff --git a/tests/qapi-schema/doc-bad-event-arg.json b/tests/qapi-schema/d=
oc-bad-event-arg.json
index 80d4e1240b..23c83cc81f 100644
--- a/tests/qapi-schema/doc-bad-event-arg.json
+++ b/tests/qapi-schema/doc-bad-event-arg.json
@@ -1,5 +1,4 @@
 # Arguments listed in the doc comment must exist in the actual schema
-# BUG: nonexistent @a is not rejected
=20
 ##
 # @FOO:
diff --git a/tests/qapi-schema/doc-bad-event-arg.out b/tests/qapi-schema/do=
c-bad-event-arg.out
index ad0367cd45..e69de29bb2 100644
--- a/tests/qapi-schema/doc-bad-event-arg.out
+++ b/tests/qapi-schema/doc-bad-event-arg.out
@@ -1,19 +0,0 @@
-module None
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module doc-bad-event-arg.json
-event FOO None
-    boxed=3DFalse
-doc symbol=3DFOO
-    body=3D
-
-    arg=3Da
-a
--=20
2.21.0


