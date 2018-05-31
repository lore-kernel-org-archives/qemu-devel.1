Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8g-0003o0-I4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8d-0000Ia-Eb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:26 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:30 +0200
Message-Id: <20180531171253.21012-31-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/53] hw/isa/superio: Fix inconsistent use of
 Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-stable@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
use of Chardev->be. Also, this CharBackend member is private and is
not supposed to be accessible.

Fix it by removing the inconsistent check.

Cc: qemu-stable@nongnu.org
Reported-by: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>
Message-Id: <20180515152500.19460-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/isa/isa-superio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 9359be7008..8bc2f69eaa 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -42,7 +42,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
         if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
             /* FIXME use a qdev chardev prop instead of parallel_hds[] *=
/
             chr =3D parallel_hds[i];
-            if (chr =3D=3D NULL || chr->be) {
+            if (chr =3D=3D NULL) {
                 name =3D g_strdup_printf("discarding-parallel%d", i);
                 chr =3D qemu_chr_new(name, "null");
             } else {
@@ -82,7 +82,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
         if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
             /* FIXME use a qdev chardev prop instead of serial_hd() */
             chr =3D serial_hd(i);
-            if (chr =3D=3D NULL || chr->be) {
+            if (chr =3D=3D NULL) {
                 name =3D g_strdup_printf("discarding-serial%d", i);
                 chr =3D qemu_chr_new(name, "null");
             } else {
--=20
2.17.0
