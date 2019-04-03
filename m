Received: from eggs.gnu.org ([209.51.188.92]:34599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcll-0008AW-BW
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBcli-0002Yg-3f
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:05:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  3 Apr 2019 12:05:03 +0200
Message-Id: <20190403100505.7550-3-cohuck@redhat.com>
In-Reply-To: <20190403100505.7550-1-cohuck@redhat.com>
References: <20190403100505.7550-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.0 2/4] hw/s390/css: avoid taking address
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

hw/s390x/css.c: In function =E2=80=98sch_handle_clear_func=E2=80=99:
hw/s390x/css.c:698:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer val\
ue [-Waddress-of-packed-member]
  698 |     PMCW *p =3D &sch->curr_status.pmcw;
      |               ^~~~~~~~~~~~~~~~~~~~~~
hw/s390x/css.c:699:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer val\
ue [-Waddress-of-packed-member]
  699 |     SCSW *s =3D &sch->curr_status.scsw;
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
Message-Id: <20190329111104.17223-13-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 388 ++++++++++++++++++++++++-------------------------
 1 file changed, 187 insertions(+), 201 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f92b046cd33e..8fc9e35ba5d3 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -695,35 +695,32 @@ void css_adapter_interrupt(CssIoAdapterType type, u=
int8_t isc)
=20
 static void sch_handle_clear_func(SubchDev *sch)
 {
-    PMCW *p =3D &sch->curr_status.pmcw;
-    SCSW *s =3D &sch->curr_status.scsw;
+    SCHIB *schib =3D &sch->curr_status;
     int path;
=20
     /* Path management: In our simple css, we always choose the only pat=
h. */
     path =3D 0x80;
=20
     /* Reset values prior to 'issuing the clear signal'. */
-    p->lpum =3D 0;
-    p->pom =3D 0xff;
-    s->flags &=3D ~SCSW_FLAGS_MASK_PNO;
+    schib->pmcw.lpum =3D 0;
+    schib->pmcw.pom =3D 0xff;
+    schib->scsw.flags &=3D ~SCSW_FLAGS_MASK_PNO;
=20
     /* We always 'attempt to issue the clear signal', and we always succ=
eed. */
     sch->channel_prog =3D 0x0;
     sch->last_cmd_valid =3D false;
-    s->ctrl &=3D ~SCSW_ACTL_CLEAR_PEND;
-    s->ctrl |=3D SCSW_STCTL_STATUS_PEND;
+    schib->scsw.ctrl &=3D ~SCSW_ACTL_CLEAR_PEND;
+    schib->scsw.ctrl |=3D SCSW_STCTL_STATUS_PEND;
=20
-    s->dstat =3D 0;
-    s->cstat =3D 0;
-    p->lpum =3D path;
+    schib->scsw.dstat =3D 0;
+    schib->scsw.cstat =3D 0;
+    schib->pmcw.lpum =3D path;
=20
 }
