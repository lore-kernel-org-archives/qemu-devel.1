Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4491C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3451208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYzNcsSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3451208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRTt-0003YA-1R
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTRS5-0002VS-Kf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:15:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTRS2-0007N0-If
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:15:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id n18so3340086wrs.5
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Okc8pSExIJI8HrYDXiTNpsQmZTMNHEmKe6qWoNA6tgA=;
 b=tYzNcsSZhtEGmiNWtMR1KWNlB76PJAFU1h8kHUI+PpxVZRZnFNbRfueQKivpLyQtIQ
 G9kx2AhgG+Hd3Ye7ODUYvfFQ0kYxCy1kvg8+tMPyd1IZK8aZBKfo4guUdUtVJMBKuV2A
 bx1XmJNd6YbKGA2jqf+aBIeIa0Uf1JJPziVlMe92QWOoI2CHBJFDEIYURaMqegVsjoa3
 LycNA+a28dlWZba8TN2G9xWxw4f3ACtrv3rT3MqhWmN1u1urflLJ7MRYMmoU8cOm/bep
 Mvpamnv9zWuv8clO49W+v2oOl+o0hPVCkkbM6hnguJiCnLVsBX5UI35eA/5bvV0GFIBX
 TIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Okc8pSExIJI8HrYDXiTNpsQmZTMNHEmKe6qWoNA6tgA=;
 b=hNOk8RJ5p9WJgxDo/NkEk0W9VSe3qR3mHNoLXR9T6UwZRM1+gq0J7HTleO8vAZkIHe
 K3KNaitkIcuyHPz4vo7weYcfhFiILVm4PBn6d7pw9X0NNWlOGtxd8WKYRmgEu7C5SrQi
 UlGsnKk0dIr6B9QnYaq18dhkONDnOPVKflULnXewEPFP55XmsDmuhCLDD2/T13XGSu6m
 wBpsvU6wGouhgEEiV2sZKi3LesHRLNUedFJ/nm2xJJxRfal3Y7bh+4tkEQl5phTBWqjW
 bkgCOXieyuGd0FofO3mr+tgnz7gQVuxCZiy4r4Ty8iA98g6YRSb6LFBX3tBfsjK2mY6B
 9tJA==
X-Gm-Message-State: AOAM53120JuHF77e/AyuTdCQod0z3ZKmgNSC2qr/1v81gpeFa78HtoR9
 MrR+Cpam/5vkYUQvZbaNaFs=
X-Google-Smtp-Source: ABdhPJxq2iia8jL7ntFJJx9/6MzJcJktDqwGfph33Wsa1OiNT/9yuIYRBBbxWDQqxwXBrw5XWRO7Zw==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr4806030wrl.124.1602861325073; 
 Fri, 16 Oct 2020 08:15:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s1sm3050567wmh.22.2020.10.16.08.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 08:15:24 -0700 (PDT)
Subject: Re: [PATCH V14 1/8] target/mips: Fix PageMask with variable page size
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
 <1602831120-3377-2-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bfb682a3-0e1f-926c-66a9-976a1659d534@amsat.org>
