Received: from eggs.gnu.org ([209.51.188.92]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6R-000086-LS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6P-0004dk-3M
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6O-0004d6-Of
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F32CF308FE9A
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BC7C5C23B
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:35 +0100
Message-Id: <20190311220843.4026-20-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/27] sysbus: Fix latent bug with onboard
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first call of sysbus_get_default() creates the main system bus and
stores it in QOM as "/machine/unattached/sysbus".  This must not
happen before main() creates "/machine", or else container_get() would
"helpfully" create it as "container" object, and the real creation of
"/machine" would later abort with "attempt to add duplicate property
'machine' to object (type 'container')".  Has been that way ever since
we wired up busses in QOM (commit f968fc6892d, v1.2.0).

I believe the bug is latent.  I got it to bite by trying to
qdev_create() a sysbus device from a machine's .instance_init()
method.

The fix is obvious: store the main system bus in QOM right after
creating "/machine".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190308131445.17502-5-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/sysbus.c | 3 ---
 vl.c             | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9f9edbcab9..307cf90a51 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -357,9 +357,6 @@ static void main_system_bus_create(void)
     qbus_create_inplace(main_system_bus, system_bus_info.instance_size,
                         TYPE_SYSTEM_BUS, NULL, "main-system-bus");
     OBJECT(main_system_bus)->free =3D g_free;
-    object_property_add_child(container_get(qdev_get_machine(),
-                                            "/unattached"),
-                              "sysbus", OBJECT(main_system_bus), NULL);
 }
=20
 BusState *sysbus_get_default(void)
diff --git a/vl.c b/vl.c
index 4f84d6568f..22609af3a4 100644
--- a/vl.c
+++ b/vl.c
@@ -3989,6 +3989,10 @@ int main(int argc, char **argv, char **envp)
     }
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine), &error_abort);
+    object_property_add_child(container_get(OBJECT(current_machine),
+                                            "/unattached"),
+                              "sysbus", OBJECT(sysbus_get_default()),
+                              NULL);
=20
     if (machine_class->minimum_page_bits) {
         if (!set_preferred_target_page_bits(machine_class->minimum_page_=
bits)) {
--=20
2.17.2
