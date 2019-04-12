Received: from eggs.gnu.org ([209.51.188.92]:33956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEy5U-00044q-Ko
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEy5T-00054q-KL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hEy5T-00054J-Ca
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3FE737E85
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 15:27:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Apr 2019 17:27:13 +0200
Message-Id: <20190412152713.16018-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190412152713.16018-1-marcandre.lureau@redhat.com>
References: <20190412152713.16018-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] vl: add -vga help support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Provide help output similar to other argument help handling:

$ qemu-system-x86_64 -vga help
none
std                  standard VGA (default)
cirrus               Cirrus VGA
vmware               VMWare SVGA
xenfb
qxl                  QXL VGA
virtio               Virtio VG

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/vl.c b/vl.c
index 0a96232e95..840c45c00f 100644
--- a/vl.c
+++ b/vl.c
@@ -2080,11 +2080,39 @@ static bool vga_interface_available(VGAInterfaceT=
ype t)
            object_class_by_name(ti->class_names[1]);
 }
=20
-static void select_vgahw(const char *p)
+static const char *
+get_default_vga_model(const MachineClass *machine_class)
+{
+    if (machine_class->default_display) {
+        return machine_class->default_display;
+    } else if (vga_interface_available(VGA_CIRRUS)) {
+        return "cirrus";
+    } else if (vga_interface_available(VGA_STD)) {
+        return "std";
+    }
+
+    return NULL;
+}
+
+static void select_vgahw(const MachineClass *machine_class, const char *=
p)
 {
     const char *opts;
     int t;
=20
+    if (g_str_equal(p, "help")) {
+        const char *def =3D get_default_vga_model(machine_class);
+
+        for (t =3D 0; t < VGA_TYPE_MAX; t++) {
+            const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
+
+            if (vga_interface_available(t) && ti->opt_name) {
+                printf("%-20s %s%s\n", ti->opt_name, ti->name ?: "",
+                       g_str_equal(ti->opt_name, def) ? " (default)" : "=
");
+            }
+        }
+        exit(0);
+    }
+
     assert(vga_interface_type =3D=3D VGA_NONE);
     for (t =3D 0; t < VGA_TYPE_MAX; t++) {
         const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
@@ -4437,16 +4465,10 @@ int main(int argc, char **argv, char **envp)
=20
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
-        if (machine_class->default_display) {
-            vga_model =3D machine_class->default_display;
-        } else if (vga_interface_available(VGA_CIRRUS)) {
-            vga_model =3D "cirrus";
-        } else if (vga_interface_available(VGA_STD)) {
-            vga_model =3D "std";
-        }
+        vga_model =3D get_default_vga_model(machine_class);
     }
     if (vga_model) {
-        select_vgahw(vga_model);
+        select_vgahw(machine_class, vga_model);
     }
=20
     if (watchdog) {
--=20
2.21.0.313.ge35b8cb8e2
