Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CE020838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CE020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BD6-0003U1-QJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4a-0006KQ-PX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4Z-0000lW-4h
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:56 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222--vVCfanuPgqVF4GDBI32Xw-1; Mon, 10 Aug 2020 12:54:50 -0400
X-MC-Unique: -vVCfanuPgqVF4GDBI32Xw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51F668005B0;
 Mon, 10 Aug 2020 16:54:49 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CDF31001901;
 Mon, 10 Aug 2020 16:54:48 +0000 (UTC)
Subject: [PATCH 08/14] spapr/xive: Rework error handling of
 kvmppc_xive_set_source_config()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:54:47 +0200
Message-ID: <159707848764.1489912.17078842252160674523.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Since kvm_device_access() returns a negative errno on failure, convert
kvmppc_xive_set_source_config() to use it for error checking. This allows
to get rid of the local_err boilerplate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c    |   13 ++++---------
 include/hw/ppc/spapr_xive.h |    4 ++--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 4142aaffff47..f2dda692183b 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -186,8 +186,8 @@ int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **err=
p)
  * XIVE Interrupt Source (KVM)
  */
=20
-void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS=
 *eas,
-                                   Error **errp)
+int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS =
*eas,
+                                  Error **errp)
 {
     uint32_t end_idx;
     uint32_t end_blk;
@@ -196,7 +196,6 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uin=
t32_t lisn, XiveEAS *eas,
     bool masked;
     uint32_t eisn;
     uint64_t kvm_src;
-    Error *local_err =3D NULL;
=20
     assert(xive_eas_is_valid(eas));
=20
@@ -216,12 +215,8 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, ui=
nt32_t lisn, XiveEAS *eas,
     kvm_src |=3D ((uint64_t)eisn << KVM_XIVE_SOURCE_EISN_SHIFT) &
         KVM_XIVE_SOURCE_EISN_MASK;
=20
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
-                      &kvm_src, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lis=
n,
+                             &kvm_src, true, errp);
 }
=20
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index d0a08b618f79..0ffbe0be0280 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -80,8 +80,8 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, u=
int32_t nr_servers,
                         Error **errp);
 void kvmppc_xive_disconnect(SpaprInterruptController *intc);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
-void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS=
 *eas,
-                                   Error **errp);
+int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS =
*eas,
+                                  Error **errp);
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)=
;
 uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
                             uint64_t data, bool write);



