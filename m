Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE20123400
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyvTURXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE20123400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i11tk-0005rQ-Dy
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11r7-0003sL-N2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11r6-0002R3-GR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:21 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11r6-0002QX-BT; Fri, 23 Aug 2019 01:11:20 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so4865514pls.8;
 Thu, 22 Aug 2019 22:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=D4R62s35/N61PuinDIXSNWQiXuObEmra2vxp3pv/2AE=;
 b=GyvTURXas2xwWnb7v90OKiA1w4rgPCN7vgI32s4+AQK2UXWUjSHj7BiO7EPJl0yFWI
 a4NghReG9PeS0e6b09CELK5UaolTK/derJAlyjxyOhsIOd72EvUti5YIrVC7+mOIca03
 fGkHDapvOk8ZVtGk1HfdYLOYVxxj7DuRWLhmnq7jo+fwBXATbQNgheloG5G8ByJx3f+f
 HfSK2L5BjyP/Ehopz+7fQGAqR+9NIbY54pBdR74B8rn58CSQ4Kh2oa6yrk85COtWpXWI
 dIv5UEmeisBMhRMnN+7GKR5ga6ot3S/KEuysJCJywhjLK1wJ3Wr+4KHdrv1dxbo5w6/j
 ERQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=D4R62s35/N61PuinDIXSNWQiXuObEmra2vxp3pv/2AE=;
 b=BINQvmCGFEmFYZ3coJdKSifz38M2nGnzVCXEw+CUO9cGiQAsY/3BUNMS73yVbACv7/
 nSFITD+sm8tc5AHB8B+bqHMkfykIdA30i+B0Cg3jHcz0O6InGKGeYY+agjmR7UeIg7Zf
 gdipeojEaP3e9CrT6Pe7W6k5848Pz3AmKbRnfw91mtEL/8v5I27GF2xpe5oEEbE3yQ6n
 DG1tNjw0sCCEp4niL2AwyiYGJ2i+DBu7E85JdcVW9XvaTSPKq7PLcJrtQ9xSQNsJyuoJ
 vFbKyppwOjEIkEt9EYv58atgXp77vVqnW9fbxJxszM4esIgrSTvcuc3kBzSzIvKWM/SW
 ORWQ==
X-Gm-Message-State: APjAAAWxTQKR3NrC7P3Lx4lS+0K5YQvN4+qUHbuxRnNvMc7UY8AdzwZg
 Hy/nNNJ4L22O/xua3JJW+D8=
X-Google-Smtp-Source: APXvYqxMdn483gUBdvSYXUHdPsrPumXeVfiNVGhANdWtUdd6pdNcLAYjOCH/4hkoQuOvslfuoCJxuQ==
X-Received: by 2002:a17:902:f30f:: with SMTP id
 gb15mr2646104plb.233.1566537079599; 
 Thu, 22 Aug 2019 22:11:19 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.18
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:42 -0700
Message-Id: <1566537069-22741-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v5 03/30] riscv: hw: Remove not needed PLIC
 properties in device tree
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

This removes "reg-names" and "riscv,max-priority" properties of the
PLIC node from device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up

 hw/riscv/sifive_u.c | 2 --
 hw/riscv/virt.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3f9284e..5fe0033 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -180,8 +180,6 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 127f005..2f75195 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -244,8 +244,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_PLIC].base,
         0x0, memmap[VIRT_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
-- 
2.7.4


