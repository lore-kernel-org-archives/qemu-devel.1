Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C47C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10BB22D2B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRFSRFbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10BB22D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKBC-0001UM-Et
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSK9n-0000Z9-Ps
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:16:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSK9j-0007pd-I1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:15:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so13925486wrv.7
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3Mf015AQOw67n9uZVZv8wr6LiwAvIXGZ927nKahjMUo=;
 b=BRFSRFbXpnp+HTOrnyShOFMLsXYUxp6aXNERgeLaxNPv4zipCsuYQOM3OYAMClmsZd
 9ax4ziLGlhw7XOtIIugy0B0es/FBXc25ZlwRj90fOfcbk4/s4GIFpgXvBN6xdv+E7QfT
 1a6EkFKp5RR2Kk7HK+IyiqrALvzAWkELu4S5T2/c1e+R0ZBvL/KH+wvv2KqEnlt10VM8
 HRgjxSvZFU5rf7Zgf4Tfyw4ojQh1giUnCpvhenQRhTF0V/wyw34OGFOWG06nmtKw4VI/
 FxySyA0yTlf+ioc3eQISyvzrhxS6wuzWCeVheoGS00kkoIkSegUMAhFA2wo2tFCSajIm
 SINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Mf015AQOw67n9uZVZv8wr6LiwAvIXGZ927nKahjMUo=;
 b=epr8gFZH3hQqA5mJ/vVS8lzBiH+kRsTNVoN7e3zd3nhP05nQu4DeydsLeeZNniiT3W
 LWb1byTceWONAL3h79/8EeBoXOrCUxD349TCaVRk9hcYwA4wiDVvtBzyI7fnV/Qe3czH
 dFmze+JCubNMB9yiZJJqxjYri3gZNNRfkz5upQ/eJe32Ux5SjdIciMapHY11Utwi4RfS
 ylsPueU/iZNVYRCCGtZcYrI0sSSRmbmdjDyZcjkTHl+Z+1MZKnr2nqEQjc1+KZ8+rG+l
 qodZ02qzu/5l94RENIdFxjFnytDPM2s4mWAroTnbac5VAg40uYzWZfKmvgPga09QnblZ
 fc0A==
X-Gm-Message-State: AOAM530rHu4rXOxEtTHaDtr+9QWLXsd/KfckRQef+qf5/39m3dQFcZdW
 G7IfhUI9m+jZ/75kWmZRLY8=
X-Google-Smtp-Source: ABdhPJxe0HAP5kuUks0Wqlz5smLpojyaz5BvOXXF5FcM7vC2V8/8PluXDnQRHdmUQEcpa4tzo7Z0zA==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr37785984wrv.182.1602594954032; 
 Tue, 13 Oct 2020 06:15:54 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v11sm13634963wml.26.2020.10.13.06.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 06:15:52 -0700 (PDT)
Subject: Re: [PATCH 1/1] mips: add 34Kf-64tlb fictitious cpu type like 34Kf
 but with 64 TLBs
To: Victor Kamensky <kamensky@cisco.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20201012203613.85823-1-kamensky@cisco.com>
 <20201012203613.85823-2-kamensky@cisco.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d32116e-aeb2-4f02-79fd-6678004fbc47@amsat.org>
Date: Tue, 13 Oct 2020 15:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012203613.85823-2-kamensky@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Khem Raj <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 10:36 PM, Victor Kamensky wrote:
> In Yocto Project CI runs it was observed that test run
> of 32 bit mips image takes almost twice longer than 64 bit
> mips image with the same logical load and CI execution
> hits timeout.
> 
> See https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
> 
> Yocto project uses 34Kf cpu type to run 32 bit mips image,
> and MIPS64R2-generic cpu type to run 64 bit mips64 image.
> 
> Upon qemu behavior differences investigation between mips
> and mips64 two prominent observations came up: under
> logically similar load (same definition and configuration
> of user-land image) in case of mips get_physical_address
> function is called almost twice more often, meaning
> twice more memory accesses involved in this case. Also
> number of tlbwr instruction executed (r4k_helper_tlbwr
> qemu function) almost 16 time bigger in mips case than in
> mips64.
> 
> It turns out that 34Kf cpu has 16 TLBs, but in case of
> MIPS64R2-generic it is 64 TLBs. So that explains why
> some many more tlbwr had to be execute by kernel TLB refill
> handler in case of 32 bit misp.
> 
> The idea of the fix is to come up with new 34Kf-64tlb fictitious
> cpu type, that would behave exactly as 34Kf but it would
> contain 64 TLBs to reduce TLB trashing. After all, adding
> more TLBs to soft mmu is easy.
> 
> Experiment with some significant non-trvial load in Yocto
> environment by running do_testimage load shows that 34Kf-64tlb
> cpu performs 40% or so better than original 34Kf cpu wrt test
> execution real time.
> 
> It is not ideal to have cpu type that does not exist in the
> wild but given performance gains it seems to be justified.

