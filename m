Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAEEC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F8F2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA+283w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F8F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkXS-00060I-SZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwkUo-0001dr-Uz
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwkUn-0004Cv-Od
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:22:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwkUn-0004Cj-Lb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580293373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWkt4u6IqgjSMY/oZKZNLjltOiO10J3xyAYIACaN4mU=;
 b=EA+283w29XzJ3GrdV7hTzoAH0H24vJBW/l7U++jhWBSTWQlVB1qu9qtH12fnWRFyvwPsWO
 t+qt5UnW5GALIaSqp8On6FCkM3ZAc7T34SGHdCBkZHuKZh/8bL+ki8y84BaSKCDESzTMeG
 /dGTL0XA5SDcDFgwUmFK4rAjkPHEWT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-VfoBCywYNoyMc6jvf4k2dw-1; Wed, 29 Jan 2020 05:22:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6299C107ACC7;
 Wed, 29 Jan 2020 10:22:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-205.ams2.redhat.com
 [10.36.116.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CD0D7C42C;
 Wed, 29 Jan 2020 10:22:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/4] monitor: Move qmp_query_qmp_schema to
 qmp-cmds-control.c
Date: Wed, 29 Jan 2020 11:22:39 +0100
Message-Id: <20200129102239.31435-5-kwolf@redhat.com>
In-Reply-To: <20200129102239.31435-1-kwolf@redhat.com>
References: <20200129102239.31435-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VfoBCywYNoyMc6jvf4k2dw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

monitor/misc.c contains code that works only in the system emulator, so
it can't be linked to tools like a storage daemon. In order to make
schema introspection available for tools, move the function to
monitor/qmp-cmds-control.c, which can be linked into the storage daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
index 482e19a154..a64963cef4 100644
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
2.20.1


