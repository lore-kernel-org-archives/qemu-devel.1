Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC3C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5EA2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOLLIzc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5EA2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNt7-0003td-4p
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTn-00015e-Qu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTi-00063H-KA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzrBGtJp5HYgKEGPS65H9c5wxTSREV/KWJ3YU9/vw+0=;
 b=EOLLIzc+uP/sgdtdl8WAwqRqt8CxTBZ4bEmPtduSXhlPcq3gHFS10TKrNs8raKE1jAkXBl
 cCMWPc+u3f5AyTa67XrKkF2Anq9dZ3RaIJBUDb14o8FZMwDoLjVOzpOdhQrkUHm3FLt/Jm
 Ru67acOdBF6KTLC1X6NJPGMUZlTeIv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-819HxMAUPT6ioalw6aT21g-1; Thu, 24 Sep 2020 05:23:37 -0400
X-MC-Unique: 819HxMAUPT6ioalw6aT21g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FE421891E89;
 Thu, 24 Sep 2020 09:23:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1E3873662;
 Thu, 24 Sep 2020 09:23:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/92] hw/char/serial-{isa,
 pci}: Alias QDEV properties from generic serial object
Date: Thu, 24 Sep 2020 05:22:06 -0400
Message-Id: <20200924092314.1722645-25-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Instead of overwritting the properties of the generic 'state'
object, alias them.
Note we can now propagate the "baudbase" property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200907015535.827885-7-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial-isa.c | 4 ++--
 hw/char/serial-pci.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index fc8ff7823a..1b8b303079 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -116,8 +116,6 @@ static Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
-    DEFINE_PROP_CHR("chardev",   ISASerialState, state.chr),
-    DEFINE_PROP_BOOL("wakeup",   ISASerialState, state.wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -138,6 +136,8 @@ static void serial_isa_initfn(Object *o)
     ISASerialState *self = ISA_SERIAL(o);
 
     object_initialize_child(o, "serial", &self->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&self->state), o);
 }
 
 static const TypeInfo serial_isa_info = {
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index b0520a5a09..93d6f99244 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -82,7 +82,6 @@ static const VMStateDescription vmstate_pci_serial = {
 };
 
 static Property serial_pci_properties[] = {
-    DEFINE_PROP_CHR("chardev",  PCISerialState, state.chr),
     DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -107,6 +106,8 @@ static void serial_pci_init(Object *o)
     PCISerialState *ps = PCI_SERIAL(o);
 
     object_initialize_child(o, "serial", &ps->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&ps->state), o);
 }
 
 static const TypeInfo serial_pci_info = {
-- 
2.26.2



