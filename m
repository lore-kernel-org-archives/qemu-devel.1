Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF13C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A657E20756
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nBxFAkLV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MpEYN5kW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A657E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl2Cl-0001mF-QF
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 23:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bm-0000S6-IP; Mon, 15 Jun 2020 23:23:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bi-0007aH-PW; Mon, 15 Jun 2020 23:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592277782; x=1623813782;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=kRe/7Rk2IAx/zyalnlwWHEW7E6IERnquP3/R3BhyOGU=;
 b=nBxFAkLV61hbTIbkS48ZTXCOcAYDy8YibxQPGBy6KlrmXo+8gdlbJ7hM
 bTCsf2T1AZIL4hvjfy21X+Gj18+jV8HkS5Ac2KO+GVWbSbUP0lrTEGOXY
 aQgkVTM0OISliu42bRGHPi3MrvdtyryNohLC9kurgoZ5kTpBXUYika9v6
 7ngf289NSlt1yrNOkV3Y5CVHt61LqjrH6Uf/SWEhBq4mC3oYZDDh44nYj
 7p6oXz2npaHOvuLON5/Maa1y0Ya319u9jad1r+vAyb1dwGvHLRLpu4Tnm
 p9NzBrIJ5Kw0fPL23iD5W0k/h/8EzNsHOAENLW90rjrOxjRGYmCmZKyy3 g==;
IronPort-SDR: j5CwrZTd3VMna10kyoYZdJntOh3LQxrUPBZFibW2lbKN5fHwNJShrhayqhXeK0lGNBBPh1MneN
 UJTl4HWu8qy8c57bhHRaoHNz8kSWYOgPxeXBJolV7iYKmnLsYJe8/BMh/Wp8nW2x8dNd65bQkA
 ZwE3eKGav6RxAxSraJkqJbSiQirANGgmkC1qINpFcNGD/Gp1usW4ZCD7AgyfqhR8TN1Mbl1Lqx
 6XbHo7tuBTEyodKPU2F6k6bnY3TLWrQ611XJ138vZloOlQirltQW2zxg/pnU9mlvhBV9fSKy2K
 8Yg=
X-IronPort-AV: E=Sophos;i="5.73,517,1583164800"; d="scan'208";a="249266450"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 11:22:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvkYSzKGC83z+i4lRHUlzIo360ZPKtXyhOCH8ZLwRF/U6R1ydTvhPynKXYS1Tz4hy4WDZrtVemnrPIts/9xc9NJvYak/J3SRVVUOaNGH3b7obzCbTpGf3pdXW6GEG0LpjHS25VpabPPRHWo56O3YimUTnwFWRH0aAYEZyiXPCHE+29TGsZwTt9j4PX8qAAtXY6dtScXkNGM2NM4CITCjCJLe1U8q0qn4t0WqZC/qFn/GMZmydgkUejl5Y6C/oV4433Py4S7X0NkJWLj1GJn0jNe9spVBP6yzCHOLuSMhGOlnHFxPr0FwPvjH7py2wGObcWb0YsL+3ZH3QTEEgQHIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g27UUW2M4j3KCAnvgg5xdZQK3B9ZHHWGM7Hwr4UDBxQ=;
 b=m9Kn+dAi07/h2nW2dkTnTgsNFUxjaPspiPfrdoYpZvFTDnriX3kFlMtR9tfpEdb4sTKBF19FF64CIj3P8+PJ32fHbVP4utD6NVXd0vLcmSALgJ8228RsrBPGu0pEdeAEk2svZc//Jmz0iSoXumpYdMt/4iVTGdEALOqLW7GhHGeyIIDTWD2dVB1FJHf6Kt/TkG1MfzPMn/A8/U8xz/smRjqGbOUfgBoibWi3BMg9Wy+cHge4nb/YOZTNSLrZJHuVCSXXLdzgQvst+fWq6LiYkJJ1sZp4pAryCGz20ZS6bFiTXq/5YCSHFCNvh0XLakNxjDqJRjM0rDCzcCrc5mMafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g27UUW2M4j3KCAnvgg5xdZQK3B9ZHHWGM7Hwr4UDBxQ=;
 b=MpEYN5kWziUhRFxura5MG2Hjka7ok004cH3UAQ9VMLe9Y6cZts/AsELp7IkH7h7jRXoPpyn35gCvUxxeuchhH0iio3pqgGYRKTP8GkZkq6SYUZt8Kc2McczFYUT/i6MW++47RXZE+SjVkKY/YqYC1igAXf8OeA9LsIZ9RQ1wkfM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4123.namprd04.prod.outlook.com (2603:10b6:5:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 03:22:54 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:22:54 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v6 0/5] RISC-V multi-socket support
Date: Tue, 16 Jun 2020 08:52:24 +0530
Message-Id: <20200616032229.766089-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.201.92) by
 MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 03:22:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.171.201.92]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5e7b0db-cac5-4d4e-e095-08d811a48ed3
