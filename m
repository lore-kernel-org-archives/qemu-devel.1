Received: from eggs.gnu.org ([2001:4830:134:3::10]:46698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfH-0002Fn-3T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfG-0003yu-AY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfG-0003ye-5c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:18 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:34 +0400
Message-Id: <20181127092801.21777-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 01/28] target/xtensa: gdbstub fix
 register counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

In order to communicate correctly with gdb xtensa gdbstub must provide
expected number of registers in 'g' packet response. xtensa-elf-gdb
expects both nonprivileged and privileged registers. xtensa-linux-gdb
only expects nonprivileged registers. gdb only counts one contiguous
stretch of registers, do the same for the core registers in the
xtensa_count_regs.

With this change qemu-system-xtensa is able to communicate with all
xtensa-elf-gdb versions (versions prior to 8.2 require overlay fixup),
and qemu-xtensa is able to communicate with all xtensa-linux-gdb
versions, except 8.2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/gdbstub.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index c9450914c7..d43bb190c6 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -45,15 +45,20 @@ void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs)
 {
     unsigned i;
+    bool count_core_regs =3D true;
=20
     for (i =3D 0; config->gdb_regmap.reg[i].targno >=3D 0; ++i) {
         if (config->gdb_regmap.reg[i].type !=3D xtRegisterTypeTieState &=
&
             config->gdb_regmap.reg[i].type !=3D xtRegisterTypeMapped &&
             config->gdb_regmap.reg[i].type !=3D xtRegisterTypeUnmapped) =
{
             ++*n_regs;
-            if ((config->gdb_regmap.reg[i].flags &
-                 XTENSA_REGISTER_FLAGS_PRIVILEGED) =3D=3D 0) {
-                ++*n_core_regs;
+            if (count_core_regs) {
+                if ((config->gdb_regmap.reg[i].flags &
+                     XTENSA_REGISTER_FLAGS_PRIVILEGED) =3D=3D 0) {
+                    ++*n_core_regs;
+                } else {
+                    count_core_regs =3D false;
+                }
             }
         }
     }
--=20
2.20.0.rc1
