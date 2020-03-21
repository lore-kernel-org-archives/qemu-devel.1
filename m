Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34425C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE0220757
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cwt4HIDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE0220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfNe-0002mi-3H
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfJu-0005Q0-NL
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfJt-0007V9-Kt
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfJt-0007Uv-HN
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvtpmJoV32BEyOe596XwKOYG0GxD3I0LNs6dD0KNAUs=;
 b=Cwt4HIDO8AQsqVGCL3OLnJGOmupuZxiZ0aJW78aOXREVrDGYFHxksKyvlkq1RR2PmXU7Ce
 fsUfTqRXZ1cExln8I5oIhI7VC3f9lZkDizbLThIVxorKQmpQAVhNkXn82S2bG8E+KJWS2o
 KEkL4vfFVrMNq4e2BWpueWxoHgyy5uo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-D54etfosOv26yJD7_MCgDg-1; Sat, 21 Mar 2020 10:41:47 -0400
X-MC-Unique: D54etfosOv26yJD7_MCgDg-1
Received: by mail-wr1-f71.google.com with SMTP id i18so4352266wrx.17
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bL5NUrmTjbHjm3pvKXbJpPZgk/5XIoNG4lJHv7ZuRaU=;
 b=SIz6Wz4MPoUqU6OUWVbZ0hWrSHE6PkajIxljV95mVclH4RhY0x8YhVys6O5HTBI25V
 6BzXtihMVUKUZcz1PFZOAF5tgWdPerSnsoyuIpvbMa1ISA+jXPVyRSUbLPQjBjaXX7X6
 niKGB6FHzHNSI+u2CKoSHw6ddKI1d/NrneXnG6gR3h+m8hzrZ/Bh4lzYleSy1SVGmbax
 UFhWFZ3tioWDYu/mUWqPvwJdCFVP9exXWCysxvqCydGl4JQci75a2Jbb5IWJklwLa6A1
 tx7R+g+FguVRXAGtIZ3bo9dJRTMmCdZ9MhFdTUzR37WxawuOkgPfi7hsF8mSBLdRKCR+
 093A==
X-Gm-Message-State: ANhLgQ2YZPR6rpEDliSwN6/fHbeYNgFSC0HL1fmU6M9gU+b+gUFr7aTA
 +zF7bvkOZA8vduIpHYCk0nnuwvxxaLzbncz/H8YTm472yt7ph9R7PILRPJiuthzY+wM9zQSDc5l
 rBghAaNYajRjovzA=
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr17193376wmk.160.1584801705931; 
 Sat, 21 Mar 2020 07:41:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvPBABnTVrFLPi9F6uhCW5QPfP0PaTUxHoC+sJfC9KClGy5HdXjRGO23/0BW9pONNYT7mVwuA==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr17193337wmk.160.1584801705724; 
 Sat, 21 Mar 2020 07:41:45 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id n2sm14551205wro.25.2020.03.21.07.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:41:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 05/11] hw/ide/sii3112: Remove dead assignment
Date: Sat, 21 Mar 2020 15:41:04 +0100
Message-Id: <20200321144110.5010-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200321144110.5010-1-philmd@redhat.com>
References: <20200321144110.5010-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/ide/sii3112.o
  hw/ide/sii3112.c:204:9: warning: Value stored to 'val' is never read
          val =3D 0;
          ^     ~

Fixes: a9dd6604
Reported-by: Clang Static Analyzer
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Fix the correct function (Aleksandar review)
---
 hw/ide/sii3112.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 06605d7af2..b2ff6dd6d9 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -42,7 +42,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr add=
r,
                                 unsigned int size)
 {
     SiI3112PCIState *d =3D opaque;
-    uint64_t val =3D 0;
+    uint64_t val;
=20
     switch (addr) {
     case 0x00:
@@ -126,6 +126,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr a=
ddr,
         break;
     default:
         val =3D 0;
+        break;
     }
     trace_sii3112_read(size, addr, val);
     return val;
@@ -201,7 +202,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr=
,
         d->regs[1].sien =3D (val >> 16) & 0x3eed;
         break;
     default:
-        val =3D 0;
+        break;
     }
 }
=20
--=20
2.21.1


