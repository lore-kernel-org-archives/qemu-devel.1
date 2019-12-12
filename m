Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E0C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079C8214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlHykSLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079C8214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifXoo-0005w6-3y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXnz-00058K-7H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXnx-000749-2H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:35 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:35273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ifXnv-0006zj-H4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:32 -0500
Received: by mail-lj1-x230.google.com with SMTP id j6so568646lja.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lp8ydgDOVLYnzNeRidfIHC2JLqLXcTtj8UXZm6Z61Wc=;
 b=UlHykSLj01SKtPh0Iz4aDOd52MT09/fDWu1N3BAbgQMyXzCPXV/aV6H2HxXxZTXAAU
 0Zdml0J9g5UDqaZnXlFOrDH9ixmQ45S8aaTtRARx1jxAiMO+0FiFFrQLoluo59b8UBtA
 IuzH2cqh2mK2jyBnlDSjjzMwZKNATMeRd1kMAGYHoo9cy4MbJ62jNTyUhuv2rmfkNlpg
 2v0XBGrsfbAxq28hogsrE18tVqj5mUnPaE4iwSOPUgpYRVYv2Jl1Y1v8GeuE6uL3xdsn
 /oGVKFzfL/hg3NhHDu2aJvKtVKl6nAOfNxJKqN6uDlVVviGtkYGz6v1ShOvJTjuETlqM
 ecYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lp8ydgDOVLYnzNeRidfIHC2JLqLXcTtj8UXZm6Z61Wc=;
 b=cjPlV5qoduW743Rt9drcEOy/LN3k/x/PdI43DcIsZj+OYTr3CUvP+BOFbWse9xaJGw
 /PQr5DrA/QFI7Nl/TL7Ze43vLehlpz3oL0UfY3CPgVS2iKRqFSIETyNOvZqwlk6PpICp
 M5nB8rui1DIiNwVq5teuxmHU2pa8n64La6SjVammR1AAk0hKuHYdQv5b/L7W00wSkSKq
 cmoP5QgUW4Tjqcf2grmjSKzmaHe52nWVus64ZWdNPgxM2BN+xlLbhKH8IuWE5AKhptjV
 eD70BAGGKgSX0Sd/cM7Mh7heTDnRaEdrH1ppRX5uk2nheobZk8H06DhZxRw5CeXlBrig
 ZMlw==
X-Gm-Message-State: APjAAAXMcvzJjAbh+9Fys2E1a2nAMvFNnqkbMd7NHhkmdfK36uzp1itd
 epviQEe4uWgMWE3hm+DeFE1QeZnnaV0=
X-Google-Smtp-Source: APXvYqxmBDbXkAij6AMkbuRR9jrvC2nTKO1pvd02rL5uu/4ijzrnt2k1ohIheevNXY0ZG4XG/srrug==
X-Received: by 2002:a2e:144b:: with SMTP id 11mr7659037lju.216.1576193009558; 
 Thu, 12 Dec 2019 15:23:29 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id j19sm4107859lfb.90.2019.12.12.15.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 15:23:28 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/xtensa: use background MPU map from overlay
Date: Thu, 12 Dec 2019 15:23:16 -0800
Message-Id: <20191212232318.2840-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::230
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this series changes target/xtensa/import_core.sh script to import one
more header from the configuration overlay: the one with default address
space map for the core and uses information in this header to generate
background MPU map.

Max Filippov (2):
  target/xtensa: import xtensa/config/core-isa.h
  target/xtensa: use MPU background map from core configuration

 target/xtensa/import_core.sh |  6 ++++--
 target/xtensa/overlay_tool.h | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.20.1


