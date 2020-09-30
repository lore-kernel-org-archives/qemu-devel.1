Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D471CC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D772074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2GjKzPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D772074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZLf-00069c-GJ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZIm-0002oR-3V; Wed, 30 Sep 2020 06:25:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZIi-0006xQ-SA; Wed, 30 Sep 2020 06:25:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so1151907wrl.12;
 Wed, 30 Sep 2020 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=18kmQLHiNL484w+7WNWt0ZkZR2/BkKITMRuKbPOqxvw=;
 b=c2GjKzPjidd54jFb/0cspT/oCjrlBYBERtbJvFwu8kLhf59ZQPuZ6dFI3CG/FWerN7
 GJHZ0ZbDRn1lnT9JUj4KUG8pLT420xtwp2k17EI6WmKU1PWGZz+q8UgUmpPIayBma2c6
 vGGQZ8sX4MHrdQp1lhDcbyiBTdGOeKLvJQGYF6HXpBXcBEIjgHKb17aQnJKAqpSsYBxc
 0ieTo29Lr8GxXsKXgonRFwrzF00DjyfDIbdJ8r1Ml4Eii+H/6jYc5hVUpMx1uxwMQyvW
 WsZNU+YASk1amwmN2vNC4RA4cELHnCvAqtOvJPkvzu3+V69EHtFwCoo5BH3+IYaiSIaY
 nMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=18kmQLHiNL484w+7WNWt0ZkZR2/BkKITMRuKbPOqxvw=;
 b=RDxUYkLttbtEmkBjJAYEtxN+ZuLs3EdqKaRNdAD9jr73Fnw0mPcTvNuXYoETadvVSK
 DQyjAEjoVQFXoZ7j1gVhqjOlDym/K2QVZOnAA6cNrQg4hA+yFtLz6ujSo6v0i3/RZARi
 TIw66Cnn99d6gr4nxRryPOLtRSLe0f55MINl6jIWK4U8juSDacrStahiKPQfsHtmCJBH
 g8fBJnqZzjYSneNIa2VSyi3gQEP54O3ZKbt3E25p0MElErU+VhWAid/1+cUWcZXIqcx8
 ihAGxjmZSPPlHxrliZO3TrgoTwvsrJ1Vz685b9l++oE5J//0w2C4k5IepBMvqx9RhcMG
 l3zA==
X-Gm-Message-State: AOAM533DaMcXq0p82hFRfbckQQR7fed6SIsiJkvR6AEOrmNOVgTNKqYG
 YJxRuN3ILREgW2esnsnNIsvB+n8tMxc=
X-Google-Smtp-Source: ABdhPJz4Di6Ly7uLwlS6Vw8/EPqNe/ZcW89lpQeTCA3IU59dbVaYghjJCsqcgAw2FCOSqwB18WUVsw==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr2231750wrr.235.1601461530622; 
 Wed, 30 Sep 2020 03:25:30 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id v4sm1829803wml.46.2020.09.30.03.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:25:30 -0700 (PDT)
Subject: Re: [PATCH RFC 14/14] target/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-15-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7ddb89a-a7fc-4bbb-0dd1-090e4055867c@amsat.org>
Date: Wed, 30 Sep 2020 12:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-15-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/cpu.h        | 2 +-
>  target/sparc/asi.h           | 2 +-
>  target/unicore32/translate.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index bd42faf..8ca8605 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -291,7 +291,7 @@ typedef struct CPUOpenRISCState {
>      int is_counting;
>  
>      uint32_t picmr;         /* Interrupt mask register */
> -    uint32_t picsr;         /* Interrupt contrl register*/
> +    uint32_t picsr;         /* Interrupt control register*/
>  #endif
>      void *irq[32];          /* Interrupt irq input */
>  } CPUOpenRISCState;
> diff --git a/target/sparc/asi.h b/target/sparc/asi.h
> index bb58735..4e9f1d5 100644
> --- a/target/sparc/asi.h
> +++ b/target/sparc/asi.h
> @@ -231,7 +231,7 @@
>  #define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
>  #define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
>  #define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
> -#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
> +#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
>  #define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
>  #define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
>  #define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
> index d4b06df..2e91b05 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -119,7 +119,7 @@ static void load_reg_var(DisasContext *s, TCGv var, int reg)
>  {
>      if (reg == 31) {
>          uint32_t addr;
> -        /* normaly, since we updated PC */
> +        /* normally, since we updated PC */
>          addr = (long)s->pc;
>          tcg_gen_movi_i32(var, addr);
>      } else {
> 


