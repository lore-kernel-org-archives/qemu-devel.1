Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD17C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18496217D6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ5Cn4zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18496217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRHN-0006U4-2Q
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXR8Z-0006UZ-R7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXR8Y-0007Qq-NJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:39:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXR8Y-0007Qd-Jv
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574260758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMHW1WAgn70tsh97+exGzsGlsn1i7EXNYS2vp0eYyyY=;
 b=OZ5Cn4zvyjhdKltB0iPjKuXLN78z6EjUyCUrko5pMz8lmYkBk/Cqj7SDxmM/LyQyudDOdA
 FwUDWzGvw2Pw4r73R2J0wapsYcGHryfEJX9Jz7326kg8Y4aXgxoUTXS9SBug8Wtepe4geF
 +x7/NmwDbpr+Fbpw3gS9bi1maSjzZz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-VKCzY_DzNRyN6phr8gvUtg-1; Wed, 20 Nov 2019 09:39:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB95107ACC4;
 Wed, 20 Nov 2019 14:39:15 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE4DE2A81F;
 Wed, 20 Nov 2019 14:39:14 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] net/virtio: avoid passing NULL to qdev_set_parent_bus
Date: Wed, 20 Nov 2019 15:38:58 +0100
Message-Id: <20191120143859.24584-4-jfreimann@redhat.com>
In-Reply-To: <20191120143859.24584-1-jfreimann@redhat.com>
References: <20191120143859.24584-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VKCzY_DzNRyN6phr8gvUtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure we don't pass NULL to qdev_set_parent_bus(). Also simplify
code a bit and fix a typo.
This fixes CID 1407224.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/net/virtio-net.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ac4d19109e..78f1e4e87c 100644
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
2.21.0


