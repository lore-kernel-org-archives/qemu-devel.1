Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5D5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362E22231F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362E22231F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIXW-0000oJ-Aj
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIWq-0000M7-8u
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIWp-00026U-AH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:46:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIWp-00025x-3j
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:46:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so79330496wmj.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FjEitvLQH4IYhQizIH+kqPj2lpDQjk0LVHd1jpjqFE0=;
 b=LevgH+2Xyo6RbkjMYB+9lg6K0weS7TxwYn0zcOjjYteTyO7vwfT9g3OXBLrd7l2SVK
 YSw1vGcFLolh8aLKo8en+ZJYthliKcIHGAjZ9tvFpF4eXfjDJyhFkuInjiQSuVUGJt3h
 GEk8XDaBGhcuR1Dtyo6JPQ2SdKPve1e6Kaj0pXAPiQC0G8pxb8fCQguBS94p5VT5d70C
 H7LJa5GpwiF5oDjPaOr6lAlxlC+YnIAQVb/2Dxd90YS+KIUK/00CnVTQmHnuDfx+NuHu
 byMH3HddtKm22j9pPmDMrG4ad4/QYt1cHctdQzJskYjojIY8YOiyY8YYv3zPTc8EJ56z
 sZ5g==
X-Gm-Message-State: APjAAAXFZ8yuF8QmWvQ3o773kMHxZ0VFixQKT4UYi3c1C8yZ5a2gCrlf
 uYEx3mMGrNwc1kvgjGSwQJIrzw==
X-Google-Smtp-Source: APXvYqyyFuuMPjycs07mZVi3BSBuwl2NZ+m4bgeUPT80+3QrzYG7R+GobeFmS1JXrY54N2D22jbutQ==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr9608774wmh.100.1565171202027; 
 Wed, 07 Aug 2019 02:46:42 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id i6sm90316882wrv.47.2019.08.07.02.46.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 02:46:41 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-8-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9ed12581-f73e-af09-0a0e-7bce3b69d998@redhat.com>
Date: Wed, 7 Aug 2019 11:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565163924-18621-8-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 07/28] riscv: sifive_u: Set the minimum
 number of cpus to 2
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

On 8/7/19 9:45 AM, Bin Meng wrote:
> It is not useful if we only have one management CPU.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> ---
> 
> Changes in v2:
> - update the file header to indicate at least 2 harts are created
> 
>  hw/riscv/sifive_u.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 821f1d5..91f3c76 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -10,8 +10,8 @@
>   * 1) CLINT (Core Level Interruptor)
>   * 2) PLIC (Platform Level Interrupt Controller)
>   *
> - * This board currently generates devicetree dynamically that indicates at most
> - * five harts.
> + * This board currently generates devicetree dynamically that indicates at least
> + * two harts and up to five harts.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -429,6 +429,8 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>       * management CPU.
>       */
>      mc->max_cpus = 5;

I'm confuse this patch does not apply on top of v4.1.0-rc4.

Using #define makes these comments redundant, something like:

#define MANAGEMENT_CPU_COUNT 1
#define COMPUTE_CPU_COUNT 4

then you could use

  max_cpus = MANAGEMENT_CPU_COUNT + COMPUTE_CPU_COUNT

and

  min_cpus = MANAGEMENT_CPU_COUNT + 1.

> +    /* It is not useful if we only have one management CPU */
> +    mc->min_cpus = 2;
>  }
>  
>  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> 

