Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0BC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAAB208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ejp8H14G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAAB208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB514-0008UZ-Tl
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vO-0001Rp-NC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vN-000535-Ma
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53819)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vN-00052h-De; Thu, 19 Sep 2019 18:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932177; x=1600468177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DdrHjKo4Ejm/yxVn75Wd2s1We09kw2iSPTLiAnM5W4Q=;
 b=Ejp8H14GI3uT7occlzp0jVMfVIepDNjo6aOJp8Gt4dDyYAyetNShVmUL
 BTlUp8HxeszDAyGopPAD4CWrc1czdq5SZSU0iawU1nIBQsnufXZ3ZkCMr
 seiyXTKyQ7HCdBe9BER62bNRMtpQ95NYRC4GIchOdudWHLbpfVUe1p6jZ
 jisEcKAU0AwOKaTZxjc9QBlHu79JX39ysOCk9BXplhqEXesc1A4tvtLDW
 uF+TYgDeUI459AJf3C1PaxXGMf3wSfj0qp5QhRRYWjgrSccGhssy69B1D
 7WjZX626NYYzrHYZiROWPTxKbrJwHRyjSm5k5ojqR8u7zDHIDn4oxLnsd A==;
IronPort-SDR: MpqJPU70IHBx11hBffmhdzSPoHZdtJ+fVqbscLNnDG7uyVVSlmpFWrB8Z5OEVT060JgPJl9+Ms
 BVQO2XsTy/xCvcuhBX0Ah083BTwgOJS7LCqOmoUWYaoRlYdmNWValHT9/CLbFQyaEHwcTAjnTz
 8p6QS2+49WbukwH44+AMi+yBJ6tz5iFhmOzFbhWABrKePWos+CzHK/hOZ8anntsGlHhFAfR9k4
 4Qcj5LhgW0r8zPF8edj+swfTLUXBgadA2D2aPAeiBG19064IK2Xl2I6dvmZ7i88CMuUkbcInMO
 zeU=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="219490597"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:36 +0800
IronPort-SDR: WKctnQsPGljMffycGJXgz7Qz74uEVSd/mxxNx8yBr42Ej7NJYiz6amxdJrGDCzaV6W6mjQdCxe
 RXchZVnRGY4BoI6NQK16/ZnPei61I/SfhiZw3AEiU+7wXMtq7q/WRQJRlRD6DXWFX8xn2tQHeO
 lW4G48nWNZteyVPfz96DzAs4Zc8LHEY7avwdT+rUZdUokVW/5XHbO+vUCYyeONpPgQpBl/uLkM
 FsvAYyhXyk2YW4BJ4alU8/PYsUTS/s4zosDkCms5qdL48VzXjKRWfiI4+UhIC6YKNm/gLT8fKR
 lSU4uGDKxItsOX3TJANgHInP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:48 -0700
IronPort-SDR: +2GHoSGSHbrKJ8tqSrajCQxOYT+GC1J6Mx2V8BqtgdK8C0KI2IsXrMwAfRQJC2i841z7l1kJtz
 QG80HQc4HYyZWKTIx5rvooKDjMTryRB11eLWJ/JXQL6o6yxpNqoy1ZdDtQBG2/8Wr+rFIw8jgm
 yUMeRJBeTbFtzAPCrTTlZwXUAyjeRTIw9cf1mNmO2hy0D4lJrlnKD4Jmg8qG10vI0EMmeOcyI6
 o3OwBxhpbq46EG7xZuAagp8fDn2jodRX5hfSn2DaM66Y4Z9L0q396DL83PqBaXChh6QAtwDpBA
 MwQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 Sep 2019 15:29:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 6/6] riscv/virt: Jump to pflash if specified
Date: Thu, 19 Sep 2019 15:25:08 -0700
Message-Id: <a3649f52a79eff39c707546d88ecd25b753dbf33.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568931866.git.alistair.francis@wdc.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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

If the user supplied pflash to QEMU then change the reset code to jump
to the pflash base address instead of the DRAM base address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ca002ecea7..ed25cc6761 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -441,6 +441,7 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     size_t plic_hart_config_len;
+    target_ulong start_addr = memmap[VIRT_DRAM].base;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -487,6 +488,13 @@ static void riscv_virt_board_init(MachineState *machine)
         }
     }
 
+    if (drive_get(IF_PFLASH, 0, 0)) {
+        /* Pflash was supplied, let's overwrite the address we jump to after
+         * reset to the base of the flash.
+         */
+        start_addr = virt_memmap[VIRT_FLASH].base;
+    }
+
     /* reset vector */
     uint32_t reset_vec[8] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
@@ -499,7 +507,7 @@ static void riscv_virt_board_init(MachineState *machine)
 #endif
         0x00028067,                  /*     jr     t0 */
         0x00000000,
-        memmap[VIRT_DRAM].base,      /* start: .dword memmap[VIRT_DRAM].base */
+        start_addr,                  /* start: .dword */
         0x00000000,
                                      /* dtb: */
     };
-- 
2.23.0


