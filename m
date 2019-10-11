Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83369C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FB62190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FB62190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48625 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIt1S-0001Zm-Cd
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 07:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iIsz4-00071c-87
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iIsz3-00021c-6k
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iIsz3-0001ze-18
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:21:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4919C18C8909;
 Fri, 11 Oct 2019 11:21:20 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AD165D713;
 Fri, 11 Oct 2019 11:21:13 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/10] migration: allow unplug during migration for
 failover devices
Date: Fri, 11 Oct 2019 13:20:11 +0200
Message-Id: <20191011112015.11785-7-jfreimann@redhat.com>
In-Reply-To: <20191011112015.11785-1-jfreimann@redhat.com>
References: <20191011112015.11785-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 11 Oct 2019 11:21:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: parav@mellanox.com, mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In "b06424de62 migration: Disable hotplug/unplug during migration" we
added a check to disable unplug for all devices until we have figured
out what works. For failover primary devices qdev_unplug() is called
from the migration handler, i.e. during migration.

This patch adds a flag to DeviceState which is set to false for all
devices and makes an exception for vfio-pci devices that are also
primary devices in a failover pair.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/core/qdev.c         | 1 +
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 84fac591ca..fb76c6eeaf 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -991,6 +991,7 @@ static void device_initfn(Object *obj)
=20
     dev->instance_id_alias =3D -1;
     dev->realized =3D false;
+    dev->allow_unplug_during_migration =3D false;
=20
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, N=
ULL);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b61cf82ded..f023c6e9c7 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -143,6 +143,7 @@ struct DeviceState {
     bool pending_deleted_event;
     QemuOpts *opts;
     int hotplugged;
+    bool allow_unplug_during_migration;
     BusState *parent_bus;
     QLIST_HEAD(, NamedGPIOList) gpios;
     QLIST_HEAD(, BusState) child_bus;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9fc8331157..cf9d1fa901 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -853,7 +853,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
=20
-    if (!migration_is_idle() && !migration_in_setup(migrate_get_current(=
))) {
+    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
     }
--=20
2.21.0


