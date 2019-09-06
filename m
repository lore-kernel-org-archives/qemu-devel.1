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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C3C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40108206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+kiAGu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40108206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H0U-0006QL-EB
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyT-0004HW-Lc
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyS-0004Fc-6J
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyR-0004EQ-W5; Fri, 06 Sep 2019 12:20:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id 4so3372773pld.10;
 Fri, 06 Sep 2019 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=RqMaYwrNsl9JPwDwEyIjVs6TYazhiDU8x5eT1fAS0xs=;
 b=V+kiAGu+u/WmnN8PsO6RLZSwAZC58qheutF3dqL+hHaC3rqv102X0zwInvhaji8/GM
 2AEgqouaq9U7tsbD5VNurM+IS+z4ul3Ox6N8/Rhr6UbUgPvxnq2jifCyQSimtWndy13g
 RnTZsgdQ2413IzLsh2Nb3T4KNmdXKcN8B5sa9bdwX5MCzHRAPeAt35rU4NR1En+SovjG
 1PK6j01y3wMHmSe2i5Z+LA6Itl+/WfiXlyfrheoaqZMhJkGLkfiOBvgYZoC70dhjq8Z5
 SSb5UJ9sueMeGOKEx1XtkE+EaKl2zjH2IaV+snCH8RIhN/wtwXk/88muclUg4nfi7587
 HK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=RqMaYwrNsl9JPwDwEyIjVs6TYazhiDU8x5eT1fAS0xs=;
 b=T0ZiqRZg17d4lo0XZtI5QQMvHY26ENicSnAjQ1X03ICH/JXSed8fNUFwHTjLlo6M5K
 7YJMzrStQbOLPCqxFfsR7yL95+2a4Oo+baUpW5PkEPJXOrW4+OBINyxiFLQqgydNEmQ2
 Xh1gOKeM8I+96ylJ35N3/1v8Oy0g8hOOwIAQouP8fHozKCapK+hMZzuBueT5Ht8z3vgj
 f3xTNmibXlyz4VdQrqgKq7f8/ybVX7CeuE0PyOM/0Vk9e96C8gn9jFqK62S0dHarK+yL
 cnjg45gxiPEDna8nC1bYDKn3wMVEN4t2LjO7Y23K0kVS2N0ajIqrZaFVMgP4pguZgzR5
 72EA==
X-Gm-Message-State: APjAAAWTRrap9IVIc7NURa3bCdwBNfRPouyGutrlJa2fgQma8jCAZaBR
 2BV2fwlHpuo/PdbsfHiYOfg=
X-Google-Smtp-Source: APXvYqwGwB64ZKMRIdnGwxfILxV1YUMeUvf6zsnIMnadmNBMszE35oWe2KJx9KcDO5G16/FvX6bM2A==
X-Received: by 2002:a17:902:9004:: with SMTP id
 a4mr9972905plp.295.1567786835160; 
 Fri, 06 Sep 2019 09:20:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.34
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:34 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:19:56 -0700
Message-Id: <1567786819-22142-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::631
Subject: [Qemu-devel] [PATCH v8 09/32] riscv: roms: Remove executable
 attribute of opensbi images
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

Like other binary files, the executable attribute of opensbi images
should not be set.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- new patch to remove executable attribute of opensbi images

Changes in v3: None
Changes in v2: None

 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
old mode 100755
new mode 100644
-- 
2.7.4


