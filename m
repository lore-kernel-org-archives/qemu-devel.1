Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906DAC35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA01222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVqh4gPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA01222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CAu-0008Ov-Ho
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8m-00065x-Va
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8l-0007yi-UR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8l-0007yM-Pm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2pPJB7dVv53xB+pM6ByHDe1JdpbC3cSQ0yop2iaXBM=;
 b=CVqh4gPK64BU+2r+AAn8/4KtAaYQxnGvkFzRzYr493HlwxZo8GAu90IuE5vfPcpZTX0Mlh
 1AxG40C5D6l9w0RoICfJe6YmDDJ86jETpLbq213KBwlPtWz78FIT++1pHiNXowUe3VXGsQ
 h3bvkOpam5KpAJyli08nA8GEwwTaBdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-xiPfrd_HMey2i75zoVhZIg-1; Fri, 21 Feb 2020 12:31:01 -0500
X-MC-Unique: xiPfrd_HMey2i75zoVhZIg-1
Received: by mail-wm1-f69.google.com with SMTP id f207so854794wme.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1tNyRzGC0EsXOg8ox9ROXwfpcEcBwuRdTCHdqcdRxTY=;
 b=KUP0Y3wRDw2bKfJjWOMPOtHNTW3nxCMsKEzUbpK2zQeGDf33YCIT4ivapzMXOxfYwG
 11vJ8yD1jIQu1adozGMvu+8K35ev0+HDQYxGf6XmXKTjjH5Rr+FPi1VYkf8bRMMK6hi4
 VKBfTQlAoo9hWcZS/gad8DX7ZYcH8go8wtikCaPox5+Bdz++yRvv+RXUeKdebyh+pXCU
 jGnyCpyPHGGbTpFsM7u923BgB82QdS/sS6OhAbor0I881RnxJTD14ML3O/qt8nFTdVKN
 t+jfETsQfBebCwr2YxCazam3n0N4Sd3hC33jeBEgTYmUhpklUgimaI3q0WyLdCsQnR+Z
 GEgg==
X-Gm-Message-State: APjAAAU3qpfHY6dnlumdGEru1XK+6JEGHyRWCpxVfP4D+O7nuDamp+M4
 Q1aDDf6yjGQRJcAyPz1woDfC4wL0W/Ku7yIMU8ZBI0S7X+HkMRdVWxjj4gmkwMqEDeZ3SO6GUMi
 reGvHIYDfPagRc6c=
X-Received: by 2002:adf:f091:: with SMTP id n17mr48035246wro.387.1582306260616; 
 Fri, 21 Feb 2020 09:31:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAW+qR5XRP7uwi7KWjtLc+Ik1gy311YfEvXAKKV0p8ZnHFE0EazAPFpnBibOLVdwTqQTE/UQ==
X-Received: by 2002:adf:f091:: with SMTP id n17mr48035215wro.387.1582306260447; 
 Fri, 21 Feb 2020 09:31:00 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:30:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/core: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:46 +0100
Message-Id: <20200221173049.18134-5-philmd@redhat.com>
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
 hw/core/platform-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 22c5f76dd0..d494e5cec1 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -187,7 +187,8 @@ static void platform_bus_realize(DeviceState *dev, Erro=
r **errp)
     d =3D SYS_BUS_DEVICE(dev);
     pbus =3D PLATFORM_BUS_DEVICE(dev);
=20
-    memory_region_init(&pbus->mmio, NULL, "platform bus", pbus->mmio_size)=
;
+    memory_region_init(&pbus->mmio, OBJECT(dev), "platform bus",
+                       pbus->mmio_size);
     sysbus_init_mmio(d, &pbus->mmio);
=20
     pbus->used_irqs =3D bitmap_new(pbus->num_irqs);
--=20
2.21.1


