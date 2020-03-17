Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D637DC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10D52074D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0EGG9Q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10D52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB2b-0008MU-Qy
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoa-0008CM-52
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoX-0006jF-Ml
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21375)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoX-0006fa-F1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fq4EW+oFromDiIjy76Jj42Gb0RRXNiFOAif+yCT6AnU=;
 b=B0EGG9Q8K3qcrBzaZCViS64Rzer6p/I+mftvN+nEFKZfJMV0ZyiD1oaLy6P/eQ2K62/KKZ
 2mWfblGUhUine7JVxS5LeC/avDOo0H6PLr9NV8ljtzsRLZg7NcQk2ANGr0b2NBa3xwfrkY
 4VpNh4dLxQu1D+zAcMeCgY8g4KrdioM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-bZpEtGPXNSmUV9zYQAcbMw-1; Tue, 17 Mar 2020 07:55:15 -0400
X-MC-Unique: bZpEtGPXNSmUV9zYQAcbMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8998014D7;
 Tue, 17 Mar 2020 11:55:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05BEB5F700;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8953C1135246; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 29/34] qapi: Implement deprecated-output=hide for QMP events
Date: Tue, 17 Mar 2020 12:54:54 +0100
Message-Id: <20200317115459.31821-30-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy suppresses deprecated bits in output, and thus permits
"testing the future".  Implement it for QMP events: suppress
deprecated ones.

No QMP event is deprecated right now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-event.c | 19 +++++++++++++++++++
 scripts/qapi/events.py | 14 ++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 7dd0053190..ae4913ceb3 100644
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
@@ -140,6 +141,23 @@ static void test_event_d(TestEventData *data,
     qobject_unref(data->expect);
 }
=20
+static void test_event_deprecated(TestEventData *data, const void *unused)
+{
+    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATU=
RES1' }");
+
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    qapi_event_send_test_event_features1();
+    g_assert(data->emitted);
+
+    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_HIDE;
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
@@ -148,6 +166,7 @@ int main(int argc, char **argv)
     event_test_add("/event/event_b", test_event_b);
     event_test_add("/event/event_c", test_event_c);
     event_test_add("/event/event_d", test_event_d);
+    event_test_add("/event/deprecated", test_event_deprecated);
     g_test_run();
=20
     return 0;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index b544af5a1c..95ca4b4753 100644
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
+    if (compat_policy.deprecated_output =3D=3D COMPAT_POLICY_OUTPUT_HIDE) =
{
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
2.21.1


