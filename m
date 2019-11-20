Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD03C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E897206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFnhhBIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E897206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVKh-0006aC-NY
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVCD-00071i-6N
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVCB-0002Wu-NS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30830
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iXVC7-0002U9-DS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bg+QxGnWgAGLhQ/w5EbbApoaMWMmtldCtQd70JohfpA=;
 b=PFnhhBILvImVj/kvR8N/8aFG9fjll5OSqGFTBrJqD79vOkP5nrEvTMMJLLDbry8m7AuwrO
 tCj8qt+iCR5BGRvq6v7sx0P7Zow2T7uh3em1s+lISHTXwQA6to06pglXrk6GyT8Zj8+htv
 b95fq3MNy/pLhoi+PM0NNKEG2rwwSuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-bl2HaCHQOG6qIFLxAUpFLQ-1; Wed, 20 Nov 2019 13:59:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC862DB61;
 Wed, 20 Nov 2019 18:59:11 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D930A63647;
 Wed, 20 Nov 2019 18:59:09 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9] monitor: move remaining hmp_block* functions to
 blockdev-hmp-cmds.c
Date: Wed, 20 Nov 2019 20:58:48 +0200
Message-Id: <20191120185850.18986-8-mlevitsk@redhat.com>
In-Reply-To: <20191120185850.18986-1-mlevitsk@redhat.com>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: bl2HaCHQOG6qIFLxAUpFLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 blockdev-hmp-cmds.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c  | 64 ---------------------------------------------
 2 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
index f3d22c7dd3..76951352b1 100644
--- a/blockdev-hmp-cmds.c
+++ b/blockdev-hmp-cmds.c
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


