Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6F0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED18920863
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4E8q4fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED18920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGXA-0003aI-Qz
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iZGTQ-0000Ay-7D
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iZGTO-0002Mm-U6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51931
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iZGTO-0002LR-PT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsLeO+lghsEcl92KqwNTr47O3Zogpop0sIHUKDu+20o=;
 b=F4E8q4fyRz1RCyZY7tC4XmbPjDszi+1MXqOGke24owUgBnypOnklSC64ABAqgJ+qjQWOnD
 mRDAmuRAy8yiGEAGpGM3e9mRzazp01mlpzLJHkD1qJgj5Pp6Ir+hiImw9hrxpdNU5pFkFa
 u7fs2SfgHmHyYwO6w/GkWR/DEtSxqZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-plU76t1tN5q01cuewssWBA-1; Mon, 25 Nov 2019 10:40:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C8D8024CF;
 Mon, 25 Nov 2019 15:40:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-31.pek2.redhat.com
 [10.72.12.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319A45D9CA;
 Mon, 25 Nov 2019 15:40:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 3/4] net/virtio: fix re-plugging of primary device
Date: Mon, 25 Nov 2019 23:40:06 +0800
Message-Id: <1574696407-4188-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
References: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: plU76t1tN5q01cuewssWBA-1
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
Cc: Jason Wang <jasowang@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

failover_replug_primary was returning true on failure which lead to
re-plug not working when a migration failed.  Fix this by returning
success when hotplug worked.  This is a bug that was missed in last
round of testing but was tested succesfully with this version.  Also
make sure we don't pass NULL to qdev_set_parent_bus().

This fixes CID 1407224.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ac4d191..565dea0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2805,25 +2805,33 @@ static bool failover_replug_primary(VirtIONet *n, E=
rror **errp)
         n->primary_device_opts =3D qemu_opts_from_qdict(
                 qemu_find_opts("device"),
                 n->primary_device_dict, errp);
-    }
-    if (n->primary_device_opts) {
-        if (n->primary_dev) {
-            n->primary_bus =3D n->primary_dev->parent_bus;
-        }
-        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
-        n->primary_should_be_hidden =3D false;
-        qemu_opt_set_bool(n->primary_device_opts,
-                "partially_hotplugged", true, errp);
-        hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
-        if (hotplug_ctrl) {
-            hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
-            hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
+        if (!n->primary_device_opts) {
+            error_setg(errp, "virtio_net: couldn't find primary device opt=
s");
+            goto out;
         }
-        if (!n->primary_dev) {
+    }
+    if (!n->primary_dev) {
             error_setg(errp, "virtio_net: couldn't find primary device");
-        }
+            goto out;
     }
-    return *errp !=3D NULL;
+
+    n->primary_bus =3D n->primary_dev->parent_bus;
+    if (!n->primary_bus) {
+        error_setg(errp, "virtio_net: couldn't find primary bus");
+        goto out;
+    }
+    qdev_set_parent_bus(n->primary_dev, n->primary_bus);
+    n->primary_should_be_hidden =3D false;
+    qemu_opt_set_bool(n->primary_device_opts,
+                      "partially_hotplugged", true, errp);
+    hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
+    if (hotplug_ctrl) {
+        hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
+        hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
+    }
+
+out:
+    return *errp =3D=3D NULL;
 }
=20
 static void virtio_net_handle_migration_primary(VirtIONet *n,
@@ -2852,7 +2860,7 @@ static void virtio_net_handle_migration_primary(VirtI=
ONet *n,
             warn_report("couldn't unplug primary device");
         }
     } else if (migration_has_failed(s)) {
-        /* We already unplugged the device let's plugged it back */
+        /* We already unplugged the device let's plug it back */
         if (!failover_replug_primary(n, &err)) {
             if (err) {
                 error_report_err(err);
--=20
2.5.0


