Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E5CC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A222083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep7ZXTe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A222083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2vm-00046r-QC
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2us-0002Tl-QB; Tue, 01 Sep 2020 05:49:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2ur-0002tv-0L; Tue, 01 Sep 2020 05:49:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id l9so516784wme.3;
 Tue, 01 Sep 2020 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CyyMESLdqm+L4Z3bYhzecc7rV/eRyNkyF63EHZKY3dU=;
 b=Ep7ZXTe/UJoXUGAx2uGUKhDJrA5vbrxPDNJWrDGU+OlgULA4suSb7gIpRMKbY9N+Bc
 jbGwdWIx/9hiYtCC44BlBaJ5ykobDlk/es+Y/CU42Tfek+dzDdNBu+MWb0JZuYOUdKLV
 X6MAEecBt14rrUTzuhzv3o9RCxqT9RnOTHH33PmFOnt7kjYB/w8HGJFc39X+6G0vx9j/
 +WV7cGmHXzd8Ohwgj8Sf22AQe7mNUTNGpzdMRDgvqZtG/dcgbhYNJhErQPui+ZyAl6oc
 1MpiM1Oqg4kx/LwawMKl5C1YeqVA5/FWjq8mYTpWWNVQRbsK5R9nMOCMbGJ7aOSHcymv
 DHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CyyMESLdqm+L4Z3bYhzecc7rV/eRyNkyF63EHZKY3dU=;
 b=G9et1dpqTbX2nAwgBdv/TFmdkXqc9+JbAMyXs1kLJbwBuztflF6APx/oD4ZA32Avof
 I4DYCNmMYwrYEUtNgA2MO6a7Hp9lYoAUUxoG5U3tjcrgRxEgUhHuWWqaSwugHhRx+6gn
 i+gCakJ5pJRBUQjCME6YSFziwjgumSHs71DOZdfsN/qFx+TD8gw5pk8AAMrdM22EqmTh
 ZO73qMP9SnfHxbm2ihOdTa3OOGsU9nafDtT6DQeJ0dnpgX7t8kma6ZmKe7pmYv2p8TGf
 UGK7QnkZ7Cfq5/YEWEX9mnz/ffcDEIK8xMqWvwwVxYlafU1ReDls6a4GpOYD6SkbbNV7
 0HYA==
X-Gm-Message-State: AOAM530fmOvJgcPINymO23HBqDyvXUMtQ0WF85iN1Yyi8PZ1qSifDUyo
 oNPp96oDttII9CW+bwif4Ao=
X-Google-Smtp-Source: ABdhPJzmAbh/tHRCwU8ETW+3K5asY7pzdnvy/ZF4Y91Tszyn5f0sykDiTq+QC2TLXdHGhCtJPXeraA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr921321wmb.179.1598953762373; 
 Tue, 01 Sep 2020 02:49:22 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v24sm1665974wrd.6.2020.09.01.02.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:49:21 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] hw/riscv: clint: Avoid using hard-coded timebase
 frequency
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-16-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <35e929ff-95e6-9c35-fb91-c931573e04f9@amsat.org>
Date: Tue, 1 Sep 2020 11:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-16-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:39 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the CLINT timestamp is using a hard-coded timebase
> frequency value SIFIVE_CLINT_TIMEBASE_FREQ. This might not be
> true for all boards.
> 
> Add a new 'timebase-freq' property to the CLINT device, and
> update various functions to accept this as a parameter.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> ---
> 
> (no changes since v1)
> 
>  include/hw/riscv/sifive_clint.h |  4 +++-
>  target/riscv/cpu.h              |  6 ++++--
>  hw/riscv/microchip_pfsoc.c      |  6 +++++-
>  hw/riscv/sifive_clint.c         | 26 +++++++++++++++-----------
>  hw/riscv/sifive_e.c             |  3 ++-
>  hw/riscv/sifive_u.c             |  3 ++-
>  hw/riscv/spike.c                |  3 ++-
>  hw/riscv/virt.c                 |  3 ++-
>  target/riscv/cpu_helper.c       |  4 +++-
>  target/riscv/csr.c              |  4 ++--
>  10 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
> index 9f5fb3d..a30be0f 100644
> --- a/include/hw/riscv/sifive_clint.h
> +++ b/include/hw/riscv/sifive_clint.h
> @@ -39,11 +39,13 @@ typedef struct SiFiveCLINTState {
>      uint32_t timecmp_base;
>      uint32_t time_base;
>      uint32_t aperture_size;
> +    uint32_t timebase_freq;
>  } SiFiveCLINTState;
>  
>  DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
>      uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
> -    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime);
> +    uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
> +    bool provide_rdtime);

As an future improvement, consider using the recently introduced Clock API.

Regards,

Phil.

