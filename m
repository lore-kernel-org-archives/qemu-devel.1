Received: from eggs.gnu.org ([2001:4830:134:3::10]:36795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbe-0001iX-H1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbb-0006WJ-PE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOTbb-0006RD-KV
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDB9040201A5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:51:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 May 2018 21:51:16 +0200
Message-Id: <20180531195119.22021-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180531195119.22021-1-marcandre.lureau@redhat.com>
References: <20180531195119.22021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] bus: do not unref the added child bus on
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, spopovyc@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When the parent bus removes the child property, it takes care of
removing the added reference, in object_finalize_child_property().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f24486..ad0c9df335 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -102,7 +102,6 @@ static void qbus_realize(BusState *bus, DeviceState *=
parent, const char *name)
         QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
         bus->parent->num_child_bus++;
         object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT=
(bus), NULL);
-        object_unref(OBJECT(bus));
     } else if (bus !=3D sysbus_get_default()) {
         /* TODO: once all bus devices are qdevified,
            only reset handler for main_system_bus should be registered h=
ere. */
--=20
2.17.1.906.g10fd178552
