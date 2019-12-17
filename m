Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454182067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk82sE0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454182067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6gT-0005YC-Vc
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6K0-0000nJ-RC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jw-0000zM-Ey
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jw-0000wO-7U
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zz1BdIBykpy+A3TslHFCNCV/ACFmhDH4nK9Dd2kpEbQ=;
 b=Bk82sE0bs5kGBokEKr840WWLChKrvEcBX/uJAaXSwYiVoyUwc3YvLOFI4JsDO4DOqSUjih
 sSluuH+DeJeFEsIdZg1pEJd0tYJn7CMRjfvbUYRMrNGBg6r0+hPShpgrtJ/pKYWWnT0VF/
 JT23kVmCXF4KG2YLhuS4GhkRmo/7RHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-T14700GVOnOCrjuK43m8Sw-1; Tue, 17 Dec 2019 01:26:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50745800D4C;
 Tue, 17 Dec 2019 06:26:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9A485C28C;
 Tue, 17 Dec 2019 06:26:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C2CD1136421; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/34] hmp: drop Error pointer indirection in hmp_handle_error
Date: Tue, 17 Dec 2019 07:26:34 +0100
Message-Id: <20191217062651.9687-18-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: T14700GVOnOCrjuK43m8Sw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We don't need Error **, as all callers pass local Error object, which
isn't used after the call. Use Error * instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191205174635.18758-5-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/hmp.h      |   2 +-
 dump/dump-hmp-cmds.c       |   4 +-
 hw/core/machine-hmp-cmds.c |   6 +-
 monitor/hmp-cmds.c         | 155 ++++++++++++++++++-------------------
 qdev-monitor.c             |   4 +-
 qom/qom-hmp-cmds.c         |   4 +-
 6 files changed, 87 insertions(+), 88 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index a0e9511440..3d329853b2 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,7 +16,7 @@
=20
 #include "qemu/readline.h"
=20
-void hmp_handle_error(Monitor *mon, Error **errp);
+void hmp_handle_error(Monitor *mon, Error *err);
=20
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index 3dbf44372c..e5053b04cd 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -32,7 +32,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdi=
ct)
=20
     if (zlib + lzo + snappy + win_dmp > 1) {
         error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -66,7 +66,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdi=
ct)
=20
     qmp_dump_guest_memory(paging, prot, true, detach, has_begin, begin,
                           has_length, length, true, dump_format, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
     g_free(prot);
 }
=20
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index cd970cc4c5..b76f7223af 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -55,7 +55,7 @@ void hmp_cpu_add(Monitor *mon, const QDict *qdict)
=20
     cpuid =3D qdict_get_int(qdict, "id");
     qmp_cpu_add(cpuid, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
@@ -66,7 +66,7 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdi=
ct)
     CpuInstanceProperties *c;
=20
     if (err !=3D NULL) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -135,7 +135,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\n");
=20
     qapi_free_MemdevList(memdev_list);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_info_numa(Monitor *mon, const QDict *qdict)
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..c5dea307b6 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -60,11 +60,10 @@
 #include <spice/enums.h>
 #endif
=20
-void hmp_handle_error(Monitor *mon, Error **errp)
+void hmp_handle_error(Monitor *mon, Error *err)
 {
-    assert(errp);
-    if (*errp) {
-        error_reportf_err(*errp, "Error: ");
+    if (err) {
+        error_reportf_err(err, "Error: ");
     }
 }
=20
@@ -734,7 +733,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
=20
     info2l =3D qmp_query_vnc_servers(&err);
     if (err) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
     if (!info2l) {
@@ -850,7 +849,7 @@ void hmp_info_balloon(Monitor *mon, const QDict *qdict)
=20
     info =3D qmp_query_balloon(&err);
     if (err) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -1172,7 +1171,7 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdic=
t)
         Error *err =3D NULL;
=20
         error_setg(&err, QERR_INVALID_PARAMETER, op);
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
     }
 }
