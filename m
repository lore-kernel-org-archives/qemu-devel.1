Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44FC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF976208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sn717IIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF976208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfTK-0003TQ-Pf
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH8-0005NL-7R
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH3-0007Nw-AD
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyDKceypEWz+8riJI6yGqoX39X+g88wTAYURoyNIUmU=;
 b=Sn717IIlAaDD1DbDIU5tsgAVikqY79NhhTH13jbeBO2QgmnAVFWkOXMHqNyo7Buh3G5Ett
 dGcWb6kyZWWXomlhpDxKdZMTt3HoSa6RkFP40Vx2pwWjTMhPbLMrwNXWoaI7NVw6xzYysL
 VxyiYsdYh0oxCcMeXX1Sovj2UEdDcFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-IApZVA_KM0Wa51fUAshrfw-1; Sat, 19 Sep 2020 11:59:34 -0400
X-MC-Unique: IApZVA_KM0Wa51fUAshrfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F10910066FC;
 Sat, 19 Sep 2020 15:59:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3377196F3;
 Sat, 19 Sep 2020 15:59:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/57] hw/char/serial: Remove TYPE_SERIAL_IO
Date: Sat, 19 Sep 2020 11:58:38 -0400
Message-Id: <20200919155916.1046398-20-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

TYPE_SERIAL_IO is a subset of TYPE_SERIAL_MM, and it is
not used anymore. Remove it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200907011538.818996-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c         | 41 ----------------------------------------
 include/hw/char/serial.h | 11 -----------
 2 files changed, 52 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2386479492..fd80ae5592 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -985,46 +985,6 @@ const MemoryRegionOps serial_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void serial_io_realize(DeviceState *dev, Error **errp)
-{
-    SerialIO *sio = SERIAL_IO(dev);
-    SerialState *s = &sio->serial;
-
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
-        return;
-    }
-
-    memory_region_init_io(&s->io, OBJECT(dev), &serial_io_ops, s, "serial", 8);
-    sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
-    sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
-}
-
-static void serial_io_class_init(ObjectClass *klass, void* data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = serial_io_realize;
-    /* No dc->vmsd: class has no migratable state */
-}
-
-static void serial_io_instance_init(Object *o)
-{
-    SerialIO *sio = SERIAL_IO(o);
-
-    object_initialize_child(o, "serial", &sio->serial, TYPE_SERIAL);
-
-    qdev_alias_all_properties(DEVICE(&sio->serial), o);
-}
-
-
-static const TypeInfo serial_io_info = {
-    .name = TYPE_SERIAL_IO,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SerialIO),
-    .instance_init = serial_io_instance_init,
-    .class_init = serial_io_class_init,
-};
-
 static Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
@@ -1178,7 +1138,6 @@ static const TypeInfo serial_mm_info = {
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
-    type_register_static(&serial_io_info);
     type_register_static(&serial_mm_info);
 }
 
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 264f529a7f..51397a8a18 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -91,13 +91,6 @@ struct SerialMM {
 };
 typedef struct SerialMM SerialMM;
 
-struct SerialIO {
-    SysBusDevice parent;
-
-    SerialState serial;
-};
-typedef struct SerialIO SerialIO;
-
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
 
@@ -111,10 +104,6 @@ DECLARE_INSTANCE_CHECKER(SerialState, SERIAL,
 DECLARE_INSTANCE_CHECKER(SerialMM, SERIAL_MM,
                          TYPE_SERIAL_MM)
 
-#define TYPE_SERIAL_IO "serial-io"
-DECLARE_INSTANCE_CHECKER(SerialIO, SERIAL_IO,
-                         TYPE_SERIAL_IO)
-
 SerialMM *serial_mm_init(MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
-- 
2.26.2



