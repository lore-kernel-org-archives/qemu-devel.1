Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5122146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdisyUet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5122146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEME-0007w8-Ek
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihEKM-0006L2-Ul
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihEKK-00040Q-Fc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:59:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihEKJ-0003rZ-Ui
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576594794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rz8XplpVE9Nfga1S43gkcI04Wv87Es806T4s0FizFFk=;
 b=XdisyUetB9AHCpcSIeD/aKaorsaggzVq9+m4bXa9w2aJf8XcpTBkMnoC3ovuIH5n4+VOgS
 4FyOmYkowdMxy4jGYl3DwBOJHYUDJv65AIiQZWmwX+YD4Fwh+muwGpw/kvvmO/v2lEkWwZ
 TBLJCnjLHAlYu5xRArhbYs6+w8imj0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-D_x5C5CGPSOc4BS9ENpVkg-1; Tue, 17 Dec 2019 09:59:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 587CE18AAFD4;
 Tue, 17 Dec 2019 14:59:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9482B26FA3;
 Tue, 17 Dec 2019 14:59:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] hmp: Allow using qdev ID for qemu-io command
Date: Tue, 17 Dec 2019 15:59:38 +0100
Message-Id: <20191217145939.5537-3-kwolf@redhat.com>
In-Reply-To: <20191217145939.5537-1-kwolf@redhat.com>
References: <20191217145939.5537-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: D_x5C5CGPSOc4BS9ENpVkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to issue requests on an existing BlockBackend with the
'qemu-io' HMP command, allow specifying the BlockBackend not only with a
BlockBackend name, but also with a qdev ID/QOM path for a device that
owns the (possibly anonymous) BlockBackend.

Because qdev names could be conflicting with BlockBackend and node
names, introduce a -d option to explicitly address a device. If the
option is not given, a BlockBackend or a node is addressed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/hmp-cmds.c | 28 ++++++++++++++++++----------
 hmp-commands.hx    |  8 +++++---
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..5f8941d298 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2468,23 +2468,31 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
 {
     BlockBackend *blk;
     BlockBackend *local_blk =3D NULL;
+    bool qdev =3D qdict_get_try_bool(qdict, "qdev", false);
     const char* device =3D qdict_get_str(qdict, "device");
     const char* command =3D qdict_get_str(qdict, "command");
     Error *err =3D NULL;
     int ret;
=20
-    blk =3D blk_by_name(device);
-    if (!blk) {
-        BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
-        if (bs) {
-            blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
-                                      0, BLK_PERM_ALL);
-            ret =3D blk_insert_bs(blk, bs, &err);
-            if (ret < 0) {
+    if (qdev) {
+        blk =3D blk_by_qdev_id(device, &err);
+        if (!blk) {
+            goto fail;
+        }
+    } else {
+        blk =3D blk_by_name(device);
+        if (!blk) {
+            BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
+            if (bs) {
+                blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
+                                          0, BLK_PERM_ALL);
+                ret =3D blk_insert_bs(blk, bs, &err);
+                if (ret < 0) {
+                    goto fail;
+                }
+            } else {
                 goto fail;
             }
-        } else {
-            goto fail;
         }
     }
=20
diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044ce4..dc23185de4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1875,9 +1875,11 @@ ETEXI
=20
     {
         .name       =3D "qemu-io",
-        .args_type  =3D "device:B,command:s",
-        .params     =3D "[device] \"[command]\"",
-        .help       =3D "run a qemu-io command on a block device",
+        .args_type  =3D "qdev:-d,device:B,command:s",
+        .params     =3D "[-d] [device] \"[command]\"",
+        .help       =3D "run a qemu-io command on a block device\n\t\t\t"
+                      "-d: [device] is a device ID rather than a "
+                      "drive ID or node name",
         .cmd        =3D hmp_qemu_io,
     },
=20
--=20
2.20.1


