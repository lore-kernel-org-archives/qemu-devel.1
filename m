Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC699C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DE420754
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIsiUhjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DE420754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcjL-0000Wv-Ib
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcbN-0002UU-OD
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcbL-00075l-LG
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcbK-00074l-QP
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TG3vD6dCJich6pAeWRU+T1xBswh8CnNUpTlBwJ1yiQM=;
 b=IIsiUhjIIPDOHbDbXlsn8XNlj4D/zh+WPObtHyVu7N9yLNl03wjZR46B+/E7O9RLD7af4a
 3GYwK+BmhSRkUTLogWHk6VVwsPydCej2/ya5YCtlqZyQcVUH3Gx4D4x4pPxQKvbzcxRf16
 3AQENERAc5wJ4yIg47j1CVdgTISTaI8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-SXinkYuBMxq6LSNOlwq-4A-1; Sat, 21 Mar 2020 07:47:37 -0400
X-MC-Unique: SXinkYuBMxq6LSNOlwq-4A-1
Received: by mail-wr1-f69.google.com with SMTP id g4so4176999wrv.12
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zAAolWyXSH1ZCqRxa+9EfzNPi+VU6uagizFc7cEyMYQ=;
 b=RUQs/+PMTSfhcmnQfPScAkY3umfgUyAqdYqyCqcVnVXYhg0J0GwuxBEQXVotV81wjM
 5VGqP7MtCaXV0TrBehC+rkCm6sVLEFO0cwPlnpwRyrTPJX2Ygh7LCKoLNnPzxO35K6GM
 F5C7GKYlq6T6Baq2l8jfMQYiuPh5MVuk0iYSnSdTf9Z0yWXExr86ODA1iskxBjtuxtL3
 ozJgyMIVZeJfcQAmIYy8K6jCL7t4i6brbRCs78Fjsr50l0KWbub0K60cZc6WROLZ5BQ8
 FnrfJ94EH8Bt5cIzxC7eozzGAscyQ+IUMLlJMxHwTThZ3LmdhOcd3YMSmSahRwtybb0j
 jZ4g==
X-Gm-Message-State: ANhLgQ0IRmO7Czwsh322vSTnbuveTJGHpRWeRX6j7ZgCOQxcYG9Sds3T
 HTzJdm002OMXC26mNe04qojJnRmhk1xHWExetCrqHMD76kYTngmdpnBtF7Es7JoNjdffMIreXfc
 wu4vwjyhOsOafSLI=
X-Received: by 2002:a5d:628f:: with SMTP id k15mr10384655wru.404.1584791254910; 
 Sat, 21 Mar 2020 04:47:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunMup0EkhHY5Z4VqmUt/VLtiE0tE9EtlCM6177KdVJaaGEx8Tohte6eaOFXmY60+p5L/3iMQ==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr10384613wru.404.1584791254676; 
 Sat, 21 Mar 2020 04:47:34 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id q13sm12849850wrs.91.2020.03.21.04.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:47:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 10/11] hw/timer/pxa2xx_timer: Add assertion to silent
 static analyzer warning
Date: Sat, 21 Mar 2020 12:46:14 +0100
Message-Id: <20200321114615.5360-11-philmd@redhat.com>
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

pxa2xx_timer_tick4() takes an opaque pointer, then calls
pxa2xx_timer_update4(), so the static analyzer can not
verify that the 'n < 8':

  425 static void pxa2xx_timer_tick4(void *opaque)
  426 {
  427     PXA2xxTimer4 *t =3D (PXA2xxTimer4 *) opaque;
  428     PXA2xxTimerInfo *i =3D (PXA2xxTimerInfo *) t->tm.info;
  429
  430     pxa2xx_timer_tick(&t->tm);
  433     if (t->control & (1 << 6))
  434         pxa2xx_timer_update4(i, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
, t->tm.num - 4);

  135 static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int=
 n)
  136 {
  137     PXA2xxTimerInfo *s =3D (PXA2xxTimerInfo *) opaque;
  140     static const int counters[8] =3D { 0, 0, 0, 0, 4, 4, 6, 6 };
  142
  143     if (s->tm4[n].control & (1 << 7))
  144         counter =3D n;
  145     else
  146         counter =3D counters[n];

Add an assert() to give the static analyzer a hint, this fixes a
warning reported by Clang static code analyzer:

    CC      hw/timer/pxa2xx_timer.o
  hw/timer/pxa2xx_timer.c:146:17: warning: Assigned value is garbage or und=
efined
          counter =3D counters[n];
                  ^ ~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/pxa2xx_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index cd172cc1e9..944c165889 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -140,6 +140,7 @@ static void pxa2xx_timer_update4(void *opaque, uint64_t=
 now_qemu, int n)
     static const int counters[8] =3D { 0, 0, 0, 0, 4, 4, 6, 6 };
     int counter;
=20
+    assert(n < ARRAY_SIZE(counters));
     if (s->tm4[n].control & (1 << 7))
         counter =3D n;
     else
--=20
2.21.1


