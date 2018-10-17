Received: from eggs.gnu.org ([2001:4830:134:3::10]:51030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAb-000855-Ip
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAY-0000za-61
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAX-0000wr-Qt
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:25 +0200
Message-Id: <20181017082702.5581-2-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/38] error: Fix use of error_prepend()
 with &error_fatal, &error_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fei Li <fli@suse.com>

>From include/qapi/error.h:

  * Pass an existing error to the caller with the message modified:
  *     error_propagate(errp, err);
  *     error_prepend(errp, "Could not frobnicate '%s': ", name);

Fei Li pointed out that doing error_propagate() first doesn't work
well when @errp is &error_fatal or &error_abort: the error_prepend()
is never reached.

Since I doubt fixing the documentation will stop people from getting
it wrong, introduce error_propagate_prepend(), in the hope that it
lures people away from using its constituents in the wrong order.
Update the instructions in error.h accordingly.

Convert existing error_prepend() next to error_propagate to
error_propagate_prepend().  If any of these get reached with
&error_fatal or &error_abort, the error messages improve.  I didn't
check whether that's the case anywhere.

Cc: Fei Li <fli@suse.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                 |  6 +++---
 block/qcow2.c           |  4 ++--
 block/qed.c             |  4 ++--
 hw/9pfs/9p-local.c      |  4 ++--
 hw/intc/xics.c          | 15 +++++++++------
 hw/ppc/pnv_core.c       |  4 ++--
 hw/ppc/spapr_pci.c      |  7 +++----
 hw/timer/aspeed_timer.c |  3 +--
 hw/usb/bus.c            |  5 +++--
 hw/vfio/pci.c           |  3 +--
 include/qapi/error.h    | 14 ++++++++++++++
 migration/migration.c   | 12 ++++++------
 util/error.c            | 13 +++++++++++++
 13 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/block.c b/block.c
index 7710b399a3..5d51419d21 100644
--- a/block.c
+++ b/block.c
@@ -4697,9 +4697,9 @@ bool bdrv_op_is_blocked(BlockDriverState *bs, Block=
OpType op, Error **errp)
     assert((int) op >=3D 0 && op < BLOCK_OP_TYPE_MAX);
     if (!QLIST_EMPTY(&bs->op_blockers[op])) {
         blocker =3D QLIST_FIRST(&bs->op_blockers[op]);
-        error_propagate(errp, error_copy(blocker->reason));
-        error_prepend(errp, "Node '%s' is busy: ",
-                      bdrv_get_device_or_node_name(bs));
+        error_propagate_prepend(errp, error_copy(blocker->reason),
+                                "Node '%s' is busy: ",
+                                bdrv_get_device_or_node_name(bs));
         return true;
     }
     return false;
diff --git a/block/qcow2.c b/block/qcow2.c
index 7277feda13..4f8d2fa7bd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2208,8 +2208,8 @@ static void coroutine_fn qcow2_co_invalidate_cache(=
BlockDriverState *bs,
     qemu_co_mutex_unlock(&s->lock);
     qobject_unref(options);
     if (local_err) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "Could not reopen qcow2 layer: ");
+        error_propagate_prepend(errp, local_err,
+                                "Could not reopen qcow2 layer: ");
         bs->drv =3D NULL;
         return;
     } else if (ret < 0) {
diff --git a/block/qed.c b/block/qed.c
index 689ea9d4d5..9377c0b7ad 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1606,8 +1606,8 @@ static void coroutine_fn bdrv_qed_co_invalidate_cac=
he(BlockDriverState *bs,
     ret =3D bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
     qemu_co_mutex_unlock(&s->table_lock);
     if (local_err) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "Could not reopen qed layer: ");
+        error_propagate_prepend(errp, local_err,
+                                "Could not reopen qed layer: ");
         return;
     } else if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not reopen qed layer");
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c30f4f26bd..08e673a79c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1509,8 +1509,8 @@ static int local_parse_opts(QemuOpts *opts, FsDrive=
rEntry *fse, Error **errp)
=20
     fsdev_throttle_parse_opts(opts, &fse->fst, &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "invalid throttle configuration: ");
+        error_propagate_prepend(errp, local_err,
+                                "invalid throttle configuration: ");
         return -1;
     }
