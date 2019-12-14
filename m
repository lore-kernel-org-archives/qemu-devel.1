Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44AC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1261C20866
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL7imkA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1261C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEd4-0008E4-8H
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEWI-0000Te-I9
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEWH-0001qp-4Q
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEWG-0001nZ-IQ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SlorlqSNo6p31H7HgBYKxDoBhr5Y5T4+whsDnKxCwo=;
 b=UL7imkA/BKwGRVDgJT5IiD8P0Y9c1twCKg4fi/XlPKlqwGun78/+sw8+i21+mJBwHfYQmG
 wdsVS32BRw69tThNncfZDsvWxc4TjdebRlIrrR5Ar4cSzErynzhg26Jp1IJWOfvVU8OHCb
 I6VlBmczFRegk1dQmJ1Qbi/Euuheu9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-uNUZ_QilNLChRElt76KaAQ-1; Sat, 14 Dec 2019 10:57:34 -0500
X-MC-Unique: uNUZ_QilNLChRElt76KaAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F701852E2A;
 Sat, 14 Dec 2019 15:57:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0764F5D6A7;
 Sat, 14 Dec 2019 15:57:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] hw/i386/intel_iommu: Use memory_region_add_subregion when
 priority is 0
Date: Sat, 14 Dec 2019 16:56:10 +0100
Message-Id: <20191214155614.19004-5-philmd@redhat.com>
In-Reply-To: <20191214155614.19004-1-philmd@redhat.com>
References: <20191214155614.19004-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to overlap a memory subregion with priority 0.
Use the simpler memory_region_add_subregion() function.

This patch was produced with the following spatch script:

    @@
    expression region;
    expression offset;
    expression subregion;
    @@
    -memory_region_add_subregion_overlap(region, offset, subregion, 0)
    +memory_region_add_subregion(region, offset, subregion)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/intel_iommu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43c94b993b..afa7e07b05 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3363,11 +3363,9 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *=
s, PCIBus *bus, int devfn)
          * switch between DMAR & noDMAR by enable/disable
          * corresponding sub-containers
          */
-        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
-                                            MEMORY_REGION(&vtd_dev_as->i=
ommu),
-                                            0);
-        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
-                                            &vtd_dev_as->nodmar, 0);
+        memory_region_add_subregion(&vtd_dev_as->root, 0,
+                                    MEMORY_REGION(&vtd_dev_as->iommu));
+        memory_region_add_subregion(&vtd_dev_as->root, 0, &vtd_dev_as->n=
odmar);
=20
         vtd_switch_address_space(vtd_dev_as);
     }
@@ -3764,8 +3762,7 @@ static void vtd_realize(DeviceState *dev, Error **e=
rrp)
     memory_region_init_alias(&s->mr_sys_alias, OBJECT(s),
                              "vtd-sys-alias", get_system_memory(), 0,
                              memory_region_size(get_system_memory()));
-    memory_region_add_subregion_overlap(&s->mr_nodmar, 0,
-                                        &s->mr_sys_alias, 0);
+    memory_region_add_subregion(&s->mr_nodmar, 0, &s->mr_sys_alias);
     memory_region_add_subregion_overlap(&s->mr_nodmar,
                                         VTD_INTERRUPT_ADDR_FIRST,
                                         &s->mr_ir, 1);
--=20
2.21.0