X-MS-TrafficTypeDiagnostic: DM6PR04MB4123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB412348F2CC1C1D86570151F58D9D0@DM6PR04MB4123.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QumkAKfEcRL/M5XeBj3H1AlOUkghYmETZ0qtnD9A5t/VsPPSdi7nixsqXm+3C1kNhrY5Vh4XCXw78NYI2pfHB7zbxrlAWWFS/s0OwGIwF2C+/CdBFu7nNuKdSRFULGm1ZsjFOvl0lkEHN/EaRYLdWH3yXBM/nRdqy43qgPzYK8S3dbOWXCYjAtqe9DWRh1h95+p/2z4So1D1waotAyj6K7Z+lxw/2I3txZ2EtoprmtVJmw3UJvZIuuAuHVON6LDeX/8glJbX5r49QgNkfm6UcFbusojlx6CFXn94jkNZvFweUZ+ppQfu4TbQdxkipWvmS/ZA+GQnxuDyUXz4vyTeWE96kSyOrF2mFtFHxK44FpmBFcPH+gFs7fvTMGQd8ZPnXbWcWpSjNEyvJM0n9NKSSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66946007)(2616005)(66476007)(66556008)(8936002)(956004)(2906002)(316002)(54906003)(478600001)(6666004)(186003)(44832011)(966005)(55016002)(36756003)(7696005)(52116002)(83380400001)(26005)(8676002)(4326008)(86362001)(16526019)(1076003)(8886007)(110136005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XqLoF5Jw2Wdxtb3xIxBLbYknNIAfMcPvETZW0gDsRuX4cRIL9RTuhQrnXDTRiAON70RaDEgG1ogpPBA87YsszL6+ZCAmd2ChPIkDuUeKoTsWBS0TLD3jJUjUH5RoOJ7GEb1951nzc73xnYRrEknKIX79n7ZbaOk4oLz6r9PZwR5J967GK2rDwVgaIsbumY5h1tBurFoRUqt1LkO7Dx9LNlY9eiyJ0p8vdoryKS8QJuYihxjhgtQl1OqmGnAVp4WwZgdOYu43c2z3j1cd7YV6xmnvIE/ssN/ib9mIVvRuJkxVNffdeBXiAIb7NedhqCidMrozXtQpVplBf+D/OdDuYh3GvvnCcHWAcFOfEsMiDZEqCtS7CdgVvZn1l3dKN3Ya87lp0U8sMdKLEJW7qnFw6QXJTtkA+EMYg8BsGQbNCrBUBG0BLjXM/+Vk/7Uz+S84mAfNsNk49WGNIbOocmaWRQo6897bAvNv0rL/l/bsuRc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e7b0db-cac5-4d4e-e095-08d811a48ed3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 03:22:54.3462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD86buI4IY4Bezp9qe6FIRAPK59ZSsOllu7QA+OQ3/H74sL7BgVQroqeJzBRpJeX1YINXuTYOFkoRx3RriwE0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4123
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4298fe783=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 23:22:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds multi-socket support for RISC-V virt machine and
RISC-V spike machine. The multi-socket support will help us improve
various RISC-V operating systems, firmwares, and bootloader to
support RISC-V NUMA systems.

These patch can be found in riscv_multi_socket_v6 branch at:
https://github.com/avpatel/qemu.git

Changes since v5:
 - Rebased patches on Spike changes from Alistair
 - Added comments describing RISC-V NUMA helper functions

Changes since v4:
 - Re-arrange patches and move CLINT and PLIC patches before other
   patches because these are already reviewed
 - Added PATCH3 for common RISC-V multi-socket helpers
 - Added support for "-numa cpu,node-id" option in PATCH4 and PATCH5

Changes since v3:
 - Use "-numa" QEMU options to populate sockets instead of custom
   "multi-socket" sub-option in machine name

Changes since v2:
 - Dropped PATCH1 as it is not required any more
 - Added "multi-socket" sub-option for Spike and Virt machine
   which can be used to enable/disable mult-socket support

Changes since v1:
 - Fixed checkpatch errors and warnings
 - Added PATCH1 for knowning whether "sockets" sub-option was specified
 - Remove SPIKE_CPUS_PER_SOCKET_MIN and SPIKE_CPUS_PER_SOCKET_MAX in PATCH3
 - Remove VIRT_CPUS_PER_SOCKET_MIN and VIRT_CPUS_PER_SOCKET_MAX in PATCH5

Anup Patel (5):
  hw/riscv: Allow creating multiple instances of CLINT
  hw/riscv: Allow creating multiple instances of PLIC
  hw/riscv: Add helpers for RISC-V multi-socket NUMA machines
  hw/riscv: spike: Allow creating multiple NUMA sockets
  hw/riscv: virt: Allow creating multiple NUMA sockets

 hw/riscv/Makefile.objs          |   1 +
 hw/riscv/numa.c                 | 242 +++++++++++++++
 hw/riscv/sifive_clint.c         |  20 +-
 hw/riscv/sifive_e.c             |   4 +-
 hw/riscv/sifive_plic.c          |  24 +-
 hw/riscv/sifive_u.c             |   4 +-
 hw/riscv/spike.c                | 237 +++++++++-----
 hw/riscv/virt.c                 | 530 ++++++++++++++++++--------------
 include/hw/riscv/numa.h         | 113 +++++++
 include/hw/riscv/sifive_clint.h |   7 +-
 include/hw/riscv/sifive_plic.h  |  12 +-
 include/hw/riscv/spike.h        |  11 +-
 include/hw/riscv/virt.h         |   9 +-
 13 files changed, 873 insertions(+), 341 deletions(-)
 create mode 100644 hw/riscv/numa.c
 create mode 100644 include/hw/riscv/numa.h

-- 
2.25.1


