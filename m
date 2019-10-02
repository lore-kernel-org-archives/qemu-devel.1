Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04EC10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C2F2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyVXZ6kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C2F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi8y-0000ee-Q3
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrR-0005aR-NX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrQ-0003XS-Ej
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrQ-0003Wc-6w
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so7696719wml.4
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=i9c6AFc6vOgw/CCh7etmxchVWi89c6GZaBeygIRrOxc=;
 b=dyVXZ6kd2FLmBsK0kElBVkW9xEW8f7ZebXRO+L05ZiA4qwNrun2jojlNmXRVY3wzZn
 lZMylbdUluFe4PIHJ4dlbVQClWyae0yokITMKS6UTzK1y1CvBCyBZ0x2BQQingnaehvG
 sWNSOON3ju1PRydHpzX63vLUPM/htirqktPVErYXPDUDN/xlDVl3keSx7MXowhuRxeq+
 3R0ndJ+9a1lCimTw2G4cASsG4NfuuriNECIzwGhVLXajOhZnetfjjoI4mMcKlRBBGVmq
 kbMI4MdAx2AlJVtub5ljGCiEPQWj61tVABOMxGEsfIe+qk1x517rN5lfTdZnzqQIf1IE
 JRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=i9c6AFc6vOgw/CCh7etmxchVWi89c6GZaBeygIRrOxc=;
 b=VYTPRDn0jPrLjmcKxqBsGNYM7BHQIAGXRlseF+jkYv6bJ9fagZDMBjBpju7Jgec9GS
 CK2NXlGcbIL7i2xpq7+YqIP6e+cAljDf7nkjl4fUxZCieZJxYQtsJNe/fmv2n+cG/Rba
 mhHAISEl8et7N4sWDjfHQkGv01b7U2/tPSTZXLkdj6buLSIHRMd198nW2u2W6sVjd5nQ
 MWyrQpY9QMzgvfgJuVp2vimxcWUqViyg3K71aMdW6LmuNbGHSjXkH28cLFO1lGgOuelV
 3bI1Tz1DYrkF+1RPuL3mm+NwXqWlHO3N+WimxNJbYObI8pivsXRVqRqI3uorFAB8k5lp
 vgkw==
X-Gm-Message-State: APjAAAWmSG3KmNySc0MS7F+2MaujRzW8CuqPO88Yu86wKoWF26FSWaIx
 NMFVL3zylzaa2TKlbqEds/stmCwA
X-Google-Smtp-Source: APXvYqw66NKewjZoS03fTw5xubrUIwdweWFkbdHtjV2artDwblzplZPcnSSh0zCiFBJEvAPraMLxUg==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3520602wmg.33.1570035138662; 
 Wed, 02 Oct 2019 09:52:18 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/30] vfio: Turn the container error into an Error handle
Date: Wed,  2 Oct 2019 18:51:46 +0200
Message-Id: <1570035113-56848-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

The container error integer field is currently used to store
the first error potentially encountered during any
vfio_listener_region_add() call. However this fails to propagate
detailed error messages up to the vfio_connect_container caller.
Instead of using an integer, let's use an Error handle.

Messages are slightly reworded to accomodate the propagation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/common.c              | 43 ++++++++++++++++++++++++++++---------------
 hw/vfio/spapr.c               |  4 +++-
 include/hw/vfio/vfio-common.h |  2 +-
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3e03c49..cebbb1c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -509,6 +509,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     int ret;
     VFIOHostDMAWindow *hostwin;
     bool hostwin_found;
+    Error *err = NULL;
 
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_add_skip(
@@ -543,13 +544,20 @@ static void vfio_listener_region_add(MemoryListener *listener,
                                hostwin->max_iova - hostwin->min_iova + 1,
                                section->offset_within_address_space,
                                int128_get64(section->size))) {
-                ret = -1;
+                error_setg(&err,
+                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
+                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
+                    section->offset_within_address_space,
+                    section->offset_within_address_space +
+                        int128_get64(section->size) - 1,
+                    hostwin->min_iova, hostwin->max_iova);
                 goto fail;
             }
         }
 
         ret = vfio_spapr_create_window(container, section, &pgsize);
         if (ret) {
+            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
             goto fail;
         }
 
@@ -594,10 +602,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     if (!hostwin_found) {
-        error_report("vfio: IOMMU container %p can't map guest IOVA region"
-                     " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx,
-                     container, iova, end);
-        ret = -EFAULT;
+        error_setg(&err, "Container %p can't map guest IOVA region"
+                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
         goto fail;
     }
 
@@ -664,11 +670,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
     ret = vfio_dma_map(container, iova, int128_get64(llsize),
                        vaddr, section->readonly);
     if (ret) {
-        error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
-                     "0x%"HWADDR_PRIx", %p) = %d (%m)",
-                     container, iova, int128_get64(llsize), vaddr, ret);
+        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+                   "0x%"HWADDR_PRIx", %p) = %d (%m)",
+                   container, iova, int128_get64(llsize), vaddr, ret);
         if (memory_region_is_ram_device(section->mr)) {
             /* Allow unexpected mappings not to be fatal for RAM devices */
+            error_report_err(err);
             return;
         }
         goto fail;
@@ -688,9 +695,14 @@ fail:
      */
     if (!container->initialized) {
         if (!container->error) {
-            container->error = ret;
+            error_propagate_prepend(&container->error, err,
+                                    "Region %s: ",
+                                    memory_region_name(section->mr));
+        } else {
+            error_free(err);
         }
     } else {
+        error_report_err(err);
         hw_error("vfio: DMA mapping failed, unable to continue");
     }
 }
@@ -1251,6 +1263,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->space = space;
     container->fd = fd;
+    container->error = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
 
@@ -1308,9 +1321,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                      &address_space_memory);
             if (container->error) {
                 memory_listener_unregister(&container->prereg_listener);
-                ret = container->error;
-                error_setg(errp,
-                    "RAM memory listener initialization failed for container");
+                ret = -1;
+                error_propagate_prepend(errp, container->error,
+                    "RAM memory listener initialization failed: ");
                 goto free_container_exit;
             }
         }
@@ -1365,9 +1378,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     memory_listener_register(&container->listener, container->space->as);
 
     if (container->error) {
-        ret = container->error;
-        error_setg_errno(errp, -ret,
-                         "memory listener initialization failed for container");
+        ret = -1;
+        error_propagate_prepend(errp, container->error,
+            "memory listener initialization failed: ");
         goto listener_release_exit;
     }
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 96c0ad9..e853eeb 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
@@ -85,7 +86,8 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
          */
         if (!container->initialized) {
             if (!container->error) {
-                container->error = ret;
+                error_setg_errno(&container->error, -ret,
+                                 "Memory registering failed");
             }
         } else {
             hw_error("vfio: Memory registering failed, unable to continue");
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9107bd4..fd56420 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -71,7 +71,7 @@ typedef struct VFIOContainer {
     MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    int error;
+    Error *error;
     bool initialized;
     unsigned long pgsizes;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
-- 
1.8.3.1



