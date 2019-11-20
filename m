Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B823CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D12720692
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbGSzBPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D12720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSDf-0001b5-04
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRw4-0006Ki-RP
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRvz-0008VM-VD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:30:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRvz-0008V8-RX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5S9nC8+EUqqGQp52W18e2okUmVSlvCBBSsw0eh2DCk=;
 b=fbGSzBPaMAFaru9hAXe0gji4/I41hC3CaX6Ee2cwnQZ6avCXg7XzqcZpcU5Dwiyx61jfqM
 rGv4Hj3Bs/p1DGa0KHY3/YncJ6j0HzFQwts3n4zLx65BdDWbmYBS9uY2OBihMPfuCGiURH
 RfyG8q6TxzfgFU85yxEOvssd2QxJiwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-NBtW23FkM3On0UVaNdpLqg-1; Wed, 20 Nov 2019 10:30:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBADD80268F;
 Wed, 20 Nov 2019 15:30:20 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01F885ED40;
 Wed, 20 Nov 2019 15:30:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 27/37] leon3: use qdev gpio facilities for the PIL
Date: Wed, 20 Nov 2019 19:24:32 +0400
Message-Id: <20191120152442.26657-28-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NBtW23FkM3On0UVaNdpLqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/sparc/leon3.c   | 6 ++++--
 target/sparc/cpu.h | 1 -
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index cac987373e..1a89d44e57 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -230,8 +230,10 @@ static void leon3_generic_hw_init(MachineState *machin=
e)
=20
     /* Allocate IRQ manager */
     dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
-    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
-    qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
+    qdev_init_gpio_in_named_with_opaque(DEVICE(env), leon3_set_pil_in,
+                                        env, "pil", 1);
+    qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
+                                qdev_get_gpio_in_named(DEVICE(env), "pil",=
 0));
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
     env->irq_manager =3D dev;
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
--=20
2.24.0


