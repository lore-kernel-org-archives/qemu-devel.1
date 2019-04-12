Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFDC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B09F2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="h/QxOBab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B09F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvHe-0004ge-B8
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:27:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAt-00066j-Aa
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAs-00070P-0Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:55 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:38070)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAr-0006ze-Jc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:53 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5D4A32E128D;
	Fri, 12 Apr 2019 15:20:52 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
	[2a02:6b8:0:1472:2741:0:8b6:10])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	VEn76H1FkC-KpMWKQuW; Fri, 12 Apr 2019 15:20:52 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555071652; bh=flDSQI+j21sPI4CmZ6PSn1OkpHEK4JepGKApSy2Uy2E=;
	h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
	b=h/QxOBabfAIa4SQQPBUo07Osv0+2fitr/xvA/BEmeLlHk9DfNDIvo9u4VHwFrw86O
	oAX/HAWHbxRiVIbuSB4TLd6zxzIS4Zfu86t//s0CHv9v67fC9obBj0/sn5ILkEC3Wn
	oHzkoZF8ppaBCii+/+Nm6guocbebtvhpIYWvBi0g=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:3404:6cb5:5ab:ed68])
	by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	m4LakqlT7Q-Kp0WqXeM; Fri, 12 Apr 2019 15:20:51 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2019 15:20:27 +0300
Message-Id: <20190412122028.7067-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 95.108.205.193
Subject: [Qemu-devel] [PATCH 2/3] migration: Add inline-fd protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
	yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122027.F6ggUlS1PcO2cQe9OWSJ6ex-5_gufqXq2cxxynKa2q0@z>

Existing 'fd:' proto works with previously added fd by getfd or add-fd co=
mmands.
If client doesn't want to work with this fd before or after migration the=
n it's
easier to send an fd with the migrate-* command. Also, client shouldn't m=
aintain
this fd.
So, add 'inline-fd:' proto to work with sent fd.

Usage:
{ 'execute': 'migrate', 'arguments': { 'uri': 'inline-fd:' } }
{ 'execute': 'migrate-incoming', 'arguments': { 'uri': 'inline-fd:' } }

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/Makefile.objs |  2 +-
 migration/inline-fd.c   | 89 +++++++++++++++++++++++++++++++++++++++++
 migration/inline-fd.h   | 22 ++++++++++
 migration/migration.c   | 15 +++++++
 migration/trace-events  |  4 ++
 5 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 migration/inline-fd.c
 create mode 100644 migration/inline-fd.h

diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index a4f3bafd86..f4bb6c5803 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y +=3D migration.o socket.o fd.o exec.o
+common-obj-y +=3D migration.o socket.o fd.o inline-fd.o exec.o
 common-obj-y +=3D tls.o channel.o savevm.o
 common-obj-y +=3D colo.o colo-failover.o
 common-obj-y +=3D vmstate.o vmstate-types.o page_cache.o
