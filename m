Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E1C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0750120637
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMfDhfGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0750120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcdI-0006d6-5q
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcaK-0000Pj-6H
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcaJ-0006JM-6U
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcaJ-0006J4-3N
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMQ8dVIZnYJPrg4MRf01ROr1UWOuRMuavJ9h1G8fyNE=;
 b=OMfDhfGBrTPSZDPZ4Nl3XO6mYEV3Jrt7wwV5TCeZ+x/9mcmvnOl3S9mDiI3gFXGEasxOtI
 2OKm0MQyWlCNueHVHDb8DNbZmznUcNuVTy09RkDq7zIXR4cjlecwchWfEA25IvCSAIZl51
 FWjIqfMW/VBcspyTY5xM2r9TAdBMGas=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-p52w7N_xNnq_aS2t7NQ9Ag-1; Sat, 21 Mar 2020 07:46:33 -0400
X-MC-Unique: p52w7N_xNnq_aS2t7NQ9Ag-1
Received: by mail-wr1-f70.google.com with SMTP id l17so3771852wro.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kX8C0eEcHvhI8rcexY79cvumv+xMMYTkKA4klDytxcc=;
 b=MlWXlhqwC4Hbe4Wrz4ihkn6Tam3e4nLMZp1LGyY6kRhXF++lLX+d670Y6NFqCBtvKX
 F/ezyxNouIYJpu7V24Bt0I2HYB3x3l3psJ3VpBt80v+1U7c4xDpM5Owya3Z31xHxTwk0
 uySwJZX0R1IMgOhwYOG4Sov2qEqLknTSFcVYSe7H8wGC6MZISq/USlHxt6zGLmJs4bBz
 ZLKWxBwIPgFlPYHIDGrexaF0bHFdg9yGwlZhINv46KxTx0UtgkfzTcHvjWEs5vHND2Ag
 NiT0xA9oO54yWCMQozzOp8T3B0Qc4XBszAtqtIE1E6wmJk0qCINDAgZi92/3qgpxl9Fe
 ihIg==
X-Gm-Message-State: ANhLgQ2/p3P0CY04awKHFfKxmWK/rSfMelSN3GBiEq2/wcmK5Oat7E6Y
 6+9WKXaJj3k3uksDjeI47TgV4eIbJRPnXRcPtYEo+DMptlXB5Oe1VCbt/DUR/9JJaZsQzCpcIoJ
 CkISgQyu+05bm0xQ=
X-Received: by 2002:adf:c44c:: with SMTP id a12mr17986423wrg.172.1584791191385; 
 Sat, 21 Mar 2020 04:46:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuT3XdAAValv75OTSe0ODvom2WIFeUB+FFeo0vbikqEyZ6JXGrJZ1M3aU7NlUmOl7P+zQMFFA==
X-Received: by 2002:adf:c44c:: with SMTP id a12mr17986387wrg.172.1584791191199; 
 Sat, 21 Mar 2020 04:46:31 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d5sm2667163wrh.40.2020.03.21.04.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:46:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 01/11] block: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:05 +0100
Message-Id: <20200321114615.5360-2-philmd@redhat.com>
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

  block.c:3167:5: warning: Value stored to 'ret' is never read
      ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index a2542c977b..908c109a8c 100644
--- a/block.c
+++ b/block.c
@@ -3164,7 +3164,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                     parent->open_flags, parent->options);
     }
=20
-    ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
+    bdrv_fill_options(&options, filename, &flags, &local_err);
     if (local_err) {
         goto fail;
     }
--=20
2.21.1


