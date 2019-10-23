Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95721CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586A221872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR5yCmQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586A221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNC8R-0007iA-7u
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNC0M-0003Jc-4o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNC0K-0006Ul-33
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNC0J-0006TE-Fp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsMGOxPnmVpYk8EllN+pMhqAga9WNaKjW/eMZMn6bvo=;
 b=XR5yCmQV6WEerV/ccbS79kSMlqBvJmkBEXbWpnRgsTcE9yj8xlFBo5+RQP+497xm74mq8R
 ffXH35GKCLOTmUbHx00HrUf1KnVL/Ht50MELQQMuHU9shxXUFR+m0qOUj9hPFFQMeJX84k
 kqfOo2jAKFgNLPxK6kyTg9+Nyr7l3XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-CtChwgn_MNuBjaU6_0gQ7g-1; Wed, 23 Oct 2019 04:28:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D15AA107AD31;
 Wed, 23 Oct 2019 08:28:21 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40489600CC;
 Wed, 23 Oct 2019 08:28:20 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/11] migration: allow unplug during migration for
 failover devices
Date: Wed, 23 Oct 2019 10:27:07 +0200
Message-Id: <20191023082711.16694-8-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-1-jfreimann@redhat.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CtChwgn_MNuBjaU6_0gQ7g-1
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In "b06424de62 migration: Disable hotplug/unplug during migration" we
added a check to disable unplug for all devices until we have figured
out what works. For failover primary devices qdev_unplug() is called
from the migration handler, i.e. during migration.

This patch adds a flag to DeviceState which is set to false for all
devices and makes an exception for PCI devices that are also
primary devices in a failover pair.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/core/qdev.c         | 1 +
 hw/pci/pci.c           | 1 +
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f786650446..dc1289da86 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -995,6 +995,7 @@ static void device_initfn(Object *obj)
=20
     dev->instance_id_alias =3D -1;
     dev->realized =3D false;
+    dev->allow_unplug_during_migration =3D false;
=20
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, NUL=
L);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fa9b5219f8..8fbf32d68c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2116,6 +2116,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error=
 **errp)
             error_propagate(errp, local_err);
             return;
         }
+        qdev->allow_unplug_during_migration =3D true;
     }
=20
     /* rom loading */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 710981af36..1518495b1e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -156,6 +156,7 @@ struct DeviceState {
     bool pending_deleted_event;
     QemuOpts *opts;
     int hotplugged;
+    bool allow_unplug_during_migration;
     BusState *parent_bus;
     QLIST_HEAD(, NamedGPIOList) gpios;
     QLIST_HEAD(, BusState) child_bus;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 676a759fb4..bc6a41fa37 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -851,7 +851,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
=20
-    if (!migration_is_idle()) {
+    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
     }
--=20
2.21.0


