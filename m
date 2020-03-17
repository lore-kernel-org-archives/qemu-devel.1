Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C3C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB69D20658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHF/9M3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB69D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3WA-0001lY-T5
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3UW-00087a-J8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3UV-00029h-4t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1jE3UU-0001ys-O0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id z5so11185824pfn.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=iNBqy/EyGYwQ63RRDbQPMjqB6icieu8FIzbCkicjV2c=;
 b=LHF/9M3V35NDN33t2dJlKN+4XJNsJBwuofv/9JOiPoQAAZgdD7tCc44RM/+Osu1Rc9
 A9yOtIJRV2gqQLWWVdmkEdJVdJU/noxzE4iuTp03mRVjsmfgbO+9b0v5HSuAeHyWAdxe
 8l5L4+FJUKUoQJc5LfLlvpuXQR3M4NGS0K21i1GW+UiyH/3OVMSGfADu/LuChAQYKnT8
 eQnvWS6r+lp+qKfEsBrsleE2CbonzEueYlHR9xq9fUBDEyg8AOAo4Fw/x9iaOPRgC/gU
 VJbIxLLQ+D2kS3/fcCKsj6vMNjBbLCyQKA6LSMUU7K+ypiNvvi02G4JvA1sX6BBuNXHG
 FVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=iNBqy/EyGYwQ63RRDbQPMjqB6icieu8FIzbCkicjV2c=;
 b=eiC80wzkyjuxRXIEEMDcKYByrZrsrm809MENgsmVyrDCIxNrtdm2V7TLIzbawGO1Ir
 v7t9/Dv1x1UyAYNK0YAfkhhtGACaB51zr6nInk4dn/wr76mzbSgvWlf/N42Nl6CTJfgY
 jAAhT3o/3DhcdP0vFXd2iTexjt/5zrGN8AnRWYNAdXgOEFjApeNvNQYjFTktf9Gm2iAd
 GhDZY8YS7u4JO5qP31b488qfGo9q12hf0Ctt6ViKeRirZN8p6yh/1HRNFjrrjKORYGin
 VPsJxojBvfBxoKGjbqBzvMGw3XGo86LhbPfyy1yavGI3Z/vJ+TRFR7qxhf93UHaPXoEu
 kmvQ==
X-Gm-Message-State: ANhLgQ1AMft/hMO3uDw5YdK3lIFogjKeI5wCetbLvUu0RqKmOwt4o/JH
 L3LaJZMyp6V9BLQbEmm+Wd9N5g==
X-Google-Smtp-Source: ADFU+vu4KijjLwxveeTDD/6FM+mzdNt3hMowVffwXj0NpXu0qmYVmSpKZuJWn4gXGUoXt+B+HNV7tQ==
X-Received: by 2002:a63:28c:: with SMTP id 134mr3009660pgc.165.1584417961985; 
 Mon, 16 Mar 2020 21:06:01 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id 26sm849506pgs.85.2020.03.16.21.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 21:06:01 -0700 (PDT)
Subject: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 5
Date: Mon, 16 Mar 2020 21:05:41 -0700
Message-Id: <20200317040547.222501-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
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

The following changes since commit a98135f727595382e200d04c2996e868b7925a01:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)

are available in the Git repository at:

  git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf5

for you to fetch changes up to c5969a3a3c2cb9ea02ffb7e86acb059d3cf8c264:

  target/riscv: Fix VS mode interrupts forwarding. (2020-03-16 17:03:51 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.0 Soft Freeze, Part 5

This tag contains the last of the patches I'd like to target for the 5.0 soft
freeze.  At this point we're mostly collecting fixes, but there are a few new
features.  The changes include:

* An OpenSBI update, including the various bits necessary to put CI together
  and an image for the 32-bit sifive_u board.
* A fix that disallows TSR when outside of machine mode.
* A fix for VS-mode interrupt forwarding.

----------------------------------------------------------------
Alistair Francis (1):
      target/riscv: Correctly implement TSR trap

Bin Meng (4):
      roms: opensbi: Upgrade from v0.5 to v0.6
      roms: opensbi: Add 32-bit firmware image for sifive_u machine
      riscv: sifive_u: Update BIOS_FILENAME for 32-bit
      gitlab-ci.yml: Add jobs to build OpenSBI firmware binaries

Rajnesh Kanwal (1):
      target/riscv: Fix VS mode interrupts forwarding.

 .gitlab-ci-opensbi.yml                       |  63 +++++++++++++++++++++++++++
 .gitlab-ci.d/opensbi/Dockerfile              |  33 ++++++++++++++
 .gitlab-ci.yml                               |   1 +
 Makefile                                     |   2 +-
 hw/riscv/sifive_u.c                          |   6 ++-
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 0 -> 49472 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 40984 -> 41280 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 49160 -> 53760 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 45064 -> 49664 bytes
 roms/Makefile                                |   7 +++
 roms/opensbi                                 |   2 +-
 target/riscv/cpu_helper.c                    |   9 +++-
 target/riscv/op_helper.c                     |   2 +-
 13 files changed, 120 insertions(+), 5 deletions(-)
 create mode 100644 .gitlab-ci-opensbi.yml
 create mode 100644 .gitlab-ci.d/opensbi/Dockerfile
 create mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin


