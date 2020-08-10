Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E2E22B47
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E2E22B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B5W-0007Ty-UN
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B49-0005YH-Os
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34670
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B48-0000iR-3n
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:29 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-1eOYZTHxNnyVaKWenPKo_A-1; Mon, 10 Aug 2020 12:54:22 -0400
X-MC-Unique: 1eOYZTHxNnyVaKWenPKo_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68BA5106B249;
 Mon, 10 Aug 2020 16:54:21 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 919C02DE64;
 Mon, 10 Aug 2020 16:54:20 +0000 (UTC)
Subject: [PATCH 04/14] spapr/xive: Rework error handling of kvmppc_xive_mmap()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:54:19 +0200
Message-ID: <159707845972.1489912.719896767746375765.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Callers currently check failures of kvmppc_xive_mmap() through the
@errp argument, which isn't a recommanded practice. It is preferred
to use a return value when possible.

Since NULL isn't an invalid address in theory, it seems better to
return MAP_FAILED and to teach callers to handle it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index d801bf5cd11c..b2a36fd59dae 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -698,6 +698,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_=
id)
     return 0;
 }
=20
+/* Returns MAP_FAILED on error and sets errno */
 static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
                               Error **errp)
 {
@@ -708,7 +709,6 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pgof=
f, size_t len,
                 pgoff << page_shift);
     if (addr =3D=3D MAP_FAILED) {
         error_setg_errno(errp, errno, "XIVE: unable to set memory mapping"=
);
-        return NULL;
     }
=20
     return addr;
@@ -728,6 +728,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     size_t tima_len =3D 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
+    void *addr;
=20
     /*
      * The KVM XIVE device already in use. This is the case when
@@ -763,11 +764,12 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
     /*
      * 1. Source ESB pages - KVM mapping
      */
-    xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, es=
b_len,
-                                      &local_err);
-    if (local_err) {
+    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
+                            &local_err);
+    if (addr =3D=3D MAP_FAILED) {
         goto fail;
     }
+    xsrc->esb_mmap =3D addr;
=20
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
                                       "xive.esb-kvm", esb_len, xsrc->esb_m=
map);
@@ -781,11 +783,13 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
     /*
      * 3. TIMA pages - KVM mapping
      */
-    xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, ti=
ma_len,
-                                     &local_err);
-    if (local_err) {
+    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
+                            &local_err);
+    if (addr =3D=3D MAP_FAILED) {
         goto fail;
     }
+    xive->tm_mmap =3D addr;
+
     memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
                                       "xive.tima", tima_len, xive->tm_mmap=
);
     memory_region_add_subregion_overlap(&xive->tm_mmio, 0,



