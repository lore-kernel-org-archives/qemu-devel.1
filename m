Received: from eggs.gnu.org ([209.51.188.92]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcll-0008Aa-EV
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBclk-0002dk-A2
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  3 Apr 2019 12:05:05 +0200
Message-Id: <20190403100505.7550-5-cohuck@redhat.com>
In-Reply-To: <20190403100505.7550-1-cohuck@redhat.com>
References: <20190403100505.7550-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.0 4/4] hw/s390x/3270-ccw: avoid taking
 address of fields in packed struct
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

hw/s390x/3270-ccw.c: In function =E2=80=98emulated_ccw_3270_cb=E2=80=99:
hw/s390x/3270-ccw.c:81:19: error: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer value [-Werro=
r=3Daddress-of-packed-member]
   81 |         SCSW *s =3D &sch->curr_status.scsw;
      |                   ^~~~~~~~~~~~~~~~~~~~~~

This local variable is only present to save a little bit of
typing when setting the field later. Get rid of this to avoid
the warning about unaligned accesses.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190329111104.17223-15-berrange@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/3270-ccw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 2c8d16ccf7e2..14882242c3de 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -78,13 +78,13 @@ static int emulated_ccw_3270_cb(SubchDev *sch, CCW1 c=
cw)
=20
     if (rc =3D=3D -EIO) {
         /* I/O error, specific devices generate specific conditions */
-        SCSW *s =3D &sch->curr_status.scsw;
+        SCHIB *schib =3D &sch->curr_status;
=20
         sch->curr_status.scsw.dstat =3D SCSW_DSTAT_UNIT_CHECK;
         sch->sense_data[0] =3D 0x40;    /* intervention-req */
-        s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-        s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-        s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+        schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+        schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+        schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY =
|
                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
     }
=20
--=20
2.17.2
