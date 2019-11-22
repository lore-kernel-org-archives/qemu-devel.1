Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD1C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ADA20674
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDGiH8RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ADA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDAS-0002R8-Lm
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC7D-0005z1-0J
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC75-0004Kq-6v
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6t-0004Dj-6Z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgK5Xo36lDrENAHEJy6DofaTGP8Y8rbG8Btlz+6uNy8=;
 b=UDGiH8RUuJiUiiulPxodS4l50EycHIUo1lg0Q9CGoWDLEypIsfXBj6CpFQ4K+LrX3tzZT+
 TXagPQLCILEhhs8KRQTiIrs+kNZTWaKwlN1aD8BKw8n0xbIxC0RbEk23iSb4PPIIJCjfaS
 msreJSbaMDhaSfjAjWEKiEywtSPiYjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-VA1tVi5HP7arFCH8CrSbjQ-1; Fri, 22 Nov 2019 11:48:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189B210509B6;
 Fri, 22 Nov 2019 16:48:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14C5877010;
 Fri, 22 Nov 2019 16:48:26 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
Date: Fri, 22 Nov 2019 18:48:06 +0200
Message-Id: <20191122164807.27938-9-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VA1tVi5HP7arFCH8CrSbjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 247 +++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c             | 245 --------------------------------
 2 files changed, 247 insertions(+), 245 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 76951352b1..c943dccd03 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "block/block_int.h"
+#include "block/qapi.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qmp/qerror.h"
 #include "monitor/hmp.h"
