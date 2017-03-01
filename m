Received: from eggs.gnu.org ([2001:4830:134:3::10]:41775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0DK-0003dt-4A
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0DG-0001j0-4T
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cj0DF-0001iv-V6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27A1A8047D
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 09:06:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Mar 2017 13:04:48 +0400
Message-Id: <20170301090453.11075-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/28] bus: do not unref hotplug handler
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/piix4.c | 2 ++
 hw/core/bus.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6d99fe407c..a553a7e110 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -440,6 +440,8 @@ static void piix4_update_bus_hotplug(PCIBus *pci_bus,=
 void *opaque)
 {
     PIIX4PMState *s =3D opaque;
=20
+    /* pci_bus cannot outlive PIIX4PMState, because /machine keeps it al=
ive
+     * and it's not hot-unpluggable */
     qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
 }
=20
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
2.12.0.rc2.3.gc93709801
