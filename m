Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD19C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D16F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFcpLCiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D16F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjgb-0001yO-Bc
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLjfk-0001VT-Ci
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:05:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLjfi-0007NK-AL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:05:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id b79so2416653wmb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RQB7Ps5eJVljJMTA9VqzK0EUqMF6dc6ZPgXiAqg9L/M=;
 b=PFcpLCiTQkQwE+Bi0JS5RUmph04uxPMbBz7nPZUWuheuFrGDDUlJPS9hxCFlj3o08+
 6NCiuGXiZijSY/ECM/4iIsg0Yse2n/TCZWcMAWNqpmKtT7uN9eBPMl+8Eqg2MwT41Dnj
 +8ep3JxGeGsC/ZXpULJ7YzABX1ySsC/okOXoNZ51tb8wMgmOHF+Sq6S72+YByngw1vAK
 5GguEyNUhTIltelCN205NIX0ArB5nZ8oDRI0HK5eVi7L+IK+4bZlOljDMfmaH7OUxTPg
 Tc0U1iM3XE3ldmHGwMVOA/s8yhEV5W6aWChh04NOeTSztUKHAfkVxm1av6eevj5qrtQK
 lXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RQB7Ps5eJVljJMTA9VqzK0EUqMF6dc6ZPgXiAqg9L/M=;
 b=KfPprW40DtUdS9779n6HlbgNt+UDqQmP+Bwp6zx1t9jRyFCzlucxpLf6ZYgvq90Aoe
 eL73nOc+Ajnxb1EQ18NleaVGAxuTLFDIyd7jvYPlFsRZXl9TvdpZNr2eBkUaQnHYiHCo
 Nnpc2z6Nkpr1fKdgFUobF3+vQoTD+kqAxh7FtSMiPashii4dUjy92dHvYq56R5dq6TIq
 twwfAxIr1mJVaBzg5ysO/4yr+DMecXEKpApkiYRVxV/EJyBJL3S9lsdScKrWYxyGIwKy
 hH3sGifKHWUEV72WNsy7rUDZHSzhGR0WZOsiu1Ot9/8QEz0WsevjqEbZIZi8xNM0Jazy
 BYpA==
X-Gm-Message-State: AOAM533IDW//Bm4rPY0xuEjosTZcQuO4WC7RcUSkNlZRnB7IM6vIoAof
 iwxVsWctnwCCNr6vZytGT8U=
X-Google-Smtp-Source: ABdhPJxdjXKM/vE+cbwNkHsOZSff5+HZ923SGmTEvE+tsgObBUb7a4AQ+lO4iqSFIg6nVq5G5pykYA==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr1932377wmf.1.1601024740155;
 Fri, 25 Sep 2020 02:05:40 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id o4sm2011593wru.55.2020.09.25.02.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 02:05:39 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <20200925083307.13761-1-kele.hwang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4b9b605c-40ee-514e-87c0-94973a7a4b29@amsat.org>
Date: Fri, 25 Sep 2020 11:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925083307.13761-1-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.214,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Xu Zou <iwatchnima@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing TCG MIPS maintainers *again*.

On 9/25/20 10:33 AM, Kele Huang wrote:
> Detect all MIPS store instructions in cpu_signal_handler for all available
> MIPS versions, and set is_write if encountering such store instructions.
> 
> This fixed the error while dealing with self-modified code for MIPS.
> 
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> ---
>  accel/tcg/user-exec.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..c4494c93e7 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>  
>  #elif defined(__mips__)
>  
> +#if defined(__misp16) || defined(__mips_micromips)
> +#error "Unsupported encoding"
> +#endif
> +
>  int cpu_signal_handler(int host_signum, void *pinfo,
>                         void *puc)
>  {
> @@ -709,9 +713,41 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>      ucontext_t *uc = puc;
>      greg_t pc = uc->uc_mcontext.pc;
>      int is_write;
> +    uint32_t insn;
>  
> -    /* XXX: compute is_write */
> +    /* Detect all store instructions at program counter. */
>      is_write = 0;
> +    insn = *(uint32_t *)pc;
> +    switch((insn >> 26) & 077) {
> +    case 050: /* SB */
> +    case 051: /* SH */
> +    case 052: /* SWL */
> +    case 053: /* SW */
> +    case 054: /* SDL */
> +    case 055: /* SDR */
> +    case 056: /* SWR */
> +    case 070: /* SC */
> +    case 071: /* SWC1 */
> +    case 074: /* SCD */
> +    case 075: /* SDC1 */
> +    case 077: /* SD */
> +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> +    case 072: /* SWC2 */
> +    case 076: /* SDC2 */
> +#endif
> +        is_write = 1;
> +        break;
> +    case 023: /* COP1X */
> +        /* Required in all versions of MIPS64 since 
> +           MIPS64r1 and subsequent versions of MIPS32. */
> +        switch (insn & 077) {
> +        case 010: /* SWXC1 */
> +        case 011: /* SDXC1 */
> +            is_write = 1;
> +        }
> +        break;
> +    }
> +
>      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>  }
>  
> 


