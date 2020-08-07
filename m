Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26A3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7963F21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7963F21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40ch-000623-C3
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k40bj-0004Ra-Vo
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:32:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k40bg-0000wm-Tc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:32:19 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-SM8HD-pAMAKQXHRO0FOeoQ-1; Fri, 07 Aug 2020 07:32:10 -0400
X-MC-Unique: SM8HD-pAMAKQXHRO0FOeoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 287EA8005B0;
 Fri,  7 Aug 2020 11:32:09 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8DEE60CD0;
 Fri,  7 Aug 2020 11:32:07 +0000 (UTC)
Subject: [PATCH v3 for-5.2 1/3] ppc/xive: Rework setup of XiveSource::esb_mmio
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 07 Aug 2020 13:32:06 +0200
Message-ID: <159679992680.876294.7520540158586170894.stgit@bahia.lan>
In-Reply-To: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Depending on whether XIVE is emultated or backed with a KVM XIVE device,
the ESB MMIOs of a XIVE source point to an I/O memory region or a mapped
memory region.

This is currently handled by checking kvm_irqchip_in_kernel() returns
false in xive_source_realize(). This is a bit awkward as we usually
need to do extra things when we're using the in-kernel backend, not
less. But most important, we can do better: turn the existing "xive.esb"
memory region into a plain container, introduce an "xive.esb-emulated"
I/O subregion and rename the existing "xive.esb" subregion in the KVM
code to "xive.esb-kvm". Since "xive.esb-kvm" is added with overlap
and a higher priority, it prevails over "xive.esb-emulated" (ie.
a guest using KVM XIVE will interact with "xive.esb-kvm" instead of
the default "xive.esb-emulated" region.

While here, consolidate the computation of the MMIO region size in
a common helper.

Suggested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |    4 ++--
 hw/intc/xive.c           |   11 ++++++-----
 include/hw/ppc/xive.h    |    6 ++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 893a1ee77e70..6130882be678 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -742,7 +742,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     SpaprXive *xive =3D SPAPR_XIVE(intc);
     XiveSource *xsrc =3D &xive->source;
     Error *local_err =3D NULL;
-    size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+    size_t esb_len =3D xive_source_esb_len(xsrc);
     size_t tima_len =3D 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
@@ -788,7 +788,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     }
=20
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
-                                      "xive.esb", esb_len, xsrc->esb_mmap)=
;
+                                      "xive.esb-kvm", esb_len, xsrc->esb_m=
map);
     memory_region_add_subregion_overlap(&xsrc->esb_mmio, 0,
                                         &xsrc->esb_mmio_kvm, 1);
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9b55e0356c62..561d746cd1da 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1128,6 +1128,7 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
+    size_t esb_len =3D xive_source_esb_len(xsrc);
=20
     assert(xsrc->xive);
=20
@@ -1147,11 +1148,11 @@ static void xive_source_realize(DeviceState *dev, E=
rror **errp)
     xsrc->status =3D g_malloc0(xsrc->nr_irqs);
     xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
=20
-    if (!kvm_irqchip_in_kernel()) {
-        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
-                              &xive_source_esb_ops, xsrc, "xive.esb",
-                              (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
-    }
+    memory_region_init(&xsrc->esb_mmio, OBJECT(xsrc), "xive.esb", esb_len)=
;
+    memory_region_init_io(&xsrc->esb_mmio_emulated, OBJECT(xsrc),
+                          &xive_source_esb_ops, xsrc, "xive.esb-emulated",
+                          esb_len);
+    memory_region_add_subregion(&xsrc->esb_mmio, 0, &xsrc->esb_mmio_emulat=
ed);
=20
     qemu_register_reset(xive_source_reset, dev);
 }
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 705cf48176fc..82a61eaca74f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -191,6 +191,7 @@ typedef struct XiveSource {
     uint64_t        esb_flags;
     uint32_t        esb_shift;
     MemoryRegion    esb_mmio;
+    MemoryRegion    esb_mmio_emulated;
=20
     /* KVM support */
     void            *esb_mmap;
@@ -215,6 +216,11 @@ static inline bool xive_source_esb_has_2page(XiveSourc=
e *xsrc)
         xsrc->esb_shift =3D=3D XIVE_ESB_4K_2PAGE;
 }
=20
+static inline size_t xive_source_esb_len(XiveSource *xsrc)
+{
+    return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+}
+
 /* The trigger page is always the first/even page */
 static inline hwaddr xive_source_esb_page(XiveSource *xsrc, uint32_t srcno=
)
 {



