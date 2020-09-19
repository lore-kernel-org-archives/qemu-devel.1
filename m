Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CDBC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72161208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfxbSYvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72161208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfh6-00040O-Em
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHL-0005Sn-MU
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH5-0007Ob-8b
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfGTAbqMGw/xw7XV9c27JOc7nCehK4nw8/Elk/LIIjE=;
 b=YfxbSYvLIujI8Nst7utZYOoIUI2SH/jGG+ON1NHhdkdd60+99bmhg2Et1LlhLGKrTjEdMI
 CWX10zbWgAl2qDXUGwdMvorkUCKk3e3fuhu+1NQfZ9J9Z3hq2pyF3kBpjpwWj8HBcwkfIk
 zkYdWsF4JE1k+K7rtH1AMpw2AISTbe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-zts2a8tUNkiAQhBsBkVMtA-1; Sat, 19 Sep 2020 11:59:40 -0400
X-MC-Unique: zts2a8tUNkiAQhBsBkVMtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C9091006710;
 Sat, 19 Sep 2020 15:59:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFB3560C84;
 Sat, 19 Sep 2020 15:59:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/57] hw/char/serial-{isa,
 pci}: Alias QDEV properties from generic serial object
Date: Sat, 19 Sep 2020 11:58:45 -0400
Message-Id: <20200919155916.1046398-27-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 7e1b36c3f6..c0607476c2 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -118,8 +118,6 @@ static Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
-    DEFINE_PROP_CHR("chardev",   ISASerialState, state.chr),
-    DEFINE_PROP_BOOL("wakeup",   ISASerialState, state.wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -140,6 +138,8 @@ static void serial_isa_initfn(Object *o)
     ISASerialState *self = ISA_SERIAL(o);
 
     object_initialize_child(o, "serial", &self->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&self->state), o);
 }
 
 static const TypeInfo serial_isa_info = {
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index f68948154e..81da2783f9 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -84,7 +84,6 @@ static const VMStateDescription vmstate_pci_serial = {
 };
 
 static Property serial_pci_properties[] = {
-    DEFINE_PROP_CHR("chardev",  PCISerialState, state.chr),
     DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -109,6 +108,8 @@ static void serial_pci_init(Object *o)
     PCISerialState *ps = PCI_SERIAL(o);
 
     object_initialize_child(o, "serial", &ps->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&ps->state), o);
 }
 
 static const TypeInfo serial_pci_info = {
-- 
2.26.2



