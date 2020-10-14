Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEAFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9743D212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvVZ6wIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9743D212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShxC-0006mi-5N
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrN-0001VR-Ss
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrM-000641-2a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602686071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lZ2vwJoIf/EbpWJn4lNu5fvufxDiZ6wJR6K5jxiHgg=;
 b=AvVZ6wIX2E2oaiRcqmgSDpNODgbCYEU0BLH4LUmOfvWLHE3RiwxkMyozCjES0plYeSVGeI
 3j8+zGIzthgbOcU0n51aGbciAhcp2VYq11QZGeptpBSdYiNTJ8moId/UUI2NOlvdQGOxwf
 X9zyUAxhHZjBtsz4NDM6bBEtBe2H/Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-WCpjcT2nPfSHJsKYK4Undg-1; Wed, 14 Oct 2020 10:34:28 -0400
X-MC-Unique: WCpjcT2nPfSHJsKYK4Undg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF29102120F;
 Wed, 14 Oct 2020 14:34:27 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10C695D9CD;
 Wed, 14 Oct 2020 14:34:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/10] vga-pci: Register "big-endian-framebuffer" as class
 property
Date: Wed, 14 Oct 2020 10:34:12 -0400
Message-Id: <20201014143415.240472-8-ehabkost@redhat.com>
In-Reply-To: <20201014143415.240472-1-ehabkost@redhat.com>
References: <20201014143415.240472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200921221045.699690-22-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/display/vga-pci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index e5d9af5868..48d29630ab 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -267,13 +267,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void pci_std_vga_init(Object *obj)
-{
-    /* Expose framebuffer byteorder via QOM */
-    object_property_add_bool(obj, "big-endian-framebuffer",
-                             vga_get_big_endian_fb, vga_set_big_endian_fb);
-}
-
 static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
 {
     PCIVGAState *d = PCI_VGA(dev);
@@ -386,6 +379,10 @@ static void vga_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_DISPLAY_VGA;
     device_class_set_props(dc, vga_pci_properties);
     dc->hotpluggable = false;
+
+    /* Expose framebuffer byteorder via QOM */
+    object_class_property_add_bool(klass, "big-endian-framebuffer",
+                                   vga_get_big_endian_fb, vga_set_big_endian_fb);
 }
 
 static void secondary_class_init(ObjectClass *klass, void *data)
@@ -403,7 +400,6 @@ static void secondary_class_init(ObjectClass *klass, void *data)
 static const TypeInfo vga_info = {
     .name          = "VGA",
     .parent        = TYPE_PCI_VGA,
-    .instance_init = pci_std_vga_init,
     .class_init    = vga_class_init,
 };
 
-- 
2.28.0


