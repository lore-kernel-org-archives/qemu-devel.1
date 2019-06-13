Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D87C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144F52147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144F52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbM0H-0006kH-1L
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hbLzT-0006JU-5v
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hbLzR-00076b-8d
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hbLzR-00073x-04; Thu, 13 Jun 2019 05:25:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AAF73082B02;
 Thu, 13 Jun 2019 09:25:47 +0000 (UTC)
Received: from localhost (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 698E157982;
 Thu, 13 Jun 2019 09:25:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 13 Jun 2019 11:25:42 +0200
Message-Id: <20190613092542.2834-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 13 Jun 2019 09:25:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6] vfio-ccw: support async command subregion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A vfio-ccw device may provide an async command subregion for
issuing halt/clear subchannel requests. If it is present, use
it for sending halt/clear request to the device; if not, fall
back to emulation (as done today).

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

v5->v6:
- plug a memory leak [Farhan]

v4->v5:
- It seems we need to take the indirection via the class for the
  callbacks after all :(
- Dropped Eric's R-b: for that reason

---
 hw/s390x/css.c              |  27 +++++++--
 hw/s390x/s390-ccw.c         |  20 +++++++
 hw/vfio/ccw.c               | 113 +++++++++++++++++++++++++++++++++++-
 include/hw/s390x/css.h      |   3 +
 include/hw/s390x/s390-ccw.h |   2 +
 5 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index ad310b9f94bc..b92395f165e6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -22,6 +22,7 @@
 #include "trace.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/s390-ccw.h"
=20
 typedef struct CrwContainer {
     CRW crw;
@@ -1205,6 +1206,26 @@ static void sch_handle_start_func_virtual(SubchDev=
 *sch)
=20
 }
=20
+static void sch_handle_halt_func_passthrough(SubchDev *sch)
+{
+    int ret;
+
+    ret =3D s390_ccw_halt(sch);
+    if (ret =3D=3D -ENOSYS) {
+        sch_handle_halt_func(sch);
+    }
+}
+
+static void sch_handle_clear_func_passthrough(SubchDev *sch)
+{
+    int ret;
+
+    ret =3D s390_ccw_clear(sch);
+    if (ret =3D=3D -ENOSYS) {
+        sch_handle_clear_func(sch);
+    }
+}
+
 static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
 {
     SCHIB *schib =3D &sch->curr_status;
@@ -1244,11 +1265,9 @@ IOInstEnding do_subchannel_work_passthrough(SubchD=
ev *sch)
     SCHIB *schib =3D &sch->curr_status;
=20
     if (schib->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
-        /* TODO: Clear handling */
-        sch_handle_clear_func(sch);
+        sch_handle_clear_func_passthrough(sch);
     } else if (schib->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
-        /* TODO: Halt handling */
-        sch_handle_halt_func(sch);
+        sch_handle_halt_func_passthrough(sch);
     } else if (schib->scsw.ctrl & SCSW_FCTL_START_FUNC) {
         return sch_handle_start_func_passthrough(sch);
     }
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 8403f0e3e950..22c6878b8413 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -30,6 +30,26 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
     return cdc->handle_request(sch);
 }
=20
+int s390_ccw_halt(SubchDev *sch)
+{
+    S390CCWDeviceClass *cdc =3D S390_CCW_DEVICE_GET_CLASS(sch->driver_da=
ta);
+
+    if (!cdc->handle_halt) {
+        return -ENOSYS;
+    }
+    return cdc->handle_halt(sch);
+}
+
+int s390_ccw_clear(SubchDev *sch)
+{
+    S390CCWDeviceClass *cdc =3D S390_CCW_DEVICE_GET_CLASS(sch->driver_da=
ta);
+
+    if (!cdc->handle_clear) {
+        return -ENOSYS;
+    }
+    return cdc->handle_clear(sch);
+}
+
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
                                   char *sysfsdev,
                                   Error **errp)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 03a2becb3ec9..2636195529fa 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -2,9 +2,12 @@
  * vfio based subchannel assignment support
  *
  * Copyright 2017 IBM Corp.
+ * Copyright 2019 Red Hat, Inc.
+ *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
  *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
  * your option) any later version. See the COPYING file in the top-level
@@ -33,6 +36,9 @@ struct VFIOCCWDevice {
     uint64_t io_region_size;
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
+    uint64_t async_cmd_region_size;
+    uint64_t async_cmd_region_offset;
+    struct ccw_cmd_region *async_cmd_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -115,6 +121,87 @@ again:
     }
 }
