Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998EC2070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxAZk7PB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998EC2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioYdR-0005bU-LR
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 15:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ioYca-00055M-7B
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 15:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ioYcZ-0006C6-2S
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 15:05:04 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:39890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ioYcY-0006B1-Q0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 15:05:03 -0500
Received: by mail-lj1-x22b.google.com with SMTP id l2so52202378lja.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gm7z/IYXW1KfUj1OU9qjr7hrxDHe/l6AyZiFNnLkr2M=;
 b=gxAZk7PBHEUph/Vc7Fq4uayGqntJ6mL9ozs5C8rLWzWVFHVuDVTUKPYtMJrKiIVb8V
 6KxprEHh3NR2eXtoYSIotf2cwyPNttTIqulgdaDBensbyrfo8mw1CBtYYTjs1feYwBgk
 wvWtoGFz+2kyLiVD3RrMXGETQr4d1UoFp3721e0Rf63oFtyRBatQmChz7hO6F0CU25nK
 h2EtORaSzq9+dw7D6Br1XRqQkS7ay2CZqtIDmp9yxoUcYWEY3Y6PapCsvRxWOdSUYKQz
 PObbDzhsbf3tq5shgEBvVVYYHWHmf1ZhoTq/Hlhp9cK3mYWiQim239GPW9dg5DgnZkGg
 Pcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gm7z/IYXW1KfUj1OU9qjr7hrxDHe/l6AyZiFNnLkr2M=;
 b=b24Cy2qNx0Kqh80wVM1ZMfnJUqbNPxaTKZ7mrMeI5BTCp/wT1R9Jip6HiIvndxNMSD
 0RvSUvg57GJ3PwH8wy4McW3nxFBUPn+oWPlqVgesaQF/WA5cDWuYklUDDRD+GZ6IByru
 NYkpQfv7bw8pgOkXt/v9DrRTTtnoLK+96G6k86d7PxkjO8DvoYZM0Pxw1S0QGB8o7H/g
 nSZZEx9PuPBLt8BpqMkkL9R6CFCx1r5nQcz+q18QupYmRWMyOCd5utI8tJgVxwVwYknt
 B484qxypfu6M2ZXDKDDpd0PMvGAYdiSwIv1iRc9ojngIDZtdL9OL3haGHoKvW4ZGsdoB
 10Pw==
X-Gm-Message-State: APjAAAWACBFjhmYBvwBGBFtUqNWJx5BReE26TyDBIeBT5JVphmUiETZN
 pa4RdnZ6WtMGHhTy74Wfc1DQbsg6
X-Google-Smtp-Source: APXvYqxcUwMcfnjkNYy1PV4QQfnAC7xl5QpgM/vBsSVz/da485wEE8+rUOSW4P13UO8TmfsHFJHEVQ==
X-Received: by 2002:a05:651c:111c:: with SMTP id
 d28mr62009718ljo.32.1578341100501; 
 Mon, 06 Jan 2020 12:05:00 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id r6sm24777545ljk.37.2020.01.06.12.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 12:04:59 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] target/xtensa queue
Date: Mon,  6 Jan 2020 12:04:34 -0800
Message-Id: <20200106200434.27646-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22b
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

please pull the following target/xtensa batch.

The following changes since commit f4d8cf148e43d942ef1202071e0cd66ce40322e0:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-01-06' into staging (2020-01-06 17:44:22 +0000)

are available in the Git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20200106-xtensa

for you to fetch changes up to a153a3f73d8e028be996f1602fa99c7f3f53348c:

  target/xtensa: use MPU background map from core configuration (2020-01-06 11:46:16 -0800)

----------------------------------------------------------------
target/xtensa improvements for v5.0:

- fix ps.ring use in MPU configs;
- use MPU background map from the configuration overlay.

----------------------------------------------------------------
Max Filippov (3):
      target/xtensa: fix ps.ring use in MPU configs
      target/xtensa: import xtensa/config/core-isa.h
      target/xtensa: use MPU background map from core configuration

 target/xtensa/cpu.h          | 10 +++++++---
 target/xtensa/import_core.sh |  6 ++++--
 target/xtensa/overlay_tool.h | 15 ++++++++++++++-
 target/xtensa/translate.c    |  3 ++-
 4 files changed, 27 insertions(+), 7 deletions(-)

-- 
Thanks.
-- Max

