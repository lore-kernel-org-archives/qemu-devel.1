Received: from eggs.gnu.org ([2001:4830:134:3::10]:32903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6DA-00007j-Ch
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6D9-0008Sq-Eg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6D9-0008Rw-92
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:35 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64738C704A
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:53:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:52:05 +0400
Message-Id: <20170207135211.15870-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/28] bus: do not unref hotplug handler
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
