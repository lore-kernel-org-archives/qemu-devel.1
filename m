Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15622C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F53222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew7qOE8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F53222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIdW-0003tU-Be
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIbm-0002HD-8g
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIbl-00048O-3S
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIbk-00045x-TQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdCyFYn/HsfbvSgtbOBMQszsFSG9g0+uWPfNrJnmnsY=;
 b=Ew7qOE8jy4ferDZdONIwWsbD+vd+gnqmm6dXrPnfhbKNPGsBNQhJO7XkC7X6qbZuG9E4pp
 MswdNZzyNy8xQqddGakhSFyIAfU6CgCaee9DzXZnfJYKWvDN7wcs0K/+cEDjdlwWaNZhOz
 RKzR4fnjxFyLWZON3FPImQFJBV6Uk1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-MiRixK9POUOdEb2YRfSA2w-1; Fri, 20 Dec 2019 08:46:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB489911B1;
 Fri, 20 Dec 2019 13:46:15 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAF9B26FB2;
 Fri, 20 Dec 2019 13:46:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/37] hw/display/sm501: Always map the UART0
Date: Fri, 20 Dec 2019 17:45:25 +0400
Message-Id: <20191220134601.571905-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: MiRixK9POUOdEb2YRfSA2w-1
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The SM501 is a Mobile Multimedia Companion Chip with 2 UARTs.
This model only implements the first UART. Being part of the
chipset, the UART block is always mapped in memory, regardless
of whether we provide a chardev backend.

Since commit 12051d82f, qemu_chr_fe_init() accepts a NULL chardev.
Let's remove the chardev check and always map the UART in the
chipset memory.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191122133623.13004-1-philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1f33c87e65..79bd7bc2d1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1958,11 +1958,9 @@ static void sm501_realize_sysbus(DeviceState *dev, E=
rror **errp)
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
=20
     /* bridge to serial emulation module */
-    if (s->chr_state) {
-        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
-                       NULL, /* TODO : chain irq to IRL */
-                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
-    }
+    serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
+                   NULL, /* TODO : chain irq to IRL */
+                   115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
 }
=20
 static Property sm501_sysbus_properties[] =3D {
--=20
2.24.0.308.g228f53135a


