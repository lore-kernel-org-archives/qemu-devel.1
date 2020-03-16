Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1960C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB4B20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpgzr3O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB4B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv8R-0002PL-Mj
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDupD-00082p-3E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupC-0002b2-2G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupB-0002Wd-U5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIgThoEePPf90ajNUgSVa3azTjacscrWOhCWVgwnzwo=;
 b=Wpgzr3O+xbgQNnF+fvyEp/0piv3c02jycI7VKlH6vEZtFjDPMzQPfbIdI4ASbegDx4yCHn
 jBzk5daPOyzZNz19YigvOTbMhK8kpgkzHvQoBDFtFk1GJHpJHzK+b/aCbhvX3Bo+0KKB1c
 hCjHS6itLQ97ttmQc6mLrE/3fq19obc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-hcCofLS_PIOuwtAQI8Sssg-1; Mon, 16 Mar 2020 14:50:51 -0400
X-MC-Unique: hcCofLS_PIOuwtAQI8Sssg-1
Received: by mail-wr1-f71.google.com with SMTP id t10so3162210wrp.15
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yr6HrhyKndkeZIUV2fnZDlI2PIM1TMA/l8zKwFVALGs=;
 b=UzrdCen6IfY7FwFSfuIQPjTlpzVWrwmKZHWULrUHywYpYwy1sGfEDXeN0zDiFoFWgw
 u4vPyRsL9EDV6x2ogsEizPoU8nn0Bfm1V076sBEEvUKFTFZS8zTU2o87Q5rPVXJvDRTg
 NEkpFdBmDGn/dyTgHECRGidH6nU8q1HvZRrmpmAOgbtIGdGNLKPT8krqG7vG564rzOA5
 2ESdV7011xmfVymT56dF3cB16WT0ncAXSnjP0yfGBQA+gDLrHCmPQIl9MDpsZ4ypfakp
 tWCHACqGjlo/7ds0nA31ARF4zpXjgNJbuX/D01rDRywXIlkY6NL5oAqcCUgy/1Z4Svf2
 CjDA==
X-Gm-Message-State: ANhLgQ09J161K2+ZUTo0Uo/uPjHFXvPoGwgS0WoobV7XtKs9OHPPztR4
 TXq6hNi8wyNfKmSMy2ShOUvdF55dpAvru+E6EXw8tt1R4fDGHRDn+NROS4jZqryBwhNag6V4RaW
 q4gXFZGZtEHysegc=
X-Received: by 2002:adf:9c8d:: with SMTP id d13mr807040wre.6.1584384649860;
 Mon, 16 Mar 2020 11:50:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvxVw34Y0dvw/cj/D+8i0g4RQcCseUS6Ilb7fPEP6+sNlgRxoS8Homs2uJJt6CsOxg59vbrAw==
X-Received: by 2002:adf:9c8d:: with SMTP id d13mr807022wre.6.1584384649697;
 Mon, 16 Mar 2020 11:50:49 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id z6sm1009141wrp.95.2020.03.16.11.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 08/25] hw/net: Use memory_region_init_rom() with read-only
 regions
Date: Mon, 16 Mar 2020 19:49:49 +0100
Message-Id: <20200316185006.576-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/dp8393x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 81fc13ee9f..1563c11b9e 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -986,13 +986,12 @@ static void dp8393x_realize(DeviceState *dev, Error *=
*errp)
=20
     s->watchdog =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
=20
-    memory_region_init_ram(&s->prom, OBJECT(dev),
-                           "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
+    memory_region_init_rom(&s->prom, OBJECT(dev), "dp8393x-prom",
+                           SONIC_PROM_SIZE, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-    memory_region_set_readonly(&s->prom, true);
     prom =3D memory_region_get_ram_ptr(&s->prom);
     checksum =3D 0;
     for (i =3D 0; i < 6; i++) {
--=20
2.21.1


