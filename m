Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15990C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB6620786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB6620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Lhs-0002T6-7F
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0Lgo-0001cy-JP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:14:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0Lgk-0007eY-Ct
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:14:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-OXq25s6EMK2cdfmb7XeBKA-1; Tue, 28 Jul 2020 05:14:17 -0400
X-MC-Unique: OXq25s6EMK2cdfmb7XeBKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC51C79EC1;
 Tue, 28 Jul 2020 09:14:15 +0000 (UTC)
Received: from bahia.lan (ovpn-114-208.ams2.redhat.com [10.36.114.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10DC15C1BD;
 Tue, 28 Jul 2020 09:14:14 +0000 (UTC)
Subject: [PATCH for-5.2] spapr: Avoid some integer conversions in
 spapr_phb_realize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 28 Jul 2020 11:14:13 +0200
Message-ID: <159592765385.99837.12059368746532345109.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
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
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this patch, the irq number gets converted uselessly from int
to int32_t, back and forth.

This doesn't fix an actual issue, it's just to make the code neater.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This is a follow-up to my previous "spapr: Simplify error handling in
spapr_phb_realize()" patch. Maybe worth squashing it there ?
---
 hw/ppc/spapr_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 59441e2117f3..0a418f1e6711 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1964,7 +1964,7 @@ static void spapr_phb_realize(DeviceState *dev, Error=
 **errp)
=20
     /* Initialize the LSI table */
     for (i =3D 0; i < PCI_NUM_PINS; i++) {
-        int32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i=
;
+        int irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
=20
         if (smc->legacy_irq_allocation) {
             irq =3D spapr_irq_findone(spapr, errp);



