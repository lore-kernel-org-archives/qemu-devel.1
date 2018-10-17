Received: from eggs.gnu.org ([2001:4830:134:3::10]:53453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yP-DF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002Dr-4u
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-0001Gx-Nl
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:06 +0200
Message-Id: <1539770707-7289-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/15] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The generic-loader is currently compiled target specific due to one
single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We have already a
function called target_words_bigendian() for this instead, so we can
put the generic-loader into common-obj to save some compilation time.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/Makefile.objs    | 2 +-
 hw/core/generic-loader.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index eb88ca9..b736ce2 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -20,6 +20,6 @@ common-obj-$(CONFIG_SOFTMMU) +=3D register.o
 common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
 common-obj-$(CONFIG_SOFTMMU) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
+common-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
=20
-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
 obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index be29ae1..fbae05f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -130,11 +130,7 @@ static void generic_loader_realize(DeviceState *dev,=
 Error **errp)
         s->cpu =3D first_cpu;
     }
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    big_endian =3D 1;
-#else
-    big_endian =3D 0;
-#endif
+    big_endian =3D target_words_bigendian();
=20
     if (s->file) {
         AddressSpace *as =3D s->cpu ? s->cpu->as :  NULL;
--=20
1.8.3.1
