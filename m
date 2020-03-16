Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EAFC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA5D20753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzlZQFAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA5D20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvLK-0000ut-Ka
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuq7-0001rd-Aj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuq6-0001Md-5T
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuq6-0001LD-0g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3ghcWWXfmrp7QvFdK9qXlRLUNNDkXw1/QjRUWIVTOU=;
 b=CzlZQFAz/JQh5e1diW4e2sX7ytkEy9dTzvpO5vy3BOdHZRzL4u4Bjm5HULlrsTB9dYkXT+
 f+sqYp1+76EoNP64+AqnwgEhD+4LZdLTEWE/mQ92q7pR39jaovJIWmVbvREBj4rCWw1un2
 TTNs5DJuYoPLkCf3nNjVwWc2oUD+eUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-PNFviC6cPpyfD68pkftx3g-1; Mon, 16 Mar 2020 14:51:48 -0400
X-MC-Unique: PNFviC6cPpyfD68pkftx3g-1
Received: by mail-wr1-f70.google.com with SMTP id v7so10146wrp.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tg4YT8Vv6s4Pvf6ypAvksHmessU7kCXErgARgCCgCB0=;
 b=F+EEKFQxwOgtCuvBpEftTtWQ2Y08R3VsJSxbpU2zYt9js4rC5BdeNXYnIlc+CzLUB3
 dKqzuWOTPeIV6EVz+6LKjR1b69WnVEe51Li7emdvulZWoKk1WcZMkrUmFp7m12mIFBWA
 KeiF4IRUyRRaTVr26D1bOFR/QAitIVCPg18cky/dFABGZTzSXsUbjfxFGtawEd2tWgE1
 0AebaK6eqrOqOHQaa43XF2ayF3rc8EvYevGg2UZLp2RRnloY9iKpnpkfaldPNTk2Qp6D
 sTJ+SQRfalcHfGO1ujtDvbytrxc0YTMz/I8tnXd6mbRqJNINfIzx6ph31oVP+7xxkdh6
 imyg==
X-Gm-Message-State: ANhLgQ1VQmjIM0zpqRWXXomdyWEGMvNrXjVXB7gLBGDVf8vjFxJS+aS9
 MSAAnJeqRWlrlO2WzCrsn+oKWwx+LpeU9giPmFs7t4k9bp+mDIzRONi5sd/HU8liHA0tdNF3xEG
 nL5hIMeCxI/FRDwk=
X-Received: by 2002:a05:6000:10d:: with SMTP id
 o13mr787616wrx.84.1584384706875; 
 Mon, 16 Mar 2020 11:51:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvbAJ8oPKSi+7bUQa0Z5HltaI79+8Zsqm/dSQSSkH8TmcXK0iCza9kQkk+65DqJCDLlRmdwag==
X-Received: by 2002:a05:6000:10d:: with SMTP id
 o13mr787595wrx.84.1584384706714; 
 Mon, 16 Mar 2020 11:51:46 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id x5sm1027236wrv.67.2020.03.16.11.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 19/25] hw/dma: Let devices own the MemoryRegion they create
Date: Mon, 16 Mar 2020 19:50:00 +0100
Message-Id: <20200316185006.576-20-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/dma/i8257.c  | 2 +-
 hw/dma/rc4030.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bad8debae4..ef15c06d77 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -553,7 +553,7 @@ static void i8257_realize(DeviceState *dev, Error **err=
p)
     I8257State *d =3D I8257(dev);
     int i;
=20
-    memory_region_init_io(&d->channel_io, NULL, &channel_io_ops, d,
+    memory_region_init_io(&d->channel_io, OBJECT(dev), &channel_io_ops, d,
                           "dma-chan", 8 << d->dshift);
     memory_region_add_subregion(isa_address_space_io(isa),
                                 d->base, &d->channel_io);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 21e2c360ac..7434d274aa 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -679,9 +679,9 @@ static void rc4030_realize(DeviceState *dev, Error **er=
rp)
     s->periodic_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      rc4030_periodic_timer, s);
=20
-    memory_region_init_io(&s->iomem_chipset, NULL, &rc4030_ops, s,
+    memory_region_init_io(&s->iomem_chipset, o, &rc4030_ops, s,
                           "rc4030.chipset", 0x300);
-    memory_region_init_io(&s->iomem_jazzio, NULL, &jazzio_ops, s,
+    memory_region_init_io(&s->iomem_jazzio, o, &jazzio_ops, s,
                           "rc4030.jazzio", 0x00001000);
=20
     memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
--=20
2.21.1


