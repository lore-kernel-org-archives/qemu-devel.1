Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 23:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABE42072E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 23:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kv06fIbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABE42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iphSN-00077b-8q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 18:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iphRi-0006fM-KE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 18:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iphRh-0006Q8-Fr
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 18:42:34 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iphRh-00067v-4c
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 18:42:33 -0500
Received: by mail-pg1-x543.google.com with SMTP id b137so67710pga.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 15:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=mefVIwlrKKDip3XVpDDxb1wot7pwoE9ZiAmCZtDHxak=;
 b=Kv06fIbEbumpO+4n9WTcgZqd9BjBPpldJ8BUGkRYqhynEqf+r9ewN3C5cgPWhKI7oJ
 AbJgzE4P/zIrX0znwqTx4nhL4QkUHBfdjwDvWiwN/krVZnR9F1pQQ5p1Pr0rzq/zLMx2
 Bcwj7rilVIJnXGgMG4jWcsZt3/y8AGd4/OU7uc7f2IyM/R3nxd9OTlbUJichFvK3H5eZ
 Ew37uOgV0c0OPTccm8shyxXLPSWvZjeUPkA2K3L8i2r+1pQeYjKTTaoEkIoFk2zwjNyy
 PKV9tBlPHWrx+Ak8cjoxHz0p3sfNvUW6K9Vr+HxLmcJiqAlyTkEWgx701eWhGvoDi9tM
 4+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=mefVIwlrKKDip3XVpDDxb1wot7pwoE9ZiAmCZtDHxak=;
 b=BrrknDbdXDx0HpZrefwbP5W6rzxY2rAz8MJt1e1b0nKumfPMrxQ+8uBtINnaUvyIWF
 otvhlFfJmB+PO8gi3k54PIPngJADEsCjEow+0CeHs5UpBskcxpoJjVv/XBVlksZyHRgn
 u+CKezfQfIavoKA9a2cX5fGxOMy6VZqEmAMESgKpd9kL+EXK0HWgUtwDNlw5pa4d6EHR
 Vf2O5qnZTWywsBn7kWkXQxomKZ5u4GOcpRnhzJ9QCXglzgNa5SroLrgnRMT9nEjvb7yZ
 4sYpWdDqVyRZsR1iKz74i6Or5U+0DRWCoiEgexuMPm5LUM3jW9ltIReRT73tvshl6XJh
 Eiaw==
X-Gm-Message-State: APjAAAVx96TYLE+HG+clfcLAahwGpvWy/iOftKAGQSUDbT8Pbgcg2W7w
 06turScFca3cCwBiryb2nEBO1Q==
X-Google-Smtp-Source: APXvYqzThfhawpHp3qkzVWCcDVR5G+UIrqQ5Xl+luqRP15w8dF/AL3uXejLQJlQYkfqM7Jk2v+lqHA==
X-Received: by 2002:a62:18f:: with SMTP id 137mr504226pfb.84.1578613348899;
 Thu, 09 Jan 2020 15:42:28 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id q12sm131706pfh.158.2020.01.09.15.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 15:42:28 -0800 (PST)
Date: Thu, 09 Jan 2020 15:42:28 -0800 (PST)
X-Google-Original-Date: Thu, 09 Jan 2020 15:38:32 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] riscv/sifive_u: fix a memory leak in soc_realize()
CC: pannengyuan@huawei.com, Alistair Francis <Alistair.Francis@wdc.com>,
 sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
To: alistair23@gmail.com
In-Reply-To: <CAKmqyKNH0NdhksX35C7Cm1e51in-iRBrmH8TJWGYregCgLgO6w@mail.gmail.com>
References: <CAKmqyKNH0NdhksX35C7Cm1e51in-iRBrmH8TJWGYregCgLgO6w@mail.gmail.com>
 <1575962077-28800-1-git-send-email-pannengyuan@huawei.com>
Message-ID: <mhng-8d4724ea-7312-45f2-8f14-fb3175ca9b6a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

On Tue, 10 Dec 2019 10:38:29 PST (-0800), alistair23@gmail.com wrote:
> On Mon, Dec 9, 2019 at 11:15 PM <pannengyuan@huawei.com> wrote:
>>
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> Fix a minor memory leak in riscv_sifive_u_soc_realize()
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks.  This is in the queue, I'm hoping to submit a PR after the H patch set
is ready to go.

>
> Alistair
>
>> ---
>>  hw/riscv/sifive_u.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index 0140e95..0e12b3c 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -542,6 +542,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>>          SIFIVE_U_PLIC_CONTEXT_BASE,
>>          SIFIVE_U_PLIC_CONTEXT_STRIDE,
>>          memmap[SIFIVE_U_PLIC].size);
>> +    g_free(plic_hart_config);
>>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
>>          serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
>>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>> --
>> 2.7.2.windows.1
>>
>>
>>

