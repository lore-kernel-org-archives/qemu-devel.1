Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E7C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330E6222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESUscsSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330E6222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CD3-0002em-A4
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8q-0006Fl-Nk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8p-00080p-JU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8p-00080J-Es
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcJ0r25XnABvMzyrrGJORHDPS5fue3w9osOFGOe2Mkc=;
 b=ESUscsSldpayKZq6GbAqKDqn3745z+nJuq29aBjfZ1Q7p2xXJ1NqiL58qTVyZZH6h82PET
 +S/4qDiBbJyvwbTjnAvU4oCn75qy3EHHN8OPQiCnFErF7GFsXgSm9wOrNRFB6lCYF6u+Zi
 Jfk/w5XjoVDDKRP+7phvu+8L8LEv1SM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-OVjY4K9NMZaD4oGzVar4jA-1; Fri, 21 Feb 2020 12:31:05 -0500
X-MC-Unique: OVjY4K9NMZaD4oGzVar4jA-1
Received: by mail-wr1-f72.google.com with SMTP id o9so1315351wrw.14
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vBRFsAffF41rgxvlY5ZKXchGXzJT1TmiIiTOimH9EdI=;
 b=BGn2v97TZg6pHkBDvYsFMVRT/O0EawAEvsg/DcloRV+suNFYs7VKvD6VuxFvlnhcJ2
 vXjwKSRyhi/Wo1Bog2c90c0/1laweKGpK3RsCCvbecVjzCRX77MvUcGgBofYj4iheUNw
 7bqK9k5AyjmncT+zPap90hPMrACdMp91Wq7odvJvHhg+668ZdDBA5HPzS2mecUTOnfFN
 aHdqTi6yOs2cQq3YKw/TzW7A+44r8Hun2zCRNDmdYHLUMausooxsEjvg72r3pFxBh5J0
 IeY1hk67nCIPq0v335/WQ41VbbdbbR8nWOtd2fslUrInC44PDqdpOwONhi1xBqKO5hTP
 VITA==
X-Gm-Message-State: APjAAAVlhwTc3LesQvtutew3FTsiliRivMy7w2A6jEuQQGcVbHoLmgMs
 91PWujHPg5CXbKq3bwSKRpn5FW7c8NmMheNlJjFI5kPwx0HWDzA8xnbHnofwN/DQaX7ysO4f5lU
 aMsZh3fAbQ38pZJc=
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr5069526wmf.102.1582306263753; 
 Fri, 21 Feb 2020 09:31:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEI/3oNsoby0bNnihrImcdqmlWs6JCexTdc29W5L27hyKcBACqbzBuXeY5ABZ/RF+Qns1Heg==
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr5069492wmf.102.1582306263543; 
 Fri, 21 Feb 2020 09:31:03 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:31:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/dma: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:48 +0100
Message-Id: <20200221173049.18134-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221173049.18134-1-philmd@redhat.com>
References: <20200221173049.18134-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid orphean memory regions being added in the /unattached
QOM container, use the memory_region_owner_nonnull.cocci script
to set the correct ownership.

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
index c4cf8236f4..f62eb3d2a3 100644
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


