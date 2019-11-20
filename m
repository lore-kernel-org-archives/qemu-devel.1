Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362DFC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0197520709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC0YTeco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0197520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS7h-00036G-Kp
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRuZ-0003lm-Ui
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRuY-0007n5-SB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:28:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRuY-0007n0-OV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLPNQ0lU7tbB+5rt3ylST9obxLlvq+ff1WfwDeQkDfk=;
 b=fC0YTecolR4zPFUwJLp1gSVR/YqpJVQsfGkMsOpahUkKHx9Yilg7stvVMhejZ+S2S9erii
 gpUGuh9G4IYJSCCkd7GTs4yPhbp0sOLP58waSX2i8ckVIOam5Di9cTaaPXkw3Skhc9w4D2
 Qn2Inwn1MMQPuoh+M774z8mwSRpgsWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-757NWRkaPfaR3mA7vLsvlQ-1; Wed, 20 Nov 2019 10:28:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6932107ACC4;
 Wed, 20 Nov 2019 15:28:51 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EB60503F1;
 Wed, 20 Nov 2019 15:28:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 20/37] mips: use sysbus_mmio_get_region() instead of
 internal fields
Date: Wed, 20 Nov 2019 19:24:25 +0400
Message-Id: <20191120152442.26657-21-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 757NWRkaPfaR3mA7vLsvlQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Register the memory region with sysbus_init_mmio() and look it up with
sysbus_mmio_get_region() to avoid accessing internal device fields.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c       | 1 +
 hw/mips/mips_mipssim.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 23f0b02516..02c545ff8c 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -993,6 +993,7 @@ static void serial_io_realize(DeviceState *dev, Error *=
*errp)
     qdev_init_nofail(DEVICE(s));
=20
     memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
+    sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
 }
=20
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 2c2c7f25b2..84c03dd035 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -227,7 +227,8 @@ mips_mipssim_init(MachineState *machine)
         qdev_set_legacy_instance_id(dev, 0x3f8, 2);
         qdev_init_nofail(dev);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
-        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->serial.=
io);
+        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
+                      sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
     }
=20
     if (nd_table[0].used)
--=20
2.24.0


