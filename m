Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B002084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imjTnuxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B002084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNd77-0007ma-Ca
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKg-0003pX-JD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKf-00068X-5O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKf-000684-16
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLjPN6dVpq/UleY7W+a+Yfax21W6uVXEWUh1XaQk7To=;
 b=imjTnuxdm+gSorXKCVhSsVgHa+xxwGucSIzYURrSLc60LPXfgjQAgbWRhZfFl2j6okWs+o
 4Yhd2em2BIYKUQH1jqRqW5XUlHcz1uo+F0LCBrkUDjGyGXWcSgVsVW5Ca9wCSE/evyl+RC
 URq2X96K5V2hMS0Lt3WWTR794MpSMss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-GubLqWuOPLqOlor9v2LbVw-1; Thu, 24 Oct 2019 08:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0683B5E4;
 Thu, 24 Oct 2019 12:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CC7760166;
 Thu, 24 Oct 2019 12:35:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37D1D112FB55; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 19/19] qapi: Implement -compat deprecated-output=hide for
 events
Date: Thu, 24 Oct 2019 14:34:58 +0200
Message-Id: <20191024123458.13505-20-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GubLqWuOPLqOlor9v2LbVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

This policy suppresses deprecated events, and thus permits "testing
the future".

No QMP event is deprecated right now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json       |  4 ++--
 tests/test-qmp-event.c | 17 +++++++++++++++++
 qemu-options.hx        |  4 +++-
 scripts/qapi/events.py | 14 ++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 06e54642bb..4e3da4beee 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -167,14 +167,14 @@
 # Policy for handling "funny" output.
 #
 # @accept: Pass on unchanged
-# TODO @hide: Filter out
+# @hide: Filter out
 #
 # FIXME Guidance on intended use.
 #
 # Since: 4.2
 ##
 { 'enum': 'CompatPolicyOutput',
-  'data': [ 'accept' ] }
+  'data': [ 'accept', 'hide' ] }
=20
 ##
 # @CompatPolicy:
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 7dd0053190..303c8d6382 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
=20
 #include "qemu-common.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
@@ -140,6 +141,21 @@ static void test_event_d(TestEventData *data,
     qobject_unref(data->expect);
 }
=20
+static void test_event_deprecated(TestEventData *data, const void *unused)
+{
+    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATU=
RES1' }");
+
+    qapi_event_send_test_event_features1();
+    g_assert(data->emitted);
+
+    qapi_compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_HIDE;
+    data->emitted =3D false;
+    qapi_event_send_test_event_features1();
+    g_assert(!data->emitted);
+
+    qobject_unref(data->expect);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -148,6 +164,7 @@ int main(int argc, char **argv)
     event_test_add("/event/event_b", test_event_b);
     event_test_add("/event/event_c", test_event_c);
     event_test_add("/event/event_d", test_event_d);
+    event_test_add("/event/deprecated", test_event_deprecated);
     g_test_run();
=20
     return 0;
diff --git a/qemu-options.hx b/qemu-options.hx
index 645629457a..c0128813c6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3320,7 +3320,7 @@ STEXI
 ETEXI
=20
 DEF("compat", HAS_ARG, QEMU_OPTION_compat,
-    "-compat [deprecated-input=3Daccept|reject|crash][,deprecated-output=
=3Daccept]\n"
+    "-compat [deprecated-input=3Daccept|reject|crash][,deprecated-output=
=3Daccept|hide]\n"
     "                Policy for handling deprecated management interfaces\=
n",
     QEMU_ARCH_ALL)
 STEXI
@@ -3337,6 +3337,8 @@ Reject deprecated commands
 Crash on deprecated command
 @item deprecated-output=3Daccept (default)
 Emit deprecated events
+@item deprecated-output=3Dhide
+Suppress deprecated events
 @end table
 FIXME Guidance on intended use
 ETEXI
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index f64e61076e..5778fa1a0d 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -61,7 +61,8 @@ def gen_param_var(typ):
     return ret
=20
=20
-def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
+def gen_event_send(name, arg_type, features, boxed,
+                   event_enum_name, event_emit):
     # FIXME: Our declaration of local variables (and of 'errp' in the
     # parameter list) can collide with exploded members of the event's
     # data type passed in as parameters.  If this collision ever hits in
@@ -86,6 +87,14 @@ def gen_event_send(name, arg_type, boxed, event_enum_nam=
e, event_emit):
         if not boxed:
             ret +=3D gen_param_var(arg_type)
=20
+    if 'deprecated' in [f.name for f in features]:
+        ret +=3D mcgen('''
+
+    if (qapi_compat_policy.deprecated_output =3D=3D COMPAT_POLICY_OUTPUT_H=
IDE) {
+        return;
+    }
+''')
+
     ret +=3D mcgen('''
=20
     qmp =3D qmp_event_build_dict("%(name)s");
@@ -154,6 +163,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisit=
or):
 #include "%(prefix)sqapi-emit-events.h"
 #include "%(events)s.h"
 #include "%(visit)s.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-output-visitor.h"
@@ -192,7 +202,7 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdict)=
;
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
-            self._genc.add(gen_event_send(name, arg_type, boxed,
+            self._genc.add(gen_event_send(name, arg_type, features, boxed,
                                           self._event_enum_name,
                                           self._event_emit_name))
         # Note: we generate the enum member regardless of @ifcond, to
--=20
2.21.0