=20
+static int vfio_ccw_handle_clear(SubchDev *sch)
+{
+    S390CCWDevice *cdev =3D sch->driver_data;
+    VFIOCCWDevice *vcdev =3D DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_cmd_region *region =3D vcdev->async_cmd_region;
+    int ret;
+
+    if (!vcdev->async_cmd_region) {
+        /* Async command region not available, fall back to emulation */
+        return -ENOSYS;
+    }
+
+    memset(region, 0, sizeof(*region));
+    region->command =3D VFIO_CCW_ASYNC_CMD_CSCH;
+
+again:
+    ret =3D pwrite(vcdev->vdev.fd, region,
+                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_o=
ffset);
+    if (ret !=3D vcdev->async_cmd_region_size) {
+        if (errno =3D=3D EAGAIN) {
+            goto again;
+        }
+        error_report("vfio-ccw: write cmd region failed with errno=3D%d"=
, errno);
+        ret =3D -errno;
+    } else {
+        ret =3D region->ret_code;
+    }
+    switch (ret) {
+    case 0:
+    case -ENODEV:
+    case -EACCES:
+        return 0;
+    case -EFAULT:
+    default:
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return 0;
+    }
+}
+
+static int vfio_ccw_handle_halt(SubchDev *sch)
+{
+    S390CCWDevice *cdev =3D sch->driver_data;
+    VFIOCCWDevice *vcdev =3D DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_cmd_region *region =3D vcdev->async_cmd_region;
+    int ret;
+
+    if (!vcdev->async_cmd_region) {
+        /* Async command region not available, fall back to emulation */
+        return -ENOSYS;
+    }
+
+    memset(region, 0, sizeof(*region));
+    region->command =3D VFIO_CCW_ASYNC_CMD_HSCH;
+
+again:
+    ret =3D pwrite(vcdev->vdev.fd, region,
+                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_o=
ffset);
+    if (ret !=3D vcdev->async_cmd_region_size) {
+        if (errno =3D=3D EAGAIN) {
+            goto again;
+        }
+        error_report("vfio-ccw: write cmd region failed with errno=3D%d"=
, errno);
+        ret =3D -errno;
+    } else {
+        ret =3D region->ret_code;
+    }
+    switch (ret) {
+    case 0:
+    case -EBUSY:
+    case -ENODEV:
+    case -EACCES:
+        return 0;
+    case -EFAULT:
+    default:
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return 0;
+    }
+}
+
 static void vfio_ccw_reset(DeviceState *dev)
 {
     CcwDevice *ccw_dev =3D DO_UPCAST(CcwDevice, parent_obj, dev);
@@ -288,9 +375,13 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev=
, Error **errp)
         return;
     }
=20
+    /*
+     * We always expect at least the I/O region to be present. We also
+     * may have a variable number of regions governed by capabilities.
+     */
     if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
-        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
-                   vdev->num_regions);
+        error_setg(errp, "vfio: too few regions (%u), expected at least =
%u",
+                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
         return;
     }
=20
@@ -310,11 +401,27 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcde=
v, Error **errp)
     vcdev->io_region_offset =3D info->offset;
     vcdev->io_region =3D g_malloc0(info->size);
=20
+    /* check for the optional async command region */
+    ret =3D vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &i=
nfo);
+    if (!ret) {
+        vcdev->async_cmd_region_size =3D info->size;
+        if (sizeof(*vcdev->async_cmd_region) !=3D vcdev->async_cmd_regio=
n_size) {
+            error_setg(errp, "vfio: Unexpected size of the async cmd reg=
ion");
+            g_free(vcdev->io_region);
+            g_free(info);
+            return;
+        }
+        vcdev->async_cmd_region_offset =3D info->offset;
+        vcdev->async_cmd_region =3D g_malloc0(info->size);
+    }
+
     g_free(info);
 }
=20
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
 }
=20
@@ -487,6 +594,8 @@ static void vfio_ccw_class_init(ObjectClass *klass, v=
oid *data)
     dc->reset =3D vfio_ccw_reset;
=20
     cdc->handle_request =3D vfio_ccw_handle_request;
+    cdc->handle_halt =3D vfio_ccw_handle_halt;
+    cdc->handle_clear =3D vfio_ccw_handle_clear;
 }
=20
 static const TypeInfo vfio_ccw_info =3D {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 7cc183ef4366..d033387fba8a 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -215,6 +215,9 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch);
 IOInstEnding do_subchannel_work_virtual(SubchDev *sub);
 IOInstEnding do_subchannel_work_passthrough(SubchDev *sub);
=20
+int s390_ccw_halt(SubchDev *sch);
+int s390_ccw_clear(SubchDev *sch);
+
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO =3D 0,
     CSS_IO_ADAPTER_PCI =3D 1,
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 901d805d79a3..fffb54562f6d 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -35,6 +35,8 @@ typedef struct S390CCWDeviceClass {
     void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev, Error **errp);
     IOInstEnding (*handle_request) (SubchDev *sch);
+    int (*handle_halt) (SubchDev *sch);
+    int (*handle_clear) (SubchDev *sch);
 } S390CCWDeviceClass;
=20
 #endif
--=20
2.20.1


