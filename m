Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA7BC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE1D2073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE1D2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGip5-0002BQ-Ck
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 07:33:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinT-0001H9-HF
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinR-0001yr-KT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGinP-0001wB-JC; Wed, 17 Apr 2019 07:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 132B781F1B;
	Wed, 17 Apr 2019 11:32:06 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-141.ams2.redhat.com [10.36.117.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44B6310027DF;
	Wed, 17 Apr 2019 11:32:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 13:31:43 +0200
Message-Id: <20190417113143.5551-3-david@redhat.com>
In-Reply-To: <20190417113143.5551-1-david@redhat.com>
References: <20190417113143.5551-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 17 Apr 2019 11:32:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/2] exec: Introduce qemu_maxrampagesize()
 and rename qemu_getrampagesize()
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417113143.rJpXgVXv-pHgVPbUza5ZitLrLRA8_OFnR5fvdi_cM7o@z>

Rename qemu_getrampagesize() to qemu_minrampagesize(). While at it,
properly rename find_max_supported_pagesize() to
find_min_backend_pagesize().

s390x is actually interested into the maximum ram pagesize, so
introduce and use qemu_maxrampagesize().

Add a TODO, indicating that looking at any mapped memory backends is not
100% correct in some cases.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_caps.c        |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  2 +-
 hw/vfio/spapr.c            |  2 +-
 include/exec/ram_addr.h    |  3 ++-
 target/ppc/kvm.c           |  2 +-
 6 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4eee..f9b834ef82 100644
--- a/exec.c
+++ b/exec.c
@@ -1687,7 +1687,7 @@ void ram_block_dump(Monitor *mon)
  * when we actually open and map them.  Iterate over the file
  * descriptors instead, and use qemu_fd_getpagesize().
  */
-static int find_max_supported_pagesize(Object *obj, void *opaque)
+static int find_min_backend_pagesize(Object *obj, void *opaque)
 {
     long *hpsize_min =3D opaque;
=20
@@ -1703,7 +1703,27 @@ static int find_max_supported_pagesize(Object *obj=
, void *opaque)
     return 0;
 }
=20
-long qemu_getrampagesize(void)
+static int find_max_backend_pagesize(Object *obj, void *opaque)
+{
+    long *hpsize_max =3D opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
+        HostMemoryBackend *backend =3D MEMORY_BACKEND(obj);
+        long hpsize =3D host_memory_backend_pagesize(backend);
+
+        if (host_memory_backend_is_mapped(backend) && (hpsize > *hpsize_=
max)) {
+            *hpsize_max =3D hpsize;
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * TODO: We assume right now that all mapped host memory backends are
+ * used as RAM, however some might be used for different purposes.
+ */
+long qemu_minrampagesize(void)
 {
     long hpsize =3D LONG_MAX;
     long mainrampagesize;
@@ -1723,7 +1743,7 @@ long qemu_getrampagesize(void)
      */
     memdev_root =3D object_resolve_path("/objects", NULL);
     if (memdev_root) {
-        object_child_foreach(memdev_root, find_max_supported_pagesize, &=
hpsize);
+        object_child_foreach(memdev_root, find_min_backend_pagesize, &hp=
size);
     }
     if (hpsize =3D=3D LONG_MAX) {
         /* No additional memory regions found =3D=3D> Report main RAM pa=
ge size */
@@ -1746,8 +1766,24 @@ long qemu_getrampagesize(void)
=20
     return hpsize;
 }
+
+long qemu_maxrampagesize(void)
+{
+    long pagesize =3D qemu_mempath_getpagesize(mem_path);
+    Object *memdev_root =3D object_resolve_path("/objects", NULL);
+
+    if (memdev_root) {
+        object_child_foreach(memdev_root, find_max_backend_pagesize,
+                             &pagesize);
+    }
+    return pagesize;
+}
 #else
-long qemu_getrampagesize(void)
+long qemu_minrampagesize(void)
+{
+    return getpagesize();
+}
+long qemu_maxrampagesize(void)
 {
     return getpagesize();
 }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index edc5ed0e0c..9b1c10baa6 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -347,7 +347,7 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineSta=
te *spapr,
         warn_report("Many guests require at least 64kiB hpt-max-page-siz=
e");
     }
=20
-    spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
+    spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
=20
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
@@ -609,7 +609,7 @@ static SpaprCapabilities default_caps_with_cpu(SpaprM=
achineState *spapr,
         uint8_t mps;
=20
         if (kvmppc_hpt_needs_host_contiguous_pages()) {
-            mps =3D ctz64(qemu_getrampagesize());
+            mps =3D ctz64(qemu_minrampagesize());
         } else {
             mps =3D 34; /* allow everything up to 16GiB, i.e. everything=
 */
         }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3be5679657..7e256d3d31 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -188,7 +188,7 @@ static void s390_memory_init(ram_addr_t mem_size)
      * Configure the maximum page size. As no memory devices were create=
d
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_getrampagesize(), &local_err);
+    s390_set_max_pagesize(qemu_maxrampagesize(), &local_err);
     if (local_err) {
         error_report_err(local_err);
         exit(EXIT_FAILURE);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 57fe758e54..96c0ad9d9b 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -148,7 +148,7 @@ int vfio_spapr_create_window(VFIOContainer *container=
,
     uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
     unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
-    long rampagesize =3D qemu_getrampagesize();
+    long rampagesize =3D qemu_minrampagesize();
=20
     /*
      * The host might not support the guest supported IOMMU page size,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9ecd911c3e..139ad79390 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -73,7 +73,8 @@ static inline unsigned long int ramblock_recv_bitmap_of=
fset(void *host_addr,
=20
 bool ramblock_is_pmem(RAMBlock *rb);
=20
-long qemu_getrampagesize(void);
+long qemu_minrampagesize(void);
+long qemu_maxrampagesize(void);
=20
 /**
  * qemu_ram_alloc_from_file,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2427c8ee13..59d92c4275 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2136,7 +2136,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
     /* Find the largest hardware supported page size that's less than
      * or equal to the (logical) backing page size of guest RAM */
     kvm_get_smmu_info(&info, &error_fatal);
-    rampagesize =3D qemu_getrampagesize();
+    rampagesize =3D qemu_minrampagesize();
     best_page_shift =3D 0;
=20
     for (i =3D 0; i < KVM_PPC_PAGE_SIZES_MAX_SZ; i++) {
--=20
2.20.1


