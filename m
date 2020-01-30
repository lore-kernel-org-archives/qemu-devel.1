Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D2BC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D0B206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W36c5Ov3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D0B206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60109 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix98C-00083y-0n
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92i-0006SC-PG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92h-0005Cb-HF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ix92h-0005Bx-C8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJUPOHmntB9ho2HtJMwQbVXRTaucc5wHz3u9jhdGrNU=;
 b=W36c5Ov3tVP1n3N9snKwx9nc/X2510XoK7Cg28gk9w4a3uLWjkPNqvqmCh9Ns0sIWTHAJW
 gJJTkc34rvjRVvR2cXYrPGXyjqyJ8kbhflAoCwdcCWJG3rcHs5WM1QlLMKvvRYh1T/5095
 WQMTqmX7aG94+wprpR8AyBQXIAnFvP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-lCUfIltONj-A3tZDaS4lwg-1; Thu, 30 Jan 2020 07:35:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA84800D53;
 Thu, 30 Jan 2020 12:35:27 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCEAD166A9;
 Thu, 30 Jan 2020 12:35:25 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/11] monitor/hmp: Move hmp_drive_add_node to
 block-hmp-cmds.c
Date: Thu, 30 Jan 2020 14:34:48 +0200
Message-Id: <20200130123448.21093-12-mlevitsk@redhat.com>
In-Reply-To: <20200130123448.21093-1-mlevitsk@redhat.com>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lCUfIltONj-A3tZDaS4lwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 30 ++++++++++++++++++++++++
 blockdev.c                     | 42 +++++++---------------------------
 include/block/block_int.h      |  5 ++--
 3 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 2ee96f3258..67098e3d51 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -54,6 +54,36 @@
 #include "block/block-hmp-cmds.h"
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
index f2c5ea8a87..d422ac4fe3 100644
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
@@ -4232,37 +4237,6 @@ out:
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
@@ -4292,7 +4266,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error=
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