diff --git a/migration/inline-fd.c b/migration/inline-fd.c
new file mode 100644
index 0000000000..90a0dc079f
--- /dev/null
+++ b/migration/inline-fd.c
@@ -0,0 +1,89 @@
+/*
+ * QEMU live migration via generic fd passed with command
+ *
+ * Copyright Yandex, Inc. 2019
+ *
+ * Authors:
+ *  Yury Kotov <yury-kotov@yandex-team.ru>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "channel.h"
+#include "inline-fd.h"
+#include "monitor/monitor.h"
+#include "io/channel-util.h"
+#include "trace.h"
+
+
+void inline_fd_start_outgoing_migration(MigrationState *s, Error **errp)
+{
+    QIOChannel *ioc;
+    int fd;
+
+    if (!cur_mon) {
+        error_setg(errp, "Monitor is disabled");
+        return;
+    }
+
+    fd =3D monitor_recv_fd(cur_mon, errp);
+    if (fd =3D=3D -1) {
+        return;
+    }
+
+    trace_migration_inline_fd_outgoing(fd);
+    ioc =3D qio_channel_new_fd(fd, errp);
+    if (!ioc) {
+        close(fd);
+        return;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-infd-outgoing");
+    migration_channel_connect(s, ioc, NULL, NULL);
+    object_unref(OBJECT(ioc));
+}
+
+static gboolean inline_fd_accept_incoming_migration(QIOChannel *ioc,
+                                                    GIOCondition conditi=
on,
+                                                    gpointer opaque)
+{
+    migration_channel_process_incoming(ioc);
+    object_unref(OBJECT(ioc));
+    return G_SOURCE_REMOVE;
+}
+
+void inline_fd_start_incoming_migration(Error **errp)
+{
+    QIOChannel *ioc;
+    int fd;
+
+    if (!cur_mon) {
+        error_setg(errp, "Monitor is disabled");
+        return;
+    }
+
+    fd =3D monitor_recv_fd(cur_mon, errp);
+    if (fd =3D=3D -1) {
+        return;
+    }
+
+    trace_migration_inline_fd_incoming(fd);
+    ioc =3D qio_channel_new_fd(fd, errp);
+    if (!ioc) {
+        close(fd);
+        return;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-infd-incoming");
+    qio_channel_add_watch(ioc,
+                          G_IO_IN,
+                          inline_fd_accept_incoming_migration,
+                          NULL,
+                          NULL);
+}
diff --git a/migration/inline-fd.h b/migration/inline-fd.h
new file mode 100644
index 0000000000..5b23ce314d
--- /dev/null
+++ b/migration/inline-fd.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU live migration via generic fd passed with command
+ *
+ * Copyright Yandex, Inc. 2019
+ *
+ * Authors:
+ *  Yury Kotov <yury-kotov@yandex-team.ru>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#ifndef QEMU_MIGRATION_INLINE_FD_H
+#define QEMU_MIGRATION_INLINE_FD_H
+
+void inline_fd_start_incoming_migration(Error **errp);
+void inline_fd_start_outgoing_migration(MigrationState *s, Error **errp)=
;
+
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index 609e0df5d0..7b9fafe218 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -19,6 +19,7 @@
 #include "migration/blocker.h"
 #include "exec.h"
 #include "fd.h"
+#include "inline-fd.h"
 #include "socket.h"
 #include "rdma.h"
 #include "ram.h"
@@ -364,6 +365,13 @@ void qemu_start_incoming_migration(const char *uri, =
Error **errp)
         unix_start_incoming_migration(p, errp);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
+    } else if (strstart(uri, "inline-fd:", &p)) {
+        if (!*p) {
+            inline_fd_start_incoming_migration(errp);
+        } else {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+                       "an empty path for 'inline-fd:' protocol");
+        }
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1924,6 +1932,13 @@ void qmp_migrate(const char *uri, bool has_blk, bo=
ol blk,
         unix_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
+    } else if (strstart(uri, "inline-fd:", &p)) {
+        if (!*p) {
+            inline_fd_start_outgoing_migration(s, &local_err);
+        } else {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+                       "an empty path for 'inline-fd:' protocol");
+        }
     } else {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
diff --git a/migration/trace-events b/migration/trace-events
index de2e136e57..1afd11eab5 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -261,6 +261,10 @@ migration_exec_incoming(const char *cmd) "cmd=3D%s"
 migration_fd_outgoing(int fd) "fd=3D%d"
 migration_fd_incoming(int fd) "fd=3D%d"
=20
+# inline-fd.c
+migration_inline_fd_outgoing(int fd) "fd=3D%d"
+migration_inline_fd_incoming(int fd) "fd=3D%d"
+
 # socket.c
 migration_socket_incoming_accepted(void) ""
 migration_socket_outgoing_connected(const char *hostname) "hostname=3D%s=
"
--=20
2.21.0


