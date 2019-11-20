Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E5CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F4C206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMzMcMxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F4C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVMk-0000P8-CN
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVCG-000786-TR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVCF-0002YQ-Mo
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iXVCE-0002XP-UM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4dvGR4gZEtP4vSQnX6FbVbRkhx4Y683633Zm/XQyJI=;
 b=dMzMcMxGNYSLFxWUl18d3g2BVg21lENYfWFnaMOdgYxIinOmtCBENxKWyH9HfmEnrfmTVL
 +M0ebdV2Yp2l466dTkwICKKg0UbaekfahSrVpmdoQtXgGtbf94wxT5gGwhHnmZV5RtB7yJ
 ZCsFQPK+k9leTMP0scemTyU7KVCW2/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-V28GbecYMMCyLBpNP8agRw-1; Wed, 20 Nov 2019 13:59:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B95D8024C0;
 Wed, 20 Nov 2019 18:59:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76D5563647;
 Wed, 20 Nov 2019 18:59:14 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] monitor/hmp: Prefer to use hmp_handle_error for error
 reporting in block hmp commands
Date: Wed, 20 Nov 2019 20:58:50 +0200
Message-Id: <20191120185850.18986-10-mlevitsk@redhat.com>
In-Reply-To: <20191120185850.18986-1-mlevitsk@redhat.com>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: V28GbecYMMCyLBpNP8agRw-1
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

This way they all will be prefixed with 'Error:' which some parsers
(e.g libvirt need)


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 blockdev-hmp-cmds.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
index c943dccd03..197994716f 100644
--- a/blockdev-hmp-cmds.c
+++ b/blockdev-hmp-cmds.c
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


