Received: from eggs.gnu.org ([209.51.188.92]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL5-0004nX-BC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL3-0006R4-Fu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:37 +0100
Message-Id: <20190308131445.17502-5-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/12] sysbus: Fix latent bug with onboard
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
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

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
index b6368662e0..c38739e34c 100644
--- a/vl.c
+++ b/vl.c
@@ -3991,6 +3991,10 @@ int main(int argc, char **argv, char **envp)
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
