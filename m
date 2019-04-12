Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92086C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186142171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186142171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtCa-0001xf-W9
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:14:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt4T-0002P2-QH
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt4S-0004si-PW
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt4N-0004mP-LD; Fri, 12 Apr 2019 06:06:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4665AC057F47;
	Fri, 12 Apr 2019 10:06:01 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC02819C65;
	Fri, 12 Apr 2019 10:05:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:45 +0200
Message-Id: <20190412100354.6409-19-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 12 Apr 2019 10:06:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 18/27] hw/vfio/common: Introduce
 hostwin_from_range helper
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
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100345.xtI82ltkVtmIs1isbC9sr1Jz2AONoDXeSQRvIDiuQ9A@z>

Let's introduce a hostwin_from_range() helper that returns the
hostwin encapsulating an IOVA range or NULL if non is found.

This improves the readibility of callers and removes the usage
of hostwin_found.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cf876d5264..785d9c191c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -494,6 +494,19 @@ static VFIOGuestIOMMU *vfio_alloc_guest_iommu(VFIOCo=
ntainer *container,
     return giommu;
 }
=20
+static VFIOHostDMAWindow *
+hostwin_from_range(VFIOContainer *container, hwaddr iova, hwaddr end)
+{
+    VFIOHostDMAWindow *hostwin;
+
+    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+        if (hostwin->min_iova <=3D iova && end <=3D hostwin->max_iova) {
+            return hostwin;
+        }
+    }
+    return NULL;
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -503,7 +516,6 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
     void *vaddr;
     int ret;
     VFIOHostDMAWindow *hostwin;
-    bool hostwin_found;
=20
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_add_skip(
@@ -580,15 +592,8 @@ static void vfio_listener_region_add(MemoryListener =
*listener,
 #endif
     }
=20
-    hostwin_found =3D false;
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-        if (hostwin->min_iova <=3D iova && end <=3D hostwin->max_iova) {
-            hostwin_found =3D true;
-            break;
-        }
-    }
-
-    if (!hostwin_found) {
+    hostwin =3D hostwin_from_range(container, iova, end);
+    if (!hostwin) {
         error_report("vfio: IOMMU container %p can't map guest IOVA regi=
on"
                      " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx,
                      container, iova, end);
@@ -759,16 +764,10 @@ static void vfio_listener_region_del(MemoryListener=
 *listener,
=20
     if (memory_region_is_ram_device(section->mr)) {
         hwaddr pgmask;
-        VFIOHostDMAWindow *hostwin;
-        bool hostwin_found =3D false;
+        VFIOHostDMAWindow *hostwin =3D
+            hostwin_from_range(container, iova, end);
=20
-        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-            if (hostwin->min_iova <=3D iova && end <=3D hostwin->max_iov=
a) {
-                hostwin_found =3D true;
-                break;
-            }
-        }
-        assert(hostwin_found); /* or region_add() would have failed */
+        assert(hostwin); /* or region_add() would have failed */
=20
         pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
         try_unmap =3D !((iova & pgmask) || (int128_get64(llsize) & pgmas=
k));
--=20
2.20.1


