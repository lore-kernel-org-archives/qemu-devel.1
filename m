Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBDC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10DD2072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfFQqDHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10DD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9unG-0004DC-3K
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 13:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ukI-0007e8-Ce
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ukH-0002us-Be
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ukH-0002u3-8Y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583431036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFzOf21mMRMWBpr53hzhWDWl6EUS9wSXvSla5EkKK0o=;
 b=EfFQqDHTUEg4jFEla9iviswXvoCTW1AM9UBrFdvs3LOGgstRyzKr+WEV4dNjsAfezDkWgG
 SquDItZc8wqGiMaQF4QENJrjqjervRk9lnMvYMtBl8QsGFuVy8OPAPSclM+cg7KekzYzsY
 JJ5KXIBOPD3qUEdJX84EEmWf/Y7r0A4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-ax-9TwH9NSi2jxB13UuU3w-1; Thu, 05 Mar 2020 12:57:15 -0500
X-MC-Unique: ax-9TwH9NSi2jxB13UuU3w-1
Received: by mail-wm1-f71.google.com with SMTP id r19so2383294wmh.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KuZu0l8YBqYXQOonzFZy05S+UvA1gUT1JdqmPkqMlAs=;
 b=tVG4lZNPAk4VEbYA/tO6uvw9p4Ta7Ojoz5jcngsBf75jaLqSHjpGZOsbamr8zqRXyG
 AVkEXLjdkyahSAUs7F+Hfk/4Junyji7oBEEpFtcPoe2ekvgy6eFMQ8Quq5VEY0uXm7Bg
 oSzGs+4xzwzKGoc8fikcPks6MBMK0QbLGznmcv44WfU2GUBNhT2fmJcKlmjdZU4C+k5B
 5hj+FiKeK+hkFP8EQE92BOSVEnpBBHZ83zzNs9yp8lv7zNo8gOg8qdq/xjo9ruq74Ggb
 0i8kuAXcDn+9r0NmY9OsfK0ChF4ZvFmXEdXHDGwZ3i2qKsmC8AfXVrWnGrobPWp/EKQf
 ipYA==
X-Gm-Message-State: ANhLgQ2IhiT63Cj4ZDe/SogK+ryvvm6p52zlEke8+LUsPwRozDUuBznh
 BUzxKCQApgZDhRnmBkV3IFppRlzfr/LKl4E4cotMYnDk0zyTLqB7fK01bO0X6SQcqVsn1B/7RXF
 mzx+yNmvwuwljMYY=
X-Received: by 2002:a1c:750e:: with SMTP id o14mr10482418wmc.156.1583431033782; 
 Thu, 05 Mar 2020 09:57:13 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt9kbFZJCsgnlMYHXpGvqWjyZ0ERbNoxVPqdKTWvq9o2jftfKQM7F/6kgRnJ1dixgvdd0OPnw==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr10482398wmc.156.1583431033617; 
 Thu, 05 Mar 2020 09:57:13 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a1sm5164615wru.75.2020.03.05.09.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 09:57:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/net/rtl8139: Update coding style to make checkpatch.pl
 happy
Date: Thu,  5 Mar 2020 18:56:48 +0100
Message-Id: <20200305175651.4563-5-philmd@redhat.com>
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

We will modify this code in the next commit. Clean it up
first to avoid checkpatch.pl errors.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/rtl8139.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index ef3211537f..be9a0af629 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -799,10 +799,12 @@ static int rtl8139_can_receive(NetClientState *nc)
     int avail;
=20
     /* Receive (drop) packets if card is disabled.  */
-    if (!s->clock_enabled)
-      return 1;
-    if (!rtl8139_receiver_enabled(s))
-      return 1;
+    if (!s->clock_enabled) {
+        return 1;
+    }
+    if (!rtl8139_receiver_enabled(s)) {
+        return 1;
+    }
=20
     if (rtl8139_cp_receiver_enabled(s) && rtl8139_cp_rx_valid(s)) {
         /* ??? Flow control not implemented in c+ mode.
--=20
2.21.1


