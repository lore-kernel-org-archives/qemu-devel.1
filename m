Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D3C4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D281C20637
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aeljr/Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D281C20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcdD-0006T6-UI
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcbS-0002gC-4s
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcbR-00079m-0u
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcbQ-00079Q-Td
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEdgbG/luCssALBIqG8TygafayDXTkEa0M3aN0ohCNI=;
 b=Aeljr/TqdJrW03xZZM4tOGzYDFf5As6//+5Re/GwqhLvD5Cgv3jid2fyazmOmVyB/nVB60
 xGZtFcaR+E99CtezBFa7GZbTHPw8g1t8PZjFnLwvjVM4+ZCws6mcUNbQWsFccZxM0Op5M5
 q7Yrze7/IACBLVJN6nlycx2OSeItuJA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-fcAJNDnGOVC85t8A2lqXXw-1; Sat, 21 Mar 2020 07:47:42 -0400
X-MC-Unique: fcAJNDnGOVC85t8A2lqXXw-1
Received: by mail-wr1-f70.google.com with SMTP id b12so4216770wro.4
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RNYtNktAqDdDAs+EFJozo/fN2JmmaPRaAB7IeiBu7pw=;
 b=XCXIVJFKvlqgByKspJcVE2JU3nVTV6GMtpAPH1VxOr0SVXcjK0WsbvF1j2fRlChC0S
 Zpb3Wlsfo1nfuYfXqBdnbqR4b8+LxCQ3xRWMImG2JLYSDTugvYNjl3/TVfqRvE///Ou+
 xYzjomCBLl6bB1uWaZEbHepjcko5dlcQsFRucwS4C1+jjCzyXkF9szw0Rb4bwqVS/n3A
 +4YSaB1d6lrXC7t9FU6sckeSs6VrIvHgtWA5BkoedchiDFPJ3CmCaSTAsvlzMiLsaogN
 KQE+n4++ok38PBq9/Bsmo9HLq6vdiPj/wZsUKIY/dRtlVPWn/CDokG0K5+ExuGbHjb07
 Au6Q==
X-Gm-Message-State: ANhLgQ0ESlNsyr7Dj2tYxaRWgSnEVD+KDn11Lw1Dgxvo7k1XX1Pjws2l
 6gp2wJOQe75RJqPHzL9v6AeQO1kqYCQPQsVqA165stKeLSM71ncCydhInwFtqjdMZ8Xi8u/m6O2
 IrAbCwXo0mc5tTm0=
X-Received: by 2002:adf:82f7:: with SMTP id 110mr16733195wrc.373.1584791261269; 
 Sat, 21 Mar 2020 04:47:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubbmq/qIpJmOqmMG8os2wSMw39sfHglC6xWNohsFGnLp3+N7OMkezA8fRZyCRCUVesI83LnA==
X-Received: by 2002:adf:82f7:: with SMTP id 110mr16733166wrc.373.1584791261035; 
 Sat, 21 Mar 2020 04:47:41 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id a11sm13098686wrx.54.2020.03.21.04.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:47:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 11/11] hw/scsi/esp-pci: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:15 +0100
Message-Id: <20200321114615.5360-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200321114615.5360-1-philmd@redhat.com>
References: <20200321114615.5360-1-philmd@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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

    CC      hw/scsi/esp-pci.o
  hw/scsi/esp-pci.c:198:9: warning: Value stored to 'size' is never read
          size =3D 4;
          ^      ~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/esp-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e017..2e6cc07d4e 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -195,7 +195,6 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
         val <<=3D shift;
         val |=3D current & ~(mask << shift);
         addr &=3D ~3;
-        size =3D 4;
     }
=20
     if (addr < 0x40) {
--=20
2.21.1


