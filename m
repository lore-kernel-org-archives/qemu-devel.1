Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8C6C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B247D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B247D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfIf7-0001eo-1Z
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hfIc5-0007YE-8Z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hfIc3-0004j4-Hg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hfIc3-0004cb-B3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC15F85A07;
 Mon, 24 Jun 2019 06:37:54 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DBBE608E4;
 Mon, 24 Jun 2019 06:37:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 14:37:32 +0800
Message-Id: <20190624063733.22079-2-peterx@redhat.com>
In-Reply-To: <20190624063733.22079-1-peterx@redhat.com>
References: <20190624063733.22079-1-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 24 Jun 2019 06:37:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] intel_iommu: Fix incorrect "end" for
 vtd_address_space_unmap
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
 Auger Eric <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yan Zhao <yan.y.zhao@intel.com>

IOMMUNotifier is with inclusive ranges, so we should check
against (VTD_ADDRESS_SIZE(s->aw_bits) - 1).

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[peterx: split from another bigger patch]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 44b1231157..719ce19ab3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3379,12 +3379,12 @@ static void vtd_address_space_unmap(VTDAddressSpa=
ce *as, IOMMUNotifier *n)
      * VT-d spec), otherwise we need to consider overflow of 64 bits.
      */
=20
-    if (end > VTD_ADDRESS_SIZE(s->aw_bits)) {
+    if (end > VTD_ADDRESS_SIZE(s->aw_bits) - 1) {
         /*
          * Don't need to unmap regions that is bigger than the whole
          * VT-d supported address space size
          */
-        end =3D VTD_ADDRESS_SIZE(s->aw_bits);
+        end =3D VTD_ADDRESS_SIZE(s->aw_bits) - 1;
     }
=20
     assert(start <=3D end);
--=20
2.21.0


