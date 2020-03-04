Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEDFC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9294820848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiu04KBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9294820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cMc-00028b-PK
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLU-00007x-Rm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLT-0006lJ-TS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLT-0006kD-QX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/IY56asJn4k/fIDmK4Z2UzFuTytUtXxN/1Jeo1uL4U=;
 b=fiu04KBwOcfg+FhGAjIBdELZCtfZ8TgU0QSBxSNe96pOlJ6+VTFEYASELj0xKo26Q6KROu
 VihXb8EyRRKMfJh9XUGG3+vYFm0f3oThhaNLoscGtFt0o9jNICylzqBEhkYjpijDmzkHC0
 u8UpMKRkmxcXMc0e88KdhTZScVSj9k4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-Q-BjeehaN-Ki9ytM9ZZRLg-1; Wed, 04 Mar 2020 17:18:26 -0500
X-MC-Unique: Q-BjeehaN-Ki9ytM9ZZRLg-1
Received: by mail-wm1-f71.google.com with SMTP id 7so1340172wmo.7
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XSVnfTQjqSoslQR7PQ9GzBNYFbBYE7GKO7GWOT3EV9E=;
 b=jDVJO2bAdKu0jmw+sVgk9hO4xJjFn5cLywi1+C+MF2YsRMBfbL8UHUc25q9i2NXTL8
 gphfslI16Lb4CLXL6g8XJbSY4GZFPcf1soWfwwqxp0NR4Sg10lnuHNil2q1QmVZj90vE
 Ql4XBWbnCw+BntLyeUh9LGC51knh9xUrNHR6fWA7EIUijUVQVxBYb4CJE3jue9/F1GY7
 nJMsxwN2A1lG3v44LrwbnxUJS3C0WOhEh6u0Yck3XlQNsreCz38kVr9ayzhy5rPtY6h2
 mUEUL7hjHkuWmoHOO7qUv/CSY/UBKWqFmfPQ4N866Jx0pv5KDCMzJ/TV14srfTAAtICQ
 6P6g==
X-Gm-Message-State: ANhLgQ0VkwHBTlE7ojBB8SKamhzn9OwpnkWuujDQEr2AGLZECwbRFNCZ
 5/QCr3Hufb8+TW6sa6HFjQd6BjfqARIOuFKh8Sgam0j7hy7YlJ6s0KtCPxIaML6EIiM9tAlUb4Q
 Ed7b8qKf4UGNx5Dg=
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr5699809wrx.147.1583360304704; 
 Wed, 04 Mar 2020 14:18:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuNJdcnEDAJHYcPDME2sY95E31wEuSjXw582qCwO+eePpHJ5JRuqU0V6TK2m3gpex69x2yTUw==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr5699792wrx.147.1583360304484; 
 Wed, 04 Mar 2020 14:18:24 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r3sm3815573wmg.19.2020.03.04.14.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/usb/quirks: Use smaller types to reduce .rodata by
 10KiB
Date: Wed,  4 Mar 2020 23:18:04 +0100
Message-Id: <20200304221807.25212-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304221807.25212-1-philmd@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The USB descriptor sizes are specified as 16-bit for idVendor /
idProduct, and 8-bit for bInterfaceClass / bInterfaceSubClass /
bInterfaceProtocol. Doing so we reduce the usbredir_raw_serial_ids[]
and usbredir_ftdi_serial_ids[] arrays from 16KiB to 6KiB (size
reported on x86_64 host, building with --extra-cflags=3D-Os).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/quirks.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index 89480befd7..794d89a356 100644
--- a/hw/usb/quirks.h
+++ b/hw/usb/quirks.h
@@ -21,11 +21,11 @@
 #include "quirks-pl2303-ids.h"
=20
 struct usb_device_id {
-    int vendor_id;
-    int product_id;
-    int interface_class;
-    int interface_subclass;
-    int interface_protocol;
+    int16_t vendor_id;
+    int16_t product_id;
+    int8_t interface_class;
+    int8_t interface_subclass;
+    int8_t interface_protocol;
 };
=20
 #define USB_DEVICE(vendor, product) \
--=20
2.21.1


