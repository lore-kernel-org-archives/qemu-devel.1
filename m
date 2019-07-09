Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD0C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3AB2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3AB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvNz-0005h3-QE
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkvLJ-0003Th-2w
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkvLH-0005pR-V9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5231)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkvLB-0005jH-6C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AA21A3B63
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 18:59:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55E225B806;
 Tue,  9 Jul 2019 18:59:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAC281138648; Tue,  9 Jul 2019 20:59:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:59:36 +0200
Message-Id: <20190709185936.31335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 09 Jul 2019 18:59:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qdev: Collect HMP handlers command handlers in
 qdev-monitor.c
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move hmp_device_add(), hmp_device_del() from monitor/hmp-cmds.c to
qdev-monitor.c, where they are covered by MAINTAINERS section "QOM",
just like qapi/qdev.json.  hmp_info_qtree() and hmp_info_qdm() are
already there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
This is a follow-up to my "Move QOM, qdev, machine core and dump code"
series, merged in commit 374f63f6810.

 monitor/hmp-cmds.c | 19 -------------------
 qdev-monitor.c     | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 99ceb0846b..550d363374 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,7 +25,6 @@
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
 #include "monitor/monitor-internal.h"
-#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/opts-visitor.h"
@@ -35,7 +34,6 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
-#include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-rocker.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
@@ -2181,23 +2179,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
 }
=20
-void hmp_device_add(Monitor *mon, const QDict *qdict)
-{
-    Error *err =3D NULL;
-
-    qmp_device_add((QDict *)qdict, NULL, &err);
-    hmp_handle_error(mon, &err);
-}
-
-void hmp_device_del(Monitor *mon, const QDict *qdict)
-{
-    const char *id =3D qdict_get_str(qdict, "id");
-    Error *err =3D NULL;
-
-    qmp_device_del(id, &err);
-    hmp_handle_error(mon, &err);
-}
-
 void hmp_netdev_add(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 58222c2211..cd6299e92b 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "hw/sysbus.h"
+#include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
@@ -844,6 +845,23 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
=20
+void hmp_device_add(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+
+    qmp_device_add((QDict *)qdict, NULL, &err);
+    hmp_handle_error(mon, &err);
+}
+
+void hmp_device_del(Monitor *mon, const QDict *qdict)
+{
+    const char *id =3D qdict_get_str(qdict, "id");
+    Error *err =3D NULL;
+
+    qmp_device_del(id, &err);
+    hmp_handle_error(mon, &err);
+}
+
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 {
     DeviceState *dev;
--=20
2.21.0


