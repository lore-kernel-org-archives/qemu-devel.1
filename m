Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66AC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF4920663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF8gJ8M6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF4920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsiW-00028s-1a
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDqjN-00080B-HY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDqjL-0002sZ-LN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDqjL-0002rz-Fl
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584368915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fOKrfo5bbyxSEwW8Bb/6gBXkGPftjp1ADluFRQkIlR8=;
 b=dF8gJ8M6SgkNs2vSCkvBLwOyrakVtO8bCiwskhwEjcEgwv9dpLyPM+XAmoDSUmNkGIYPxp
 Or3eRkpm8yvybHqydtO0KOkF7BZ+WgfdZrPDAvrDnLypMTvYOit0CBE2T6Xl2q7ch0y/jK
 G7v6jbTTVhpOP0V7eofub3GSOYLGYhE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-WwImNHVIMcaqyVaODKsUBQ-1; Mon, 16 Mar 2020 10:28:32 -0400
X-MC-Unique: WwImNHVIMcaqyVaODKsUBQ-1
Received: by mail-wm1-f72.google.com with SMTP id a23so5867312wmm.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TDKRgixbJAcVUYD4Ybb2gvKa7rLyvdtOHGcjQKF6N9w=;
 b=UAy3ifrVeXBA7CLTMxYfcYJ21FqkGGVTEaA3+vNIPzstXikaCymEGULGSJeFt+RjPw
 MPwqMt5lTI6Y3bW6tQL/YWQ0wnEO9cZ2oQVhaM/1MZpSwZ0uz7SBgMszZwNl7RU7gx/y
 sNIyGofmZo4WyUKqLkR7LK4jr2PV24YdVNac3d7QA3uE3Q2HVizMiGkXPDU4t5n7+Y4m
 4vbTYyajY5mxNGSsj55CrLQPMCsOyBV8Unc/d7S8VYLclsqLfNFw0dwufQcs5wewXe38
 1isOJftAm47z4wfaUQqBIfALfjZuwiJyJiqUWzbJGAvYjzu4L5wMOFCm/l6TJFX8Sw2z
 ypZg==
X-Gm-Message-State: ANhLgQ0ZWhsPSg2eKorLx96FPV53iIk4yv8V/DiU8C0AT16n9NF03DiF
 YlUf045WKUPUOq5/YxL94L3eM9W/DTVv5PLICXm8RDIIABe7Dsjgm2KQSgwqPueCQUVung//A6Y
 /KnImQrc9p6mm5SE=
X-Received: by 2002:a7b:c391:: with SMTP id s17mr27039050wmj.55.1584368911114; 
 Mon, 16 Mar 2020 07:28:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6eNhDEYbXHwMl5ihSAYArb+HJ5waefmoYQoCCKuDAoI9gtrCoKXJA0yOJKdtgD+h3j7Pc8A==
X-Received: by 2002:a7b:c391:: with SMTP id s17mr27039033wmj.55.1584368910848; 
 Mon, 16 Mar 2020 07:28:30 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id z6sm94673wrp.95.2020.03.16.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Michael Walle <michael@walle.cc>,
 =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] MAINTAINERS: Mark the LatticeMico32 target as orphan
Date: Mon, 16 Mar 2020 15:28:27 +0100
Message-Id: <20200316142827.20867-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Markus Armbruster <armbru@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Walle expressed his desire to orphan the lm32 target [*]:

  I guess it is time to pull the plug. Mainly, because I have
  no time for this anymore. I've always worked on this on my
  spare time and life changed. And secondly, I guess RISC-V is
  taking over ;) It has a far better ecosystem. Also, to my
  knowledge the only (public) user of LM32 is milkymist and this
  project is dead for years now..

  So time to say goodbye. It was fun and I've learned a lot -
  technically and also how a huge open source project works.
  Thank you everyone for that :)

  Basically everything still works and there are even TCG test
  cases which covers all instructions the processor has.

Many thanks to Michael for his substantial contributions to QEMU,
and for maintaining the LM32 target for various years!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html

Acked-by: Michael Walle <michael@walle.cc>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Also orphan machines, added Michael A-b tag
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..c89bf61989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -183,8 +183,8 @@ F: hw/net/*i82596*
 F: include/hw/net/lasi_82596.h
=20
 LM32 TCG CPUs
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: target/lm32/
 F: disas/lm32.c
 F: hw/lm32/
@@ -945,13 +945,13 @@ F: pc-bios/hppa-firmware.img
 LM32 Machines
 -------------
 EVR32 and uclinux BSP
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: hw/lm32/lm32_boards.c
=20
 milkymist
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: hw/lm32/milkymist.c
=20
 M68K Machines
--=20
2.21.1


