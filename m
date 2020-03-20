Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABBC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A840920724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eILTEfdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A840920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFL8s-0002A3-ON
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL1U-0005zk-Hp
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL1S-00064t-Js
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:01:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52283)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL1S-000602-Dz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byzUJiS9ybFm6Zi718D15WsPDKGzETbRUksymqF2wWg=;
 b=eILTEfdPZ3ClkoX/L/DOExX5sla3ng4R3Tk3vF3ySsQFqwqEdHaNNVT8/cLpgtMsatN3Ck
 dcEf0uJ96u7/AKCPasB0ZY0rJa2pPwIdRD/gHfdSnZrWJJQCetSXhNRIxz5TspJic9r/Wy
 sNeUHwz8kLVfa/X6S8zcrQpqcpG0XHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450--E8lsZbgOx-7My4UjCfYBA-1; Fri, 20 Mar 2020 13:01:22 -0400
X-MC-Unique: -E8lsZbgOx-7My4UjCfYBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8234DBDB;
 Fri, 20 Mar 2020 17:01:19 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 653AA1C955;
 Fri, 20 Mar 2020 17:00:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 11/24] vfio: Introduce helpers to DMA map/unmap a RAM section
Date: Fri, 20 Mar 2020 17:58:27 +0100
Message-Id: <20200320165840.30057-12-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's introduce two helpers that allow to DMA map/unmap a RAM
section. Those helpers will be called for nested stage setup in
another call site. Also the vfio_listener_region_add/del()
structure may be clearer.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6:
- add Error **
---
 hw/vfio/common.c     | 177 ++++++++++++++++++++++++++-----------------
 hw/vfio/trace-events |   4 +-
 2 files changed, 108 insertions(+), 73 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f20b37fbee..e067009da8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -512,13 +512,115 @@ hostwin_from_range(VFIOContainer *container, hwaddr =
iova, hwaddr end)
     return NULL;
 }
=20
+static int vfio_dma_map_ram_section(VFIOContainer *container,
+                                    MemoryRegionSection *section, Error **=
err)
+{
+    VFIOHostDMAWindow *hostwin;
+    Int128 llend, llsize;
+    hwaddr iova, end;
+    void *vaddr;
+    int ret;
+
+    assert(memory_region_is_ram(section->mr));
+
+    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    llend =3D int128_make64(section->offset_within_address_space);
+    llend =3D int128_add(llend, section->size);
+    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+    end =3D int128_get64(int128_sub(llend, int128_one()));
+
+    vaddr =3D memory_region_get_ram_ptr(section->mr) +
+            section->offset_within_region +
+            (iova - section->offset_within_address_space);
+
+    hostwin =3D hostwin_from_range(container, iova, end);
+    if (!hostwin) {
+        error_setg(err, "Container %p can't map guest IOVA region"
+                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, e=
nd);
+        return -EFAULT;
+    }
+
+    trace_vfio_dma_map_ram(iova, end, vaddr);
+
+    llsize =3D int128_sub(llend, int128_make64(iova));
+
+    if (memory_region_is_ram_device(section->mr)) {
+        hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
+
+        if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
+            trace_vfio_listener_region_add_no_dma_map(
+                memory_region_name(section->mr),
+                section->offset_within_address_space,
+                int128_getlo(section->size),
+                pgmask + 1);
+            return 0;
+        }
+    }
+
+    ret =3D vfio_dma_map(container, iova, int128_get64(llsize),
+                       vaddr, section->readonly);
+    if (ret) {
+        error_setg(err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+                   "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
+                   container, iova, int128_get64(llsize), vaddr, ret);
+        if (memory_region_is_ram_device(section->mr)) {
+            /* Allow unexpected mappings not to be fatal for RAM devices *=
/
+            error_report_err(*err);
+            return 0;
+        }
+        return ret;
+    }
+    return 0;
+}
+
+static void vfio_dma_unmap_ram_section(VFIOContainer *container,
+                                       MemoryRegionSection *section)
+{
+    Int128 llend, llsize;
+    hwaddr iova, end;
+    bool try_unmap =3D true;
+    int ret;
+
+    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    llend =3D int128_make64(section->offset_within_address_space);
+    llend =3D int128_add(llend, section->size);
+    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+
+    if (int128_ge(int128_make64(iova), llend)) {
+        return;
+    }
+    end =3D int128_get64(int128_sub(llend, int128_one()));
+
+    llsize =3D int128_sub(llend, int128_make64(iova));
+
+    trace_vfio_dma_unmap_ram(iova, end);
+
+    if (memory_region_is_ram_device(section->mr)) {
+        hwaddr pgmask;
+        VFIOHostDMAWindow *hostwin =3D hostwin_from_range(container, iova,=
 end);
+
+        assert(hostwin); /* or region_add() would have failed */
+
+        pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
+        try_unmap =3D !((iova & pgmask) || (int128_get64(llsize) & pgmask)=
);
+    }
+
+    if (try_unmap) {
+        ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize));
+        if (ret) {
+            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                         "0x%"HWADDR_PRIx") =3D %d (%m)",
+                         container, iova, int128_get64(llsize), ret);
+        }
+    }
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
     VFIOContainer *container =3D container_of(listener, VFIOContainer, lis=
tener);
     hwaddr iova, end;
