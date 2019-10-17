Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2126FA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E34D20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34D20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5c4-0005Mg-7u
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SG-0000vq-J1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5SB-0008VY-MT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5S9-0008Tc-5x; Thu, 17 Oct 2019 09:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D2E03082B6D;
 Thu, 17 Oct 2019 13:04:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5181001B23;
 Thu, 17 Oct 2019 13:04:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 12/18] stubs: Update monitor stubs for qemu-storage-daemon
Date: Thu, 17 Oct 2019 15:01:58 +0200
Message-Id: <20191017130204.16131-13-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 13:04:28 +0000 (UTC)
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

Before we can add the monitor to qemu-storage-daemon, we need to add a
few monitor stubs, and we need to make sure that stubs that are actually
implemented in the monitor core aren't linked so that we don't get
linker errors because of duplicate symbols.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 stubs/monitor-core.c | 21 +++++++++++++++++++++
 stubs/monitor.c      | 15 ++-------------
 stubs/Makefile.objs  |  1 +
 3 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 stubs/monitor-core.c

diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
new file mode 100644
index 0000000000..403c00a6d0
--- /dev/null
+++ b/stubs/monitor-core.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "qemu-common.h"
+#include "qapi/qapi-emit-events.h"
+
+__thread Monitor *cur_mon;
+
+void monitor_init_qmp(Chardev *chr, bool pretty)
+{
+}
+
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+}
+
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    abort();
+}
+
+
diff --git a/stubs/monitor.c b/stubs/monitor.c
index c3e9a2e4dc..9403f8e72c 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,14 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-emit-events.h"
 #include "monitor/monitor.h"
-
-__thread Monitor *cur_mon;
-
-int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
-{
-    abort();
-}
+#include "../monitor/monitor-internal.h"
=20
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
@@ -16,14 +9,10 @@ int monitor_get_fd(Monitor *mon, const char *name, Err=
or **errp)
     return -1;
 }
=20
-void monitor_init_qmp(Chardev *chr, bool pretty)
-{
-}
-
 void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
 }
=20
-void qapi_event_emit(QAPIEvent event, QDict *qdict)
+void monitor_fdsets_cleanup(void)
 {
 }
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 77fbf72576..ad4515ac70 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -19,6 +19,7 @@ stub-obj-y +=3D machine-init-done.o
 stub-obj-y +=3D migr-blocker.o
 stub-obj-y +=3D change-state-handler.o
 stub-obj-y +=3D monitor.o
+stub-obj-y +=3D monitor-core.o
 stub-obj-y +=3D notify-event.o
 stub-obj-y +=3D qtest.o
 stub-obj-y +=3D replay.o
--=20
2.20.1