@@ -400,3 +401,249 @@ void hmp_block_set_io_throttle(Monitor *mon, const QD=
ict *qdict)
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
+
+static void print_block_info(Monitor *mon, BlockInfo *info,
+                             BlockDeviceInfo *inserted, bool verbose)
+{
+    ImageInfo *image_info;
+
+    assert(!info || !info->has_inserted || info->inserted =3D=3D inserted)=
;
+
+    if (info && *info->device) {
+        monitor_printf(mon, "%s", info->device);
+        if (inserted && inserted->has_node_name) {
+            monitor_printf(mon, " (%s)", inserted->node_name);
+        }
+    } else {
+        assert(info || inserted);
+        monitor_printf(mon, "%s",
+                       inserted && inserted->has_node_name ? inserted->nod=
e_name
+                       : info && info->has_qdev ? info->qdev
+                       : "<anonymous>");
+    }
+
+    if (inserted) {
+        monitor_printf(mon, ": %s (%s%s%s)\n",
+                       inserted->file,
+                       inserted->drv,
+                       inserted->ro ? ", read-only" : "",
+                       inserted->encrypted ? ", encrypted" : "");
+    } else {
+        monitor_printf(mon, ": [not inserted]\n");
+    }
+
+    if (info) {
+        if (info->has_qdev) {
+            monitor_printf(mon, "    Attached to:      %s\n", info->qdev);
+        }
+        if (info->has_io_status && info->io_status !=3D BLOCK_DEVICE_IO_ST=
ATUS_OK) {
+            monitor_printf(mon, "    I/O status:       %s\n",
+                           BlockDeviceIoStatus_str(info->io_status));
+        }
+
+        if (info->removable) {
+            monitor_printf(mon, "    Removable device: %slocked, tray %s\n=
",
+                           info->locked ? "" : "not ",
+                           info->tray_open ? "open" : "closed");
+        }
+    }
+
+
+    if (!inserted) {
+        return;
+    }
+
+    monitor_printf(mon, "    Cache mode:       %s%s%s\n",
+                   inserted->cache->writeback ? "writeback" : "writethroug=
h",
+                   inserted->cache->direct ? ", direct" : "",
+                   inserted->cache->no_flush ? ", ignore flushes" : "");
+
+    if (inserted->has_backing_file) {
+        monitor_printf(mon,
+                       "    Backing file:     %s "
+                       "(chain depth: %" PRId64 ")\n",
+                       inserted->backing_file,
+                       inserted->backing_file_depth);
+    }
+
+    if (inserted->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF) {
+        monitor_printf(mon, "    Detect zeroes:    %s\n",
+                BlockdevDetectZeroesOptions_str(inserted->detect_zeroes));
+    }
+
+    if (inserted->bps  || inserted->bps_rd  || inserted->bps_wr  ||
+        inserted->iops || inserted->iops_rd || inserted->iops_wr)
+    {
+        monitor_printf(mon, "    I/O throttling:   bps=3D%" PRId64
+                        " bps_rd=3D%" PRId64  " bps_wr=3D%" PRId64
+                        " bps_max=3D%" PRId64
+                        " bps_rd_max=3D%" PRId64
+                        " bps_wr_max=3D%" PRId64
+                        " iops=3D%" PRId64 " iops_rd=3D%" PRId64
+                        " iops_wr=3D%" PRId64
+                        " iops_max=3D%" PRId64
+                        " iops_rd_max=3D%" PRId64
+                        " iops_wr_max=3D%" PRId64
+                        " iops_size=3D%" PRId64
+                        " group=3D%s\n",
+                        inserted->bps,
+                        inserted->bps_rd,
+                        inserted->bps_wr,
+                        inserted->bps_max,
+                        inserted->bps_rd_max,
+                        inserted->bps_wr_max,
+                        inserted->iops,
+                        inserted->iops_rd,
+                        inserted->iops_wr,
+                        inserted->iops_max,
+                        inserted->iops_rd_max,
+                        inserted->iops_wr_max,
+                        inserted->iops_size,
+                        inserted->group);
+    }
+
+    if (verbose) {
+        monitor_printf(mon, "\nImages:\n");
+        image_info =3D inserted->image;
+        while (1) {
+                bdrv_image_info_dump(image_info);
+            if (image_info->has_backing_image) {
+                image_info =3D image_info->backing_image;
+            } else {
+                break;
+            }
+        }
+    }
+}
+
+void hmp_info_block(Monitor *mon, const QDict *qdict)
+{
+    BlockInfoList *block_list, *info;
+    BlockDeviceInfoList *blockdev_list, *blockdev;
+    const char *device =3D qdict_get_try_str(qdict, "device");
+    bool verbose =3D qdict_get_try_bool(qdict, "verbose", false);
+    bool nodes =3D qdict_get_try_bool(qdict, "nodes", false);
+    bool printed =3D false;
+
+    /* Print BlockBackend information */
+    if (!nodes) {
+        block_list =3D qmp_query_block(NULL);
+    } else {
+        block_list =3D NULL;
+    }
+
+    for (info =3D block_list; info; info =3D info->next) {
+        if (device && strcmp(device, info->value->device)) {
+            continue;
+        }
+
+        if (info !=3D block_list) {
+            monitor_printf(mon, "\n");
+        }
+
+        print_block_info(mon, info->value, info->value->has_inserted
+                                           ? info->value->inserted : NULL,
+                         verbose);
+        printed =3D true;
+    }
+
+    qapi_free_BlockInfoList(block_list);
+
+    if ((!device && !nodes) || printed) {
+        return;
+    }
+
+    /* Print node information */
+    blockdev_list =3D qmp_query_named_block_nodes(NULL);
+    for (blockdev =3D blockdev_list; blockdev; blockdev =3D blockdev->next=
) {
+        assert(blockdev->value->has_node_name);
+        if (device && strcmp(device, blockdev->value->node_name)) {
+            continue;
+        }
+
+        if (blockdev !=3D blockdev_list) {
+            monitor_printf(mon, "\n");
+        }
+
+        print_block_info(mon, NULL, blockdev->value, verbose);
+    }
+    qapi_free_BlockDeviceInfoList(blockdev_list);
+}
+
+void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
+{
+    BlockStatsList *stats_list, *stats;
+
+    stats_list =3D qmp_query_blockstats(false, false, NULL);
+
+    for (stats =3D stats_list; stats; stats =3D stats->next) {
+        if (!stats->value->has_device) {
+            continue;
+        }
+
+        monitor_printf(mon, "%s:", stats->value->device);
+        monitor_printf(mon, " rd_bytes=3D%" PRId64
+                       " wr_bytes=3D%" PRId64
+                       " rd_operations=3D%" PRId64
+                       " wr_operations=3D%" PRId64
+                       " flush_operations=3D%" PRId64
+                       " wr_total_time_ns=3D%" PRId64
+                       " rd_total_time_ns=3D%" PRId64
+                       " flush_total_time_ns=3D%" PRId64
+                       " rd_merged=3D%" PRId64
+                       " wr_merged=3D%" PRId64
+                       " idle_time_ns=3D%" PRId64
+                       "\n",
+                       stats->value->stats->rd_bytes,
+                       stats->value->stats->wr_bytes,
+                       stats->value->stats->rd_operations,
+                       stats->value->stats->wr_operations,
+                       stats->value->stats->flush_operations,
+                       stats->value->stats->wr_total_time_ns,
+                       stats->value->stats->rd_total_time_ns,
+                       stats->value->stats->flush_total_time_ns,
+                       stats->value->stats->rd_merged,
+                       stats->value->stats->wr_merged,
+                       stats->value->stats->idle_time_ns);
+    }
+
+    qapi_free_BlockStatsList(stats_list);
+}
+
+void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
+{
+    BlockJobInfoList *list;
+    Error *err =3D NULL;
+
+    list =3D qmp_query_block_jobs(&err);
+    assert(!err);
+
+    if (!list) {
+        monitor_printf(mon, "No active jobs\n");
+        return;
+    }
+
+    while (list) {
+        if (strcmp(list->value->type, "stream") =3D=3D 0) {
+            monitor_printf(mon, "Streaming device %s: Completed %" PRId64
+                           " of %" PRId64 " bytes, speed limit %" PRId64
+                           " bytes/s\n",
+                           list->value->device,
+                           list->value->offset,
+                           list->value->len,
+                           list->value->speed);
+        } else {
+            monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
+                           " of %" PRId64 " bytes, speed limit %" PRId64
+                           " bytes/s\n",
+                           list->value->type,
+                           list->value->device,
+                           list->value->offset,
+                           list->value->len,
+                           list->value->speed);
+        }
+        list =3D list->next;
+    }
+
+    qapi_free_BlockJobInfoList(list);
+}
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 8be48e0af6..1008902bc3 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -468,213 +468,6 @@ void hmp_info_migrate_cache_size(Monitor *mon, const =
QDict *qdict)
                    qmp_query_migrate_cache_size(NULL) >> 10);
 }
