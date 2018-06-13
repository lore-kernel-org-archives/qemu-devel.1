Received: from eggs.gnu.org ([2001:4830:134:3::10]:47547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fT9ZP-0003Jq-Bg
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fT9ZO-0006Y7-F4
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fT9ZO-0006WP-AP
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1D394022414
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 17:28:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Jun 2018 19:28:15 +0200
Message-Id: <20180613172815.32738-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180613172815.32738-1-marcandre.lureau@redhat.com>
References: <20180613172815.32738-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] Revert "bus: do not unref the added child
 bus on realize"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This is wrong.  object_finalize_child_property()'s unref balances the
ref in object_property_add_child().  qbus_realize's unref balances the
ref that was initially placed by object_new/object_initialize.

This reverts commit f3d58385a6d3d82f65db602c5506e2d3d8c82394.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index ad0c9df335..4651f24486 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -102,6 +102,7 @@ static void qbus_realize(BusState *bus, DeviceState *=
parent, const char *name)
         QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
         bus->parent->num_child_bus++;
         object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT=
(bus), NULL);
+        object_unref(OBJECT(bus));
     } else if (bus !=3D sysbus_get_default()) {
         /* TODO: once all bus devices are qdevified,
            only reset handler for main_system_bus should be registered h=
ere. */
--=20
2.18.0.rc1
