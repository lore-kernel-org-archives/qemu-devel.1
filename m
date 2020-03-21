Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CDEC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5236320714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH35ds0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5236320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcfl-0003Kc-GV
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcbG-0002K5-V9
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcbF-00071e-VA
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcbF-00071A-PS
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2ZxNlM8IiHu0dxI+a0SAXUIREttoqtshJPpfqAJ9kA=;
 b=bH35ds0DMoZduKLgjBHWO9f4IJp1Ixr6/U+vBxA8umgGbczJIih/Mel+U6PAYq4D1c6Xo7
 VCPcuPUHJ1LiJijEUyNr7X9d79IhgEAwCkA+ME46Gq4VFXFENfEVhMD6CGMHVXigXjaeYP
 ABThzzCkxrdwxfeD/UxE3Ah855agx14=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-kEFY3LONPUWlafTG-11sCA-1; Sat, 21 Mar 2020 07:47:29 -0400
X-MC-Unique: kEFY3LONPUWlafTG-11sCA-1
Received: by mail-wr1-f70.google.com with SMTP id v6so4137819wrg.22
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=860B2IkAp+GSKWrMYmt9BxqMmpnco8VZzzV9xEgKT/A=;
 b=VJ0npswumx3uZdgl2HFGdN5r1qSSBhBWq/+FcFNS4t/g63hbQyms6Kk4cTBjNhMLW2
 mfqudRWxIDsnf7uZ8yWQ/1nS2V8yiyfoy8s3iSLoVEwEVKcV1gosrC82hhAMdMTmg9nu
 dHzG/uj+/UjkoRoQQ+nJXiNaDnoiASnBbnrxOULGuqmw+tSzAk+l9YNNhbLQ89mR2Inw
 7ivyF993oqgoUb666lCdrLUOTTzk7sfvaN8h9FnAmH02Flu69L6JCeAh7AXG5qyCO7+N
 qd1VRysIUJZiC4OdnTjJEi0rjoMyualHCB7weHp2qF+zwn+Gr/1sD+yXyU3wJNAb4e8U
 LlCw==
X-Gm-Message-State: ANhLgQ3uHHQUzYo4NUFL2JAHIi7yL06JU/QSGbBUUogWLOp18ysY38lr
 l4BReQ54+SR94W76+eoOEkJWkodL0tLPqwwLlTZ6HnPF+E2XCt26WPv4POFdTCr2tlKBc+ZZkLM
 E+rDXIngtaAMtfrw=
X-Received: by 2002:a5d:6082:: with SMTP id w2mr17078556wrt.300.1584791248577; 
 Sat, 21 Mar 2020 04:47:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsvu5wfvhRuM6jVgboSn3IbxzjQxhFrW0gmXdleJclIAtsXaDBlpnQ+JjoWQKg5OAX+ODoNhA==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr17078523wrt.300.1584791248363; 
 Sat, 21 Mar 2020 04:47:28 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id s22sm11269798wmc.16.2020.03.21.04.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:47:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 09/11] hw/timer/stm32f2xx_timer: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:13 +0100
Message-Id: <20200321114615.5360-10-philmd@redhat.com>
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

    CC      hw/timer/stm32f2xx_timer.o
  hw/timer/stm32f2xx_timer.c:225:9: warning: Value stored to 'value' is nev=
er read
          value =3D timer_val;
          ^       ~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/stm32f2xx_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 06ec8a02c2..ba8694dcd3 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -222,7 +222,6 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr =
offset,
     case TIM_PSC:
         timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
         s->tim_psc =3D value & 0xFFFF;
-        value =3D timer_val;
         break;
     case TIM_CNT:
         timer_val =3D value;
--=20
2.21.1


