Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BA9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B6320C09
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZguoHkm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B6320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3db-0005y6-4d
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo3c6-000475-Vw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:30:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo3c1-0007xW-KB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592998240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=W5jLchuDEVC4h32xQx4FbHLLABhySJXQUN1JP811Qec=;
 b=ZguoHkm5wXduB1e8Fd3XBBDT44D0nJh5Bi9J5dmqPsIXgs9qbV+Zcv8FM+bzpVSCzscJ6A
 dH8KipDbBnQh/LuHctRRbPkHbDChr6ZzrYTgjJJPyyRsGiB0lPrzlUICGTRnaParTLh8Td
 oZzmGjCc83HbpjRdK4CqPonwpYBUS/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-uaL-haxkMi-3_w_9_uh96w-1; Wed, 24 Jun 2020 07:30:39 -0400
X-MC-Unique: uaL-haxkMi-3_w_9_uh96w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2593D107ACF6;
 Wed, 24 Jun 2020 11:30:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D09E91C8;
 Wed, 24 Jun 2020 11:30:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 41B0B31E57; Wed, 24 Jun 2020 13:30:27 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/20] audio: rework pcspk_init()
Date: Wed, 24 Jun 2020 13:30:21 +0200
Message-Id: <20200624113026.13343-16-kraxel@redhat.com>
In-Reply-To: <20200624113026.13343-1-kraxel@redhat.com>
References: <20200624113026.13343-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of creating and returning the pc speaker accept it as argument.
That allows to rework the initialization workflow in followup patches.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/audio/pcspk.h | 6 +-----
 hw/i386/pc.c             | 2 +-
 hw/isa/i82378.c          | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 7e7f5f49dcb0..8b485602675f 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -31,18 +31,14 @@
 
 #define TYPE_PC_SPEAKER "isa-pcspk"
 
-static inline ISADevice *pcspk_init(ISABus *bus, ISADevice *pit)
+static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
 {
     DeviceState *dev;
-    ISADevice *isadev;
 
-    isadev = isa_new(TYPE_PC_SPEAKER);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase", 0x61);
     object_property_set_link(OBJECT(dev), OBJECT(pit), "pit", NULL);
     isa_realize_and_unref(isadev, bus, &error_fatal);
-
-    return isadev;
 }
 
 #endif /* HW_PCSPK_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ba88e1dfb80f..3f1d42b05102 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1240,7 +1240,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             /* connect PIT to output control line of the HPET */
             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
         }
-        pcspk_init(isa_bus, pit);
+        pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
     }
 
     i8257_dma_init(isa_bus, 0);
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index d9e6c7fa0096..75a2da288157 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -102,7 +102,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     pit = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
-    pcspk_init(isabus, pit);
+    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
 
     /* 2 82C37 (dma) */
     isa_create_simple(isabus, "i82374");
-- 
2.18.4