Date: Fri, 16 Oct 2020 17:15:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602831120-3377-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:51 AM, Huacai Chen wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Our current code assumed the target page size is always 4k
> when handling PageMask and VPN2, however, variable page size
> was just added to mips target and that's no longer true.
> 
> Fixes: ee3863b9d414 ("target/mips: Support variable page size")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   target/mips/cp0_helper.c | 36 +++++++++++++++++++++++++++++-------
>   target/mips/cpu.h        |  1 +
>   2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index de64add038..f3478d826b 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -867,13 +867,35 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
>   
>   void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
>   {
> -    uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
> -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
> -        (mask == 0x0000 || mask == 0x0003 || mask == 0x000F ||
> -         mask == 0x003F || mask == 0x00FF || mask == 0x03FF ||
> -         mask == 0x0FFF || mask == 0x3FFF || mask == 0xFFFF)) {
> -        env->CP0_PageMask = arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << 1));
> +    unsigned long mask;
> +    int maskbits;
> +
> +    if (env->insn_flags & ISA_MIPS32R6) {
> +        return;
> +    }
> +    /* Don't care MASKX as we don't support 1KB page */
> +    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
> +    maskbits = find_first_zero_bit(&mask, 32);
> +
> +    /* Ensure no more set bit after first zero */
> +    if (mask >> maskbits) {
> +        goto invalid;
> +    }
> +    /* We don't support VTLB entry smaller than target page */
> +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
> +        goto invalid;
>       }
> +    env->CP0_PageMask = mask << CP0PM_MASK;
> +
> +    return;
> +
> +invalid:
> +    /*
> +     * When invalid, ensure the value is bigger than or equal to
> +     * the minimal but smaller than or equal to the maxium.
> +     */
> +    maskbits = MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
> +    env->CP0_PageMask = ((1 << (16 + 1)) - 1) << CP0PM_MASK;
>   }
>   
>   void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> @@ -1104,7 +1126,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
>   void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
>   {
>       target_ulong old, val, mask;
> -    mask = (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
> +    mask = ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;
>       if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >= 2) {
>           mask |= 1 << CP0EnHi_EHINV;
>       }
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 7cf7f5239f..9c8bb23807 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -618,6 +618,7 @@ struct CPUMIPSState {
>    * CP0 Register 5
>    */
>       int32_t CP0_PageMask;
> +#define CP0PM_MASK 13
>       int32_t CP0_PageGrain_rw_bitmask;
>       int32_t CP0_PageGrain;
>   #define CP0PG_RIE 31
> 

Malta test failing:

[    0.000000] Linux version 4.5.0-2-4kc-malta 
(debian-kernel@lists.debian.org) (gcc version 5.3.1 20160519 (Debian 
5.3.1-20) ) #1 Debian 4.5.5-1 (2016-05-29)
[    0.000000] earlycon: Early serial console at I/O port 0x3f8 (options 
'38400n8')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] CPU0 revision is: 00019300 (MIPS 24Kc)
[    0.000000] FPU revision is: 00739300
[    0.000000] MIPS: machine is mti,malta
[...]
Freeing unused kernel memory: 412K (80979000 - 809e0000)
do_page_fault(): sending SIGSEGV to mount for invalid write access to 
0018a000
epc = 77848a54 in libc-2.27.so[7782f000+177000]
ra  = 779d0618 in ld-2.27.so[779bf000+24000]
do_page_fault(): sending SIGSEGV to ln for invalid write access to 0018a000
epc = 778d4a54 in libc-2.27.so[778bb000+177000]
ra  = 77a5c618 in ld-2.27.so[77a4b000+24000]
do_page_fault(): sending SIGSEGV to S01logging for invalid write access 
to 0018a000
epc = 77d08a54 in libc-2.27.so[77cef000+177000]
ra  = 77e90618 in ld-2.27.so[77e7f000+24000]
do_page_fault(): sending SIGSEGV to S20urandom for invalid write access 
to 0018a000
epc = 76ee4a54 in libc-2.27.so[76ecb000+177000]
ra  = 7706c618 in ld-2.27.so[7705b000+24000]
do_page_fault(): sending SIGSEGV to ifup for invalid write access to 
0018a000
epc = 77974a54 in libc-2.27.so[7795b000+177000]
ra  = 77afc618 in ld-2.27.so[77aeb000+24000]
do_page_fault(): sending SIGSEGV to awk for invalid read access from 
00000000
epc = 00000000 in busybox[400000+d8000]
ra  = 77248110 in libc-2.27.so[770fb000+177000]
do_page_fault(): sending SIGSEGV to cat for invalid write access to 0018a000
epc = 77484a54 in libc-2.27.so[7746b000+177000]
ra  = 7760c618 in ld-2.27.so[775fb000+24000]
do_page_fault(): sending SIGSEGV to run.sh for invalid write access to 
0018a000
epc = 76e88a54 in libc-2.27.so[76e6f000+177000]
ra  = 77010618 in ld-2.27.so[76fff000+24000]
qemu-system-mips: terminating on signal 2

Please run the QEMU tests.

The easiest way is to push your series on GitLab.

Regards,

Phil.

