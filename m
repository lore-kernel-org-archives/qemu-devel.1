Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44650C4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B6220757
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f73Fq9/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B6220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfT8-0002r8-7Z
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfKS-0006GQ-Aw
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfKP-0007xV-TN
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfKP-0007wT-Lt
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TG3vD6dCJich6pAeWRU+T1xBswh8CnNUpTlBwJ1yiQM=;
 b=f73Fq9/MIQv8adz/ZgYmdwv/FqPikMBkNM4np1GwS6MkLvUUZeJQZOd0XVs0mhfgT50Az8
 zCiPih4HsFYrlOOweUzR356hxUKHdymRGkdWuq1AXl0H8Xc+oCJP+S1K3O//K8qengtI1V
 xh4oOBv7KVBXAooiRqLrxmWWYEnChac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-t5f1oDRDOd24NVLSDon0sw-1; Sat, 21 Mar 2020 10:42:19 -0400
X-MC-Unique: t5f1oDRDOd24NVLSDon0sw-1
Received: by mail-wr1-f71.google.com with SMTP id w11so4360338wrp.20
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zAAolWyXSH1ZCqRxa+9EfzNPi+VU6uagizFc7cEyMYQ=;
 b=NdP4xVoJezNLcG4yNQVSmdtDRUnEENrFFzW6U4DRMOT/XLYxLuYxt2uTNwG/GUtqi1
 +24IHzxl5fLPXfV8YpVAjYkLc5JEa42Oq8pYUYNXj5t+uvsHxgF/fi0ccAp92Amv2eSx
 Y6Yl4pPfQ8JmZgX2xA7xutap5wQ1ANq111ZESiEbKyFPVOa5bjvEpWCF1FGc61lruhsC
 49fESKhjbo0LDqmFioVeI8BEQVVKh9GC8MzbqqVlSiwc9ik3STbKe9k8ERolWvNgGmMF
 q8G+InYooMhaRJ2JopO12V7ulmz5jOu+wpfhoo8W70CROeHHpjpDnP9p8lfQnWyopU71
 sOYw==
X-Gm-Message-State: ANhLgQ3JIX0dLSQ8HS2DlN8d0FlbaaCRneOcQN/Pc+cXT1QgSsic/SVw
 Znh7x3B3smZ+icDnUsj71PcIrlwqfVnPLJGBsJJPyEV+09pCT6zlD94wvmmoEtjFjke+290M9ph
 0j+f5RyVWDffxzn0=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr18118308wru.426.1584801737792; 
 Sat, 21 Mar 2020 07:42:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsl+3ePkFRoRlIgn8f/HqRo7liy9CnmPsdS2QHY2gZeAqtjiG+Hn+C7e13XG+1vA7HdxTVxDA==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr18118265wru.426.1584801737585; 
 Sat, 21 Mar 2020 07:42:17 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id k84sm13063251wmk.2.2020.03.21.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:42:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 10/11] hw/timer/pxa2xx_timer: Add assertion to
 silent static analyzer warning
Date: Sat, 21 Mar 2020 15:41:09 +0100
Message-Id: <20200321144110.5010-11-philmd@redhat.com>
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


