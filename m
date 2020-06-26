Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD05C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 00:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67F820767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 00:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bKaPLDA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67F820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jocKP-0000LS-88
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 20:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4399c1bdf=atish.patra@wdc.com>)
 id 1jocJ4-0007YR-2p; Thu, 25 Jun 2020 20:33:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4399c1bdf=atish.patra@wdc.com>)
 id 1jocIz-0002rQ-9H; Thu, 25 Jun 2020 20:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593131601; x=1624667601;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mSJ89GBH8VHkoy9Pcszqq8B0AJx7eEZCVPN5N/o8NRM=;
 b=bKaPLDA2LSRBsJheDxp8Tm3+52G+hbR7JPBig3iHHZ8cS7VA9XTupdmU
 FIQbd9fZ7jdol6FRLf8ytqNZu3sDWItYJUavEM3NcZOyzSBwUUFkxwIdg
 syjNDRKvhnftB6PnMiWRotZuUq+Tk9ZCn/IY71U5xT6qjeP8tWMi0W6Fr
 A7tJRsLfLsxyT1g4+Z6KnP0JY5Iy3NGB8h6FuWSLwVggpJBubiKCHU+To
 fIyynHE7gSPXwTN1zOL/O3RuSd5DEmNzVT6vm6HktsSJV6KPzLs/81xIx
 QnXq55S7Jax1QA8QUSkMyqjhCK70BZfaOgiazKHASVh4PnMvHFDL5CD43 w==;
IronPort-SDR: XIuOtbquPE8aJRY7ICVDUhTTABUxCjOBXGPcM2nod+F4LQCLCjvZ9x712vu2eNaAYV//ArJhOT
 IRCQEzXxTlyDTiBdZqOAE0M8UsmdYZjFHxKhliEq/ogMIqpA0YcFVXUYEpm0Jkur70LPkBx9k4
 0hTeQYgyK0nZk+DylwpnuwMuwOWebO+GwNpcJC6B7JvVPw0SO7rZVkmLGJ3oyy/9okC75LFzGJ
 fA2ycMqy09bGm+ayjdAmUxtdezY30lDa0ayxJIH9jjYw+rBfV46NghdyZ4vS06A9FFp9/4UJHS
 5kE=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; d="scan'208";a="140958179"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 08:33:16 +0800
IronPort-SDR: iBvqI77I24hSDdvgeHrrFl9Nw08eYmqitwFL62iiIrrs0/tGgJQxE8X6tOFh/j4S68rv9yEpS2
 Ca9DjrLlXYpUCcsh8ZBfXP9z+Mx+y8H+k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 17:21:43 -0700
IronPort-SDR: hNsHMk8KEq/PZ8RzGIpciuc7GdmeeZzcUA+k80vr835aLkEJE9J9jQPRJVZqJqKoJzyDATVLIX
 FTAYsi2o54vA==
WDCIronportException: Internal
Received: from usa003490.ad.shared (HELO yoda.hgst.com) ([10.86.58.205])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 17:33:17 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Add OpenSBI dynamic firmware support
Date: Thu, 25 Jun 2020 17:33:10 -0700
Message-Id: <20200626003313.715355-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4399c1bdf=atish.patra@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 20:33:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support OpenSBI dynamic firmware support to Qemu.
Qemu loader passes the information about the DT and next stage (i.e. kernel
or U-boot) via "a2" register. It allows the user to build bigger OS images
without worrying about overwriting DT. It also unifies the reset vector code
in rom and dt placement. Now, the DT is copied directly in DRAM instead of ROM.

The changes have been verified on following qemu machines.

64bit:
 - spike, sifive_u, virt
32bit:
 - virt

I have also verified fw_jump on all the above platforms to ensure that this
series doesn't break the existing setup.

Changes from v2->v3:
1. Removed redundant header includes.

Changes from v1->v2:
1. Rebased on top of latest upstream Qemu (with MSEL changes for sifive_u).
2. Improved the code organization

Atish Patra (3):
riscv: Unify Qemu's reset vector code path
RISC-V: Copy the fdt in dram instead of ROM
riscv: Add opensbi firmware dynamic support

hw/riscv/boot.c                 | 103 ++++++++++++++++++++++++++++++++
hw/riscv/sifive_u.c             |  46 ++++++++------
hw/riscv/spike.c                |  55 +++++------------
hw/riscv/virt.c                 |  54 +++++------------
include/hw/riscv/boot.h         |   8 +++
include/hw/riscv/boot_opensbi.h |  58 ++++++++++++++++++
6 files changed, 228 insertions(+), 96 deletions(-)
create mode 100644 include/hw/riscv/boot_opensbi.h

--
2.26.2


