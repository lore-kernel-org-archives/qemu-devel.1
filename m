Received: from eggs.gnu.org ([209.51.188.92]:36183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbMH-0004Vr-BM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbMA-0006Bb-Eo
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbM7-00068N-CN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:48 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:54 -0200
Message-Id: <20190110142955.23254-10-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
References: <20190110142955.23254-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/10] qdev: fix -device scsi-hd, help regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since commit ea9ce8934, device_post_init() applies globals directly
from machines and accelerator classes.

There are cases, such as -device scsi-hd,help, where the machine is
setup but there in no accelerator.

Let's skip accelerator globals in this case.

Fixes SEGV:
 #0  0x0000555558ea04ff in object_get_class (obj=3D0x0) at /home/elmarco/=
src/qemu/build/../qom/object.c:857
 #1  0x000055555854c797 in object_apply_compat_props (obj=3D0x61600007898=
0) at /home/elmarco/src/qemu/build/../hw/core/qdev.c:978
 #2  0x000055555854c797 in object_apply_compat_props (obj=3D0x61600007898=
0) at /home/elmarco/src/qemu/build/../hw/core/qdev.c:973
 #3  0x000055555854c959 in device_post_init (obj=3D0x616000078980) at /ho=
me/elmarco/src/qemu/build/../hw/core/qdev.c:989
 #4  0x0000555558e9e250 in object_post_init_with_type (ti=3D<optimized ou=
t>, obj=3D0x616000078980) at /home/elmarco/src/qemu/build/../qom/object.c=
:365
 #5  0x0000555558e9e250 in object_initialize_with_type (data=3D0x61600007=
8980, size=3D616, type=3D<optimized out>) at /home/elmarco/src/qemu/build=
/../qom/object.c:425
 #6  0x0000555558e9e571 in object_new_with_type (type=3D0x613000031900) a=
t /home/elmarco/src/qemu/build/../qom/object.c:588
 #7  0x000055555830c048 in qmp_device_list_properties (typename=3Dtypenam=
e@entry=3D0x60200000c2d0 "scsi-hd", errp=3Derrp@entry=3D0x7fffffffc540) a=
t /home/elmarco/src/qemu/qmp.c:519
 #8  0x00005555582c4027 in qdev_device_help (opts=3D<optimized out>) at /=
home/elmarco/src/qemu/qdev-monitor.c:283
 #9  0x0000555559378fa2 in qemu_opts_foreach (list=3D<optimized out>, fun=
c=3Dfunc@entry=3D0x5555582cfca0 <device_help_func>, opaque=3Dopaque@entry=
=3D0x0, errp=3Derrp@entry=3D0x0) at /home/elmarco/src/qemu/util/qemu-opti=
on.c:1171

https://bugzilla.redhat.com/show_bug.cgi?id=3D1664364

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190109102311.7635-1-marcandre.lureau@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3769a2bccb..47bddacb4f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -975,10 +975,13 @@ void object_apply_compat_props(Object *obj)
     if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
         MachineState *m =3D MACHINE(qdev_get_machine());
         MachineClass *mc =3D MACHINE_GET_CLASS(m);
-        AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
=20
-        if (ac->compat_props) {
-            object_apply_global_props(obj, ac->compat_props, &error_abor=
t);
+        if (m->accelerator) {
+            AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
+
+            if (ac->compat_props) {
+                object_apply_global_props(obj, ac->compat_props, &error_=
abort);
+            }
         }
         object_apply_global_props(obj, mc->compat_props, &error_abort);
     }
--=20
2.18.0.rc1.1.g3f1ff2140
