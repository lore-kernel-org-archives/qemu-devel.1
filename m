Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CDDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2322F21556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcaiYwmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2322F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94YE-0003mH-8J
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94W4-0007dz-2Y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94W1-0006AT-IY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94W0-00069g-ER
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fq233vp5w5aZrfj8fLdkUXIRg6LJGgiJqm59yH0KHgM=;
 b=YcaiYwmbxiIQJFlUOMfvpIM/5o0pWSm7u28mzWYcp6DYSt/bDsx3zH5/bNlo0EDPsAvRmz
 7hPnL/EitN0L4WRPLObXnt7euKlTOUoKU4BW435PlDzFah9ktpFcP2LNfaY5CPu/zFUFwK
 ob6weRHFElXY/NPjSnwq7zGFUwCnono=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-AY_PeZpPPayfgUpz8w7kIQ-1; Tue, 03 Mar 2020 05:11:01 -0500
X-MC-Unique: AY_PeZpPPayfgUpz8w7kIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 541D213F5;
 Tue,  3 Mar 2020 10:11:00 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF7898D55E;
 Tue,  3 Mar 2020 10:10:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 06/23] dp8393x: Clear RRRA command register bit only when
 appropriate
Date: Tue,  3 Mar 2020 18:10:25 +0800
Message-Id: <1583230242-14597-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

It doesn't make sense to clear the command register bit unless the
command was actually issued.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 9604623..b5a9c6a 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -352,9 +352,6 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RBE;
         dp8393x_update_irq(s);
     }
-
-    /* Done */
-    s->regs[SONIC_CR] &=3D ~SONIC_CR_RRRA;
 }
=20
 static void dp8393x_do_software_reset(dp8393xState *s)
@@ -565,8 +562,10 @@ static void dp8393x_do_command(dp8393xState *s, uint16=
_t command)
         dp8393x_do_start_timer(s);
     if (command & SONIC_CR_RST)
         dp8393x_do_software_reset(s);
-    if (command & SONIC_CR_RRRA)
+    if (command & SONIC_CR_RRRA) {
         dp8393x_do_read_rra(s);
+        s->regs[SONIC_CR] &=3D ~SONIC_CR_RRRA;
+    }
     if (command & SONIC_CR_LCAM)
         dp8393x_do_load_cam(s);
 }
--=20
2.5.0


