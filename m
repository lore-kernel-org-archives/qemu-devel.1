Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625EFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A48720869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A48720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5lG-0008Et-TR
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SV-0001KL-3z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5SQ-0000AO-2L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5SN-00008E-8W; Thu, 17 Oct 2019 09:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 803553090FDF;
 Thu, 17 Oct 2019 13:04:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F267610098FB;
 Thu, 17 Oct 2019 13:04:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 17/18] monitor: Move qmp_query_qmp_schema to
 qmp-cmds-monitor.c
Date: Thu, 17 Oct 2019 15:02:03 +0200
Message-Id: <20191017130204.16131-18-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 17 Oct 2019 13:04:42 +0000 (UTC)
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

monitor/misc.c contains code that works only in the system emulator, so
it can't be linked to the storage daemon. In order to make schema
introspection available for the storage daemon, move the function to
monitor/qmp-cmds-monitor.c, which can be linked into the storage daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/misc.c             | 16 ----------------
 monitor/qmp-cmds-monitor.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 451aa64c1a..b91cb09ee5 100644
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
index 95c87df09b..4c90c6813e 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -69,7 +69,6 @@
 #include "qapi/qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
-#include "qapi/qapi-introspect.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
@@ -229,21 +228,6 @@ static void hmp_info_help(Monitor *mon, const QDict =
*qdict)
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
diff --git a/monitor/qmp-cmds-monitor.c b/monitor/qmp-cmds-monitor.c
index acebfd3716..7215392f3e 100644
--- a/monitor/qmp-cmds-monitor.c
+++ b/monitor/qmp-cmds-monitor.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-monitor.h"
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