=20
-static void print_block_info(Monitor *mon, BlockInfo *info,
-                             BlockDeviceInfo *inserted, bool verbose)
-{
-    ImageInfo *image_info;
-
-    assert(!info || !info->has_inserted || info->inserted =3D=3D inserted)=
;
-
-    if (info && *info->device) {
-        monitor_printf(mon, "%s", info->device);
-        if (inserted && inserted->has_node_name) {
-            monitor_printf(mon, " (%s)", inserted->node_name);
-        }
-    } else {
-        assert(info || inserted);
-        monitor_printf(mon, "%s",
-                       inserted && inserted->has_node_name ? inserted->nod=
e_name
-                       : info && info->has_qdev ? info->qdev
-                       : "<anonymous>");
-    }
-
-    if (inserted) {
-        monitor_printf(mon, ": %s (%s%s%s)\n",
-                       inserted->file,
-                       inserted->drv,
-                       inserted->ro ? ", read-only" : "",
-                       inserted->encrypted ? ", encrypted" : "");
-    } else {
-        monitor_printf(mon, ": [not inserted]\n");
-    }
-
-    if (info) {
-        if (info->has_qdev) {
-            monitor_printf(mon, "    Attached to:      %s\n", info->qdev);
-        }
-        if (info->has_io_status && info->io_status !=3D BLOCK_DEVICE_IO_ST=
ATUS_OK) {
-            monitor_printf(mon, "    I/O status:       %s\n",
-                           BlockDeviceIoStatus_str(info->io_status));
-        }
-
-        if (info->removable) {
-            monitor_printf(mon, "    Removable device: %slocked, tray %s\n=
",
-                           info->locked ? "" : "not ",
-                           info->tray_open ? "open" : "closed");
-        }
-    }
-
-
-    if (!inserted) {
-        return;
-    }
-
-    monitor_printf(mon, "    Cache mode:       %s%s%s\n",
-                   inserted->cache->writeback ? "writeback" : "writethroug=
h",
-                   inserted->cache->direct ? ", direct" : "",
-                   inserted->cache->no_flush ? ", ignore flushes" : "");
-
-    if (inserted->has_backing_file) {
-        monitor_printf(mon,
-                       "    Backing file:     %s "
-                       "(chain depth: %" PRId64 ")\n",
-                       inserted->backing_file,
-                       inserted->backing_file_depth);
-    }
-
-    if (inserted->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF) {
-        monitor_printf(mon, "    Detect zeroes:    %s\n",
-                BlockdevDetectZeroesOptions_str(inserted->detect_zeroes));
-    }
-
-    if (inserted->bps  || inserted->bps_rd  || inserted->bps_wr  ||
-        inserted->iops || inserted->iops_rd || inserted->iops_wr)
-    {
-        monitor_printf(mon, "    I/O throttling:   bps=3D%" PRId64
-                        " bps_rd=3D%" PRId64  " bps_wr=3D%" PRId64
-                        " bps_max=3D%" PRId64
-                        " bps_rd_max=3D%" PRId64
-                        " bps_wr_max=3D%" PRId64
-                        " iops=3D%" PRId64 " iops_rd=3D%" PRId64
-                        " iops_wr=3D%" PRId64
-                        " iops_max=3D%" PRId64
-                        " iops_rd_max=3D%" PRId64
-                        " iops_wr_max=3D%" PRId64
-                        " iops_size=3D%" PRId64
-                        " group=3D%s\n",
-                        inserted->bps,
-                        inserted->bps_rd,
-                        inserted->bps_wr,
-                        inserted->bps_max,
-                        inserted->bps_rd_max,
-                        inserted->bps_wr_max,
-                        inserted->iops,
-                        inserted->iops_rd,
-                        inserted->iops_wr,
-                        inserted->iops_max,
-                        inserted->iops_rd_max,
-                        inserted->iops_wr_max,
-                        inserted->iops_size,
-                        inserted->group);
-    }
-
-    if (verbose) {
-        monitor_printf(mon, "\nImages:\n");
-        image_info =3D inserted->image;
-        while (1) {
-                bdrv_image_info_dump(image_info);
-            if (image_info->has_backing_image) {
-                image_info =3D image_info->backing_image;
-            } else {
-                break;
-            }
-        }
-    }
-}
-
-void hmp_info_block(Monitor *mon, const QDict *qdict)
-{
-    BlockInfoList *block_list, *info;
-    BlockDeviceInfoList *blockdev_list, *blockdev;
-    const char *device =3D qdict_get_try_str(qdict, "device");
-    bool verbose =3D qdict_get_try_bool(qdict, "verbose", false);
-    bool nodes =3D qdict_get_try_bool(qdict, "nodes", false);
-    bool printed =3D false;
-
-    /* Print BlockBackend information */
-    if (!nodes) {
-        block_list =3D qmp_query_block(NULL);
-    } else {
-        block_list =3D NULL;
-    }
-
-    for (info =3D block_list; info; info =3D info->next) {
-        if (device && strcmp(device, info->value->device)) {
-            continue;
-        }
-
-        if (info !=3D block_list) {
-            monitor_printf(mon, "\n");
-        }
-
-        print_block_info(mon, info->value, info->value->has_inserted
-                                           ? info->value->inserted : NULL,
-                         verbose);
-        printed =3D true;
-    }
-
-    qapi_free_BlockInfoList(block_list);
-
-    if ((!device && !nodes) || printed) {
-        return;
-    }
-
-    /* Print node information */
-    blockdev_list =3D qmp_query_named_block_nodes(NULL);
-    for (blockdev =3D blockdev_list; blockdev; blockdev =3D blockdev->next=
) {
-        assert(blockdev->value->has_node_name);
-        if (device && strcmp(device, blockdev->value->node_name)) {
-            continue;
-        }
-
-        if (blockdev !=3D blockdev_list) {
-            monitor_printf(mon, "\n");
-        }
-
-        print_block_info(mon, NULL, blockdev->value, verbose);
-    }
-    qapi_free_BlockDeviceInfoList(blockdev_list);
-}
-
-void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
-{
-    BlockStatsList *stats_list, *stats;
-
-    stats_list =3D qmp_query_blockstats(false, false, NULL);
-
-    for (stats =3D stats_list; stats; stats =3D stats->next) {
-        if (!stats->value->has_device) {
-            continue;
-        }
-
-        monitor_printf(mon, "%s:", stats->value->device);
-        monitor_printf(mon, " rd_bytes=3D%" PRId64
-                       " wr_bytes=3D%" PRId64
-                       " rd_operations=3D%" PRId64
-                       " wr_operations=3D%" PRId64
-                       " flush_operations=3D%" PRId64
-                       " wr_total_time_ns=3D%" PRId64
-                       " rd_total_time_ns=3D%" PRId64
-                       " flush_total_time_ns=3D%" PRId64
-                       " rd_merged=3D%" PRId64
-                       " wr_merged=3D%" PRId64
-                       " idle_time_ns=3D%" PRId64
-                       "\n",
-                       stats->value->stats->rd_bytes,
-                       stats->value->stats->wr_bytes,
-                       stats->value->stats->rd_operations,
-                       stats->value->stats->wr_operations,
-                       stats->value->stats->flush_operations,
-                       stats->value->stats->wr_total_time_ns,
-                       stats->value->stats->rd_total_time_ns,
-                       stats->value->stats->flush_total_time_ns,
-                       stats->value->stats->rd_merged,
-                       stats->value->stats->wr_merged,
-                       stats->value->stats->idle_time_ns);
-    }
-
-    qapi_free_BlockStatsList(stats_list);
-}
=20
 #ifdef CONFIG_VNC
 /* Helper for hmp_info_vnc_clients, _servers */
