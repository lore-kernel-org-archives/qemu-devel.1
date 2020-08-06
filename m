Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6253BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14CC2086A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14CC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3jCk-0002AZ-Bv
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 12:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3jBm-0000YG-WC
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:56:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3jBl-00075i-Jg
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:56:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-R_HECKsNOGydOJ88y0zoAg-1; Thu, 06 Aug 2020 12:56:08 -0400
X-MC-Unique: R_HECKsNOGydOJ88y0zoAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57091DE5;
 Thu,  6 Aug 2020 16:56:07 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B865C5F9DC;
 Thu,  6 Aug 2020 16:56:06 +0000 (UTC)
Subject: [PATCH v2 for-5.2 1/5] spapr/xive: Fix xive->fd if
 kvm_create_device() fails
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 06 Aug 2020 18:56:05 +0200
Message-ID: <159673296585.766512.15404407281299745442.stgit@bahia.lan>
In-Reply-To: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
References: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
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

If the creation of the KVM XIVE device fails for some reasons, the
negative errno ends up in xive->fd, but the rest of the code assumes
that xive->fd either contains an open fd, ie. positive value, or -1.

This doesn't cause any misbehavior except kvmppc_xive_disconnect()
that will try to close(xive->fd) during rollback and likely be
rewarded with an EBADF.

Only set xive->fd with a open fd.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: Already applied to ppc-for-5.2 but not yet visible on github
---
 hw/intc/spapr_xive_kvm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index edb7ee0e74f1..d55ea4670e0e 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -745,6 +745,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
     size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
     size_t tima_len =3D 4ull << TM_SHIFT;
     CPUState *cs;
+    int fd;
=20
     /*
      * The KVM XIVE device already in use. This is the case when
@@ -760,11 +761,12 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
     }
=20
     /* First, create the KVM XIVE device */
-    xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
-    if (xive->fd < 0) {
-        error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM device=
");
+    fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
+    if (fd < 0) {
+        error_setg_errno(errp, -fd, "XIVE: error creating KVM device");
         return -1;
     }
+    xive->fd =3D fd;
=20
     /* Tell KVM about the # of VCPUs we may have */
     if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,



