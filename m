Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AF4206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoAbhDDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AF4206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H2J-0000MT-Bd
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyQ-0004CX-0M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyO-0004B2-Cp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyO-00048l-0j; Fri, 06 Sep 2019 12:20:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so3767599pgj.7;
 Fri, 06 Sep 2019 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=c5GPo/y0hCv2kZjfLT7aurCw2WOFnB9WYXs675+u7cY=;
 b=WoAbhDDIDQbdsy2mS2QLmWCxjRr8z3HpB8REyKj3ZJsgRf86d/scQU7fOAsD7eFiN3
 kfPH+zLN/U9x3s2eyNXfZT4+bGbwliFps9BbOPk1ggekv/FKiF5t/vWp6KmbGGV3o9Fa
 MUgUm+fpZak+CBFmyyw7tnnq50+qbe+cEH4NAmSwBbwKvruph1drtvZmwqhzyP5aftLn
 QqesxlKIBiWSi6V9FC/CPKZiDbco9Ba6As4+w2qdGu9MPDxaImR/AyDNFe/1f9x45Rfg
 qVZxc+9V1vBkc6IcIiLJU5EPMlU6OSqrmiVyoYIGTOypb9VQpKwZqw0/devnJ1YEE0rr
 qxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=c5GPo/y0hCv2kZjfLT7aurCw2WOFnB9WYXs675+u7cY=;
 b=Vp7jlvmtItALobjwC0+bQ1obQgp1YAdpE7ENapk8rCUMnVC/gm5G/kJnLy8fDlXrVC
 46pmeJs/MCluq8TywntgqNNuKE9Uh5+06PX1CzzXzx6HrsDyJslbpq4g3ITIxhC8g8RF
 ryhpNGKN6WAqwkhYmE9Ob4ylGyNiO+GyTTGsTLjI58YkZLk8GVWbkFwp2LzqJNO8Fm86
 rlqeoTrGLniTNx4SQAG7dX+JYvJjRN4Va3WMZPPgGGpIMwVcci0H7dYB/XZQs6m0nUAI
 O7dkLsGhE/HQNp4Djs7BkIQd/y1hwMWVpGJWHWwnEg2NGD8pIheYf27RbmTnAsBf7NIj
 PPIQ==
X-Gm-Message-State: APjAAAXTY4zPGipbqNDxgVhoTPJo3M61cz/lJqS1v2nIVQqRXkp7r3xb
 gc1wscpze6+lX6Au5QSxNSY=
X-Google-Smtp-Source: APXvYqxRWAbU8moMlL58B5qeCwvC5WuMUjWJ481vnhdzr/O1uNOEdCjfaHo1hysYvZ0p24EDKBG30w==
X-Received: by 2002:a62:c141:: with SMTP id i62mr11670940pfg.64.1567786831034; 
 Fri, 06 Sep 2019 09:20:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.30
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:19:52 -0700
Message-Id: <1567786819-22142-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v8 05/32] riscv: hw: Remove not needed PLIC
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

Changes in v8: None
Changes in v7: None
Changes in v6: None
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
index 762223c..e8acdd9 100644
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
index 6852178..090512b 100644
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