@@ -1054,44 +847,6 @@ void hmp_info_pci(Monitor *mon, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
=20
-void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
-{
-    BlockJobInfoList *list;
-    Error *err =3D NULL;
-
-    list =3D qmp_query_block_jobs(&err);
-    assert(!err);
-
-    if (!list) {
-        monitor_printf(mon, "No active jobs\n");
-        return;
-    }
-
-    while (list) {
-        if (strcmp(list->value->type, "stream") =3D=3D 0) {
-            monitor_printf(mon, "Streaming device %s: Completed %" PRId64
-                           " of %" PRId64 " bytes, speed limit %" PRId64
-                           " bytes/s\n",
-                           list->value->device,
-                           list->value->offset,
-                           list->value->len,
-                           list->value->speed);
-        } else {
-            monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
-                           " of %" PRId64 " bytes, speed limit %" PRId64
-                           " bytes/s\n",
-                           list->value->type,
-                           list->value->device,
-                           list->value->offset,
-                           list->value->len,
-                           list->value->speed);
-        }
-        list =3D list->next;
-    }
-
-    qapi_free_BlockJobInfoList(list);
-}
-
 void hmp_info_tpm(Monitor *mon, const QDict *qdict)
 {
     TPMInfoList *info_list, *info;
--=20
2.17.2


