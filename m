Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6159C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31834205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH5EsuA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31834205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxu5-0004SZ-7F
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 18:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIO-0004n5-M2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIN-0008RF-JS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxIN-0008Oj-DF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dw9IAA80oEFwhIPPLmt5bE5huwn4u6VjW8/3MRSDruw=;
 b=FH5EsuA/JSOZClzkkGhEPUn8P+q/Oh4FZUzLyU8fwknbb0xUPXVi746tlNQdn2LEKRmsm/
 QBEFJdxDoB/kWacrQWLb+mwQvFUfmcmfB5Ey5sFK7WSDJMgDQ6nXVy3s0F38c0NdRG2O6S
 Ga1IHF/HJSInOV2EwRuRBMVxXe7r9Gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-94--FY7-M8aabNeQWuKbcA-1; Mon, 16 Mar 2020 17:29:09 -0400
X-MC-Unique: 94--FY7-M8aabNeQWuKbcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48CE81804547
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:29:08 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5417E19C4F;
 Mon, 16 Mar 2020 21:29:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/61] hw/dma: Let devices own the MemoryRegion they create
Date: Mon, 16 Mar 2020 22:27:22 +0100
Message-Id: <1584394048-44994-56-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/dma/i8257.c  | 2 +-
 hw/dma/rc4030.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bad8deb..ef15c06 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -553,7 +553,7 @@ static void i8257_realize(DeviceState *dev, Error **err=
p)
     I8257State *d =3D I8257(dev);
     int i;
=20
-    memory_region_init_io(&d->channel_io, NULL, &channel_io_ops, d,
+    memory_region_init_io(&d->channel_io, OBJECT(dev), &channel_io_ops, d,
                           "dma-chan", 8 << d->dshift);
     memory_region_add_subregion(isa_address_space_io(isa),
                                 d->base, &d->channel_io);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 21e2c36..7434d27 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -679,9 +679,9 @@ static void rc4030_realize(DeviceState *dev, Error **er=
rp)
     s->periodic_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      rc4030_periodic_timer, s);
=20
-    memory_region_init_io(&s->iomem_chipset, NULL, &rc4030_ops, s,
+    memory_region_init_io(&s->iomem_chipset, o, &rc4030_ops, s,
                           "rc4030.chipset", 0x300);
-    memory_region_init_io(&s->iomem_jazzio, NULL, &jazzio_ops, s,
+    memory_region_init_io(&s->iomem_jazzio, o, &jazzio_ops, s,
                           "rc4030.jazzio", 0x00001000);
=20
     memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
--=20
1.8.3.1