=20
@@ -1191,7 +1190,7 @@ void hmp_exit_preconfig(Monitor *mon, const QDict *qd=
ict)
     Error *err =3D NULL;
=20
     qmp_x_exit_preconfig(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_cpu(Monitor *mon, const QDict *qdict)
@@ -1220,7 +1219,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
     }
=20
     qmp_memsave(addr, size, filename, true, cpu_index, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
@@ -1231,7 +1230,7 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_pmemsave(addr, size, filename, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
@@ -1242,7 +1241,7 @@ void hmp_ringbuf_write(Monitor *mon, const QDict *qdi=
ct)
=20
     qmp_ringbuf_write(chardev, data, false, 0, &err);
=20
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_ringbuf_read(Monitor *mon, const QDict *qdict)
@@ -1255,7 +1254,7 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qdic=
t)
=20
     data =3D qmp_ringbuf_read(chardev, size, false, 0, &err);
     if (err) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -1280,7 +1279,7 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_cont(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
@@ -1288,7 +1287,7 @@ void hmp_system_wakeup(Monitor *mon, const QDict *qdi=
ct)
     Error *err =3D NULL;
=20
     qmp_system_wakeup(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_nmi(Monitor *mon, const QDict *qdict)
@@ -1296,7 +1295,7 @@ void hmp_nmi(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_inject_nmi(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_set_link(Monitor *mon, const QDict *qdict)
@@ -1306,7 +1305,7 @@ void hmp_set_link(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_set_link(name, up, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_block_passwd(Monitor *mon, const QDict *qdict)
@@ -1316,7 +1315,7 @@ void hmp_block_passwd(Monitor *mon, const QDict *qdic=
t)
     Error *err =3D NULL;
=20
     qmp_block_passwd(true, device, false, NULL, password, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_balloon(Monitor *mon, const QDict *qdict)
@@ -1325,7 +1324,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_balloon(value, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_block_resize(Monitor *mon, const QDict *qdict)
@@ -1335,7 +1334,7 @@ void hmp_block_resize(Monitor *mon, const QDict *qdic=
t)
     Error *err =3D NULL;
=20
     qmp_block_resize(true, device, false, NULL, size, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
@@ -1358,11 +1357,11 @@ void hmp_drive_mirror(Monitor *mon, const QDict *qd=
ict)
=20
     if (!filename) {
         error_setg(&err, QERR_MISSING_PARAMETER, "target");
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
     qmp_drive_mirror(&mirror, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_drive_backup(Monitor *mon, const QDict *qdict)
@@ -1388,12 +1387,12 @@ void hmp_drive_backup(Monitor *mon, const QDict *qd=
ict)
=20
     if (!filename) {
         error_setg(&err, QERR_MISSING_PARAMETER, "target");
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
     qmp_drive_backup(&backup, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
@@ -1409,7 +1408,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *q=
dict)
         /* In the future, if 'snapshot-file' is not specified, the snapsho=
t
            will be taken internally. Today it's actually required. */
         error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -1418,7 +1417,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *q=
dict)
                                filename, false, NULL,
                                !!format, format,
                                true, mode, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
@@ -1428,7 +1427,7 @@ void hmp_snapshot_blkdev_internal(Monitor *mon, const=
 QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_blockdev_snapshot_internal_sync(device, name, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
@@ -1440,7 +1439,7 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon=
, const QDict *qdict)
=20
     qmp_blockdev_snapshot_delete_internal_sync(device, !!id, id,
                                                true, name, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
@@ -1454,7 +1453,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
     if (load_snapshot(name, &err) =3D=3D 0 && saved_vm_running) {
         vm_start();
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_savevm(Monitor *mon, const QDict *qdict)
@@ -1462,7 +1461,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     save_snapshot(qdict_get_try_str(qdict, "name"), &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_delvm(Monitor *mon, const QDict *qdict)
@@ -1476,7 +1475,7 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
                       "deleting snapshot on device '%s': ",
                       bdrv_get_device_name(bs));
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
@@ -1652,7 +1651,7 @@ void hmp_migrate_continue(Monitor *mon, const QDict *=
qdict)
         qmp_migrate_continue(val, &err);
     }
=20
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
@@ -1662,7 +1661,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *=
qdict)
=20
     qmp_migrate_incoming(uri, &err);
=20
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
@@ -1672,7 +1671,7 @@ void hmp_migrate_recover(Monitor *mon, const QDict *q=
dict)
=20
     qmp_migrate_recover(uri, &err);
=20
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_migrate_pause(Monitor *mon, const QDict *qdict)
@@ -1681,7 +1680,7 @@ void hmp_migrate_pause(Monitor *mon, const QDict *qdi=
ct)
=20
     qmp_migrate_pause(&err);
=20
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 /* Kept for backwards compatibility */
@@ -1697,7 +1696,7 @@ void hmp_migrate_set_cache_size(Monitor *mon, const Q=
Dict *qdict)
     Error *err =3D NULL;
=20
     qmp_migrate_set_cache_size(value, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 /* Kept for backwards compatibility */
@@ -1728,7 +1727,7 @@ void hmp_migrate_set_capability(Monitor *mon, const Q=
Dict *qdict)
=20
 end:
     qapi_free_MigrationCapabilityStatusList(caps);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
@@ -1869,7 +1868,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
  cleanup:
     qapi_free_MigrateSetParameters(p);
     visit_free(v);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_client_migrate_info(Monitor *mon, const QDict *qdict)
@@ -1886,14 +1885,14 @@ void hmp_client_migrate_info(Monitor *mon, const QD=
ict *qdict)
     qmp_client_migrate_info(protocol, hostname,
                             has_port, port, has_tls_port, tls_port,
                             !!cert_subject, cert_subject, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_migrate_start_postcopy(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
     qmp_migrate_start_postcopy(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict)
@@ -1901,7 +1900,7 @@ void hmp_x_colo_lost_heartbeat(Monitor *mon, const QD=
ict *qdict)
     Error *err =3D NULL;
=20
     qmp_x_colo_lost_heartbeat(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_set_password(Monitor *mon, const QDict *qdict)
@@ -1912,7 +1911,7 @@ void hmp_set_password(Monitor *mon, const QDict *qdic=
t)
     Error *err =3D NULL;
=20
     qmp_set_password(protocol, password, !!connected, connected, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_expire_password(Monitor *mon, const QDict *qdict)
@@ -1922,7 +1921,7 @@ void hmp_expire_password(Monitor *mon, const QDict *q=
dict)
     Error *err =3D NULL;
=20
     qmp_expire_password(protocol, whenstr, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_eject(Monitor *mon, const QDict *qdict)
@@ -1932,7 +1931,7 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_eject(true, device, false, NULL, true, force, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 #ifdef CONFIG_VNC
@@ -1978,7 +1977,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
                                 read_only,
                                 BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &er=
r);
             if (err) {
-                hmp_handle_error(mon, &err);
+                hmp_handle_error(mon, err);
                 return;
             }
         }
@@ -1988,7 +1987,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
                                    &err);
     }
=20
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
@@ -2016,7 +2015,7 @@ void hmp_block_set_io_throttle(Monitor *mon, const QD=
ict *qdict)
     }
=20
     qmp_block_set_io_throttle(&throttle, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
@@ -2031,7 +2030,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qdic=
t)
                      BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
                      &error);
=20
-    hmp_handle_error(mon, &error);
+    hmp_handle_error(mon, error);
 }
=20
 void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict)
@@ -2042,7 +2041,7 @@ void hmp_block_job_set_speed(Monitor *mon, const QDic=
t *qdict)
=20
     qmp_block_job_set_speed(device, value, &error);
=20
-    hmp_handle_error(mon, &error);
+    hmp_handle_error(mon, error);
 }
=20
 void hmp_block_job_cancel(Monitor *mon, const QDict *qdict)
@@ -2053,7 +2052,7 @@ void hmp_block_job_cancel(Monitor *mon, const QDict *=
qdict)
=20
     qmp_block_job_cancel(device, true, force, &error);
=20
-    hmp_handle_error(mon, &error);
+    hmp_handle_error(mon, error);
 }
=20
 void hmp_block_job_pause(Monitor *mon, const QDict *qdict)
@@ -2063,7 +2062,7 @@ void hmp_block_job_pause(Monitor *mon, const QDict *q=
dict)
=20
     qmp_block_job_pause(device, &error);
=20
-    hmp_handle_error(mon, &error);
+    hmp_handle_error(mon, error);
 }
=20
 void hmp_block_job_resume(Monitor *mon, const QDict *qdict)
@@ -2073,7 +2072,7 @@ void hmp_block_job_resume(Monitor *mon, const QDict *=
qdict)
=20
     qmp_block_job_resume(device, &error);
=20
-    hmp_handle_error(mon, &error);
+    hmp_handle_error(mon, error);
 }
=20
 void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
@@ -2083,7 +2082,7 @@ void hmp_block_job_complete(Monitor *mon, const QDict=
 *qdict)
=20
     qmp_block_job_complete(device, &error);
=20
-    hmp_handle_error(mon, &error);
+    hmp_handle_error(mon, error);
 }
=20
 typedef struct HMPMigrationStatus
@@ -2143,7 +2142,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     qmp_migrate(uri, !!blk, blk, !!inc, inc,
                 false, false, true, resume, &err);
     if (err) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -2181,7 +2180,7 @@ void hmp_netdev_add(Monitor *mon, const QDict *qdict)
     }
=20
 out:
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_netdev_del(Monitor *mon, const QDict *qdict)
@@ -2190,7 +2189,7 @@ void hmp_netdev_del(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_netdev_del(id, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_object_add(Monitor *mon, const QDict *qdict)
@@ -2201,7 +2200,7 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
=20
     opts =3D qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
     if (err) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -2209,7 +2208,7 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
     qemu_opts_del(opts);
=20
     if (err) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
     }
     if (obj) {
         object_unref(obj);
@@ -2222,7 +2221,7 @@ void hmp_getfd(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_getfd(fdname, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_closefd(Monitor *mon, const QDict *qdict)
@@ -2231,7 +2230,7 @@ void hmp_closefd(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_closefd(fdname, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_sendkey(Monitor *mon, const QDict *qdict)
@@ -2290,7 +2289,7 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
     }
=20
     qmp_send_key(head, has_hold_time, hold_time, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
=20
 out:
     qapi_free_KeyValueList(head);
@@ -2309,7 +2308,7 @@ void hmp_screendump(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_screendump(filename, id !=3D NULL, id, id !=3D NULL, head, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
@@ -2364,7 +2363,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *=
qdict)
     qapi_free_BlockInfoList(block_list);
=20
 exit:
-    hmp_handle_error(mon, &local_err);
+    hmp_handle_error(mon, local_err);
 }
=20
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
@@ -2376,7 +2375,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qd=
ict)
=20
     qmp_nbd_server_add(device, !!name, name, true, writable,
                        false, NULL, &local_err);
-    hmp_handle_error(mon, &local_err);
+    hmp_handle_error(mon, local_err);
 }
=20
 void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
@@ -2387,7 +2386,7 @@ void hmp_nbd_server_remove(Monitor *mon, const QDict =
*qdict)
=20
     /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
     qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
@@ -2395,7 +2394,7 @@ void hmp_nbd_server_stop(Monitor *mon, const QDict *q=
dict)
     Error *err =3D NULL;
=20
     qmp_nbd_server_stop(&err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_chardev_add(Monitor *mon, const QDict *qdict)
@@ -2411,7 +2410,7 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict=
)
         qemu_chr_new_from_opts(opts, NULL, &err);
         qemu_opts_del(opts);
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_chardev_change(Monitor *mon, const QDict *qdict)
@@ -2445,7 +2444,7 @@ end:
     qapi_free_ChardevReturn(ret);
     qapi_free_ChardevBackend(backend);
     qemu_opts_del(opts);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
@@ -2453,7 +2452,7 @@ void hmp_chardev_remove(Monitor *mon, const QDict *qd=
ict)
     Error *local_err =3D NULL;
=20
     qmp_chardev_remove(qdict_get_str(qdict, "id"), &local_err);
-    hmp_handle_error(mon, &local_err);
+    hmp_handle_error(mon, local_err);
 }
=20
 void hmp_chardev_send_break(Monitor *mon, const QDict *qdict)
@@ -2461,7 +2460,7 @@ void hmp_chardev_send_break(Monitor *mon, const QDict=
 *qdict)
     Error *local_err =3D NULL;
=20
     qmp_chardev_send_break(qdict_get_str(qdict, "id"), &local_err);
-    hmp_handle_error(mon, &local_err);
+    hmp_handle_error(mon, local_err);
 }
=20
 void hmp_qemu_io(Monitor *mon, const QDict *qdict)
@@ -2517,7 +2516,7 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
=20
 fail:
     blk_unref(local_blk);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_object_del(Monitor *mon, const QDict *qdict)
@@ -2526,7 +2525,7 @@ void hmp_object_del(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     user_creatable_del(id, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
@@ -2576,7 +2575,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDic=
t *qdict)
     }
=20
     qapi_free_MemoryDeviceInfoList(info_list);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
@@ -2605,7 +2604,7 @@ void hmp_rocker(Monitor *mon, const QDict *qdict)
=20
     rocker =3D qmp_query_rocker(name, &err);
     if (err !=3D NULL) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -2624,7 +2623,7 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdic=
t)
=20
     list =3D qmp_query_rocker_ports(name, &err);
     if (err !=3D NULL) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -2653,7 +2652,7 @@ void hmp_rocker_of_dpa_flows(Monitor *mon, const QDic=
t *qdict)
=20
     list =3D qmp_query_rocker_of_dpa_flows(name, tbl_id !=3D -1, tbl_id, &=
err);
     if (err !=3D NULL) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -2804,7 +2803,7 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const QDi=
ct *qdict)
=20
     list =3D qmp_query_rocker_of_dpa_groups(name, type !=3D 9, type, &err)=
;
     if (err !=3D NULL) {
-        hmp_handle_error(mon, &err);
+        hmp_handle_error(mon, err);
         return;
     }
=20
@@ -2911,7 +2910,7 @@ void hmp_info_vm_generation_id(Monitor *mon, const QD=
ict *qdict)
     if (info) {
         monitor_printf(mon, "%s\n", info->guid);
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
     qapi_free_GuidInfo(info);
 }
=20
@@ -2930,5 +2929,5 @@ void hmp_info_memory_size_summary(Monitor *mon, const=
 QDict *qdict)
=20
         qapi_free_MemoryInfo(info);
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index e6b112eb0a..29ed73e56a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -890,7 +890,7 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_device_add((QDict *)qdict, NULL, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_device_del(Monitor *mon, const QDict *qdict)
@@ -899,7 +899,7 @@ void hmp_device_del(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_device_del(id, &err);
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index a268e01eb4..cd08233a4c 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -37,7 +37,7 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
         }
         qapi_free_ObjectPropertyInfoList(start);
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 void hmp_qom_set(Monitor *mon, const QDict *qdict)
@@ -59,7 +59,7 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
         }
         object_property_parse(obj, value, property, &err);
     }
-    hmp_handle_error(mon, &err);
+    hmp_handle_error(mon, err);
 }
=20
 typedef struct QOMCompositionState {
--=20
2.21.0


