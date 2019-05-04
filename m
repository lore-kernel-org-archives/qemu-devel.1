Received: from eggs.gnu.org ([209.51.188.92]:42020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMz55-0004Xf-Vs
	for qemu-devel@nongnu.org; Sat, 04 May 2019 14:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMz54-0003pv-Bt
	for qemu-devel@nongnu.org; Sat, 04 May 2019 14:08:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hMz54-0003pU-1q
	for qemu-devel@nongnu.org; Sat, 04 May 2019 14:08:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id c12so11848822wrt.8
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 11:08:13 -0700 (PDT)
Date: Sat, 4 May 2019 19:11:19 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190504181119.GA3317@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] chardev/char-i2c: Implement Linux I2C
 character device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Ernest Esene <eroken1@gmail.com>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for Linux I2C character device for I2C device passthrough
For example:
-chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev

Signed-off-by: Ernest Esene <eroken1@gmail.com>

---
v2:
  * Fix errors
  * update "MAINTAINERS" file.
---
 MAINTAINERS                |   6 ++
 chardev/Makefile.objs      |   1 +
 chardev/char-i2c.c         | 140 +++++++++++++++++++++++++++++++++++++++++=
++++
 chardev/char.c             |   3 +
 include/chardev/char-i2c.h |  35 ++++++++++++
 include/chardev/char.h     |   1 +
 qapi/char.json             |  18 ++++++
 7 files changed, 204 insertions(+)
 create mode 100644 chardev/char-i2c.c
 create mode 100644 include/chardev/char-i2c.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7dd71e0a2d..b79d9b8edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1801,6 +1801,12 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: chardev/baum.c
=20
+Character Devices (Linux I2C)
+M: Ernest Esene <eroken1@gmail.com>
+S: Maintained
+F: chardev/char-i2c.c
+F: include/chardev/char-i2c.h
+
 Command line option argument parsing
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e1347f9..6c96b9a353 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -16,6 +16,7 @@ chardev-obj-y +=3D char-stdio.o
 chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
+chardev-obj-$(CONFIG_POSIX) +=3Dchar-i2c.o
=20
 common-obj-y +=3D msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) +=3D baum.o
