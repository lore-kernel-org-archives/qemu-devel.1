Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0465C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B5B20714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhhPvsHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B5B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcda-0007DM-QF
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcaW-0000zE-RS
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcaV-0006RQ-SE
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcaV-0006R4-Ns
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQDd9EbUfb0uuK6iIsTzZMSp5qbZytglJrEh2QYroHU=;
 b=LhhPvsHqd+9gdTRral+5RxEjZBb55LkoxKF+M+4woFoWlVl+baD2C8ezh9bEWIunzAXSje
 O/orR9E5XjJosjOliB1f/hibVjX1f6VjNcsja31nVJ4ebaoLz4XzBg6dbHAM1v0SM7fqVZ
 KMeqTee5qLPCkZE4k7fTRcyuGG0l7OM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-9XMnFl3QMz24FJrC1AOHUQ-1; Sat, 21 Mar 2020 07:46:45 -0400
X-MC-Unique: 9XMnFl3QMz24FJrC1AOHUQ-1
Received: by mail-wr1-f70.google.com with SMTP id b12so4215754wro.4
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7jHPzgLUxabSngeicFYbktzokTE6KbRJJJ5XQsCuGXA=;
 b=fFSjHh4f0tzltGK6FCynw8xMGYrJyqFIsBgy9zrOkgaibK6PmpxJBCw2qyDEaQOqno
 XXyM6siefXXfM7JdplhjLAXZXlCdHDaLRG8hNJy4WDvKOz6aeoFgOb8jATMqY2AtTUKv
 PZ+2BmHUy8XxtHefjwcOWkOcjI2vbBUzzMczw+BYx3paNhguMfd2rxiYSolc+Sqt6Pma
 yw6RZKZGAJA5PbA/YkHw+XmkTAnUJXcrDesVX3Pqay0bXUJVce5NuhfU9gC20s6RyXHO
 FvKQE7EyL9fpxN63FoGL235H3z7VXRT9rNBjTGmYTE1uz+xs+p5/HuYdzzBZlZ8eQID/
 GlWA==
X-Gm-Message-State: ANhLgQ0NON0Dl0x+4r0Y87OyDGiyuhEO6QeafGPrHEgGRlj0zaVGFFQS
 hSOL37MjtYdosEHgBfnVBjqqzJGrd+rxfwiJMfUjmmjy+dSap3QVW6/SX1fl0pEyyQ7+e1OTuQG
 fbcK0pKDmPz2dYCs=
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr16786078wrw.408.1584791204442; 
 Sat, 21 Mar 2020 04:46:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFSW+CXcA6YfLipptcKR9ABiJniuj3MZjBTWYLGZb0p+0Bf/8+S0d9XoeCUTxe7T9qj4FMdg==
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr16786051wrw.408.1584791204274; 
 Sat, 21 Mar 2020 04:46:44 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id i67sm13424296wri.50.2020.03.21.04.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:46:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 03/11] hw/i2c/pm_smbus: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:07 +0100
Message-Id: <20200321114615.5360-4-philmd@redhat.com>
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

    CC      hw/i2c/pm_smbus.o
  hw/i2c/pm_smbus.c:187:17: warning: Value stored to 'ret' is never read
                  ret =3D 0;
                  ^     ~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i2c/pm_smbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 36994ff585..4728540c37 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -184,7 +184,6 @@ static void smb_transaction(PMSMBus *s)
                 s->smb_stat |=3D STS_HOST_BUSY | STS_BYTE_DONE;
                 s->smb_data[0] =3D s->smb_blkdata;
                 s->smb_index =3D 0;
-                ret =3D 0;
             }
             goto out;
         }
--=20
2.21.1


