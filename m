Received: from eggs.gnu.org ([2001:4830:134:3::10]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX7Id-0004NQ-DD
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX7IZ-0005Az-Pj
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:19:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eX7IZ-00059l-Ff
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:19:15 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
Date: Thu, 4 Jan 2018 16:19:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04/01/2018 15:21, Samuel Thibault wrote:
> Samuel Thibault, on jeu. 04 janv. 2018 15:15:24 +0100, wrote:
>> I'm however still unable to make usb-serial and usb-braille work, as
>> mentioned in my other mail :)
>=20
> Ah, now with the documentation I understand, one has to also pass
> -chardev braille,chardev=3Dfoobar, and then
> -device usb-braille,chardev=3Dfoobar works.
>=20
> Would it be possible to make this automatic?  Before I could tell peopl=
e
> "use -usbdevice braille to test braille", and now it would be
> "use -chardev braille,chardev=3Dfoobar -device usb-braille,chardev=3Dfo=
obar"

Maybe we can add "-braille" instead.  Something like this:

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 94b5c34afe..a5239b7fe7 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -13,6 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "sysemu/sysemu.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "chardev/char-serial.h"
@@ -552,6 +553,24 @@ static USBDevice *usb_braille_init(USBBus *bus, cons=
t char *unused)
     return dev;
 }
=20
+void usb_braille_create(Error **errp)
+{
+    USBBus *bus =3D usb_bus_find(-1 /* any */);
+    USBDevice *dev =3D usb_braille_init(bus, "braille");
+    Error *local_err =3D NULL;
+
+    if (!dev) {
+        error_setg(errp, "Failed to create USB device");
+        return;
+    }
+    object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
+    if (local_err) {
+        error_prepend(&local_err, "Failed to initialize USB device: ");
+        error_propagate(errp, local_err);
+        object_unparent(OBJECT(dev));
+    }
+}
+
 static const VMStateDescription vmstate_usb_serial =3D {
     .name =3D "usb-serial",
     .unmigratable =3D 1,
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b4c10e62ba..eae3618735 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -167,6 +167,7 @@ extern Chardev *serial_hds[MAX_SERIAL_PORTS];
 extern Chardev *parallel_hds[MAX_PARALLEL_PORTS];
=20
 void hmp_info_usb(Monitor *mon, const QDict *qdict);
+void usb_braille_create(Error **errp);
=20
 void add_boot_device_path(int32_t bootindex, DeviceState *dev,
                           const char *suffix);
diff --git a/qemu-options.hx b/qemu-options.hx
index 94647e21e3..92886cb777 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1214,6 +1214,16 @@ STEXI
 Enable the USB driver (if it is not used by default yet).
 ETEXI
=20
+DEF("braille", QEMU_OPTION_braille,
+    "-braille        add a USB braille reader\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -braille
+@findex -braille
+Add a USB Braille device.  The device will use BrlAPI to display the bra=
ille
+output on a real or fake device.
+ETEXI
+
 DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
     "-usbdevice name add the host or guest USB device 'name'\n",
     QEMU_ARCH_ALL)
diff --git a/roms/seabios b/roms/seabios
index 63451fca13..cd47172a67 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 63451fca13c75870e1703eb3e20584d91179aebc
+Subproject commit cd47172a673762a05a0c7bd27df6e3cc8febe8d6
diff --git a/vl.c b/vl.c
index 5a8482a3a0..92d8775234 100644
--- a/vl.c
+++ b/vl.c
@@ -1488,6 +1488,17 @@ static int usb_parse(const char *cmdline)
     return r;
 }
=20
+static int do_braille(const char *unused)
+{
+    Error *err =3D NULL;
+    usb_braille_create(&err);
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
+    return 0;
+}
+
 /***********************************************************/
 /* machine registration */
=20
@@ -2495,6 +2506,7 @@ struct device_config {
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
         DEV_SCLP,      /* s390 sclp */
+        DEV_BRAILLE,   /* -braille */
     } type;
     const char *cmdline;
     Location loc;
@@ -3411,6 +3423,9 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_no_fd_bootchk:
                 fd_bootchk =3D 0;
                 break;
+            case QEMU_OPTION_braille:
+                add_device_config(DEV_BRAILLE, "braille");
+                break;
             case QEMU_OPTION_netdev:
                 default_net =3D 0;
                 if (net_client_parse(qemu_find_opts("netdev"), optarg) =3D=
=3D -1) {
@@ -4728,6 +4743,9 @@ int main(int argc, char **argv, char **envp)
         if (foreach_device_config(DEV_USB, usb_parse) < 0)
             exit(1);
     }
+    if (foreach_device_config(DEV_BRAILLE, do_braille) < 0) {
+        exit(1);
+    }
=20
     /* Check if IGD GFX passthrough. */
     igd_gfx_passthru();


Untested, but it compiles (and it keeps syntactic sugar out of device cod=
e).
It still would let Thomas remove over 400 lines of code, and would cater
for the specific use case. =20

Paolo
