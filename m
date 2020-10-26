Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8F3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C448B2225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448B2225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6aI-0007gV-G7
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kX6Fb-0000N9-Qm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:25:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kX6FZ-00019v-VR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:25:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id x13so6439582pgp.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P/Rhlb1gCZwkT6/wkGjGH9rJ+eVm6ZKc183lCsLqGZ8=;
 b=CKB3dMqEpKzemitpdIya8mYDJp8dKTbljvAF6lnbYTwOQmuEptWllhHl87bB0lcdt9
 PR+TKLQH5L/AzKhGuD3eEg/w4d/hAraovrGc1S3gQemy0JeKagRM2dpIfqbzFTnQRMJ5
 LN8UMT5DDjUNplPyM+CfT+31OcucsMG4mCkl9bUrEmM8uSTkKfgYotQs4sxFHQDpc6fd
 IuvPSGdZQMsYGhTZxagd58/a4srahk/0b4NsZBMSuoFpMn8dxjXVwzEnKtPHHkWWFmmm
 +5ODezb8qxPamiC7R+OoIO5Sor7n8DyTgZ15Y9h2JCB4mqIvC2LnG9p2UXldnYBoGwZR
 irNw==
X-Gm-Message-State: AOAM531o0cU6JuoVL+exrklXnd81scVVp9nxnC1izwwU5jQavpF7Dxo7
 bmkxbxObQCY/9I4AIczOiQt6avJiivc=
X-Google-Smtp-Source: ABdhPJyIs+h9KaHKP4IqeHlvy9qep9QNRW/8iXj0/r2USxTCBRcDq8UsATBTVXAzKLIxEKATXphjMA==
X-Received: by 2002:a63:354c:: with SMTP id c73mr17996195pga.315.1603733138231; 
 Mon, 26 Oct 2020 10:25:38 -0700 (PDT)
Received: from localhost.localdomain ([73.93.154.188])
 by smtp.gmail.com with ESMTPSA id j20sm12723075pfd.40.2020.10.26.10.25.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:25:37 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Mirror map JIT memory for TCG
Date: Mon, 26 Oct 2020 10:25:31 -0700
Message-Id: <20201026172535.10419-1-j@getutm.app>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.194;
 envelope-from=osy86github@gmail.com; helo=mail-pg1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To aid in debugging TCG, we enable a "mirror map" feature that, when enabled,
will use memfd_create() to create two mappings of the same memory for RW and RX.
The feature is only built when targeting system emulation on Linux and
configured with --enable-debug-tcg. It can be disabled with the runtime argument
`-accel tcg,mirror-jit=off`.

Although this patch only enables this feature for Linux, the main goal of this
is to enable, through a future patch, iOS JIT on older devices which require
strict W^X separation.

-j

Joelle van Dyne (4):
  tcg: add const hints for code pointers
  tcg: implement mirror mapped JIT for Linux
  tcg: use mirror map JIT in code generation
  tcg: make mirror mapped JIT optional

 configure                    |  13 +++++
 meson.build                  |   1 +
 include/exec/exec-all.h      |   8 +++
 include/sysemu/tcg.h         |   2 +-
 include/tcg/tcg.h            |  26 +++++++--
 tcg/aarch64/tcg-target.h     |  18 +++++-
 tcg/arm/tcg-target.h         |  15 ++++-
 tcg/i386/tcg-target.h        |  26 ++++++++-
 tcg/mips/tcg-target.h        |  12 +++-
 tcg/ppc/tcg-target.h         |  12 +++-
 tcg/riscv/tcg-target.h       |  13 ++++-
 tcg/s390/tcg-target.h        |  17 +++++-
 tcg/sparc/tcg-target.h       |  12 +++-
 tcg/tci/tcg-target.h         |   9 ++-
 accel/tcg/cpu-exec.c         |   7 ++-
 accel/tcg/tcg-all.c          |  31 +++++++++-
 accel/tcg/translate-all.c    | 106 +++++++++++++++++++++++++++++------
 bsd-user/main.c              |   2 +-
 linux-user/main.c            |   2 +-
 tcg/tcg.c                    |  60 +++++++++++++-------
 qemu-options.hx              |  11 ++++
 tcg/aarch64/tcg-target.c.inc |  48 +++++++++-------
 tcg/arm/tcg-target.c.inc     |  33 ++++++-----
 tcg/i386/tcg-target.c.inc    |  28 ++++-----
 tcg/mips/tcg-target.c.inc    |  64 ++++++++++++---------
 tcg/ppc/tcg-target.c.inc     |  57 ++++++++++++-------
 tcg/riscv/tcg-target.c.inc   |  51 +++++++++--------
 tcg/s390/tcg-target.c.inc    |  25 +++++----
 tcg/sparc/tcg-target.c.inc   |  33 ++++++-----
 tcg/tcg-ldst.c.inc           |   2 +-
 tcg/tcg-pool.c.inc           |   9 +--
 tcg/tci/tcg-target.c.inc     |   8 +--
 32 files changed, 555 insertions(+), 206 deletions(-)

-- 
2.28.0


