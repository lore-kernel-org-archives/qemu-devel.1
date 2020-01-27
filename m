Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28942C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD92207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hff8K7b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD92207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1rX-0005af-51
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1ls-0003Ht-2I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lp-00032z-Qx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw1lp-00032B-Mu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580121449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tq/DcsaJDVwKavjLtW6/keUbJyhr/KZ3fMt/+V+dYiE=;
 b=hff8K7b4Cnp1Yc2jhTvPDztaK4EHbWf5Q3Tt0kA0x8XasxP/T6I0vEXYvl8MfBVWAuW4tF
 o4r7zi9U58In17I7MPhSguDHDBhZknFaf5sDl2K6MV6PGYxhCfPIUHkaT0uI1Q0YNuuJjR
 oyJwqEPF2f29NjxcrcnXANoqSFeLvI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-QeiNRj11OcGdtqezrnJvrQ-1; Mon, 27 Jan 2020 05:37:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F78B107ACC4;
 Mon, 27 Jan 2020 10:37:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EB46451F;
 Mon, 27 Jan 2020 10:37:24 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/13] monitor: Move hmp_drive_add_node to block-hmp-cmds.c
Date: Mon, 27 Jan 2020 12:36:45 +0200
Message-Id: <20200127103647.17761-12-mlevitsk@redhat.com>
In-Reply-To: <20200127103647.17761-1-mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QeiNRj11OcGdtqezrnJvrQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 30 ++++++++++++++++++++++++
 blockdev.c                     | 42 +++++++---------------------------
 include/block/block_int.h      |  5 ++--
 3 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index a4b1604aee..7bbe4e3814 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -33,6 +33,36 @@
 #include "monitor/hmp.h"
 #include "qemu-io.h"
=20
+static void hmp_drive_add_node(Monitor *mon, const char *optstr)
+{
+    QemuOpts *opts;
+    QDict *qdict;
+    Error *local_err =3D NULL;
+
+    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
+    if (!opts) {
+        return;
+    }
+
+    qdict =3D qemu_opts_to_qdict(opts, NULL);
+
+    if (!qdict_get_try_str(qdict, "node-name")) {
+        qobject_unref(qdict);
+        error_report("'node-name' needs to be specified");
+        goto out;
+    }
+
+    BlockDriverState *bs =3D bds_tree_init(qdict, &local_err);
+    if (!bs) {
+        error_report_err(local_err);
+        goto out;
+    }
+
+    bdrv_set_monitor_owned(bs);
+out:
+    qemu_opts_del(opts);
+}
+
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
diff --git a/blockdev.c b/blockdev.c
index df43e0aaef..63805f34b5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -64,7 +64,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/throttle-options.h"
=20
-static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
+QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
     QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
=20
 static int do_open_tray(const char *blk_name, const char *qdev_id,
@@ -75,6 +75,11 @@ static void blockdev_insert_medium(bool has_device, cons=
t char *device,
                                    bool has_id, const char *id,
                                    const char *node_name, Error **errp);
=20
+void bdrv_set_monitor_owned(BlockDriverState *bs)
+{
+    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
+}
+
 static const char *const if_name[IF_COUNT] =3D {
     [IF_NONE] =3D "none",
     [IF_IDE] =3D "ide",
@@ -652,7 +657,7 @@ err_no_opts:
 }
=20
 /* Takes the ownership of bs_opts */
-static BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
+BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
 {
     int bdrv_flags =3D 0;
=20
@@ -4201,37 +4206,6 @@ out:
     aio_context_release(aio_context);
 }
=20
-void hmp_drive_add_node(Monitor *mon, const char *optstr)
-{
-    QemuOpts *opts;
-    QDict *qdict;
-    Error *local_err =3D NULL;
-
-    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
-    if (!opts) {
-        return;
-    }
-
-    qdict =3D qemu_opts_to_qdict(opts, NULL);
-
-    if (!qdict_get_try_str(qdict, "node-name")) {
-        qobject_unref(qdict);
-        error_report("'node-name' needs to be specified");
-        goto out;
-    }
-
-    BlockDriverState *bs =3D bds_tree_init(qdict, &local_err);
-    if (!bs) {
-        error_report_err(local_err);
-        goto out;
-    }
-
-    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
-
-out:
-    qemu_opts_del(opts);
-}
-
 void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
 {
     BlockDriverState *bs;
@@ -4261,7 +4235,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error=
 **errp)
         goto fail;
     }
=20
-    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
+    bdrv_set_monitor_owned(bs);
=20
 fail:
     visit_free(v);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0b37..10df257a61 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1217,8 +1217,6 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
                             BlockCompletionFunc *cb, void *opaque,
                             JobTxn *txn, Error **errp);
=20
-void hmp_drive_add_node(Monitor *mon, const char *optstr);
-
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
@@ -1320,4 +1318,7 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src=
, uint64_t src_offset,
=20
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
=20
+void bdrv_set_monitor_owned(BlockDriverState *bs);
+BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp);
+
 #endif /* BLOCK_INT_H */
--=20
2.17.2


