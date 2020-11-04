Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB02C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7990B208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMNXXsq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7990B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHne-0006kG-F9
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfW-0007e1-5g
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfS-0007pi-RT
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CwwoAYvS2LJdkyGB+0F/NGd1MdSwpM/+LqhmsM5NCo=;
 b=TMNXXsq0ohcwOUDZwkTs9J7J6gQfh4EUY7TPq7Wm4veLPRE6fct+QBdRczWup4KoNeO+t6
 opQRZuWmo4Qo6Id1Ar4KSjgrfzsshknOW83o6GpzewcbdgR++4vQjy9reGku5ZUStR0g5E
 RpEGHfrzbkzdboWz0aPj/ty6h7J5+zM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-8ACHGK_7O2u4FB9OSpwSEQ-1; Wed, 04 Nov 2020 07:13:32 -0500
X-MC-Unique: 8ACHGK_7O2u4FB9OSpwSEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8813805EFD;
 Wed,  4 Nov 2020 12:13:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4128E1C924;
 Wed,  4 Nov 2020 12:13:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8CB059CA5; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] dev-serial: add support for setting data_bits in
 QEMUSerialSetParams
Date: Wed,  4 Nov 2020 13:13:20 +0100
Message-Id: <20201104121321.7772-8-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
References: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also implement the behaviour reported in Linux's ftdi_sio.c whereby if an invalid
data_bits value is provided then the hardware defaults to using 8.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201027150456.24606-8-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 17 +++++++++++++++++
 hw/usb/trace-events |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b9e308dca198..e42ce362956b 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -308,6 +308,23 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
     }
     case VendorDeviceOutRequest | FTDI_SET_DATA:
+        switch (value & 0xff) {
+        case 7:
+            s->params.data_bits = 7;
+            break;
+        case 8:
+            s->params.data_bits = 8;
+            break;
+        default:
+            /*
+             * According to a comment in Linux's ftdi_sio.c original FTDI
+             * chips fall back to 8 data bits for unsupported data_bits
+             */
+            trace_usb_serial_unsupported_data_bits(bus->busnr, dev->addr,
+                                                   value & 0xff);
+            s->params.data_bits = 8;
+        }
+
         switch (value & FTDI_PARITY) {
         case 0:
             s->params.parity = 'N';
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 98ee1c54627d..109da521cf4d 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -327,6 +327,7 @@ usb_serial_handle_control(int bus, int addr, int request, int value) "dev %d:%u
 usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%u unsupported parity %d"
 usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%u unsupported stop bits %d"
 usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%u got unsupported/bogus control 0x%x, value 0x%x"
+usb_serial_unsupported_data_bits(int bus, int addr, int value) "dev %d:%u unsupported data bits %d, falling back to 8"
 usb_serial_bad_token(int bus, int addr) "dev %d:%u bad token"
 usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%u baud rate %d"
 usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%u parity %c, data bits %d, stop bits %d"
-- 
2.27.0


