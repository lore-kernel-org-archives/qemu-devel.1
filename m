Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82370C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E602087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be608k0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E602087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ior1I-0005F6-VM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqUq-00086Z-Qh
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqUo-0006My-Vw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:10:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqUo-0006LQ-S7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f56hg+4CIOIgZPwvUQ/VUr9C2iln/UDGdvGir/aOEKA=;
 b=Be608k0gRN2cXmLTN7zAi9VyFBug08sspsCdRwkErw/K78GYcgQlPT/IFeEaPbJS4mjr5S
 UwngWPf7PcoMH04XuNr6sQGJRvCyLqSr33XTM5KKwQb2udbqiV+tsLEqbIR+hMFcR1YO2T
 TuypmRd1BSUcxD9ttJ7I9cp0ozShhBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-g01x3LsEPZ2z-230PoNFNA-1; Tue, 07 Jan 2020 10:10:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B097800D41;
 Tue,  7 Jan 2020 15:10:09 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 010D17C33C;
 Tue,  7 Jan 2020 15:10:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/37] leon3: use qdev gpio facilities for the PIL
Date: Tue,  7 Jan 2020 19:04:32 +0400
Message-Id: <20200107150442.1727958-28-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: g01x3LsEPZ2z-230PoNFNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As Peter Maydell once said:
"Creating a gpio pin on some object that isn't yourself
looks a bit odd, but all this leon3 code is modifying
the CPU object from the outside anyway. Someday we might
tidy it up, but not today."

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/sparc/cpu.h | 1 -
 hw/sparc/leon3.c   | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index e70fec0133..ae97c7d9f7 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -541,7 +541,6 @@ struct CPUSPARCState {
 #endif
     sparc_def_t def;
=20
-    qemu_irq pil_irq;
     void *irq_manager;
     void (*qemu_irq_ack)(CPUSPARCState *env, void *irq_manager, int intno)=
;
=20
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index cac987373e..8038887ff7 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -230,8 +230,10 @@ static void leon3_generic_hw_init(MachineState *machin=
e)
=20
     /* Allocate IRQ manager */
     dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
-    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
-    qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
+    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
+                                        env, "pil", 1);
+    qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
+                                qdev_get_gpio_in_named(DEVICE(cpu), "pil",=
 0));
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
     env->irq_manager =3D dev;
--=20
2.25.0.rc1.20.g2443f3f80d


