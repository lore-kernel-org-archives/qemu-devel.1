Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF69C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A5D20714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1TWMwEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A5D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFci1-00076Y-90
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcbB-0002C6-Jg
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcb7-0006uk-Pt
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcb7-0006u6-MA
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RrFXtWXIAKlsNCj4fxVkxendU8386lJ6GdPQwHKuZc=;
 b=D1TWMwEX9ZHUpzrk/NhxEu5k+MrtcM9xQ6Pu4xlInSC1X0JQ0k6Wbeu2TV+wBD7sT6Gcsl
 0VCEVP5T8e/wasSjaaS6Q1H+0zkcCKh+GamgyGabQV1GUkQXlGIwL4IW2O3W2QjpZ6bKWU
 8syQvxUyBBT59aM/l3WH7L+GCdhbFko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-BytY6CUWPaSXVzA9m0jOJg-1; Sat, 21 Mar 2020 07:47:23 -0400
X-MC-Unique: BytY6CUWPaSXVzA9m0jOJg-1
Received: by mail-ed1-f72.google.com with SMTP id b12so4477643edy.7
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9gGzKQU/hca0N/HfH89YEyKKEwjuVATrynJmMDBqHuA=;
 b=XavToNS5ZtIRJHzVJCVkOpzgsoSneYJGpBWgkSnY4kzA/+WUbcuWMt2/Uejj4O10Wk
 ONUyc9x9LdMuYZseW//dugfvysDvTvA4StmdDQgrjlXFkiPpcqn5rbg02TCrF2tjYHW8
 dlBJnhR5qAGZaAG7tGhy8GyfOn6LBPVMSTWYdtRldTr8BTuE9ZE3FJbpSaj8RnWn/yhX
 M5RDG6HWzLxXZtQ4uFvAX5v/Cw5MxsYQHf1Mev4NYnidMtI/nO3KJ0cmfoiDObId/dts
 EGAg8d+ee9EpE1/uaStFiofSH9f5CstUdCEMeRQIehEmxfSaruc+PSOLmt5SI6S2v2Ro
 Ry1w==
X-Gm-Message-State: ANhLgQ0C76IYf28Ki1V3nBc2IlTAG9K0deS7riRd2o7g9gv0LMVY056v
 +MiK7xIkPhSUHthlgTP37LTlQujpsNu/h1VPXD7b558k4e2iWlypvtPrG90QXL5a+mIfHiGKm9O
 0ATjQbtbCI8B2tXo=
X-Received: by 2002:aa7:c0cd:: with SMTP id j13mr12145112edp.287.1584791242059; 
 Sat, 21 Mar 2020 04:47:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsNje2ZBWZggIXMm+1aJu4RAQiqKLCRY2id164eUSg0Un6tqRjsI5Yaw3McsVqiA0SKAsuv3g==
X-Received: by 2002:aa7:c0cd:: with SMTP id j13mr12145088edp.287.1584791241814; 
 Sat, 21 Mar 2020 04:47:21 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d23sm540531ejk.26.2020.03.21.04.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:47:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 08/11] hw/timer/exynos4210_mct: Remove dead assignments
Date: Sat, 21 Mar 2020 12:46:12 +0100
Message-Id: <20200321114615.5360-9-philmd@redhat.com>
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

Fix warnings reported by Clang static code analyzer:

  hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is nev=
er read
        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is nev=
er read
        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is nev=
er read
        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/exynos4210_mct.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 944120aea5..c0a25e71ec 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1367,7 +1367,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr=
 offset,
=20
     case L0_TCNTB: case L1_TCNTB:
         lt_i =3D GET_L_TIMER_IDX(offset);
-        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
=20
         /*
          * TCNTB is updated to internal register only after CNT expired.
@@ -1396,7 +1395,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr=
 offset,
=20
     case L0_ICNTB: case L1_ICNTB:
         lt_i =3D GET_L_TIMER_IDX(offset);
-        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
=20
         s->l_timer[lt_i].reg.wstat |=3D L_WSTAT_ICNTB_WRITE;
         s->l_timer[lt_i].reg.cnt[L_REG_CNT_ICNTB] =3D value &
@@ -1438,7 +1436,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr=
 offset,
=20
     case L0_FRCNTB: case L1_FRCNTB:
         lt_i =3D GET_L_TIMER_IDX(offset);
-        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
=20
         DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
=20
--=20
2.21.1


