Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F52C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586CC20826
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn83g9za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586CC20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn1y-0007Ei-IA
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv9-0002jD-EI
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv5-0001Kf-KW
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NzAsGQePlosdLQbLXcIzQnsWDyi+eddzAIRrHxLygng=;
 b=hn83g9zawUBqWjmXz2SGFLJR+8PoFPu+6re30SpBqmv+LU3NfuXDyc1j+4H+X/NSkBQaa2
 cc1CkI12hNOyLZ2i1IdA9LUg0lkawXLVCsQ5296/3a5yTj8+xTvQ/49ZxoAet85xxo/5yj
 ybfv/G+Kg95mMMynEQXdzU9jt/n/P0E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-eXk7hg6MN_eFw9taHLaZig-1; Sat, 04 Jul 2020 14:29:43 -0400
X-MC-Unique: eXk7hg6MN_eFw9taHLaZig-1
Received: by mail-wm1-f72.google.com with SMTP id b13so38187100wme.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NzAsGQePlosdLQbLXcIzQnsWDyi+eddzAIRrHxLygng=;
 b=jSyBYDv4fWhmKaZlRCySH9OylyMb09tXhGCZQ9KL9uwebrjJ+5POaBng5LxMkFv17T
 ZsbpgML8LpS+nyb/wXshtrSRIS+C6lw9+p6LpTd+4AIJm+3fes6JXlt39yTaPiEoc1ZE
 XsjFBVTB7FsOCmtaD/b8p1QnO9G6tNJyEXq28otvrLbHRE8/N4viFI40wDTQqm592zvd
 n8HJFbNOniJrcZCwW86vt8mqDjxFIoDF1VUYf28hz5GC1BFHqSvldo7ZTvnsv4jQ0Djj
 BUJGXyiiioZntjzRP3WlARAKqV3uLv7FTe2yZOq9zMpMAvWhAEWujJJ7GITPpv36grhA
 Mt1Q==
X-Gm-Message-State: AOAM530LZ/Cfxm6qZs17wBgJJdKVtQrqeqgKFfZLX176j1ZoJwCWyiIg
 LZc7m2P0sn/KGSoT0WsKZaCJl1ObkhPOuDUeCQo6Z7uhszmXok41rI0wf2f1P/kWQh3n6ilLUJJ
 IrO1gDAMz/bGmlb0=
X-Received: by 2002:a1c:7216:: with SMTP id n22mr36366284wmc.189.1593887381471; 
 Sat, 04 Jul 2020 11:29:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC+I9bCPIA+3xvvsLkW20vdpcU/D+oD76UZuOPiNxK7gzuuPsWmJf+4Co/MEYV12o3mKAgWA==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr36366269wmc.189.1593887381219; 
 Sat, 04 Jul 2020 11:29:41 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 j6sm5200083wro.25.2020.07.04.11.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:40 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/41] vfio: Convert to ram_block_discard_disable()
Message-ID: <20200704182750.1088103-7-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman <farman@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

VFIO is (except devices without a physical IOMMU or some mediated devices)
incompatible with discarding of RAM. The kernel will pin basically all VM
memory. Let's convert to ram_block_discard_disable(), which can now
fail, in contrast to qemu_balloon_inhibit().

