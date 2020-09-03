Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B4C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74C120716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxDDfjuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74C120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtb0-0006mD-QY
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYp-0003iO-44
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYn-0007QJ-9d
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKgwPgUlma51em3nmlbtaR4HUKEwx/6kfLC5jfNaNJc=;
 b=IxDDfjuEhfZH4tgy6PiIIg+znyJ+ScMbcL0mgdFn7I5qeJ0QqT/eZJcjmSreeLX409GA/D
 OQXt/4vfhGN/d062ZiOvLM7tJ5x2zkVHhaMd7B4q1HnyvG0Ru9ARtIgErtOKn0v/PRIh2U
 qQbFmRvZMG/Vr4odmsItAv7447TVmUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-T518Nt2iOP-hzx9hqZgp5w-1; Thu, 03 Sep 2020 14:02:06 -0400
X-MC-Unique: T518Nt2iOP-hzx9hqZgp5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B437F185A0C0;
 Thu,  3 Sep 2020 18:02:03 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68F0281195;
 Thu,  3 Sep 2020 18:01:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 4/8] i8259: Rename PIC to ISA_I8259
Date: Thu,  3 Sep 2020 14:01:24 -0400
Message-Id: <20200903180128.1523959-5-ehabkost@redhat.com>
In-Reply-To: <20200903180128.1523959-1-ehabkost@redhat.com>
References: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the type checking function to be consistent with the type
name constant (TYPE_ISA_I8259) and the QOM type name string
("isa-i8259").

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/intc/i8259.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index ab55163340..61422e6fef 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -39,7 +39,7 @@
 
 #define TYPE_ISA_I8259 "isa-i8259"
 typedef struct PICClass PICClass;
-DECLARE_CLASS_CHECKERS(PICClass, PIC,
+DECLARE_CLASS_CHECKERS(PICClass, ISA_I8259,
                        TYPE_ISA_I8259)
 
 /**
@@ -396,7 +396,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 static void pic_realize(DeviceState *dev, Error **errp)
 {
     PICCommonState *s = PIC_COMMON(dev);
-    PICClass *pc = PIC_GET_CLASS(dev);
+    PICClass *pc = ISA_I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
                           "pic", 2);
@@ -443,7 +443,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
 
 static void i8259_class_init(ObjectClass *klass, void *data)
 {
-    PICClass *k = PIC_CLASS(klass);
+    PICClass *k = ISA_I8259_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
-- 
2.26.2


