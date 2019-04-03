Received: from eggs.gnu.org ([209.51.188.92]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcll-0008An-L9
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBclk-0002do-9j
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  3 Apr 2019 12:05:04 +0200
Message-Id: <20190403100505.7550-4-cohuck@redhat.com>
In-Reply-To: <20190403100505.7550-1-cohuck@redhat.com>
References: <20190403100505.7550-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.0 3/4] hw/s390x/ipl: avoid taking address
 of fields in packed struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Compiling with GCC 9 complains

hw/s390x/ipl.c: In function =E2=80=98s390_ipl_set_boot_menu=E2=80=99:
hw/s390x/ipl.c:256:25: warning: taking address of packed member of =E2=80=
=98struct QemuIplParameters=E2=80=99 may result in an unaligned pointer v=
alue [-Waddress-of-packed-member]
  256 |     uint32_t *timeout =3D &ipl->qipl.boot_menu_timeout;
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This local variable is only present to save a little bit of
typing when setting the field later. Get rid of this to avoid
the warning about unaligned accesses.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190329111104.17223-14-berrange@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 896888bf8f00..51b272e190a9 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -252,8 +252,6 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 {
     QemuOptsList *plist =3D qemu_find_opts("boot-opts");
     QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
-    uint8_t *flags =3D &ipl->qipl.qipl_flags;
-    uint32_t *timeout =3D &ipl->qipl.boot_menu_timeout;
     const char *tmp;
     unsigned long splash_time =3D 0;
=20
@@ -269,7 +267,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     case S390_IPL_TYPE_CCW:
         /* In the absence of -boot menu, use zipl parameters */
         if (!qemu_opt_get(opts, "menu")) {
-            *flags |=3D QIPL_FLAG_BM_OPTS_ZIPL;
+            ipl->qipl.qipl_flags |=3D QIPL_FLAG_BM_OPTS_ZIPL;
             return;
         }
         break;
@@ -286,23 +284,23 @@ static void s390_ipl_set_boot_menu(S390IPLState *ip=
l)
         return;
     }
=20
-    *flags |=3D QIPL_FLAG_BM_OPTS_CMD;
+    ipl->qipl.qipl_flags |=3D QIPL_FLAG_BM_OPTS_CMD;
=20
     tmp =3D qemu_opt_get(opts, "splash-time");
=20
     if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
         error_report("splash-time is invalid, forcing it to 0");
-        *timeout =3D 0;
+        ipl->qipl.boot_menu_timeout =3D 0;
         return;
     }
=20
     if (splash_time > 0xffffffff) {
         error_report("splash-time is too large, forcing it to max value"=
);
-        *timeout =3D 0xffffffff;
+        ipl->qipl.boot_menu_timeout =3D 0xffffffff;
         return;
     }
=20
-    *timeout =3D cpu_to_be32(splash_time);
+    ipl->qipl.boot_menu_timeout =3D cpu_to_be32(splash_time);
 }
=20
 static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
--=20
2.17.2
