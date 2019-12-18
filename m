Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC692C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789E020717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+RCm+OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789E020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58227 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihd5n-0005ya-Bj
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihd0V-0007wS-7w
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihd0S-0000lm-R5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihd0S-0000i2-Kw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576689664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoOrTKj3h9+tvWmM1nSYpX3LSWNw7p9uAeDqW51BO5k=;
 b=g+RCm+OR5e3LKQ2irn6ZlLXcSlB6r2tl8rmYqJ8ZyOhtBb2qGT31IVcJkiIDBh6RCOezxQ
 DkV1pJlvSichC2jhPla28Tvw1wWBNc2+Q3Cm4OthsBEAVWqXWIahBMjH3uMyZZpEXJZGSD
 OMUBPXLLjixWnNtuxnpiIrKGZX/38OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-U6jhqM2pPy6AbGHctHoo2w-1; Wed, 18 Dec 2019 12:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E1D801E66;
 Wed, 18 Dec 2019 17:21:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9D4010018FF;
 Wed, 18 Dec 2019 17:20:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 04/14] hw/usb/dev-serial: Explicit we ignore few
 QEMUChrEvent in IOEventHandler
Date: Wed, 18 Dec 2019 18:19:59 +0100
Message-Id: <20191218172009.8868-5-philmd@redhat.com>
In-Reply-To: <20191218172009.8868-1-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: U6jhqM2pPy6AbGHctHoo2w-1
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit all the events ignored by this frontend, to silent the
following GCC warning:

  hw/usb/dev-serial.c: In function =E2=80=98usb_serial_event=E2=80=99:
  hw/usb/dev-serial.c:468:5: error: enumeration value =E2=80=98CHR_EVENT_MU=
X_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
    468 |     switch (event) {
        |     ^~~~~~
  hw/usb/dev-serial.c:468:5: error: enumeration value =E2=80=98CHR_EVENT_MU=
X_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add all missing enums

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 hw/usb/dev-serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 45cc74128a..2ba6870b37 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -479,6 +479,10 @@ static void usb_serial_event(void *opaque, int event)
                 usb_device_detach(&s->dev);
             }
             break;
+        case CHR_EVENT_MUX_IN:
+        case CHR_EVENT_MUX_OUT:
+            /* Ignore */
+            break;
     }
 }
=20
--=20
2.21.0


