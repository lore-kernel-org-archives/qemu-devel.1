Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63D5C3403A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C342173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv9BHBN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C342173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j435Q-0003ff-MM
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j434f-0002on-VZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j434f-0006gK-0Y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:38:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j434e-0006gC-T6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582033084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9U22auhEn+jtXpL66oZy02+rsPy7EvtN/pS/BP44Ew4=;
 b=Sv9BHBN70dTm+DBhdL+WLR12SW6uZkCZpO1IIopIZVfs902SEx1z4LcioNhJgm6XR0H2/0
 HHm5gN63KoEVYuaVgxgJ8hE6k6JnUggq1mcYRa0W6ftqySNtwELcvHyrPsfDgG4amQuQ0/
 VILZzf7Ix0snMn1LYaSyDmomvHTVaYA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-StXBZBnFP_-HI-50DSOFOQ-1; Tue, 18 Feb 2020 08:37:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so10760991wru.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JixWZ4WsNWyfMmD6dkmOBqM7CVCSEFsuH/CpnwvpzlA=;
 b=tq7OTlbfNxnAs/ceqNHazGy8qv3B4WknrtWrYjpPe/UV/LW/p40w4k1a+4mXJypQdi
 SFpDNHZsz8fS1V6PdSiVS6apkUzUjQ4oygXIp2KiLBDr0zQ/W19vrW1Xt1fl0VOlmkOY
 fe3KcpLA6yIt8Ane6QDlNVa+oh0z/L+Fk6Jxv517M74+LhOWnluP8uZ5e0z1WdkrL6aI
 uKTmY7VnFYeaasxGxODJVumRNIY3K5m/YTP6RYmyDuT+DQYzdPe+HR37dmRhWjBSnZW+
 0zHvO93f8mEc5ljUB1PgmiF2Tip5I1biJAt20cNwIWRjRnKxtREJQzUMsrTBn+8Ol53q
 whWg==
X-Gm-Message-State: APjAAAXqpnQszuMU5C1pLbYHe7J3GpjwTGL0ofGA0v73g+7Ej3jrKPov
 HnrALMSDYrrqA6w7IBUsVG3M3AG96RIfejNZ59R/snRFNJZg1O+G5U4VRUlp4P66mgTGotRvkHi
 mjAGPX2iBnhiOCgE=
X-Received: by 2002:a5d:5283:: with SMTP id c3mr29705291wrv.148.1582033077009; 
 Tue, 18 Feb 2020 05:37:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWyCh84B3SS1oVYprzB+DlwhJNV4Fa9x/zN/J8+X5gI4lS31UMHsXhPKXHtdZ2vj0GTToMvA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr29705281wrv.148.1582033076836; 
 Tue, 18 Feb 2020 05:37:56 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c13sm6377395wrn.46.2020.02.18.05.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 05:37:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] travis-ci: Improve OSX coverage
Date: Tue, 18 Feb 2020 14:37:51 +0100
Message-Id: <20200218133755.26400-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: StXBZBnFP_-HI-50DSOFOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add more packages on the Mojave OSX job (Xcode 10),
and duplicate the job to build on Catalina (Xcode 11).

Each job takes ~34min:
https://travis-ci.org/philmd/qemu/builds/651473221

Philippe Mathieu-Daud=C3=A9 (3):
  .travis.yml: Expand OSX code coverage
  .travis.yml: Build with ncurses on OSX
  .travis.yml: Test building with Xcode 11.3

 .travis.yml | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

--=20
2.21.1


