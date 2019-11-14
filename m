Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00917C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11FA206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpWnLz0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11FA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFzR-0001Xf-No
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iVFvJ-0005vO-J5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iVFvI-0005tK-5L
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:16:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iVFvI-0005rm-14
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573740995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vp19o7nPJmeYy2waXOwQ6m55HRVX0oHH0OccOrsWHXY=;
 b=TpWnLz0PPkr+h7uE+Y5A3O0fAHOHMDZaRmt7e4L46KAehmr0DE42eCeZS1s4FIF8EMjEAv
 gnf4sqcROyXDCkR1lfyz0FD1phDRW3A2FSC33x2l0qEr4frFIh66DQ54AJMPAessD+tUe8
 HmXjEgGYaG8qthFxKfRZ6WL4q4aNsgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-H87gvM6NN5C4mXNOlyGNng-1; Thu, 14 Nov 2019 09:16:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634D7107ACC5;
 Thu, 14 Nov 2019 14:16:28 +0000 (UTC)
Received: from localhost (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C2165DF3A;
 Thu, 14 Nov 2019 14:16:24 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] net/virtio: avoid passing NULL to qdev_set_parent_bus
Date: Thu, 14 Nov 2019 15:16:12 +0100
Message-Id: <20191114141613.15804-3-jfreimann@redhat.com>
In-Reply-To: <20191114141613.15804-1-jfreimann@redhat.com>
References: <20191114141613.15804-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: H87gvM6NN5C4mXNOlyGNng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure no arguments for qdev_set_parent_bus are NULL.
This fixes CID 1407224.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/net/virtio-net.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ac4d19109e..81650d4dc0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2809,8 +2809,16 @@ static bool failover_replug_primary(VirtIONet *n, Er=
ror **errp)
     if (n->primary_device_opts) {
         if (n->primary_dev) {
             n->primary_bus =3D n->primary_dev->parent_bus;
+            if (n->primary_bus) {
+                qdev_set_parent_bus(n->primary_dev, n->primary_bus);
+            } else  {
+                error_setg(errp, "virtio_net: couldn't set bus for primary=
");
+                goto out;
+            }
+        } else {
+            error_setg(errp, "virtio_net: couldn't find primary device");
+            goto out;
         }
-        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
         n->primary_should_be_hidden =3D false;
         qemu_opt_set_bool(n->primary_device_opts,
                 "partially_hotplugged", true, errp);
@@ -2819,10 +2827,8 @@ static bool failover_replug_primary(VirtIONet *n, Er=
ror **errp)
             hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
             hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
         }
-        if (!n->primary_dev) {
-            error_setg(errp, "virtio_net: couldn't find primary device");
-        }
     }
+out:
     return *errp !=3D NULL;
 }
=20
--=20
2.21.0


