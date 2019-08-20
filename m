Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B4FC3A59D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D209822DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D209822DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03Nb-0007Jz-OX
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i03La-0005sP-0C
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i03LZ-0002R5-1q
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:34:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i03LU-0002Bq-W8; Tue, 20 Aug 2019 08:34:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1679789AC2;
 Tue, 20 Aug 2019 12:34:39 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B23CA5C21F;
 Tue, 20 Aug 2019 12:34:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:34:16 +0200
Message-Id: <20190820123417.27930-2-philmd@redhat.com>
In-Reply-To: <20190820123417.27930-1-philmd@redhat.com>
References: <20190820123417.27930-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 20 Aug 2019 12:34:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] hw/char/serial: Add a helper to set the
 divisor register
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some chipsets provide 16650 compatible UART with exhanced
features. The BCM2835 provides a register to directly set
the baudrate divisor register without having to use the
LABD bit.

Add a helper to allow models to directly set the divisor.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial.c         | 6 ++++++
 include/hw/char/serial.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4aa250950..12eb93705d 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -191,6 +191,12 @@ static void serial_update_parameters(SerialState *s)
            speed, parity, data_bits, stop_bits);
 }
=20
+void serial_set_divider(SerialState *s, uint16_t divider)
+{
+    s->divider =3D divider;
+    serial_update_parameters(s);
+}
+
 static void serial_update_msl(SerialState *s)
 {
     uint8_t omsr;
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8be3d8a4f9..ef211f695d 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -83,6 +83,7 @@ extern const MemoryRegionOps serial_io_ops;
 void serial_realize_core(SerialState *s, Error **errp);
 void serial_exit_core(SerialState *s);
 void serial_set_frequency(SerialState *s, uint32_t frequency);
+void serial_set_divider(SerialState *s, uint16_t divider);
=20
 /* legacy pre qom */
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
--=20
2.20.1


