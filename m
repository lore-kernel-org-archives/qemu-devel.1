Received: from eggs.gnu.org ([209.51.188.92]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKx-0004Ay-NN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKw-0002KT-Rn
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKw-0002KA-Mp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:30 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 18:13:05 +0200
Message-Id: <20190502161310.15624-4-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/8] qtest: Don't compile qtest accel on
 non-POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>, Eduardo Otubo <otubo@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

qtest_available() will always return 0 on non-POSIX systems.
It's simpler to just not compile the accelerator code on those
systems instead of relying on the AccelClass::available function.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190422210448.2488-3-ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> [on mingw64]
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/Makefile.objs    | 2 +-
 accel/qtest.c          | 1 -
 include/sysemu/qtest.h | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 2a5ed46940..8b498d39d8 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SOFTMMU) +=3D accel.o
-obj-$(CONFIG_SOFTMMU) +=3D qtest.o
+obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-$(CONFIG_TCG) +=3D tcg/
 obj-y +=3D stubs/
diff --git a/accel/qtest.c b/accel/qtest.c
index a02b3c26c7..5b88f55921 100644
--- a/accel/qtest.c
+++ b/accel/qtest.c
@@ -34,7 +34,6 @@ static void qtest_accel_class_init(ObjectClass *oc, voi=
d *data)
 {
     AccelClass *ac =3D ACCEL_CLASS(oc);
     ac->name =3D "QTest";
-    ac->available =3D qtest_available;
     ac->init_machine =3D qtest_init_accel;
     ac->allowed =3D &qtest_allowed;
 }
diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 70aa40aa72..096ddfc20c 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -27,13 +27,4 @@ bool qtest_driver(void);
=20
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error *=
*errp);
=20
-static inline int qtest_available(void)
-{
-#ifdef CONFIG_POSIX
-    return 1;
-#else
-    return 0;
-#endif
-}
-
 #endif
--=20
2.21.0
