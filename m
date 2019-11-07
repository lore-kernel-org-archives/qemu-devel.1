Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6646FA372C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 00:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC80218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 00:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UEsLEO60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC80218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSW3h-0007RL-OJ
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 19:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=207c28696=alistair.francis@wdc.com>)
 id 1iSW2W-0006yG-8f
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 19:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=207c28696=alistair.francis@wdc.com>)
 id 1iSW2U-00075X-0e
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 19:52:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=207c28696=alistair.francis@wdc.com>)
 id 1iSW2R-0006wp-Hj; Wed, 06 Nov 2019 19:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573087959; x=1604623959;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=91GA3k5Wf0zRgFBatOvuGps7IJjNusPf3pYDty1uXAE=;
 b=UEsLEO60tVVboRyBj0iJlOPXKmyjnE7mJ+kN+yt4vcSNktkJ9sambKcH
 jGh373dFMORcCBBfhP4+uLPKvnaoUGYucHYr6/Q6uNGNaw+Vuwgn4FAmL
 MCPNz0lX3PxAJe1uvyD1jegSx+xzhMHMxTwPqcN+VNuEquLPIRSpvK0fw
 t2NwPXlxsegSH9gWbJxBhRUrwyVqLr9bB1pAFEVywEu/KZokzFV1zNhPG
 mIHqfT1xLMmDi2UkJBvVkA49vdoHBv5j1NCh6I2Bm/VOVp8pZEs8GV6Az
 uw26doaFrVzWN3B0SbR33qK1bJdMr4ivQqLTADUTjNexGVrrtWqSntv2W g==;
IronPort-SDR: OF9wVVZd+0i0IoJQNSVj2NzcRZEP/NKNwGcn29vPdIo8qOf3w0zZWBaC/e4xNMSzRfsCOS3rWi
 UmX/oygRkq8ID5JLV1vwPWlA2+o38aegxb86G3DzddrLSB8xJRkdCZo+OLbaR/iWG2U4DOuAFO
 QVsuxIegFLA2TtEBVgI6WyTKXrA9xb14YpC/mEjozhmxYCYStFWEb/6WAqQhIk8C6swRY1bAUf
 sdU+L1uixuZ8QFlxTII1eM1lMwTCqaK0Ksi8FVMn8TCHwM6jmRieoreiWV4bFcMwwbZlvwWDMj
 iXU=
X-IronPort-AV: E=Sophos;i="5.68,276,1569254400"; d="scan'208";a="123069963"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2019 08:52:34 +0800
IronPort-SDR: DyG9ayykU4lR1Kcbcysxs7rEQDb5DVmkp1xvYjUBNmjXkN0epHptuF228tqB3i90ghPqDniBJh
 pvuTV7sMqol2Dd65EldICsMNi8c8Xccwq5gDrF5qnpNMwEtv3Ys2TWF4x4LEw4BnTPS6KmzhjT
 BjyChtiIf98gVahkuSxxC/EYAAsueGlYxgjE9Wq1mkMdi1TdXE2Nkcah4BjhV60qM4ZEbBkYwa
 JD0jBVgc6rCrNAN+6oKKF0kxeLwS/1nI7uI88/4yUbkproa7XHOykhvipMphE7pPfaLWpgC+/w
 JwdclsrTxtD/jSljf19aRekn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 16:47:45 -0800
IronPort-SDR: s6jHkLwXqo7vFs/jRlJYA3om7/ZgAFilKrHTz1lkNbDuHlIS4HSsjXYcutFcUyQ5WRJOjPY2ws
 360NHw13JuFS4jKcwjJvzZJRbfDhES17ainm49PLSCqKMCX4GbAHZ5gBHBR2zsa2KO/5lOa2tc
 /lguL1hD36hB82X7iQDYAsKcjo5sTk7CGzP82h+gXMEbVPksKnvODE6rll37wBzzHZG0ZhLNm0
 zT+dBOWjhXsAlm3zSYiYvEkEizwizib59PGOTJHJ4OpOJEOmk9ZTG/384rUfSjpBsN2Y3IOf8L
 aok=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Nov 2019 16:52:34 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH for 4.2 v1 1/1] riscv/virt: Increase flash size
Date: Wed,  6 Nov 2019 16:47:20 -0800
Message-Id: <03c2f42b32fb4e304319c241122ae83584f085e0.1573087610.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coreboot developers have requested that they have at least 32MB of flash
to load binaries. We currently have 32MB of flash, but it is split in
two to allow loading two flash binaries. Let's increase the flash size
from 32MB to 64MB to ensure we have a single region that is 32MB.

No QEMU release has include flash in the RISC-V virt machine, so this
isn't a breaking change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cc8f311e6b..23f340df19 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,7 +62,7 @@ static const struct MemmapEntry {
     [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
-    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
+    [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
     [VIRT_DRAM] =        { 0x80000000,           0x0 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
-- 
2.23.0


