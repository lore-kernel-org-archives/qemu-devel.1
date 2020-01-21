Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F7CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCE6217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmwiOCQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCE6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3Ao-0003MG-9I
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 18:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39H-0001dq-8d
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39F-0004qz-TZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:31 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:37206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iu39F-0004oV-LH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:29 -0500
Received: by mail-pg1-x534.google.com with SMTP id q127so2390863pga.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to:in-reply-to:references;
 bh=zNvv3+MlZ3Fav7KlqKl3zpomZ1Z/uG7eGTPl6IdDto8=;
 b=dmwiOCQ62e8BvwK1Jq6te9pTXiNhaiy/hl1NCvMsj1lpvgVnaF3b25bVSkY5s+I5ol
 vV8tDCHxTikDL8aPGAjtHCVExCE7e9xM/E+qP8K5l5FOxVva8lol+ugziqfJ+ljcSE6o
 iOxHa/4kp+BPqVkjHQ0pnD0/rAl65U7H/klQIZyXCyftdBvD5NT2rj0ggJ9cpB/oWJJa
 nBxyFGwgLK2K+4kefyGyw8YuceSDnl8ftyl/9wf8kfFJMLC3du1kTN5A0efdcOnq/YWv
 TZ+29VlDHTL/dTn8Eotxz/Q6RBbJ5nfwPLsxSPx+b3kLXWRphOUl4Wp+4E0+FglQ3hlz
 628A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to:in-reply-to:references;
 bh=zNvv3+MlZ3Fav7KlqKl3zpomZ1Z/uG7eGTPl6IdDto8=;
 b=GGiRSWREAbkbxsUChMSewlpwiR2KZ+zBRRlRk3WavNZPL/S6oZI0acjVv86K1eoZu5
 vLnum8ad7ZNcltnHHAOMcLoMdCUcaQ+wTKitlsrHxKbsKnXa0hYMoAfAGmwFZJhgVuaS
 dtIgkszgjIAepUXyNd210llT6ZWGAE5f0Nn6vpLFDyfC5U1DW7HZW4qh5+7ArssEF5yU
 FKS06IOo1Fw9/U7hrgvBpgf8Fu9P0Q8RyyzhBv3to6pf9X4y3hd6XKkp5so7KoxezHne
 xeIWF5cce8HP+XuXbnw9UVwAwXp7lWxxD+YRu7+BCtfxBqzYyqfIBksgrbiMOOWl/zFh
 iZbg==
X-Gm-Message-State: APjAAAUiM6Hl21FfkyQRxCNC/GZh9C4vDc5ObZXx0QAq+i2NsdPOMRzX
 TMOLn+kggj87Nn+RtzUhThE3EP/YQAY=
X-Google-Smtp-Source: APXvYqz5ouoNx0M14zjlB899VEb0XMfoiZrs6JA2EYVdSk5PriCygAT0uZAWW5BlqefFmmqJaJTOtg==
X-Received: by 2002:a62:e509:: with SMTP id n9mr6672365pff.159.1579650084493; 
 Tue, 21 Jan 2020 15:41:24 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id a195sm45123929pfa.120.2020.01.21.15.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 15:41:24 -0800 (PST)
Subject: [PULL 1/5] riscv/sifive_u: fix a memory leak in soc_realize()
Date: Tue, 21 Jan 2020 14:56:58 -0800
Message-Id: <20200121225703.148465-2-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, Euler Robot <euler.robot@huawei.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
References: <20200121225703.148465-1-palmerdabbelt@google.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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

From: Pan Nengyuan <pannengyuan@huawei.com>

Fix a minor memory leak in riscv_sifive_u_soc_realize()

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/sifive_u.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0140e95732..0e12b3ccef 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -542,6 +542,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_U_PLIC_CONTEXT_BASE,
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_PLIC].size);
+    g_free(plic_hart_config);
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
-- 
2.25.0.341.g760bfbb309-goog


