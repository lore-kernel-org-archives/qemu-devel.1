Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FECC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C2F206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="wHKgRAPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C2F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVTRQ-000779-QN
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 23:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQH-0005zr-Co
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQG-00084S-5n
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:29 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:46584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iVTQF-00083E-Qe
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:28 -0500
Received: by mail-pf1-x431.google.com with SMTP id 193so5768977pfc.13
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=0C617mmsq2xf+2uJYBTRpKRhyUaY9HAmVlh/3X3L69U=;
 b=wHKgRAPen3UX4wvMstAiUZvXonrb5zPTq51DYz5N37NP+zP9ktFGku2ZQV/8k9u0xK
 CYJtzcp4QJ5/0KoKFCIQuyZuJzei3W4R5MwS8VMZ6us1wlSxMdtcjsp9E+dWsksS3xxN
 LAqboMuNjtegfioU5EX+CQZsO8bDwijjNfwdqC6zrf7slPyGT719gc6FlnD6jvSi4R/R
 KlICKh+23pHGLW8vK6/aMFk1oE5c0OEFnUFRgCEHIwy/UdSSOcdMqOfhNxWoaLATyyJB
 K3xUb4AJsj8m1Ue+oWK5v+94nhGwUaNLS9uZD4T6cB28XThiWxzThLhBlHs0Qh+UTqQm
 0sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=0C617mmsq2xf+2uJYBTRpKRhyUaY9HAmVlh/3X3L69U=;
 b=uMf9hD4BXaq/HrzTsi0oZicjIioc6Y+dGaDAlYMfSy6kjzqwwtVyDs2UF/jI8eZYR6
 XxM1D5Fmpr75eDMoBiPPCtzPfQ3FjEPx194jpmDYvZJvyh593Sq7PYRkdD5UVVAAT9Ln
 O6Yie8NVul7pV7MuO6vCBeJzdq6BKEWsPWMYgTWOHJ1xune68/oZ1/za4S/OojJeHcjW
 gNY/TnlAuVYyjJ5XcTWV0VarkTKHtLVrby/N+DnNn9K4E377YHswHDdrjzY0CN2FEqhM
 v3IRUF/RdSIDjIWebs5ltc0c1nQbn1v0tZ3/hgjFjqo/abEg/uqWSWMYk6vrIe2gckAs
 UBrg==
X-Gm-Message-State: APjAAAUdPryMtwClzigMVmM8UIKP4oV76nQYQdGpUq9Vz2UcIiJ3WFzS
 UnlD+sHB/Ss0C0TjmvIKO3/Mdw==
X-Google-Smtp-Source: APXvYqwvohUM2x80jAsoDLe7GKOIQqj6Ee47LfxlP4a1UUcIrZ6x4a8LkJAEhu+jnGFKROo/emZE0Q==
X-Received: by 2002:a63:2057:: with SMTP id r23mr14902539pgm.274.1573792885494; 
 Thu, 14 Nov 2019 20:41:25 -0800 (PST)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id b137sm8216706pga.91.2019.11.14.20.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 20:41:24 -0800 (PST)
Subject: [PULL] RISC-V Fixes for 4.2-rc2
Date: Thu, 14 Nov 2019 20:41:00 -0800
Message-Id: <20191115044104.4197-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aa464db69b40b4b695be31085e6d2f1e90956c89:

  Update version for v4.2.0-rc1 release (2019-11-12 18:40:02 +0000)

are available in the Git repository at:

  git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-rc2

for you to fetch changes up to 6911fde41006b2afe3510755c4cff259ca56c1d9:

  riscv/virt: Increase flash size (2019-11-14 09:53:28 -0800)

----------------------------------------------------------------
RISC-V Fixes for 4.2-rc2

This contains a handful of patches that I'd like to target for 4.2:

* OpenSBI upgrade to 0.5
* Increase in the flash size of the virt board.
* A non-functional cleanup.
* A cleanup to our MIP handling that avoids atomics.

This passes "make check" and boots OpenEmbedded for me.

----------------------------------------------------------------
Alistair Francis (3):
      target/riscv: Remove atomic accesses to MIP CSR
      opensbi: Upgrade from v0.4 to v0.5
      riscv/virt: Increase flash size

hiroyuki.obinata (1):
      remove unnecessary ifdef TARGET_RISCV64

 hw/riscv/virt.c                              |   2 +-
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 36888 -> 40984 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 45064 -> 49160 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 40968 -> 45064 bytes
 roms/opensbi                                 |   2 +-
 target/riscv/cpu.c                           |   5 ++-
 target/riscv/cpu.h                           |   9 -----
 target/riscv/cpu_helper.c                    |  48 ++++++++++-----------------
 target/riscv/csr.c                           |   2 +-
 target/riscv/translate.c                     |   4 +--
 10 files changed, 24 insertions(+), 48 deletions(-)


