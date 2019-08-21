Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87902C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C4D20856
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C4D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50163 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TAR-0004G1-8V
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i0T9f-0002qM-2K
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i0T9d-0002hu-MP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:08:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i0T9a-0002gd-3P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:08:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E47B6368CF
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:08:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B02A5610C6;
 Wed, 21 Aug 2019 16:08:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BE1B11655F4; Wed, 21 Aug 2019 18:08:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:08:02 +0200
Message-Id: <20190821160803.10026-4-armbru@redhat.com>
In-Reply-To: <20190821160803.10026-1-armbru@redhat.com>
References: <20190821160803.10026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 21 Aug 2019 16:08:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] qdev: Collect HMP handlers command handlers
 in qdev-monitor.c
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move hmp_device_add(), hmp_device_del() from monitor/hmp-cmds.c to
qdev-monitor.c, where they are covered by MAINTAINERS section "QOM",
just like qapi/qdev.json.  hmp_info_qtree() and hmp_info_qdm() are
already there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190709185936.31335-1-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 monitor/hmp-cmds.c | 19 -------------------
 qdev-monitor.c     | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e4d4043a3b..b2551c16d1 100644
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
@@ -2167,23 +2165,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
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
index a0003bf2a9..8fe5c2cad2 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
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