-    Int128 llend, llsize;
-    void *vaddr;
+    Int128 llend;
     int ret;
     VFIOHostDMAWindow *hostwin;
     Error *err =3D NULL;
@@ -655,39 +757,7 @@ static void vfio_listener_region_add(MemoryListener *l=
istener,
     }
=20
     /* Here we assume that memory_region_is_ram(section->mr)=3D=3Dtrue */
-
-    vaddr =3D memory_region_get_ram_ptr(section->mr) +
-            section->offset_within_region +
-            (iova - section->offset_within_address_space);
-
-    trace_vfio_listener_region_add_ram(iova, end, vaddr);
-
-    llsize =3D int128_sub(llend, int128_make64(iova));
-
-    if (memory_region_is_ram_device(section->mr)) {
-        hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
-
-        if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
-            trace_vfio_listener_region_add_no_dma_map(
-                memory_region_name(section->mr),
-                section->offset_within_address_space,
-                int128_getlo(section->size),
-                pgmask + 1);
-            return;
-        }
-    }
-
-    ret =3D vfio_dma_map(container, iova, int128_get64(llsize),
-                       vaddr, section->readonly);
-    if (ret) {
-        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
-                   "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
-                   container, iova, int128_get64(llsize), vaddr, ret);
-        if (memory_region_is_ram_device(section->mr)) {
-            /* Allow unexpected mappings not to be fatal for RAM devices *=
/
-            error_report_err(err);
-            return;
-        }
+    if (vfio_dma_map_ram_section(container, section, &err)) {
         goto fail;
     }
=20
@@ -721,10 +791,6 @@ static void vfio_listener_region_del(MemoryListener *l=
istener,
                                      MemoryRegionSection *section)
 {
     VFIOContainer *container =3D container_of(listener, VFIOContainer, lis=
tener);
-    hwaddr iova, end;
-    Int128 llend, llsize;
-    int ret;
-    bool try_unmap =3D true;
=20
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_del_skip(
@@ -763,38 +829,7 @@ static void vfio_listener_region_del(MemoryListener *l=
istener,
          */
     }
=20
-    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend =3D int128_make64(section->offset_within_address_space);
-    llend =3D int128_add(llend, section->size);
-    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
-
-    if (int128_ge(int128_make64(iova), llend)) {
-        return;
-    }
-    end =3D int128_get64(int128_sub(llend, int128_one()));
-
-    llsize =3D int128_sub(llend, int128_make64(iova));
-
-    trace_vfio_listener_region_del(iova, end);
-
-    if (memory_region_is_ram_device(section->mr)) {
-        hwaddr pgmask;
-        VFIOHostDMAWindow *hostwin =3D hostwin_from_range(container, iova,=
 end);
-
-        assert(hostwin); /* or region_add() would have failed */
-
-        pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
-        try_unmap =3D !((iova & pgmask) || (int128_get64(llsize) & pgmask)=
);
-    }
-
-    if (try_unmap) {
-        ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize));
-        if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                         "0x%"HWADDR_PRIx") =3D %d (%m)",
-                         container, iova, int128_get64(llsize), ret);
-        }
-    }
+    vfio_dma_unmap_ram_section(container, section);
=20
     memory_region_unref(section->mr);
=20
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33f..410801de6e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -97,10 +97,10 @@ vfio_iommu_map_notify(const char *op, uint64_t iova_sta=
rt, uint64_t iova_end) "i
 vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING regi=
on_add 0x%"PRIx64" - 0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to =
liobn fd %d"
 vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [=
iommu] 0x%"PRIx64" - 0x%"PRIx64
-vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void =
*vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
+vfio_dma_map_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "reg=
ion_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint6=
4_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=3D0x%"PRIx64"=
 is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
 vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING regi=
on_del 0x%"PRIx64" - 0x%"PRIx64
-vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRI=
x64" - 0x%"PRIx64
+vfio_dma_unmap_ram(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" -=
 0x%"PRIx64
 vfio_disconnect_container(int fd) "close container->fd=3D%d"
 vfio_put_group(int fd) "close group->fd=3D%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_re=
gions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
--=20
2.20.1


