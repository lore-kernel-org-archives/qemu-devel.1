Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1542190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZaao7Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1542190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GJO-0002yz-UG
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzv-0007mb-Bp
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzt-0006qJ-VI
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzt-0006pA-PV; Sat, 31 Aug 2019 22:53:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so1865918pfl.0;
 Sat, 31 Aug 2019 19:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=MVyj7603TxUelxKqH/Kjjf2UedXx/CNae5JeL6SoG0E=;
 b=EZaao7ZujhWn5HQeRQm/tHWrZkcBY3AiRfCV/0DTbY3FZ6yGlbLrna4lhv9WwRJO9h
 vKpXNkk+z/QVOS29XrT+es/ZaxAY+KU7D8qVdH7mxZQ6NT8IJlCSna9tp6ZlqnkG9wwm
 c64fhRftUMOzyLcT0WoO9fja/+nLKJpYcE+Ytq2Ahl263gOlvLjcJ3dGAmA2jBeNfQFc
 fuv+a4fa+SG048f3Cxf1IivwgsDZhsFQJYydQOZrneIcOlYZFkXflxVBOmPyWQ1BFeA8
 k4IuZQc0cQ8uXwaBm5ZxO9hTfvYYvNYD8zcWwcHBZhaLGd3ervNbzgwxhqETlTQ+l+fY
 RZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=MVyj7603TxUelxKqH/Kjjf2UedXx/CNae5JeL6SoG0E=;
 b=SMcRQT0oaManoufzHdDiOjztKCECW/5ZMjqVgPgKfTcmqoA21l/7HTH6+3gI7Oj/mt
 grm3jWzszwiWlhjYBtrO++G4vxtl2Gzu/5Pm/rvp84Z6S5LNU2jaGPCXevnuzLZlSutp
 5tqscvGqbx24g+vHNmDyBvEK3PV07syUgGD96TzjEqq2xhB82TeWOWJomh8UkRDUj7yf
 CIuft64qq1GSO3rfgSQWLOXszHmqjK2i0wYV2dBlk6Ma7zww+HPw6IeMIy1FclG3wpR5
 PzNJsTjIZEZby3MS+X6IAXBAsvYjRK5LjAdp2sNuOrY4l8PA2A86U5SjpC3KexkcqcJQ
 r/sA==
X-Gm-Message-State: APjAAAXMjjQKxTuuUYonr37W2yGrlOd69YZq1zE1n2Yj+8bk29b6mpcO
 paq7uCcgoL8/TNMCzyN/O04=
X-Google-Smtp-Source: APXvYqz6QTzcxZbsJBK3kiF8Rd1SUqwSZt7QSaplUuJ1qQtRH0jjZV6pBGHMTzvOsNyzZ0sHVVwiQw==
X-Received: by 2002:a63:d210:: with SMTP id a16mr19065757pgg.77.1567306424972; 
 Sat, 31 Aug 2019 19:53:44 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.43
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:44 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:53:05 -0700
Message-Id: <1567306391-2682-25-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 24/30] riscv: sifive_u: Change UART node
 name in device tree
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

OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
use this information to locate the serial node and probe its driver.
However currently we generate the UART node name as "/soc/uart@...",
causing U-Boot fail to find the serial node in DT.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c7b9f96..d970037 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -286,7 +286,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.7.4


