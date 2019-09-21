Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54701C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 05:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFF221835
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 05:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+eIxnL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBYBj-0006Rd-Ag
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 01:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBY9q-000571-Hd
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 01:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBY9p-00053g-9X
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 01:42:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBY9p-00053U-3w; Sat, 21 Sep 2019 01:42:09 -0400
Received: by mail-pg1-x542.google.com with SMTP id g3so3463438pgs.11;
 Fri, 20 Sep 2019 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=5qbSa87Xkgf1OMZtpitdJxDCsiCCu/5TNDU+49CdPE4=;
 b=A+eIxnL2BgE6+WlKurfZpl5Iej2H7MdqAzmJUiBYKCyQUVVp3MkGaCUVA1adp3NOJI
 erUemEtMyacfNU2VDg6Tu5EABwmuHKy56iWuzOw0v75pzkixkdOx1mcO8dj95trj9Oej
 40DUFKTfyA6vPokwMYZamd4GMakKWvWAw7fRksre+PqJLsNCnMRp7Mml4idugyw/gwLd
 jJWQuPBolvy12OL9anOGxUfpnkOCpGbYX9L8um0BjaxkcjDW8mKzEQqSiam6kN3SFGT9
 DTxWlXm9sSarjjK8aYXhcLBQkqHwiHgw+coQJWcZE7Dht1pN3kJNlOHLDlbBrfxkuwCS
 l9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=5qbSa87Xkgf1OMZtpitdJxDCsiCCu/5TNDU+49CdPE4=;
 b=JkH4CB3ifssQJHGxsTCRlc2g+3FIXc0q3EYabLw+XENrfjP3WnzpMlmSpXY+/IsSg6
 nL+w2lRX68hhsI22HhB8XRb2pfblf6RYFmBHVMKrYDuSKtVG1c964wY7Ud95xw37KqBv
 nGz6KwYn6w+F1vESLM/Lj/fLLzZbAxa6XXQEUWLdBYZ+9NOMdlwnwW+A3hca0eQ2+HhK
 61PWXbTIkte9XiHoEW0FUruK65w5Nv5Jw3wDkIhpeGucvxHxAz8hExuukaZZVE/DDMXp
 18kx6pgXjmz04D14nw/0SL2hNzep+rmMrraCzodbAmqhSgYViwUkG1rU80jIjHveTYaq
 mi0g==
X-Gm-Message-State: APjAAAWwkEn6/Hz5chKjlnYU1wHQ5za3jKoeUICms2osDmd7wU0szS5Z
 ofCgNGbGMeCiha3KA2Ry+N4=
X-Google-Smtp-Source: APXvYqzWKS0UOjUfz9CWviEB1e3LIqzL1mhOsrOWbhwc7tqkJ8Ysiw6EoL8hEMMcUYaxguE17TyjBQ==
X-Received: by 2002:a62:870a:: with SMTP id i10mr21317758pfe.259.1569044527764; 
 Fri, 20 Sep 2019 22:42:07 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d69sm3461953pfd.175.2019.09.20.22.42.07
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 20 Sep 2019 22:42:07 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 2/2] riscv: sifive_u: Add ethernet0 to the aliases node
Date: Fri, 20 Sep 2019 22:41:31 -0700
Message-Id: <1569044491-7875-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
References: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

U-Boot expects this alias to be in place in order to fix up the mac
address of the ethernet node.

This is to keep in sync with Linux kernel commit below:
https://patchwork.kernel.org/patch/11133033/

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v2: None

 hw/riscv/sifive_u.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 02dd761..1ac51e3 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -270,6 +270,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         s->soc.gem.conf.macaddr.a, ETH_ALEN);
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
+
+    qemu_fdt_add_subnode(fdt, "/aliases");
+    qemu_fdt_setprop_string(fdt, "/aliases", "ethernet0", nodename);
+
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
@@ -297,7 +301,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
 
-    qemu_fdt_add_subnode(fdt, "/aliases");
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
-- 
2.7.4


