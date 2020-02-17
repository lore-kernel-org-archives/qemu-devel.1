Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E1C761A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AEF2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwXCMKry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AEF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45607 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gXJ-0003Xg-F6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3gRn-0004N2-4S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3gRl-0000vS-0g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3gRj-0000uR-Bp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581946102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWJN2qxwSmjmo7/A3dWxWzUdQCpOLcD6TAOZxHPINlQ=;
 b=HwXCMKryfABn04T+aivLP8+KdlKvheh6I3kYJRPMIAtx4/rKZMMeSGEpqRBBxYX3iamyuL
 h/o7jNdnibgfpc0/8b0aTUtNRXhVIKBG18+0imeh5Ld4nCl13JU7it4docBIf1rhc6u4PE
 T7Uy/UPKyihmVy42/3HWW0ED9HY6tEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-2B04YCWuPtafG3IH7Hr4vA-1; Mon, 17 Feb 2020 08:28:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CBA4801E70
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 13:28:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3818410013A1;
 Mon, 17 Feb 2020 13:28:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B23B911366C8; Mon, 17 Feb 2020 14:28:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 4/5] monitor: Move qmp_query_qmp_schema to qmp-cmds-control.c
Date: Mon, 17 Feb 2020 14:28:13 +0100
Message-Id: <20200217132814.9018-5-armbru@redhat.com>
In-Reply-To: <20200217132814.9018-1-armbru@redhat.com>
References: <20200217132814.9018-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2B04YCWuPtafG3IH7Hr4vA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

monitor/misc.c contains code that works only in the system emulator, so
it can't be linked to tools like a storage daemon. In order to make
schema introspection available for tools, move the function to
monitor/qmp-cmds-control.c, which can be linked into the storage daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200129102239.31435-5-kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/misc.c             | 16 ----------------
 monitor/qmp-cmds-control.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 4d402ded85..3e6baba88f 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -180,4 +180,7 @@ void help_cmd(Monitor *mon, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
=20
+void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
+                                 Error **errp);
+
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index 4c4e47fdc4..6c41293102 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -75,7 +75,6 @@
 #include "qapi/qapi-init-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
-#include "qapi/qapi-introspect.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
@@ -232,21 +231,6 @@ static void hmp_info_help(Monitor *mon, const QDict *q=
dict)
     help_cmd(mon, "info");
 }
=20
-/*
- * Minor hack: generated marshalling suppressed for this command
- * ('gen': false in the schema) so we can parse the JSON string
- * directly into QObject instead of first parsing it with
- * visit_type_SchemaInfoList() into a SchemaInfoList, then marshal it
- * to QObject with generated output marshallers, every time.  Instead,
- * we do it in test-qobject-input-visitor.c, just to make sure
- * qapi-gen.py's output actually conforms to the schema.
- */
-static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
-                                 Error **errp)
-{
-    *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
-}
-
 static void monitor_init_qmp_commands(void)
 {
     /*
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index d5f21f90e6..5cd9bb817c 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-emit-events.h"
+#include "qapi/qapi-introspect.h"
=20
 /*
  * Accept QMP capabilities in @list for @mon.
@@ -151,3 +152,18 @@ EventInfoList *qmp_query_events(Error **errp)
=20
     return ev_list;
 }
+
+/*
+ * Minor hack: generated marshalling suppressed for this command
+ * ('gen': false in the schema) so we can parse the JSON string
+ * directly into QObject instead of first parsing it with
+ * visit_type_SchemaInfoList() into a SchemaInfoList, then marshal it
+ * to QObject with generated output marshallers, every time.  Instead,
+ * we do it in test-qobject-input-visitor.c, just to make sure
+ * qapi-gen.py's output actually conforms to the schema.
+ */
+void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
+                                 Error **errp)
+{
+    *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
+}
--=20
2.21.1


