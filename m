Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F271BC2D0EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 00:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0362054F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 00:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARw1wBl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0362054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLyBd-0007Wb-Qq
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 20:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLyAn-0006eD-8A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 20:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLyAm-0002Wg-AU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 20:02:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:33392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1jLyAm-0002WK-5e
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 20:02:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id c138so2215721pfc.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 17:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ifMBC97O93Y7fPxg3Aw2153t2JJAjrxL5/lc9HVYbQ=;
 b=ARw1wBl7ThH4QnKXdsHOgnSCGYbxsmvy5QcQi41UxZa5dVlyD8d5h2awulTWsE//Ws
 nMA1tTI1vKVxXYb5qam8bDnRWelgrvR41Abgd0pnw4UR0q8x30BoifEyZi20VCKOmii4
 FGDgHWGg0fUEvpMR6EyxjM5CaLYZjTiBPMCMw+9NnsUEx8F+WhSVrOBr9C+tpqNVJU/I
 ZSdIp343Sd/QYRFwEEMTWDS3WgaA9Mbs8L6rEt7oFN9BfMAuIrqlXfj+epEeMJW+WRq0
 9qCiqspaGLIaz4Dcg9r9Bm59NrULTzV4iVCb6Tq2M09nnZAvwPdLY5PMHM2LYUgx9a8M
 Xtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ifMBC97O93Y7fPxg3Aw2153t2JJAjrxL5/lc9HVYbQ=;
 b=N6nLAcXcQcNQGyvcwwcQJsB94e/UunE49PS1ldgmtx2xgG+kELvo5p7AKH1y/toMuk
 gIjsAxNadH0Pxjj+eVMxJAEM70hoyjZq44Y8a21nIZepwk/dxJjHX5IA29A6MUudZohb
 hyEJtaOIdGrTxTvYvFCM3a1ukwt+Z2pDbBBhrrHyAgS7N1HOW/JvTj84X1iO0JztjCKU
 ezNcSwgh8+xN+rfJk8adyjW5iMqziIQPG34NnRRA666gVpB7Cl1SHNddfKuytyuperfr
 NciRbie6WxibjtIW0GKbCaxGOhFR5puLukxxJiNQro2Tj+FozvCWRSPI/vru45UDVWFk
 wn6w==
X-Gm-Message-State: AGi0PuZM9CqQwi5qSuCPe3qD/+K5wZ5ccskELGK5DiJOj486kZ9FOdzP
 r5xmEImwfoQ24NmfdsanDLLT9DZtleo=
X-Google-Smtp-Source: APiQypIXrmf8YNwrQ9CKLh81c62NXQoLYsiRKh+sgTVv8nXPKmN130xCbP6hdiNvglGf/2bxirhznQ==
X-Received: by 2002:a63:8048:: with SMTP id j69mr4538301pgd.410.1586304147043; 
 Tue, 07 Apr 2020 17:02:27 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:63f0:a487:3b8:7ffc:c9e4])
 by smtp.gmail.com with ESMTPSA id u13sm220341pjb.45.2020.04.07.17.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 17:02:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/2] target/xtensa fixes
Date: Tue,  7 Apr 2020 17:02:10 -0700
Message-Id: <20200408000210.22182-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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

please pull the following two fixes for the target/xtensa.

The following changes since commit f3bac27cc1e303e1860cc55b9b6889ba39dee587:

  Update version for v5.0.0-rc2 release (2020-04-07 23:13:37 +0100)

are available in the Git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20200407-xtensa

for you to fetch changes up to fde557ad25ff3370ef1dd0587d299a86e060bb23:

  target/xtensa: statically allocate xtensa_insnbufs in DisasContext (2020-04-07 16:08:11 -0700)

----------------------------------------------------------------
target/xtensa fixes for 5.0:

- fix pasto in pfwait.r opcode name;
- fix memory leak with dynamically allocated xtensa_insnbufs in
  DisasContext.

----------------------------------------------------------------
Max Filippov (2):
      target/xtensa: fix pasto in pfwait.r opcode name
      target/xtensa: statically allocate xtensa_insnbufs in DisasContext

 target/xtensa/cpu.h       |  3 +++
 target/xtensa/helper.c    |  1 +
 target/xtensa/translate.c | 20 +++-----------------
 3 files changed, 7 insertions(+), 17 deletions(-)

-- 
Thanks.
-- Max

