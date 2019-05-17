Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4F6C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AF22087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AF22087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcSy-00016U-JY
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:00:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRe-0000O1-Tr
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRd-00031N-TS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hRcRd-0002rv-NO
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A40E681E05
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 12:58:33 +0000 (UTC)
Received: from localhost (dhcp-192-241.str.redhat.com [10.33.192.241])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ED7217836F;
	Fri, 17 May 2019 12:58:28 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 14:58:17 +0200
Message-Id: <20190517125820.2885-2-jfreimann@redhat.com>
In-Reply-To: <20190517125820.2885-1-jfreimann@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 17 May 2019 12:58:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] migration: allow unplug during migration
 for failover devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	mst@redhat.com, aadam@redhat.com, laine@redhat.com, ailan@redhat.com
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
index f9b6efe509..98cdaa6bf7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -954,6 +954,7 @@ static void device_initfn(Object *obj)
=20
     dev->instance_id_alias =3D -1;
     dev->realized =3D false;
+    dev->allow_unplug_during_migration =3D false;
=20
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, N=
ULL);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33ed3b8dde..5437395779 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -146,6 +146,7 @@ struct DeviceState {
     bool pending_deleted_event;
     QemuOpts *opts;
     int hotplugged;
+    bool allow_unplug_during_migration;
     BusState *parent_bus;
     QLIST_HEAD(, NamedGPIOList) gpios;
     QLIST_HEAD(, BusState) child_bus;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 373b9ad445..9cce8b93c2 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -867,7 +867,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
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


