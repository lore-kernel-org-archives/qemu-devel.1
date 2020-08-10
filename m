Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6969722D72
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6969722D72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B8Y-0005ua-6u
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B53-00074X-Cd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B50-0000tn-Ug
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:25 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-QTaOuewSOO2MZ5k5NF254A-1; Mon, 10 Aug 2020 12:55:18 -0400
X-MC-Unique: QTaOuewSOO2MZ5k5NF254A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DEA78005B0;
 Mon, 10 Aug 2020 16:55:17 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4692A6111F;
 Mon, 10 Aug 2020 16:55:16 +0000 (UTC)
Subject: [PATCH 12/14] spapr/xive: Simplify error handling in
 kvmppc_xive_connect()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:55:15 +0200
Message-ID: <159707851537.1489912.1030839306195472651.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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

Now that all these functions return a negative errno on failure, check
that and get rid of the local_err boilerplate.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 005729ebffed..e9a36115bed6 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -723,12 +723,12 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
     XiveSource *xsrc =3D &xive->source;
-    Error *local_err =3D NULL;
     size_t esb_len =3D xive_source_esb_len(xsrc);
     size_t tima_len =3D 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
     void *addr;
+    int ret;
=20
     /*
      * The KVM XIVE device already in use. This is the case when
@@ -754,9 +754,10 @@ int kvmppc_xive_connect(SpaprInterruptController *intc=
, uint32_t nr_servers,
     /* Tell KVM about the # of VCPUs we may have */
     if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
                               KVM_DEV_XIVE_NR_SERVERS)) {
-        if (kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
-                              KVM_DEV_XIVE_NR_SERVERS, &nr_servers, true,
-                              &local_err)) {
+        ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                                KVM_DEV_XIVE_NR_SERVERS, &nr_servers, true=
,
+                                errp);
+        if (ret < 0) {
             goto fail;
         }
     }
@@ -764,8 +765,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     /*
      * 1. Source ESB pages - KVM mapping
      */
-    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
-                            &local_err);
+    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len, err=
p);
     if (addr =3D=3D MAP_FAILED) {
         goto fail;
     }
@@ -783,8 +783,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     /*
      * 3. TIMA pages - KVM mapping
      */
-    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
-                            &local_err);
+    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len, e=
rrp);
     if (addr =3D=3D MAP_FAILED) {
         goto fail;
     }
@@ -802,15 +801,15 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
-        if (local_err) {
+        ret =3D kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, errp);
+        if (ret < 0) {
             goto fail;
         }
     }
=20
     /* Update the KVM sources */
-    kvmppc_xive_source_reset(xsrc, &local_err);
-    if (local_err) {
+    ret =3D kvmppc_xive_source_reset(xsrc, errp);
+    if (ret < 0) {
         goto fail;
     }
=20
@@ -820,7 +819,6 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     return 0;
=20
 fail:
-    error_propagate(errp, local_err);
     kvmppc_xive_disconnect(intc);
     return -1;
 }



