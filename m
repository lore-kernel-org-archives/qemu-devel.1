Received: from eggs.gnu.org ([2001:4830:134:3::10]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFG-0001y4-UP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFB-0004Yg-Us
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBFB-0004Y8-OT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 046CF81F07
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:16:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:44 +0400
Message-Id: <20170221141451.28305-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 23/30] bus: do not unref hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Apparently, none of the bus owner give a reference to the hotplug
handler property, do not unref it on bus release.

Furthermore, a bus is allowed to be its own hotplug handler, which can
be seen in qbus_set_bus_hotplug_handler() function. However, in this
case, the reference can't be given to the property, or this will create
a cyclic dependency and the bus will never be free.

Each bus owner should manage the lifecycle of the hotplug handler.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index cf383fc1af..4651f24486 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -197,7 +197,7 @@ static void qbus_initfn(Object *obj)
                              TYPE_HOTPLUG_HANDLER,
                              (Object **)&bus->hotplug_handler,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             0,
                              NULL);
     object_property_add_bool(obj, "realized",
                              bus_get_realized, bus_set_realized, NULL);
--=20
2.11.0.295.gd7dffce1c.dirty
