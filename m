Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61BC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EBB2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0vLJ5d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EBB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFas-00006t-8D
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUc-0006w1-Eu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUa-0003w2-Gd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFUY-0003nq-Vf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kil7rh5PLCfhjtcevVysxbFfatlucuUN8GB4YOzVHM=;
 b=H0vLJ5d2YEnKS/TS154KBCk7ai+9qSk/0Sl2N4t9qBud8ocmsy4MrDsw2sXq4dtDKCqpED
 S3ugYeSKc/e/bNH74Kl+MY2iAbrbxmRy2r+X3PdCGw/v8XDMQpviuBgLFdwwSZXsAdqLnM
 wOcs3sQtq8wNuQt1TF7QsRHankYcakY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-qglXYJT-Mh2T67zQ2J5T_A-1; Wed, 22 Apr 2020 09:32:41 -0400
X-MC-Unique: qglXYJT-Mh2T67zQ2J5T_A-1
Received: by mail-wr1-f71.google.com with SMTP id j16so1028794wrw.20
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vNxCN6M06rXiAjKleOKzOmRwlxNeGgf99J9DO/nchhk=;
 b=SorS14jm2m0/bhrFkHnd6uN3Wpblel0HyuuUPl0mrUb88IMcgZdepTT4AC9aCS0cAi
 njGZlGWKd+PPNYeTP2dghULMYsIOSCS36VN8ld6cu8ro0ymT9b93Xg7aHz5YtK88Snhl
 1S3m2xjKRD4bE84P2ifzvnkYk7/8XUOtb/eRjpYX32V9evtpXWs9bOBjCgNavw7mOSiF
 y4mnzMdAl/Y8f+SK71vhFBeVqQBzqNm3NMQyFquQJQ7wusmPvLIDIx3PAXMohW2kJY1q
 EP2AdmTwq4C5l7zOy2UwLsrFgoGe0/UDt6zioL9Z2jFse7BKJDTz2RwtGDWWRPF8qVlT
 otNw==
X-Gm-Message-State: AGi0PuZjaeVpzOXVhoa4Rzxd9vkdSy1MbIayFJWQvbzvj/1cg7S0f1DC
 Npq00jhuDveLuCGnxLRkxPAOh8meVLqk8mi7Ve+fvPVEDhKbfettzzSSamE1Fl+0JT7J02jqynB
 S+WGDLYzB4en4W0k=
X-Received: by 2002:adf:ea44:: with SMTP id j4mr32086535wrn.38.1587562359420; 
 Wed, 22 Apr 2020 06:32:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLNL1kfi8mJTmgXfQFHY/uEF7HT0TawYfHGk35xmUGa5VK+gFzIu5dhO9Vpux9XAtjya1pDzA==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr32086518wrn.38.1587562359264; 
 Wed, 22 Apr 2020 06:32:39 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 19sm7525564wmo.3.2020.04.22.06.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] hw/timer/pxa2xx_timer: Add assertion to silent static
 analyzer warning
Date: Wed, 22 Apr 2020 15:31:52 +0200
Message-Id: <20200422133152.16770-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 "open list:PXA2XX" <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


