Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B64C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EF920674
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esJvMDx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EF920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYD7m-0000mY-Ra
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6p-0005xI-Qz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6n-0004EY-1r
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6m-0004Db-9K
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHPznuT0+kSysPXt4j+ceaBtcyUhBYBkdlLihcnC3hM=;
 b=esJvMDx/nPvaNBdMXyYwB+3rp0e+9bpyVKVuojLoEIV+kzcEsyNV21Ta+KqnIaE9K6S6pk
 kUVSlTg+WtwZE43Jylqu9YIp2Iiq7Mgjg+uvg7gG+3FXYhOnhnKcNqq74XCjgLon+sVg99
 fq5XmMpua7zEOQacGTKUA6BOzvp+3wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-c1p2fmpjNbKPssWkWmn8Wg-1; Fri, 22 Nov 2019 11:48:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 454338024C0;
 Fri, 22 Nov 2019 16:48:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7000277010;
 Fri, 22 Nov 2019 16:48:29 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] monitor/hmp: Prefer to use hmp_handle_error for error
 reporting in block hmp commands
Date: Fri, 22 Nov 2019 18:48:07 +0200
Message-Id: <20191122164807.27938-10-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: c1p2fmpjNbKPssWkWmn8Wg-1
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

This way they all will be prefixed with 'Error:' which some parsers
(e.g libvirt) need

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 35 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index c943dccd03..197994716f 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -59,7 +59,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
     mc =3D MACHINE_GET_CLASS(current_machine);
     dinfo =3D drive_new(opts, mc->block_default_type, &err);
     if (err) {
-        error_report_err(err);
         qemu_opts_del(opts);
         goto err;
     }
@@ -73,7 +72,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "OK\n");
         break;
     default:
-        monitor_printf(mon, "Can't hot-add drive to type %d\n", dinfo->typ=
e);
+        error_setg(&err, "Can't hot-add drive to type %d", dinfo->type);
         goto err;
     }
     return;
@@ -84,6 +83,7 @@ err:
         monitor_remove_blk(blk);
         blk_unref(blk);
     }
+    hmp_handle_error(mon, &err);
 }
=20
 void hmp_drive_del(Monitor *mon, const QDict *qdict)
@@ -105,14 +105,14 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
=20
     blk =3D blk_by_name(id);
     if (!blk) {
-        error_report("Device '%s' not found", id);
-        return;
+        error_setg(&local_err, "Device '%s' not found", id);
+        goto err;
     }
=20
     if (!blk_legacy_dinfo(blk)) {
-        error_report("Deleting device added with blockdev-add"
-                     " is not supported");
-        return;
+        error_setg(&local_err,
+                   "Deleting device added with blockdev-add is not support=
ed");
+        goto err;
     }
=20
     aio_context =3D blk_get_aio_context(blk);
@@ -121,9 +121,8 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     bs =3D blk_bs(blk);
     if (bs) {
         if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
-            error_report_err(local_err);
             aio_context_release(aio_context);
-            return;
+            goto err;
         }
=20
         blk_remove_bs(blk);
@@ -144,12 +143,15 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     }
=20
     aio_context_release(aio_context);
+err:
+    hmp_handle_error(mon, &local_err);
 }
=20
 void hmp_commit(Monitor *mon, const QDict *qdict)
 {
     const char *device =3D qdict_get_str(qdict, "device");
     BlockBackend *blk;
+    Error *local_err =3D NULL;
     int ret;
=20
     if (!strcmp(device, "all")) {
@@ -160,12 +162,12 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
=20
         blk =3D blk_by_name(device);
         if (!blk) {
-            error_report("Device '%s' not found", device);
-            return;
+            error_setg(&local_err, "Device '%s' not found", device);
+            goto err;
         }
         if (!blk_is_available(blk)) {
-            error_report("Device '%s' has no medium", device);
-            return;
+            error_setg(&local_err, "Device '%s' has no medium", device);
+            goto err;
         }
=20
         bs =3D blk_bs(blk);
@@ -177,8 +179,13 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
         aio_context_release(aio_context);
     }
     if (ret < 0) {
-        error_report("'commit' error for '%s': %s", device, strerror(-ret)=
);
+        error_setg(&local_err,
+                   "'commit' error for '%s': %s", device, strerror(-ret));
+        goto err;
     }
+    return;
+err:
+    hmp_handle_error(mon, &local_err);
 }
=20
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
--=20
2.17.2


