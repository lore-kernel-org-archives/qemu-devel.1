Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12919C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B7E2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfjyRGdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B7E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBkh-0004zw-VX
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBX2-0007q1-Jr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBV6-0004RB-K7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUBV6-0004MV-6b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588262003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dG7PMgnrb+L8BjbcijjQdUokyjWoZkXoKJHRq6NPXU=;
 b=LfjyRGdEgBhhWtNgFzvQ/t5GBQ5XvOT+I3d3hK5pzHEjuxwqt/t/cplLAEgrgLXDqaWFFd
 X5zF8SLlOOyyjJ/zckeMUp20pNjo9agr2A5j/87bEyqJRcCRTqdBXPCm3LV4H5YfqxmIQa
 NXWODYoShNexHBEyD94zyUQNxPe/kHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-68dmycWnPjuUGXXUaWgLrw-1; Thu, 30 Apr 2020 11:53:17 -0400
X-MC-Unique: 68dmycWnPjuUGXXUaWgLrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF9D8005B7;
 Thu, 30 Apr 2020 15:53:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E24E60C84;
 Thu, 30 Apr 2020 15:53:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/15] qom: Factor out user_creatable_add_dict()
Date: Thu, 30 Apr 2020 17:52:30 +0200
Message-Id: <20200430155231.473156-15-kwolf@redhat.com>
In-Reply-To: <20200430155231.473156-1-kwolf@redhat.com>
References: <20200430155231.473156-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QMP handler qmp_object_add() and the implementation of --object in
qemu-storage-daemon can share most of the code. Currently,
qemu-storage-daemon calls qmp_object_add(), but this is not correct
because different visitors need to be used.

As a first step towards a fix, make qmp_object_add() a wrapper around a
new function user_creatable_add_dict() that can get an additional
parameter. The handling of "props" is only required for compatibility
and not required for the qemu-storage-daemon command line, so it stays
in qmp_object_add().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qom/object_interfaces.h | 12 ++++++++++++
 qom/object_interfaces.c         | 27 +++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c              | 24 +-----------------------
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interface=
s.h
index 6f92f3cebb..a0037968a4 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -87,6 +87,18 @@ Object *user_creatable_add_type(const char *type, const =
char *id,
                                 const QDict *qdict,
                                 Visitor *v, Error **errp);
=20
+/**
+ * user_creatable_add_dict:
+ * @qdict: the object definition
+ * @errp: if an error occurs, a pointer to an area to store the error
+ *
+ * Create an instance of the user creatable object that is defined by
+ * @qdict.  The object type is taken from the QDict key 'qom-type', its
+ * ID from the key 'id'. The remaining entries in @qdict are used to
+ * initialize the object properties.
+ */
+void user_creatable_add_dict(QDict *qdict, Error **errp);
+
 /**
  * user_creatable_add_opts:
  * @opts: the object definition
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 72cb9e32a9..739e3e5172 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -6,6 +6,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qom/object_interfaces.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
@@ -105,6 +106,32 @@ out:
     return obj;
 }
=20
+void user_creatable_add_dict(QDict *qdict, Error **errp)
+{
+    Visitor *v;
+    Object *obj;
+    g_autofree char *type =3D NULL;
+    g_autofree char *id =3D NULL;
+
+    type =3D g_strdup(qdict_get_try_str(qdict, "qom-type"));
+    if (!type) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
+        return;
+    }
+    qdict_del(qdict, "qom-type");
+
+    id =3D g_strdup(qdict_get_try_str(qdict, "id"));
+    if (!id) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        return;
+    }
+    qdict_del(qdict, "id");
+
+    v =3D qobject_input_visitor_new(QOBJECT(qdict));
+    obj =3D user_creatable_add_type(type, id, qdict, v, errp);
+    visit_free(v);
+    object_unref(obj);
+}
=20
 Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
 {
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e47ebe8ed1..35db44b50e 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -21,7 +21,6 @@
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qobject-input-visitor.h"
 #include "qemu/cutils.h"
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
@@ -245,24 +244,6 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, =
Error **errp)
 {
     QObject *props;
     QDict *pdict;
-    Visitor *v;
-    Object *obj;
-    g_autofree char *type =3D NULL;
-    g_autofree char *id =3D NULL;
-
-    type =3D g_strdup(qdict_get_try_str(qdict, "qom-type"));
-    if (!type) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
-        return;
-    }
-    qdict_del(qdict, "qom-type");
-
-    id =3D g_strdup(qdict_get_try_str(qdict, "id"));
-    if (!id) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "id");
-        return;
-    }
-    qdict_del(qdict, "id");
=20
     props =3D qdict_get(qdict, "props");
     if (props) {
@@ -282,10 +263,7 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, =
Error **errp)
         qobject_unref(pdict);
     }
=20
-    v =3D qobject_input_visitor_new(QOBJECT(qdict));
-    obj =3D user_creatable_add_type(type, id, qdict, v, errp);
-    visit_free(v);
-    object_unref(obj);
+    user_creatable_add_dict(qdict, errp);
 }
=20
 void qmp_object_del(const char *id, Error **errp)
--=20
2.25.3