You are right this is unlikely to get merged mainstream as
such :) I'll post a different approach making the number of
TLBs a configurable CPU property.

> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
>   target/mips/translate_init.c.inc | 55 ++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
> index 637caccd89..b73ab48231 100644
> --- a/target/mips/translate_init.c.inc
> +++ b/target/mips/translate_init.c.inc
> @@ -297,6 +297,61 @@ const mips_def_t mips_defs[] =
>           .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_MT,
>           .mmu_type = MMU_TYPE_R4000,
>       },
> +    /*
> +     * Verbatim copy of "34Kf" cpu, only bumped up number of TLB entries
> +     * from 16 to 64 (see CP0_Config0 value at CP0C1_MMU bits) to improve
> +     * performance by reducing number of TLB refill exceptions and
> +     * eliminating need to run all corresponding TLB refill handling
> +     * instructions.
> +     */
> +    {
> +        .name = "34Kf-64tlb",
> +        .CP0_PRid = 0x00019500,
> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
> +                       (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
> +                       (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
> +                       (1 << CP0C1_CA),
> +        .CP0_Config2 = MIPS_CONFIG2,
> +        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_VInt) | (1 << CP0C3_MT) |
> +                       (1 << CP0C3_DSPP),
> +        .CP0_LLAddr_rw_bitmask = 0,
> +        .CP0_LLAddr_shift = 0,
> +        .SYNCI_Step = 32,
> +        .CCRes = 2,
> +        .CP0_Status_rw_bitmask = 0x3778FF1F,
> +        .CP0_TCStatus_rw_bitmask = (0 << CP0TCSt_TCU3) | (0 << CP0TCSt_TCU2) |
> +                    (1 << CP0TCSt_TCU1) | (1 << CP0TCSt_TCU0) |
> +                    (0 << CP0TCSt_TMX) | (1 << CP0TCSt_DT) |
> +                    (1 << CP0TCSt_DA) | (1 << CP0TCSt_A) |
> +                    (0x3 << CP0TCSt_TKSU) | (1 << CP0TCSt_IXMT) |
> +                    (0xff << CP0TCSt_TASID),
> +        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
> +                    (1 << FCR0_D) | (1 << FCR0_S) | (0x95 << FCR0_PRID),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
> +        .CP0_SRSCtl = (0xf << CP0SRSCtl_HSS),
> +        .CP0_SRSConf0_rw_bitmask = 0x3fffffff,
> +        .CP0_SRSConf0 = (1U << CP0SRSC0_M) | (0x3fe << CP0SRSC0_SRS3) |
> +                    (0x3fe << CP0SRSC0_SRS2) | (0x3fe << CP0SRSC0_SRS1),
> +        .CP0_SRSConf1_rw_bitmask = 0x3fffffff,
> +        .CP0_SRSConf1 = (1U << CP0SRSC1_M) | (0x3fe << CP0SRSC1_SRS6) |
> +                    (0x3fe << CP0SRSC1_SRS5) | (0x3fe << CP0SRSC1_SRS4),
> +        .CP0_SRSConf2_rw_bitmask = 0x3fffffff,
> +        .CP0_SRSConf2 = (1U << CP0SRSC2_M) | (0x3fe << CP0SRSC2_SRS9) |
> +                    (0x3fe << CP0SRSC2_SRS8) | (0x3fe << CP0SRSC2_SRS7),
> +        .CP0_SRSConf3_rw_bitmask = 0x3fffffff,
> +        .CP0_SRSConf3 = (1U << CP0SRSC3_M) | (0x3fe << CP0SRSC3_SRS12) |
> +                    (0x3fe << CP0SRSC3_SRS11) | (0x3fe << CP0SRSC3_SRS10),
> +        .CP0_SRSConf4_rw_bitmask = 0x3fffffff,
> +        .CP0_SRSConf4 = (0x3fe << CP0SRSC4_SRS15) |
> +                    (0x3fe << CP0SRSC4_SRS14) | (0x3fe << CP0SRSC4_SRS13),
> +        .SEGBITS = 32,
> +        .PABITS = 32,
> +        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_MT,
> +        .mmu_type = MMU_TYPE_R4000,
> +    },
>       {
>           .name = "74Kf",
>           .CP0_PRid = 0x00019700,
> 


