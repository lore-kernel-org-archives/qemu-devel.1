Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52ACC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42C920870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrUl+qX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42C920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ulc-000160-OP
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9uk7-0007Gf-UG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9uk6-0002kL-Un
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9uk6-0002jQ-QD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583431026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tw4AXOFUsVnWWH/+MEC8+/Jzhzp7Eu5EQAdmUFQrX44=;
 b=QrUl+qX7YjvvjTEi0ddyZwljl9VY6VpIEHCeM4702cd9LzZw9uCHaKO1IIPy7RR/ZWFLfh
 gLpFoONjMFjZe1ureK37acscKKSFjD8JIEGYepbIAo0Rit0skoXxDCXSo0iwi/ZUAmy71H
 mzpUACiBlj9QMnZqnvJLpM4pL64atQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-jk2EZzg5NaaLkL2LTD_Xgw-1; Thu, 05 Mar 2020 12:57:05 -0500
X-MC-Unique: jk2EZzg5NaaLkL2LTD_Xgw-1
Received: by mail-wr1-f70.google.com with SMTP id q18so2601808wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+MbtoWKkcqHCz+vfqyTzTQ/PF32JMBmzxf8ccd5VY20=;
 b=uFsv2zuh2IZZqnzW/AyOGxmJ+zeHyi6pi0goP3LTBsrVwjpGkemm3rZSYt/QFh0NDa
 SSnzWGA3bMcD5hv5J6wZEnAEnTYrBpkrJ0khN8YqQZe4tZrbcZvE5Inqzyvle04y+BV6
 eMabmsV4JM6Q2ECsskJTOvNRxcM36qpw8jnZOmYdtZT61DsGNewv6BzPnyG5NDj3Mxyd
 le3Co4kDQPP4Kan5nAUKv/W8p1ZNXNIaR1A0DmB6E8NLYNeok9RT6IfVfA55zOgpFFJL
 WXNYSpVfyYFLC/tGxwjJ/ofWkTxeslmKnnFIhd77VjIV0o0RMx0szI8lTFNyWRxgADlN
 paOg==
X-Gm-Message-State: ANhLgQ1/LNmeNDA0TZCZgE32OwyN41ktfsSKjNbBk2CySdTxeIjwnjoh
 EZU2GdbgMrTM9Y65RFPLQOrX6lnyaZT8toJU3ON+DmSvFGFNJkf/tJe84lBn+6u/3snQjq/OnYt
 NXge9wufFWhpm0do=
X-Received: by 2002:a05:6000:108:: with SMTP id
 o8mr120891wrx.312.1583431023632; 
 Thu, 05 Mar 2020 09:57:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuWmokTTXWO/3o9W34TZ6DMM4KH3ciqzOZWMvRg7PGY3DDIVccA2xbcBAAbGbz94dLSvuoqxg==
X-Received: by 2002:a05:6000:108:: with SMTP id
 o8mr120874wrx.312.1583431023428; 
 Thu, 05 Mar 2020 09:57:03 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d203sm9699558wmd.37.2020.03.05.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 09:57:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/net/smc91c111: Let smc91c111_can_receive() return a
 boolean
Date: Thu,  5 Mar 2020 18:56:46 +0100
Message-Id: <20200305175651.4563-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305175651.4563-1-philmd@redhat.com>
References: <20200305175651.4563-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The smc91c111_can_receive() function simply returns a boolean value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/smc91c111.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index e9eb6f6c05..02be60c955 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -130,16 +130,16 @@ static void smc91c111_update(smc91c111_state *s)
     qemu_set_irq(s->irq, level);
 }
=20
-static int smc91c111_can_receive(smc91c111_state *s)
+static bool smc91c111_can_receive(smc91c111_state *s)
 {
     if ((s->rcr & RCR_RXEN) =3D=3D 0 || (s->rcr & RCR_SOFT_RST)) {
-        return 1;
+        return true;
     }
     if (s->allocated =3D=3D (1 << NUM_PACKETS) - 1 ||
         s->rx_fifo_len =3D=3D NUM_PACKETS) {
-        return 0;
+        return false;
     }
-    return 1;
+    return true;
 }
=20
 static inline void smc91c111_flush_queued_packets(smc91c111_state *s)
--=20
2.21.1


