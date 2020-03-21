Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B80C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110CA20714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPY3AvL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110CA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcfO-0002VT-0J
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcai-0001Le-7U
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcah-0006ae-50
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcah-0006aG-1l
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4GCDGuXxVBz+Q5fzhTo9pG6tPh9hgrqUC7e1TLGPOU=;
 b=hPY3AvL/rn5OmGMQn6XFbJUp9MOxmkHpe7cJH4dzYGQ0j30UQCT443H7iOlLVP6qsCc8AU
 oPW0bOxhRvOcRSxWgNGUECuXa2dXc2Mu2Gtt9Anlwqrn9lwmIOcLkbDVa5dYnGQodgl7ht
 tSXOXFv5v2fBmet2IGzIrJYZWs6emZc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485--yLcort2PHGRixcSt5MazA-1; Sat, 21 Mar 2020 07:46:57 -0400
X-MC-Unique: -yLcort2PHGRixcSt5MazA-1
Received: by mail-wr1-f70.google.com with SMTP id o18so767824wrx.9
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EI7aeJF1EJiZnbf/LHlroG4oQCKwaeGXEJr4kT4GssI=;
 b=OJzs3Ak+bznNkJUhuKVOoJ4T/TKfubwRcdDgvlUOAu7utbnV/Ju8D0OsrVcQ3cWezO
 Yon2d1dF4JjK73rKwwyHszisVv8zoPVauH74Gj8CWXFg+TanUFyIs/n6b31yVI4u/FQ7
 mR4TIV2KVcl5hwQnHJvTLvIjFk43XA9qRYuWD6054k52+qzJZX18ynnVllIQOTjQmiD0
 /WPD85dAKcWAWs+ybjKGJGhzIeyYIrumm8fQLtoNyIsKwLESR/5+PwPdDOyS03ZxlnJT
 jsswP7vqm/96d2Stdd1W0pgnhGpFtusmzfPIKn5S3qtvClVnhhz3NPXVfcqgFBKIHhbY
 Vahw==
X-Gm-Message-State: ANhLgQ3nXWf24Irp6+PiBlGv4nC1E7dyRQ1+hdiyFvEV06umKcx5CCTw
 /PKBvFQZNXd3su3ZYbSsZga3e49rMMPdo+DOiT78RzaBLyXFx2W+kwJSqWekKILZHBPVAeYDtnt
 Lx5A8cQBUdI5mBh8=
X-Received: by 2002:a1c:a950:: with SMTP id s77mr15599448wme.176.1584791215862; 
 Sat, 21 Mar 2020 04:46:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvfQ4vrBm8KBgyUaD+hLChCbh5Ae2/d75e8M+xeE+5T8Oik5ZY2x5rINBu/X0yrYPRPHas5yw==
X-Received: by 2002:a1c:a950:: with SMTP id s77mr15599432wme.176.1584791215666; 
 Sat, 21 Mar 2020 04:46:55 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y189sm12549500wmb.26.2020.03.21.04.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:46:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 04/11] hw/input/adb-kbd: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:08 +0100
Message-Id: <20200321114615.5360-5-philmd@redhat.com>
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

    CC      hw/input/adb-kbd.o
  hw/input/adb-kbd.c:200:5: warning: Value stored to 'olen' is never read
      olen =3D 0;
      ^      ~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/input/adb-kbd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 0ba8207589..b0565be21b 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -197,7 +197,6 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
     int keycode;
     int olen;
=20
-    olen =3D 0;
     if (s->count =3D=3D 0) {
         return 0;
     }
--=20
2.21.1


