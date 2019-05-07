Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A9C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C3C20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C3C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2LH-0003sD-9U
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:49:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hO2Jq-0003DW-5J
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hO2Jo-0007BZ-Np
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:47:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hO2Jo-0007Ah-GS; Tue, 07 May 2019 11:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0D653082B4F;
	Tue,  7 May 2019 15:47:47 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A73BC5C21F;
	Tue,  7 May 2019 15:47:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Date: Tue,  7 May 2019 17:47:33 +0200
Message-Id: <20190507154733.28604-3-cohuck@redhat.com>
In-Reply-To: <20190507154733.28604-1-cohuck@redhat.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 07 May 2019 15:47:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A vfio-ccw device may provide an async command subregion for
issuing halt/clear subchannel requests. If it is present, use
it for sending halt/clear request to the device; if not, fall
back to emulation (as done today).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c              |  27 +++++++--
 hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
 include/hw/s390x/s390-ccw.h |   3 +
 3 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 8fc9e35ba5d3..5b21a74b5c29 100644
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
@@ -1191,6 +1192,26 @@ static void sch_handle_start_func_virtual(SubchDev=
 *sch)
=20
 }
=20
+static void sch_handle_halt_func_passthrough(SubchDev *sch)
+{
+    int ret;
+
+    ret =3D vfio_ccw_handle_halt(sch);
+    if (ret =3D=3D -ENOSYS) {
+        sch_handle_halt_func(sch);
+    }
+}
+
+static void sch_handle_clear_func_passthrough(SubchDev *sch)
+{
+    int ret;
+
+    ret =3D vfio_ccw_handle_clear(sch);
+    if (ret =3D=3D -ENOSYS) {
+        sch_handle_clear_func(sch);
+    }
+}
+
 static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
 {
     SCHIB *schib =3D &sch->curr_status;
@@ -1230,11 +1251,9 @@ IOInstEnding do_subchannel_work_passthrough(SubchD=
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
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 31dd3a2a87b6..175a17b1772a 100644
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
@@ -32,6 +35,9 @@ struct VFIOCCWDevice {
     uint64_t io_region_size;
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
+    uint64_t async_cmd_region_size;
+    uint64_t async_cmd_region_offset;
+    struct ccw_cmd_region *async_cmd_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -114,6 +120,87 @@ again:
     }
 }
=20
+int vfio_ccw_handle_clear(SubchDev *sch)
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
+int vfio_ccw_handle_halt(SubchDev *sch)
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
@@ -287,9 +374,13 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev=
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
@@ -309,11 +400,26 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcde=
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
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 901d805d79a3..e9c7e1db5761 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -37,4 +37,7 @@ typedef struct S390CCWDeviceClass {
     IOInstEnding (*handle_request) (SubchDev *sch);
 } S390CCWDeviceClass;
=20
+int vfio_ccw_handle_clear(SubchDev *sch);
+int vfio_ccw_handle_halt(SubchDev *sch);
+
 #endif
--=20
2.20.1


