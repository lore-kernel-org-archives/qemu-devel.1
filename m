Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDBC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD81020707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNCxHC4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD81020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDE4-000535-Mm
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6n-0005ws-21
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6l-0004Cn-88
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6j-0004Bl-70
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uplgnk05nmvzXii7ptSX1Nb2C/HeqZjR5kJ19Id48M=;
 b=PNCxHC4ged95KpjCh40va8hIEb2AYejhZDt/Lx7q34E38jU9RmBzvPrda4OkQvgA+t0owq
 0A+GJTEBfey3janOcxHgeo7Wk4Bzxepqh0RUiXBVft55xU8zpthF1chW9fsFACp8o/mZhI
 M7lWdPCnR57Ms4yqSvxJ3gSFGC7Gw8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-5v-Rb_NVMRy84jmRGpsx7A-1; Fri, 22 Nov 2019 11:48:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B13C4107ACC5;
 Fri, 22 Nov 2019 16:48:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D761577014;
 Fri, 22 Nov 2019 16:48:24 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] monitor/hmp: move remaining hmp_block* functions to
 block-hmp-cmds.c
Date: Fri, 22 Nov 2019 18:48:05 +0200
Message-Id: <20191122164807.27938-8-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5v-Rb_NVMRy84jmRGpsx7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 63 +++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c             | 64 ----------------------------------
 2 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index f3d22c7dd3..76951352b1 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -337,3 +337,66 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon,=
 const QDict *qdict)
                                                true, name, &err);
     hmp_handle_error(mon, &err);
 }
+
+void hmp_block_resize(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    int64_t size =3D qdict_get_int(qdict, "size");
+    Error *err =3D NULL;
+
+    qmp_block_resize(true, device, false, NULL, size, &err);
+    hmp_handle_error(mon, &err);
+}
+
+void hmp_block_stream(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *base =3D qdict_get_try_str(qdict, "base");
+    int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
+
+    qmp_block_stream(true, device, device, base !=3D NULL, base, false, NU=
LL,
+                     false, NULL, qdict_haskey(qdict, "speed"), speed, tru=
e,
+                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
+                     &error);
+
+    hmp_handle_error(mon, &error);
+}
+
+void hmp_block_passwd(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *password =3D qdict_get_str(qdict, "password");
+    Error *err =3D NULL;
+
+    qmp_block_passwd(true, device, false, NULL, password, &err);
+    hmp_handle_error(mon, &err);
+}
+
+void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    char *device =3D (char *) qdict_get_str(qdict, "device");
+    BlockIOThrottle throttle =3D {
+        .bps =3D qdict_get_int(qdict, "bps"),
+        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
+        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
+        .iops =3D qdict_get_int(qdict, "iops"),
+        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
+        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
+    };
+
+    /* qmp_block_set_io_throttle has separate parameters for the
+     * (deprecated) block device name and the qdev ID but the HMP
+     * version has only one, so we must decide which one to pass. */
+    if (blk_by_name(device)) {
+        throttle.has_device =3D true;
+        throttle.device =3D device;
+    } else {
+        throttle.has_id =3D true;
+        throttle.id =3D device;
+    }
+
+    qmp_block_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 2acdcd6e1e..8be48e0af6 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1309,16 +1309,6 @@ void hmp_set_link(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
=20
-void hmp_block_passwd(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *password =3D qdict_get_str(qdict, "password");
-    Error *err =3D NULL;
-
-    qmp_block_passwd(true, device, false, NULL, password, &err);
-    hmp_handle_error(mon, &err);
-}
-
 void hmp_balloon(Monitor *mon, const QDict *qdict)
 {
     int64_t value =3D qdict_get_int(qdict, "value");
@@ -1328,17 +1318,6 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
=20
-void hmp_block_resize(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    int64_t size =3D qdict_get_int(qdict, "size");
-    Error *err =3D NULL;
-
-    qmp_block_resize(true, device, false, NULL, size, &err);
-    hmp_handle_error(mon, &err);
-}
-
-
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
     int saved_vm_running  =3D runstate_is_running();
@@ -1887,49 +1866,6 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
=20
-void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
-{
-    Error *err =3D NULL;
-    char *device =3D (char *) qdict_get_str(qdict, "device");
-    BlockIOThrottle throttle =3D {
-        .bps =3D qdict_get_int(qdict, "bps"),
-        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
-        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
-        .iops =3D qdict_get_int(qdict, "iops"),
-        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
-        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
-    };
-
-    /* qmp_block_set_io_throttle has separate parameters for the
-     * (deprecated) block device name and the qdev ID but the HMP
-     * version has only one, so we must decide which one to pass. */
-    if (blk_by_name(device)) {
-        throttle.has_device =3D true;
-        throttle.device =3D device;
-    } else {
-        throttle.has_id =3D true;
-        throttle.id =3D device;
-    }
-
-    qmp_block_set_io_throttle(&throttle, &err);
-    hmp_handle_error(mon, &err);
-}
-
-void hmp_block_stream(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *base =3D qdict_get_try_str(qdict, "base");
-    int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
-
-    qmp_block_stream(true, device, device, base !=3D NULL, base, false, NU=
LL,
-                     false, NULL, qdict_haskey(qdict, "speed"), speed, tru=
e,
-                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
-                     &error);
-
-    hmp_handle_error(mon, &error);
-}
-
 typedef struct HMPMigrationStatus
 {
     QEMUTimer *timer;
--=20
2.17.2