=20
 static void sch_handle_halt_func(SubchDev *sch)
 {
-
-    PMCW *p =3D &sch->curr_status.pmcw;
-    SCSW *s =3D &sch->curr_status.scsw;
+    SCHIB *schib =3D &sch->curr_status;
     hwaddr curr_ccw =3D sch->channel_prog;
     int path;
=20
@@ -733,20 +730,22 @@ static void sch_handle_halt_func(SubchDev *sch)
     /* We always 'attempt to issue the halt signal', and we always succe=
ed. */
     sch->channel_prog =3D 0x0;
     sch->last_cmd_valid =3D false;
-    s->ctrl &=3D ~SCSW_ACTL_HALT_PEND;
-    s->ctrl |=3D SCSW_STCTL_STATUS_PEND;
+    schib->scsw.ctrl &=3D ~SCSW_ACTL_HALT_PEND;
+    schib->scsw.ctrl |=3D SCSW_STCTL_STATUS_PEND;
=20
-    if ((s->ctrl & (SCSW_ACTL_SUBCH_ACTIVE | SCSW_ACTL_DEVICE_ACTIVE)) |=
|
-        !((s->ctrl & SCSW_ACTL_START_PEND) ||
-          (s->ctrl & SCSW_ACTL_SUSP))) {
-        s->dstat =3D SCSW_DSTAT_DEVICE_END;
+    if ((schib->scsw.ctrl & (SCSW_ACTL_SUBCH_ACTIVE |
+                             SCSW_ACTL_DEVICE_ACTIVE)) ||
+        !((schib->scsw.ctrl & SCSW_ACTL_START_PEND) ||
+          (schib->scsw.ctrl & SCSW_ACTL_SUSP))) {
+        schib->scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
     }
-    if ((s->ctrl & (SCSW_ACTL_SUBCH_ACTIVE | SCSW_ACTL_DEVICE_ACTIVE)) |=
|
-        (s->ctrl & SCSW_ACTL_SUSP)) {
-        s->cpa =3D curr_ccw + 8;
+    if ((schib->scsw.ctrl & (SCSW_ACTL_SUBCH_ACTIVE |
+                             SCSW_ACTL_DEVICE_ACTIVE)) ||
+        (schib->scsw.ctrl & SCSW_ACTL_SUSP)) {
+        schib->scsw.cpa =3D curr_ccw + 8;
     }
-    s->cstat =3D 0;
-    p->lpum =3D path;
+    schib->scsw.cstat =3D 0;
+    schib->pmcw.lpum =3D path;
=20
 }
=20
@@ -1111,9 +1110,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
=20
 static void sch_handle_start_func_virtual(SubchDev *sch)
 {
-
-    PMCW *p =3D &sch->curr_status.pmcw;
-    SCSW *s =3D &sch->curr_status.scsw;
+    SCHIB *schib =3D &sch->curr_status;
     int path;
     int ret;
     bool suspend_allowed;
@@ -1121,27 +1118,27 @@ static void sch_handle_start_func_virtual(SubchDe=
v *sch)
     /* Path management: In our simple css, we always choose the only pat=
h. */
     path =3D 0x80;
=20
-    if (!(s->ctrl & SCSW_ACTL_SUSP)) {
+    if (!(schib->scsw.ctrl & SCSW_ACTL_SUSP)) {
         /* Start Function triggered via ssch, i.e. we have an ORB */
         ORB *orb =3D &sch->orb;
-        s->cstat =3D 0;
-        s->dstat =3D 0;
+        schib->scsw.cstat =3D 0;
+        schib->scsw.dstat =3D 0;
         /* Look at the orb and try to execute the channel program. */
-        p->intparm =3D orb->intparm;
+        schib->pmcw.intparm =3D orb->intparm;
         if (!(orb->lpm & path)) {
             /* Generate a deferred cc 3 condition. */
-            s->flags |=3D SCSW_FLAGS_MASK_CC;
-            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |=3D (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
+            schib->scsw.flags |=3D SCSW_FLAGS_MASK_CC;
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+            schib->scsw.ctrl |=3D (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_=
PEND);
             return;
         }
         sch->ccw_fmt_1 =3D !!(orb->ctrl0 & ORB_CTRL0_MASK_FMT);
-        s->flags |=3D (sch->ccw_fmt_1) ? SCSW_FLAGS_MASK_FMT : 0;
+        schib->scsw.flags |=3D (sch->ccw_fmt_1) ? SCSW_FLAGS_MASK_FMT : =
0;
         sch->ccw_no_data_cnt =3D 0;
         suspend_allowed =3D !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
         /* Start Function resumed via rsch */
-        s->ctrl &=3D ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
+        schib->scsw.ctrl &=3D ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
         /* The channel program had been suspended before. */
         suspend_allowed =3D true;
     }
@@ -1154,40 +1151,40 @@ static void sch_handle_start_func_virtual(SubchDe=
v *sch)
             break;
         case 0:
             /* success */
-            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+            schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECOND=
ARY |
                     SCSW_STCTL_STATUS_PEND;
-            s->dstat =3D SCSW_DSTAT_CHANNEL_END | SCSW_DSTAT_DEVICE_END;
-            s->cpa =3D sch->channel_prog + 8;
+            schib->scsw.dstat =3D SCSW_DSTAT_CHANNEL_END | SCSW_DSTAT_DE=
VICE_END;
+            schib->scsw.cpa =3D sch->channel_prog + 8;
             break;
         case -EIO:
             /* I/O errors, status depends on specific devices */
             break;
         case -ENOSYS:
             /* unsupported command, generate unit check (command reject)=
 */
-            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-            s->dstat =3D SCSW_DSTAT_UNIT_CHECK;
+            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+            schib->scsw.dstat =3D SCSW_DSTAT_UNIT_CHECK;
             /* Set sense bit 0 in ecw0. */
             sch->sense_data[0] =3D 0x80;
-            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+            schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECOND=
ARY |
                     SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
-            s->cpa =3D sch->channel_prog + 8;
+            schib->scsw.cpa =3D sch->channel_prog + 8;
             break;
         case -EINPROGRESS:
             /* channel program has been suspended */
-            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
-            s->ctrl |=3D SCSW_ACTL_SUSP;
+            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
+            schib->scsw.ctrl |=3D SCSW_ACTL_SUSP;
             break;
         default:
             /* error, generate channel program check */
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
-            s->cpa =3D sch->channel_prog + 8;
+            schib->scsw.cpa =3D sch->channel_prog + 8;
             break;
         }
     } while (ret =3D=3D -EAGAIN);
@@ -1196,14 +1193,11 @@ static void sch_handle_start_func_virtual(SubchDe=
v *sch)
=20
 static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
 {
-
-    PMCW *p =3D &sch->curr_status.pmcw;
-    SCSW *s =3D &sch->curr_status.scsw;
-
+    SCHIB *schib =3D &sch->curr_status;
     ORB *orb =3D &sch->orb;
-    if (!(s->ctrl & SCSW_ACTL_SUSP)) {
+    if (!(schib->scsw.ctrl & SCSW_ACTL_SUSP)) {
         assert(orb !=3D NULL);
-        p->intparm =3D orb->intparm;
+        schib->pmcw.intparm =3D orb->intparm;
     }
     return s390_ccw_cmd_request(sch);
 }
@@ -1216,14 +1210,13 @@ static IOInstEnding sch_handle_start_func_passthr=
ough(SubchDev *sch)
  */
 IOInstEnding do_subchannel_work_virtual(SubchDev *sch)
 {
+    SCHIB *schib =3D &sch->curr_status;
=20
-    SCSW *s =3D &sch->curr_status.scsw;
-
-    if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
+    if (schib->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
         sch_handle_clear_func(sch);
-    } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
+    } else if (schib->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
         sch_handle_halt_func(sch);
-    } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
+    } else if (schib->scsw.ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
         sch_handle_start_func_virtual(sch);
     }
@@ -1234,15 +1227,15 @@ IOInstEnding do_subchannel_work_virtual(SubchDev =
*sch)
=20
 IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
+    if (schib->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
         /* TODO: Clear handling */
         sch_handle_clear_func(sch);
-    } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
+    } else if (schib->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
         /* TODO: Halt handling */
         sch_handle_halt_func(sch);
-    } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
+    } else if (schib->scsw.ctrl & SCSW_FCTL_START_FUNC) {
         return sch_handle_start_func_passthrough(sch);
     }
     return IOINST_CC_EXPECTED;
@@ -1370,46 +1363,45 @@ static void copy_schib_from_guest(SCHIB *dest, co=
nst SCHIB *src)
=20
 IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
     uint16_t oldflags;
-    SCHIB schib;
+    SCHIB schib_copy;
=20
-    if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
+    if (!(schib->pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
         return IOINST_CC_EXPECTED;
     }
=20
-    if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
+    if (schib->scsw.ctrl & SCSW_STCTL_STATUS_PEND) {
         return IOINST_CC_STATUS_PRESENT;
     }
=20
-    if (s->ctrl &
+    if (schib->scsw.ctrl &
         (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC))=
 {
         return IOINST_CC_BUSY;
     }
=20
-    copy_schib_from_guest(&schib, orig_schib);
+    copy_schib_from_guest(&schib_copy, orig_schib);
     /* Only update the program-modifiable fields. */
-    p->intparm =3D schib.pmcw.intparm;
-    oldflags =3D p->flags;
-    p->flags &=3D ~(PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
+    schib->pmcw.intparm =3D schib_copy.pmcw.intparm;
+    oldflags =3D schib->pmcw.flags;
+    schib->pmcw.flags &=3D ~(PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
                   PMCW_FLAGS_MASK_LM | PMCW_FLAGS_MASK_MME |
                   PMCW_FLAGS_MASK_MP);
-    p->flags |=3D schib.pmcw.flags &
+    schib->pmcw.flags |=3D schib_copy.pmcw.flags &
             (PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
              PMCW_FLAGS_MASK_LM | PMCW_FLAGS_MASK_MME |
              PMCW_FLAGS_MASK_MP);
-    p->lpm =3D schib.pmcw.lpm;
-    p->mbi =3D schib.pmcw.mbi;
-    p->pom =3D schib.pmcw.pom;
-    p->chars &=3D ~(PMCW_CHARS_MASK_MBFC | PMCW_CHARS_MASK_CSENSE);
-    p->chars |=3D schib.pmcw.chars &
+    schib->pmcw.lpm =3D schib_copy.pmcw.lpm;
+    schib->pmcw.mbi =3D schib_copy.pmcw.mbi;
+    schib->pmcw.pom =3D schib_copy.pmcw.pom;
+    schib->pmcw.chars &=3D ~(PMCW_CHARS_MASK_MBFC | PMCW_CHARS_MASK_CSEN=
SE);
+    schib->pmcw.chars |=3D schib_copy.pmcw.chars &
             (PMCW_CHARS_MASK_MBFC | PMCW_CHARS_MASK_CSENSE);
-    sch->curr_status.mba =3D schib.mba;
+    schib->mba =3D schib_copy.mba;
=20
     /* Has the channel been disabled? */
     if (sch->disable_cb && (oldflags & PMCW_FLAGS_MASK_ENA) !=3D 0
-        && (p->flags & PMCW_FLAGS_MASK_ENA) =3D=3D 0) {
+        && (schib->pmcw.flags & PMCW_FLAGS_MASK_ENA) =3D=3D 0) {
         sch->disable_cb(sch);
     }
     return IOINST_CC_EXPECTED;
@@ -1417,82 +1409,80 @@ IOInstEnding css_do_msch(SubchDev *sch, const SCH=
IB *orig_schib)
=20
 IOInstEnding css_do_xsch(SubchDev *sch)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
+    if (~(schib->pmcw.flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_EN=
A)) {
         return IOINST_CC_NOT_OPERATIONAL;
     }
=20
-    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
+    if (schib->scsw.ctrl & SCSW_CTRL_MASK_STCTL) {
         return IOINST_CC_STATUS_PRESENT;
     }
=20
-    if (!(s->ctrl & SCSW_CTRL_MASK_FCTL) ||
-        ((s->ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_FUNC) ||
-        (!(s->ctrl &
+    if (!(schib->scsw.ctrl & SCSW_CTRL_MASK_FCTL) ||
+        ((schib->scsw.ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_F=
UNC) ||
+        (!(schib->scsw.ctrl &
            (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUS=
P))) ||
-        (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
+        (schib->scsw.ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
         return IOINST_CC_BUSY;
     }
=20
     /* Cancel the current operation. */
-    s->ctrl &=3D ~(SCSW_FCTL_START_FUNC |
+    schib->scsw.ctrl &=3D ~(SCSW_FCTL_START_FUNC |
                  SCSW_ACTL_RESUME_PEND |
                  SCSW_ACTL_START_PEND |
                  SCSW_ACTL_SUSP);
     sch->channel_prog =3D 0x0;
     sch->last_cmd_valid =3D false;
-    s->dstat =3D 0;
-    s->cstat =3D 0;
+    schib->scsw.dstat =3D 0;
+    schib->scsw.cstat =3D 0;
     return IOINST_CC_EXPECTED;
 }
=20
 IOInstEnding css_do_csch(SubchDev *sch)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
+    if (~(schib->pmcw.flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_EN=
A)) {
         return IOINST_CC_NOT_OPERATIONAL;
     }
=20
     /* Trigger the clear function. */
-    s->ctrl &=3D ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
-    s->ctrl |=3D SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
+    schib->scsw.ctrl &=3D ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
+    schib->scsw.ctrl |=3D SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
=20
     return do_subchannel_work(sch);
 }
=20
 IOInstEnding css_do_hsch(SubchDev *sch)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
+    if (~(schib->pmcw.flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_EN=
A)) {
         return IOINST_CC_NOT_OPERATIONAL;
     }
=20
-    if (((s->ctrl & SCSW_CTRL_MASK_STCTL) =3D=3D SCSW_STCTL_STATUS_PEND)=
 ||
-        (s->ctrl & (SCSW_STCTL_PRIMARY |
+    if (((schib->scsw.ctrl & SCSW_CTRL_MASK_STCTL) =3D=3D SCSW_STCTL_STA=
TUS_PEND) ||
+        (schib->scsw.ctrl & (SCSW_STCTL_PRIMARY |
                     SCSW_STCTL_SECONDARY |
                     SCSW_STCTL_ALERT))) {
         return IOINST_CC_STATUS_PRESENT;
     }
=20
-    if (s->ctrl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+    if (schib->scsw.ctrl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))=
 {
         return IOINST_CC_BUSY;
     }
=20
     /* Trigger the halt function. */
-    s->ctrl |=3D SCSW_FCTL_HALT_FUNC;
-    s->ctrl &=3D ~SCSW_FCTL_START_FUNC;
-    if (((s->ctrl & SCSW_CTRL_MASK_ACTL) =3D=3D
+    schib->scsw.ctrl |=3D SCSW_FCTL_HALT_FUNC;
+    schib->scsw.ctrl &=3D ~SCSW_FCTL_START_FUNC;
+    if (((schib->scsw.ctrl & SCSW_CTRL_MASK_ACTL) =3D=3D
          (SCSW_ACTL_SUBCH_ACTIVE | SCSW_ACTL_DEVICE_ACTIVE)) &&
-        ((s->ctrl & SCSW_CTRL_MASK_STCTL) =3D=3D SCSW_STCTL_INTERMEDIATE=
)) {
-        s->ctrl &=3D ~SCSW_STCTL_STATUS_PEND;
+        ((schib->scsw.ctrl & SCSW_CTRL_MASK_STCTL) =3D=3D
+         SCSW_STCTL_INTERMEDIATE)) {
+        schib->scsw.ctrl &=3D ~SCSW_STCTL_STATUS_PEND;
     }
-    s->ctrl |=3D SCSW_ACTL_HALT_PEND;
+    schib->scsw.ctrl |=3D SCSW_ACTL_HALT_PEND;
=20
     return do_subchannel_work(sch);
 }
@@ -1534,18 +1524,17 @@ static void css_update_chnmon(SubchDev *sch)
=20
 IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
+    if (~(schib->pmcw.flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_EN=
A)) {
         return IOINST_CC_NOT_OPERATIONAL;
     }
=20
-    if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
+    if (schib->scsw.ctrl & SCSW_STCTL_STATUS_PEND) {
         return IOINST_CC_STATUS_PRESENT;
     }
=20
-    if (s->ctrl & (SCSW_FCTL_START_FUNC |
+    if (schib->scsw.ctrl & (SCSW_FCTL_START_FUNC |
                    SCSW_FCTL_HALT_FUNC |
                    SCSW_FCTL_CLEAR_FUNC)) {
         return IOINST_CC_BUSY;
@@ -1558,13 +1547,13 @@ IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb)
     sch->orb =3D *orb;
     sch->channel_prog =3D orb->cpa;
     /* Trigger the start function. */
-    s->ctrl |=3D (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
-    s->flags &=3D ~SCSW_FLAGS_MASK_PNO;
+    schib->scsw.ctrl |=3D (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
+    schib->scsw.flags &=3D ~SCSW_FLAGS_MASK_PNO;
=20
     return do_subchannel_work(sch);
 }
=20
-static void copy_irb_to_guest(IRB *dest, const IRB *src, PMCW *pmcw,
+static void copy_irb_to_guest(IRB *dest, const IRB *src, const PMCW *pmc=
w,
                               int *irb_len)
 {
     int i;
@@ -1603,24 +1592,24 @@ static void copy_irb_to_guest(IRB *dest, const IR=
B *src, PMCW *pmcw,
=20
 int css_do_tsch_get_irb(SubchDev *sch, IRB *target_irb, int *irb_len)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
+    PMCW p;
     uint16_t stctl;
     IRB irb;
=20
-    if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
+    if (~(schib->pmcw.flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_EN=
A)) {
         return 3;
     }
=20
-    stctl =3D s->ctrl & SCSW_CTRL_MASK_STCTL;
+    stctl =3D schib->scsw.ctrl & SCSW_CTRL_MASK_STCTL;
=20
     /* Prepare the irb for the guest. */
     memset(&irb, 0, sizeof(IRB));
=20
     /* Copy scsw from current status. */
-    memcpy(&irb.scsw, s, sizeof(SCSW));
+    irb.scsw =3D schib->scsw;
     if (stctl & SCSW_STCTL_STATUS_PEND) {
-        if (s->cstat & (SCSW_CSTAT_DATA_CHECK |
+        if (schib->scsw.cstat & (SCSW_CSTAT_DATA_CHECK |
                         SCSW_CSTAT_CHN_CTRL_CHK |
                         SCSW_CSTAT_INTF_CTRL_CHK)) {
             irb.scsw.flags |=3D SCSW_FLAGS_MASK_ESWF;
@@ -1629,8 +1618,8 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *target_=
irb, int *irb_len)
             irb.esw[0] =3D 0x00800000;
         }
         /* If a unit check is pending, copy sense data. */
-        if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
-            (p->chars & PMCW_CHARS_MASK_CSENSE)) {
+        if ((schib->scsw.dstat & SCSW_DSTAT_UNIT_CHECK) &&
+            (schib->pmcw.chars & PMCW_CHARS_MASK_CSENSE)) {
             int i;
=20
             irb.scsw.flags |=3D SCSW_FLAGS_MASK_ESWF | SCSW_FLAGS_MASK_E=
CTL;
@@ -1643,34 +1632,34 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *targe=
t_irb, int *irb_len)
         }
     }
     /* Store the irb to the guest. */
-    copy_irb_to_guest(target_irb, &irb, p, irb_len);
+    p =3D schib->pmcw;
+    copy_irb_to_guest(target_irb, &irb, &p, irb_len);
=20
     return ((stctl & SCSW_STCTL_STATUS_PEND) =3D=3D 0);
 }
=20
 void css_do_tsch_update_subch(SubchDev *sch)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
     uint16_t stctl;
     uint16_t fctl;
     uint16_t actl;
=20
-    stctl =3D s->ctrl & SCSW_CTRL_MASK_STCTL;
-    fctl =3D s->ctrl & SCSW_CTRL_MASK_FCTL;
-    actl =3D s->ctrl & SCSW_CTRL_MASK_ACTL;
+    stctl =3D schib->scsw.ctrl & SCSW_CTRL_MASK_STCTL;
+    fctl =3D schib->scsw.ctrl & SCSW_CTRL_MASK_FCTL;
+    actl =3D schib->scsw.ctrl & SCSW_CTRL_MASK_ACTL;
=20
     /* Clear conditions on subchannel, if applicable. */
     if (stctl & SCSW_STCTL_STATUS_PEND) {
-        s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
+        schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
         if ((stctl !=3D (SCSW_STCTL_INTERMEDIATE | SCSW_STCTL_STATUS_PEN=
D)) ||
             ((fctl & SCSW_FCTL_HALT_FUNC) &&
              (actl & SCSW_ACTL_SUSP))) {
-            s->ctrl &=3D ~SCSW_CTRL_MASK_FCTL;
+            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_FCTL;
         }
         if (stctl !=3D (SCSW_STCTL_INTERMEDIATE | SCSW_STCTL_STATUS_PEND=
)) {
-            s->flags &=3D ~SCSW_FLAGS_MASK_PNO;
-            s->ctrl &=3D ~(SCSW_ACTL_RESUME_PEND |
+            schib->scsw.flags &=3D ~SCSW_FLAGS_MASK_PNO;
+            schib->scsw.ctrl &=3D ~(SCSW_ACTL_RESUME_PEND |
                          SCSW_ACTL_START_PEND |
                          SCSW_ACTL_HALT_PEND |
                          SCSW_ACTL_CLEAR_PEND |
@@ -1678,20 +1667,20 @@ void css_do_tsch_update_subch(SubchDev *sch)
         } else {
             if ((actl & SCSW_ACTL_SUSP) &&
                 (fctl & SCSW_FCTL_START_FUNC)) {
-                s->flags &=3D ~SCSW_FLAGS_MASK_PNO;
+                schib->scsw.flags &=3D ~SCSW_FLAGS_MASK_PNO;
                 if (fctl & SCSW_FCTL_HALT_FUNC) {
-                    s->ctrl &=3D ~(SCSW_ACTL_RESUME_PEND |
+                    schib->scsw.ctrl &=3D ~(SCSW_ACTL_RESUME_PEND |
                                  SCSW_ACTL_START_PEND |
                                  SCSW_ACTL_HALT_PEND |
                                  SCSW_ACTL_CLEAR_PEND |
                                  SCSW_ACTL_SUSP);
                 } else {
-                    s->ctrl &=3D ~SCSW_ACTL_RESUME_PEND;
+                    schib->scsw.ctrl &=3D ~SCSW_ACTL_RESUME_PEND;
                 }
             }
         }
         /* Clear pending sense data. */
-        if (p->chars & PMCW_CHARS_MASK_CSENSE) {
+        if (schib->pmcw.chars & PMCW_CHARS_MASK_CSENSE) {
             memset(sch->sense_data, 0 , sizeof(sch->sense_data));
         }
     }
@@ -1804,20 +1793,19 @@ void css_do_schm(uint8_t mbk, int update, int dct=
, uint64_t mbo)
=20
 IOInstEnding css_do_rsch(SubchDev *sch)
 {
-    SCSW *s =3D &sch->curr_status.scsw;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
+    if (~(schib->pmcw.flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_EN=
A)) {
         return IOINST_CC_NOT_OPERATIONAL;
     }
=20
-    if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
+    if (schib->scsw.ctrl & SCSW_STCTL_STATUS_PEND) {
         return IOINST_CC_STATUS_PRESENT;
     }
=20
-    if (((s->ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_FUNC) ||
-        (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
-        (!(s->ctrl & SCSW_ACTL_SUSP))) {
+    if (((schib->scsw.ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_F=
UNC) ||
+        (schib->scsw.ctrl & SCSW_ACTL_RESUME_PEND) ||
+        (!(schib->scsw.ctrl & SCSW_ACTL_SUSP))) {
         return IOINST_CC_BUSY;
     }
=20
@@ -1826,7 +1814,7 @@ IOInstEnding css_do_rsch(SubchDev *sch)
         css_update_chnmon(sch);
     }
=20
-    s->ctrl |=3D SCSW_ACTL_RESUME_PEND;
+    schib->scsw.ctrl |=3D SCSW_ACTL_RESUME_PEND;
     return do_subchannel_work(sch);
 }
=20
@@ -1927,28 +1915,27 @@ static int css_add_chpid(uint8_t cssid, uint8_t c=
hpid, uint8_t type,
=20
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t t=
ype)
 {
-    PMCW *p =3D &sch->curr_status.pmcw;
-    SCSW *s =3D &sch->curr_status.scsw;
+    SCHIB *schib =3D &sch->curr_status;
     int i;
     CssImage *css =3D channel_subsys.css[sch->cssid];
=20
     assert(css !=3D NULL);
-    memset(p, 0, sizeof(PMCW));
-    p->flags |=3D PMCW_FLAGS_MASK_DNV;
-    p->devno =3D sch->devno;
+    memset(&schib->pmcw, 0, sizeof(PMCW));
+    schib->pmcw.flags |=3D PMCW_FLAGS_MASK_DNV;
+    schib->pmcw.devno =3D sch->devno;
     /* single path */
-    p->pim =3D 0x80;
-    p->pom =3D 0xff;
-    p->pam =3D 0x80;
-    p->chpid[0] =3D chpid;
+    schib->pmcw.pim =3D 0x80;
+    schib->pmcw.pom =3D 0xff;
+    schib->pmcw.pam =3D 0x80;
+    schib->pmcw.chpid[0] =3D chpid;
     if (!css->chpids[chpid].in_use) {
         css_add_chpid(sch->cssid, chpid, type, true);
     }
=20
-    memset(s, 0, sizeof(SCSW));
-    sch->curr_status.mba =3D 0;
-    for (i =3D 0; i < ARRAY_SIZE(sch->curr_status.mda); i++) {
-        sch->curr_status.mda[i] =3D 0;
+    memset(&schib->scsw, 0, sizeof(SCSW));
+    schib->mba =3D 0;
+    for (i =3D 0; i < ARRAY_SIZE(schib->mda); i++) {
+        schib->mda[i] =3D 0;
     }
 }
=20
@@ -2246,30 +2233,30 @@ int css_enable_mss(void)
=20
 void css_reset_sch(SubchDev *sch)
 {
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
-    if ((p->flags & PMCW_FLAGS_MASK_ENA) !=3D 0 && sch->disable_cb) {
+    if ((schib->pmcw.flags & PMCW_FLAGS_MASK_ENA) !=3D 0 && sch->disable=
_cb) {
         sch->disable_cb(sch);
     }
=20
-    p->intparm =3D 0;
-    p->flags &=3D ~(PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
+    schib->pmcw.intparm =3D 0;
+    schib->pmcw.flags &=3D ~(PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
                   PMCW_FLAGS_MASK_LM | PMCW_FLAGS_MASK_MME |
                   PMCW_FLAGS_MASK_MP | PMCW_FLAGS_MASK_TF);
-    p->flags |=3D PMCW_FLAGS_MASK_DNV;
-    p->devno =3D sch->devno;
-    p->pim =3D 0x80;
-    p->lpm =3D p->pim;
-    p->pnom =3D 0;
-    p->lpum =3D 0;
-    p->mbi =3D 0;
-    p->pom =3D 0xff;
-    p->pam =3D 0x80;
-    p->chars &=3D ~(PMCW_CHARS_MASK_MBFC | PMCW_CHARS_MASK_XMWME |
+    schib->pmcw.flags |=3D PMCW_FLAGS_MASK_DNV;
+    schib->pmcw.devno =3D sch->devno;
+    schib->pmcw.pim =3D 0x80;
+    schib->pmcw.lpm =3D schib->pmcw.pim;
+    schib->pmcw.pnom =3D 0;
+    schib->pmcw.lpum =3D 0;
+    schib->pmcw.mbi =3D 0;
+    schib->pmcw.pom =3D 0xff;
+    schib->pmcw.pam =3D 0x80;
+    schib->pmcw.chars &=3D ~(PMCW_CHARS_MASK_MBFC | PMCW_CHARS_MASK_XMWM=
E |
                   PMCW_CHARS_MASK_CSENSE);
=20
-    memset(&sch->curr_status.scsw, 0, sizeof(sch->curr_status.scsw));
-    sch->curr_status.mba =3D 0;
+    memset(&schib->scsw, 0, sizeof(schib->scsw));
+    schib->mba =3D 0;
=20
     sch->channel_prog =3D 0x0;
     sch->last_cmd_valid =3D false;
@@ -2433,7 +2420,7 @@ static int css_sch_get_chpids(SubchDev *sch, CssDev=
Id *dev_id)
     FILE *fd;
     uint32_t chpid[8];
     int i;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
     fid_path =3D g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/chpids=
",
                                dev_id->cssid, dev_id->ssid, dev_id->devi=
d);
@@ -2452,8 +2439,8 @@ static int css_sch_get_chpids(SubchDev *sch, CssDev=
Id *dev_id)
         return -EINVAL;
     }
=20
-    for (i =3D 0; i < ARRAY_SIZE(p->chpid); i++) {
-        p->chpid[i] =3D chpid[i];
+    for (i =3D 0; i < ARRAY_SIZE(schib->pmcw.chpid); i++) {
+        schib->pmcw.chpid[i] =3D chpid[i];
     }
=20
     fclose(fd);
@@ -2467,7 +2454,7 @@ static int css_sch_get_path_masks(SubchDev *sch, Cs=
sDevId *dev_id)
     char *fid_path;
     FILE *fd;
     uint32_t pim, pam, pom;
-    PMCW *p =3D &sch->curr_status.pmcw;
+    SCHIB *schib =3D &sch->curr_status;
=20
     fid_path =3D g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/pimpam=
pom",
                                dev_id->cssid, dev_id->ssid, dev_id->devi=
d);
@@ -2484,9 +2471,9 @@ static int css_sch_get_path_masks(SubchDev *sch, Cs=
sDevId *dev_id)
         return -EINVAL;
     }
=20
-    p->pim =3D pim;
-    p->pam =3D pam;
-    p->pom =3D pom;
+    schib->pmcw.pim =3D pim;
+    schib->pmcw.pam =3D pam;
+    schib->pmcw.pom =3D pom;
     fclose(fd);
     g_free(fid_path);
=20
@@ -2528,16 +2515,15 @@ static int css_sch_get_chpid_type(uint8_t chpid, =
uint32_t *type,
 int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
 {
     CssImage *css =3D channel_subsys.css[sch->cssid];
-    PMCW *p =3D &sch->curr_status.pmcw;
-    SCSW *s =3D &sch->curr_status.scsw;
+    SCHIB *schib =3D &sch->curr_status;
     uint32_t type;
     int i, ret;
=20
     assert(css !=3D NULL);
-    memset(p, 0, sizeof(PMCW));
-    p->flags |=3D PMCW_FLAGS_MASK_DNV;
+    memset(&schib->pmcw, 0, sizeof(PMCW));
+    schib->pmcw.flags |=3D PMCW_FLAGS_MASK_DNV;
     /* We are dealing with I/O subchannels only. */
-    p->devno =3D sch->devno;
+    schib->pmcw.devno =3D sch->devno;
=20
     /* Grab path mask from sysfs. */
     ret =3D css_sch_get_path_masks(sch, dev_id);
@@ -2552,20 +2538,20 @@ int css_sch_build_schib(SubchDev *sch, CssDevId *=
dev_id)
     }
=20
    /* Build chpid type. */
-    for (i =3D 0; i < ARRAY_SIZE(p->chpid); i++) {
-        if (p->chpid[i] && !css->chpids[p->chpid[i]].in_use) {
-            ret =3D css_sch_get_chpid_type(p->chpid[i], &type, dev_id);
+    for (i =3D 0; i < ARRAY_SIZE(schib->pmcw.chpid); i++) {
+        if (schib->pmcw.chpid[i] && !css->chpids[schib->pmcw.chpid[i]].i=
n_use) {
+            ret =3D css_sch_get_chpid_type(schib->pmcw.chpid[i], &type, =
dev_id);
             if (ret) {
                 return ret;
             }
-            css_add_chpid(sch->cssid, p->chpid[i], type, false);
+            css_add_chpid(sch->cssid, schib->pmcw.chpid[i], type, false)=
;
         }
     }
=20
-    memset(s, 0, sizeof(SCSW));
-    sch->curr_status.mba =3D 0;
-    for (i =3D 0; i < ARRAY_SIZE(sch->curr_status.mda); i++) {
-        sch->curr_status.mda[i] =3D 0;
+    memset(&schib->scsw, 0, sizeof(SCSW));
+    schib->mba =3D 0;
+    for (i =3D 0; i < ARRAY_SIZE(schib->mda); i++) {
+        schib->mda[i] =3D 0;
     }
=20
     return 0;
--=20
2.17.2