Leave "x-balloon-allowed" named as it is for now.

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-4-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 +--
 hw/vfio/ap.c                  |  8 +++---
 hw/vfio/ccw.c                 | 11 ++++----
 hw/vfio/common.c              | 53 +++++++++++++++++++----------------
 hw/vfio/pci.c                 |  6 ++--
 5 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fd564209ac..c78f3ff559 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -108,7 +108,7 @@ typedef struct VFIODevice {
     bool reset_works;
     bool needs_reset;
     bool no_mmap;
-    bool balloon_allowed;
+    bool ram_block_discard_allowed;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
@@ -128,7 +128,7 @@ typedef struct VFIOGroup {
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
     QLIST_ENTRY(VFIOGroup) container_next;
-    bool balloon_allowed;
+    bool ram_block_discard_allowed;
 } VFIOGroup;
 
 typedef struct VFIODMABuf {
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 95564c17ed..b9330a8e6f 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -105,12 +105,12 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     vapdev->vdev.dev = dev;
 
     /*
-     * vfio-ap devices operate in a way compatible with
-     * memory ballooning, as no pages are pinned in the host.
+     * vfio-ap devices operate in a way compatible with discarding of
+     * memory in RAM blocks, as no pages are pinned in the host.
      * This needs to be set before vfio_get_device() for vfio common to
-     * handle the balloon inhibitor.
+     * handle ram_block_discard_disable().
      */
-    vapdev->vdev.balloon_allowed = true;
+    vapdev->vdev.ram_block_discard_allowed = true;
 
     ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
     if (ret) {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 06e69d7066..ff7f369779 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -574,12 +574,13 @@ static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
 
     /*
      * All vfio-ccw devices are believed to operate in a way compatible with
-     * memory ballooning, ie. pages pinned in the host are in the current
-     * working set of the guest driver and therefore never overlap with pages
-     * available to the guest balloon driver.  This needs to be set before
-     * vfio_get_device() for vfio common to handle the balloon inhibitor.
+     * discarding of memory in RAM blocks, ie. pages pinned in the host are
+     * in the current working set of the guest driver and therefore never
+     * overlap e.g., with pages available to the guest balloon driver.  This
+     * needs to be set before vfio_get_device() for vfio common to handle
+     * ram_block_discard_disable().
      */
-    vcdev->vdev.balloon_allowed = true;
+    vcdev->vdev.ram_block_discard_allowed = true;
 
     if (vfio_get_device(group, vcdev->cdev.mdevid, &vcdev->vdev, errp)) {
         goto out_err;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..33357140b8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -33,7 +33,6 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
-#include "sysemu/balloon.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
 #include "trace.h"
@@ -1215,31 +1214,36 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     space = vfio_get_address_space(as);
 
     /*
-     * VFIO is currently incompatible with memory ballooning insofar as the
+     * VFIO is currently incompatible with discarding of RAM insofar as the
      * madvise to purge (zap) the page from QEMU's address space does not
      * interact with the memory API and therefore leaves stale virtual to
      * physical mappings in the IOMMU if the page was previously pinned.  We
-     * therefore add a balloon inhibit for each group added to a container,
+     * therefore set discarding broken for each group added to a container,
      * whether the container is used individually or shared.  This provides
      * us with options to allow devices within a group to opt-in and allow
-     * ballooning, so long as it is done consistently for a group (for instance
+     * discarding, so long as it is done consistently for a group (for instance
      * if the device is an mdev device where it is known that the host vendor
      * driver will never pin pages outside of the working set of the guest
-     * driver, which would thus not be ballooning candidates).
+     * driver, which would thus not be discarding candidates).
      *
      * The first opportunity to induce pinning occurs here where we attempt to
      * attach the group to existing containers within the AddressSpace.  If any
-     * pages are already zapped from the virtual address space, such as from a
-     * previous ballooning opt-in, new pinning will cause valid mappings to be
+     * pages are already zapped from the virtual address space, such as from
+     * previous discards, new pinning will cause valid mappings to be
      * re-established.  Likewise, when the overall MemoryListener for a new
      * container is registered, a replay of mappings within the AddressSpace
      * will occur, re-establishing any previously zapped pages as well.
      *
-     * NB. Balloon inhibiting does not currently block operation of the
-     * balloon driver or revoke previously pinned pages, it only prevents
-     * calling madvise to modify the virtual mapping of ballooned pages.
+     * Especially virtio-balloon is currently only prevented from discarding
+     * new memory, it will not yet set ram_block_discard_set_required() and
+     * therefore, neither stops us here or deals with the sudden memory
+     * consumption of inflated memory.
      */
-    qemu_balloon_inhibit(true);
+    ret = ram_block_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        return ret;
+    }
 
     QLIST_FOREACH(container, &space->containers, next) {
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
@@ -1405,7 +1409,7 @@ close_fd_exit:
     close(fd);
 
 put_space_exit:
-    qemu_balloon_inhibit(false);
+    ram_block_discard_disable(false);
     vfio_put_address_space(space);
 
     return ret;
@@ -1526,8 +1530,8 @@ void vfio_put_group(VFIOGroup *group)
         return;
     }
 
-    if (!group->balloon_allowed) {
-        qemu_balloon_inhibit(false);
+    if (!group->ram_block_discard_allowed) {
+        ram_block_discard_disable(false);
     }
     vfio_kvm_device_del_group(group);
     vfio_disconnect_container(group);
@@ -1565,22 +1569,23 @@ int vfio_get_device(VFIOGroup *group, const char *name,
     }
 
     /*
-     * Clear the balloon inhibitor for this group if the driver knows the
-     * device operates compatibly with ballooning.  Setting must be consistent
-     * per group, but since compatibility is really only possible with mdev
-     * currently, we expect singleton groups.
+     * Set discarding of RAM as not broken for this group if the driver knows
+     * the device operates compatibly with discarding.  Setting must be
+     * consistent per group, but since compatibility is really only possible
+     * with mdev currently, we expect singleton groups.
      */
-    if (vbasedev->balloon_allowed != group->balloon_allowed) {
+    if (vbasedev->ram_block_discard_allowed !=
+        group->ram_block_discard_allowed) {
         if (!QLIST_EMPTY(&group->device_list)) {
-            error_setg(errp,
-                       "Inconsistent device balloon setting within group");
+            error_setg(errp, "Inconsistent setting of support for discarding "
+                       "RAM (e.g., balloon) within group");
             close(fd);
             return -1;
         }
 
-        if (!group->balloon_allowed) {
-            group->balloon_allowed = true;
-            qemu_balloon_inhibit(false);
+        if (!group->ram_block_discard_allowed) {
+            group->ram_block_discard_allowed = true;
+            ram_block_discard_disable(false);
         }
     }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6838bcc4b3..d020ea9f82 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2789,7 +2789,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     }
 
     /*
-     * Mediated devices *might* operate compatibly with memory ballooning, but
+     * Mediated devices *might* operate compatibly with discarding of RAM, but
      * we cannot know for certain, it depends on whether the mdev vendor driver
      * stays in sync with the active working set of the guest driver.  Prevent
      * the x-balloon-allowed option unless this is minimally an mdev device.
@@ -2802,7 +2802,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     trace_vfio_mdev(vdev->vbasedev.name, is_mdev);
 
-    if (vdev->vbasedev.balloon_allowed && !is_mdev) {
+    if (vdev->vbasedev.ram_block_discard_allowed && !is_mdev) {
         error_setg(errp, "x-balloon-allowed only potentially compatible "
                    "with mdev devices");
         vfio_put_group(group);
@@ -3156,7 +3156,7 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
-                     vbasedev.balloon_allowed, false),
+                     vbasedev.ram_block_discard_allowed, false),
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
-- 
MST


