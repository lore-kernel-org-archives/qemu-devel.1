Received: from eggs.gnu.org ([2001:4830:134:3::10]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibpX-0006EV-Q9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibpU-0000Ol-N7
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:04:15 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:50 +0300
Message-Id: <4729b3a41d11f053a6d03620ff12b266dd0ab330.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] register: fix incorrect read mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The register_read() and register_write() functions expect a bitmask argum=
ent.
To avoid duplicated code, a new inlined function register_enabled_mask() =
is
introduced.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/register.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index be170dc..dc335a7 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -59,6 +59,15 @@ static inline uint64_t register_read_val(RegisterInfo =
*reg)
     return 0; /* unreachable */
 }
=20
+static inline uint64_t register_enabled_mask(int data_size, unsigned siz=
e)
+{
+    if (data_size < size) {
+        size =3D data_size;
+    }
+
+    return MAKE_64BIT_MASK(0, size * 8);
+}
+
 void register_write(RegisterInfo *reg, uint64_t val, uint64_t we,
                     const char *prefix, bool debug)
 {
@@ -192,11 +201,7 @@ void register_write_memory(void *opaque, hwaddr addr=
,
     }
=20
     /* Generate appropriate write enable mask */
-    if (reg->data_size < size) {
-        we =3D MAKE_64BIT_MASK(0, reg->data_size * 8);
-    } else {
-        we =3D MAKE_64BIT_MASK(0, size * 8);
-    }
+    we =3D register_enabled_mask(reg->data_size, size);
=20
     register_write(reg, value, we, reg_array->prefix,
                    reg_array->debug);
@@ -208,6 +213,7 @@ uint64_t register_read_memory(void *opaque, hwaddr ad=
dr,
     RegisterInfoArray *reg_array =3D opaque;
     RegisterInfo *reg =3D NULL;
     uint64_t read_val;
+    uint64_t re;
     int i;
=20
     for (i =3D 0; i < reg_array->num_elements; i++) {
@@ -223,7 +229,10 @@ uint64_t register_read_memory(void *opaque, hwaddr a=
ddr,
         return 0;
     }
=20
-    read_val =3D register_read(reg, size * 8, reg_array->prefix,
+    /* Generate appropriate read enable mask */
+    re =3D register_enabled_mask(reg->data_size, size);
+
+    read_val =3D register_read(reg, re, reg_array->prefix,
                              reg_array->debug);
=20
     return extract64(read_val, 0, size * 8);
--=20
2.1.4