diff --git a/chardev/char-i2c.c b/chardev/char-i2c.c
new file mode 100644
index 0000000000..4b068b0124
--- /dev/null
+++ b/chardev/char-i2c.c
@@ -0,0 +1,140 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu-common.h"
+#include "io/channel-file.h"
+#include "qemu/cutils.h"
+
+#include "chardev/char-fd.h"
+#include "chardev/char-i2c.h"
+#include "chardev/char.h"
+
+#include <sys/ioctl.h>
+#include <linux/i2c-dev.h>
+
+static int i2c_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    FDChardev *fd_chr =3D FD_CHARDEV(chr);
+    QIOChannelFile *floc =3D QIO_CHANNEL_FILE(fd_chr->ioc_in);
+    int fd =3D floc->fd;
+    int addr;
+
+    switch (cmd) {
+    case CHR_IOCTL_I2C_SET_ADDR:
+        addr =3D (int) (long) arg;
+
+        if (addr > CHR_I2C_ADDR_7BIT_MAX) {
+            /*
+             * TODO: check if adapter support 10-bit addr
+             * I2C_FUNC_10BIT_ADDR
+             */
+            if (ioctl(fd, I2C_TENBIT, addr) < 0) {
+                goto err;
+            }
+        } else {
+            if (ioctl(fd, I2C_SLAVE, addr) < 0) {
+                goto err;
+            }
+        }
+        break;
+
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+err:
+    return -ENOTSUP;
+}
+
+static void qmp_chardev_open_i2c(Chardev *chr, ChardevBackend *backend,
+                                 bool *be_opened, Error **errp)
+{
+    ChardevI2c *i2c =3D backend->u.i2c.data;
+    void *addr;
+    int fd;
+
+    fd =3D qmp_chardev_open_file_source(i2c->device, O_RDWR | O_NONBLOCK,
+                                      errp);
+    if (fd < 0) {
+        return;
+    }
+    qemu_set_block(fd);
+    qemu_chr_open_fd(chr, fd, fd);
+    addr =3D (void *) (long) i2c->address;
+    i2c_ioctl(chr, CHR_IOCTL_I2C_SET_ADDR, addr);
+}
+
+static void qemu_chr_parse_i2c(QemuOpts *opts, ChardevBackend *backend,
+                               Error **errp)
+{
+    const char *device =3D qemu_opt_get(opts, "path");
+    const char *addr =3D qemu_opt_get(opts, "address");
+    long address;
+    ChardevI2c *i2c;
+    if (device =3D=3D NULL) {
+        error_setg(errp, "chardev: linux-i2c: no device path given");
+        return;
+    }
+    if (addr =3D=3D NULL) {
+        error_setg(errp, "chardev: linux-i2c: no device address given");
+        return;
+    }
+    if (qemu_strtol(addr, NULL, 0, &address) !=3D 0) {
+        error_setg(errp, "chardev: linux-i2c: invalid device address given=
");
+        return;
+    }
+    if (address < 0 || address > CHR_I2C_ADDR_10BIT_MAX) {
+        error_setg(errp, "chardev: linux-i2c: device address out of range"=
);
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_I2C;
+    i2c =3D backend->u.i2c.data =3D g_new0(ChardevI2c, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevI2c_base(i2c));
+    i2c->device =3D g_strdup(device);
+    i2c->address =3D (int16_t) address;
+}
+
+static void char_i2c_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_i2c;
+    cc->open =3D  qmp_chardev_open_i2c;
+    cc->chr_ioctl =3D i2c_ioctl;
+}
+
+static const TypeInfo char_i2c_type_info =3D {
+    .name =3D TYPE_CHARDEV_I2C,
+    .parent =3D TYPE_CHARDEV_FD,
+    .class_init =3D char_i2c_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_i2c_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 54724a56b1..93732a9909 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -926,6 +926,9 @@ QemuOptsList qemu_chardev_opts =3D {
         },{
             .name =3D "logappend",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "address",
+            .type =3D QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
diff --git a/include/chardev/char-i2c.h b/include/chardev/char-i2c.h
new file mode 100644
index 0000000000..81e97b7556
--- /dev/null
+++ b/include/chardev/char-i2c.h
@@ -0,0 +1,35 @@
+
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2019 Ernest Esene <eroken1@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+#ifndef CHAR_I2C_H
+#define CHAR_I2C_H
+
+#define CHR_IOCTL_I2C_SET_ADDR 1
+
+#define CHR_I2C_ADDR_10BIT_MAX 1023
+#define CHR_I2C_ADDR_7BIT_MAX 127
+
+void qemu_set_block(int fd);
+
+#endif /* ifndef CHAR_I2C_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index c0b57f7685..880614391f 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -245,6 +245,7 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 #define TYPE_CHARDEV_SERIAL "chardev-serial"
 #define TYPE_CHARDEV_SOCKET "chardev-socket"
 #define TYPE_CHARDEV_UDP "chardev-udp"
+#define TYPE_CHARDEV_I2C "chardev-linux-i2c"
=20
 #define CHARDEV_IS_RINGBUF(chr) \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac7bc..2c05d6a93e 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -240,6 +240,23 @@
   'data': { 'device': 'str' },
   'base': 'ChardevCommon' }
=20
+##
+# @ChardevI2c:
+#
+# Configuration info for i2c chardev.
+#
+# @device: The name of the special file for the device,
+#          i.e. /dev/i2c-0 on linux
+# @address: The address of the i2c device on the host.
+#
+# Since: 4.1
+##
+{ 'struct': 'ChardevI2c',
+  'data': { 'device': 'str',
+            'address': 'int16'},
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_LINUX)'}
+
 ##
 # @ChardevSocket:
 #
@@ -398,6 +415,7 @@
   'data': { 'file': 'ChardevFile',
             'serial': 'ChardevHostdev',
             'parallel': 'ChardevHostdev',
+            'i2c': 'ChardevI2c',
             'pipe': 'ChardevHostdev',
             'socket': 'ChardevSocket',
             'udp': 'ChardevUdp',
--=20
2.14.2


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzN1cAACgkQJZ4JoaCv
xKot6xAAl09u3fwE+DYuDqMD0GSm28efhRwjflyWyAflzsUrx9RZbBTUn6bZojLZ
/2fY66R36CtFhj9oqQTQhbE2gaiO1zutMBdKHJ1OPM+6WBuuBb+9ha7m2UTE0Fd9
JZpxl0z9G72broHg/kahlYhqDKxSIdCXGFhnRzp/+9jtozzfnOTrVNdEcxxYdxy8
vp4SFSFMQGvg7UXLsGhnpZVpCV050cIrNVn45xtFDPBAiC+lJtLjB8HuH9hkh+ih
a+O+FkGf9WeR0e63xlC9OH+k95+UNyhBj96bnOXldC63gsWqWBz8eU3oqYhjmuTb
j2cZfnADg1/nm4wXsi3yhMsQFJYiqjbxpN89+aQhZkeNHgfaXf7dd1qiWSLinuNc
3qzl8eBesImbgxibbcsIgLXtEoFwa7zzxnDJ0OzROLiIutlnoG8LU5rGunXquTwu
jUvKfnR3V0JF7uNjQtkNskWhY2xLtmkLmCXbL0qZV9Lq8/DS8e89SUJiW6OXBzdw
qgwlIt2yG4wIGxVGy46rK3PfgiAOKHuhY7UiEi80aNxSHTEHYacxnpBYXZfkjNTn
8Jcu8QI2hlXjezp+Ez5sJE1Q9knCmSQ+vF1QSTC9UhlLi0yuP4zves03E2eR4z4c
vOliJV5BN27ryI6EQ3i91T+o4dnvKAMxfBheFLirSEo8O3u/A8E=
=26XW
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