=20
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c90c893228..406efee064 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -320,8 +320,9 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
=20
     obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_XICS, &err);
     if (!obj) {
-        error_propagate(errp, err);
-        error_prepend(errp, "required link '" ICP_PROP_XICS "' not found=
: ");
+        error_propagate_prepend(errp, err,
+                                "required link '" ICP_PROP_XICS
+                                "' not found: ");
         return;
     }
=20
@@ -329,8 +330,9 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
=20
     obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
     if (!obj) {
-        error_propagate(errp, err);
-        error_prepend(errp, "required link '" ICP_PROP_CPU "' not found:=
 ");
+        error_propagate_prepend(errp, err,
+                                "required link '" ICP_PROP_CPU
+                                "' not found: ");
         return;
     }
=20
@@ -624,8 +626,9 @@ static void ics_base_realize(DeviceState *dev, Error =
**errp)
=20
     obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
     if (!obj) {
-        error_propagate(errp, err);
-        error_prepend(errp, "required link '" ICS_PROP_XICS "' not found=
: ");
+        error_propagate_prepend(errp, err,
+                                "required link '" ICS_PROP_XICS
+                                "' not found: ");
         return;
     }
     ics->xics =3D XICS_FABRIC(obj);
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9750464bf4..ad1bcc7990 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -148,8 +148,8 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
=20
     chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
     if (!chip) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'chip' not found: ");
+        error_propagate_prepend(errp, local_err,
+                                "required link 'chip' not found: ");
         return;
     }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c2271e6ed4..58afa46204 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1724,16 +1724,15 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
         if (smc->legacy_irq_allocation) {
             irq =3D spapr_irq_findone(spapr, &local_err);
             if (local_err) {
-                error_propagate(errp, local_err);
-                error_prepend(errp, "can't allocate LSIs: ");
+                error_propagate_prepend(errp, local_err,
+                                        "can't allocate LSIs: ");
                 return;
             }
         }
=20
         spapr_irq_claim(spapr, irq, true, &local_err);
         if (local_err) {
-            error_propagate(errp, local_err);
-            error_prepend(errp, "can't allocate LSIs: ");
+            error_propagate_prepend(errp, local_err, "can't allocate LSI=
s: ");
             return;
         }
=20
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 54b400b94a..5c786e5128 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -454,8 +454,7 @@ static void aspeed_timer_realize(DeviceState *dev, Er=
ror **errp)
=20
     obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
     if (!obj) {
-        error_propagate(errp, err);
-        error_prepend(errp, "required link 'scu' not found: ");
+        error_propagate_prepend(errp, err, "required link 'scu' not foun=
d: ");
         return;
     }
     s->scu =3D ASPEED_SCU(obj);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 11f7720d71..bf796d67e6 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -340,8 +340,9 @@ static USBDevice *usb_try_create_simple(USBBus *bus, =
const char *name,
     }
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err) {
-        error_propagate(errp, err);
-        error_prepend(errp, "Failed to initialize USB device '%s': ", na=
me);
+        error_propagate_prepend(errp, err,
+                                "Failed to initialize USB device '%s': "=
,
+                                name);
         return NULL;
     }
     return dev;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b73582d51..4404c28360 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1283,8 +1283,7 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int =
pos, Error **errp)
         if (ret =3D=3D -ENOTSUP) {
             return 0;
         }
-        error_prepend(&err, "msi_init failed: ");
-        error_propagate(errp, err);
+        error_propagate_prepend(errp, err, "msi_init failed: ");
         return ret;
     }
     vdev->msi_cap_size =3D 0xa + (msi_maskbit ? 0xa : 0) + (msi_64bit ? =
0x4 : 0);
diff --git a/include/qapi/error.h b/include/qapi/error.h
index bcb86a79f5..51b63dd4b5 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -52,8 +52,12 @@
  * where Error **errp is a parameter, by convention the last one.
  *
  * Pass an existing error to the caller with the message modified:
+ *     error_propagate_prepend(errp, err);
+ *
+ * Avoid
  *     error_propagate(errp, err);
  *     error_prepend(errp, "Could not frobnicate '%s': ", name);
+ * because this fails to prepend when @errp is &error_fatal.
  *
  * Create a new error and pass it to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
@@ -215,6 +219,16 @@ void error_setg_win32_internal(Error **errp,
  */
 void error_propagate(Error **dst_errp, Error *local_err);
=20
+
+/*
+ * Propagate error object (if any) with some text prepended.
+ * Behaves like
+ *     error_prepend(&local_err, fmt, ...);
+ *     error_propagate(dst_errp, local_err);
+ */
+void error_propagate_prepend(Error **dst_errp, Error *local_err,
+                             const char *fmt, ...);
+
 /*
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, @ap like vprintf().
diff --git a/migration/migration.c b/migration/migration.c
index d6ae879dc8..f0f299a773 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1546,9 +1546,9 @@ static GSList *migration_blockers;
 int migrate_add_blocker(Error *reason, Error **errp)
 {
     if (migrate_get_current()->only_migratable) {
-        error_propagate(errp, error_copy(reason));
-        error_prepend(errp, "disallowing migration blocker "
-                          "(--only_migratable) for: ");
+        error_propagate_prepend(errp, error_copy(reason),
+                                "disallowing migration blocker "
+                                "(--only_migratable) for: ");
         return -EACCES;
     }
=20
@@ -1557,9 +1557,9 @@ int migrate_add_blocker(Error *reason, Error **errp=
)
         return 0;
     }
=20
-    error_propagate(errp, error_copy(reason));
-    error_prepend(errp, "disallowing migration blocker (migration in "
-                      "progress) for: ");
+    error_propagate_prepend(errp, error_copy(reason),
+                            "disallowing migration blocker "
+                            "(migration in progress) for: ");
     return -EBUSY;
 }
=20
diff --git a/util/error.c b/util/error.c
index 3efdd69162..b5ccbd8eac 100644
--- a/util/error.c
+++ b/util/error.c
@@ -292,3 +292,16 @@ void error_propagate(Error **dst_errp, Error *local_=
err)
         error_free(local_err);
     }
 }
+
+void error_propagate_prepend(Error **dst_errp, Error *err,
+                             const char *fmt, ...)
+{
+    va_list ap;
+
+    if (dst_errp && !*dst_errp) {
+        va_start(ap, fmt);
+        error_vprepend(&err, fmt, ap);
+        va_end(ap);
+    } /* else error is being ignored, don't bother with prepending */
+    error_propagate(dst_errp, err);
+}
--=20
2.17.1
