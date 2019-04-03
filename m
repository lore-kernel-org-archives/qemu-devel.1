Received: from eggs.gnu.org ([209.51.188.92]:34552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBclk-0008AC-40
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcli-0002YE-1j
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:19 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  3 Apr 2019 12:05:02 +0200
Message-Id: <20190403100505.7550-2-cohuck@redhat.com>
In-Reply-To: <20190403100505.7550-1-cohuck@redhat.com>
References: <20190403100505.7550-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.0 1/4] hw/vfio/ccw: avoid taking address
 members in packed structs
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

The GCC 9 compiler complains about many places in s390 code
that take the address of members of the 'struct SCHIB' which
is marked packed:

hw/vfio/ccw.c: In function =E2=80=98vfio_ccw_io_notifier_handler=E2=80=99=
:
hw/vfio/ccw.c:133:15: warning: taking address of packed member of =E2=80=98=
struct SCHIB=E2=80=99 may result in an unaligned pointer value \
[-Waddress-of-packed-member]
  133 |     SCSW *s =3D &sch->curr_status.scsw;
      |               ^~~~~~~~~~~~~~~~~~~~~~
hw/vfio/ccw.c:134:15: warning: taking address of packed member of =E2=80=98=
struct SCHIB=E2=80=99 may result in an unaligned pointer value \
[-Waddress-of-packed-member]
  134 |     PMCW *p =3D &sch->curr_status.pmcw;
      |               ^~~~~~~~~~~~~~~~~~~~~~

...snip many more...

Almost all of these are just done for convenience to avoid
typing out long variable/field names when referencing struct
members. We can get most of this convenience by taking the
address of the 'struct SCHIB' instead, avoiding triggering
the compiler warnings.

In a couple of places we copy via a local variable which is
a technique already applied elsewhere in s390 code for this
problem.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190329111104.17223-12-berrange@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9246729a75d6..c44d13cc5081 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -130,8 +130,8 @@ static void vfio_ccw_io_notifier_handler(void *opaque=
)
     S390CCWDevice *cdev =3D S390_CCW_DEVICE(vcdev);
     CcwDevice *ccw_dev =3D CCW_DEVICE(cdev);
     SubchDev *sch =3D ccw_dev->sch;
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
+    SCSW s;
     IRB irb;
     int size;
=20
@@ -145,33 +145,33 @@ static void vfio_ccw_io_notifier_handler(void *opaq=
ue)
         switch (errno) {
         case ENODEV:
             /* Generate a deferred cc 3 condition. */
-            s->flags |=3D SCSW_FLAGS_MASK_CC;
-            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |=3D (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
+            schib->scsw.flags |=3D SCSW_FLAGS_MASK_CC;
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+            schib->scsw.ctrl |=3D (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_=
PEND);
             goto read_err;
         case EFAULT:
             /* Memory problem, generate channel data check. */
-            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-            s->cstat =3D SCSW_CSTAT_DATA_CHECK;
-            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+            schib->scsw.cstat =3D SCSW_CSTAT_DATA_CHECK;
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+            schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECOND=
ARY |
                        SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
             goto read_err;
         default:
             /* Error, generate channel program check. */
-            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-            s->cstat =3D SCSW_CSTAT_PROG_CHECK;
-            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+            schib->scsw.cstat =3D SCSW_CSTAT_PROG_CHECK;
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+            schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECOND=
ARY |
                        SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
             goto read_err;
         }
     } else if (size !=3D vcdev->io_region_size) {
         /* Information transfer error, generate channel-control check. *=
/
-        s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-        s->cstat =3D SCSW_CSTAT_CHN_CTRL_CHK;
-        s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-        s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+        schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+        schib->scsw.cstat =3D SCSW_CSTAT_CHN_CTRL_CHK;
+        schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+        schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY =
|
                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
         goto read_err;
     }
@@ -179,11 +179,13 @@ static void vfio_ccw_io_notifier_handler(void *opaq=
ue)
     memcpy(&irb, region->irb_area, sizeof(IRB));
=20
     /* Update control block via irb. */
-    copy_scsw_to_guest(s, &irb.scsw);
+    s =3D schib->scsw;
+    copy_scsw_to_guest(&s, &irb.scsw);
+    schib->scsw =3D s;
=20
     /* If a uint check is pending, copy sense data. */
-    if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
-        (p->chars & PMCW_CHARS_MASK_CSENSE)) {
+    if ((schib->scsw.dstat & SCSW_DSTAT_UNIT_CHECK) &&
+        (schib->pmcw.chars & PMCW_CHARS_MASK_CSENSE)) {
         memcpy(sch->sense_data, irb.ecw, sizeof(irb.ecw));
     }
=20
--=20
2.17.2
