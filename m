Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00105C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8922083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kncUDNkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8922083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqjk-0001gT-1l
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgqIp-0001bn-7A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgqIn-00039f-QD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:48:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgqIl-000316-Ea
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:48:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so8995229wme.4
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b652vpUXjXaZQC/pKdEKHyL4/H09hz7Dq7+8riyYOuY=;
 b=kncUDNkYPru8Psr1FBEAq05pnxUc4aowM+P4g2WCF2RTLUv/VJbGG+pe6Ua/rdE7SQ
 6cEZUyqkxZvTe3H46DPHo+IdgQb64+DSegJt9tM1mzwI1LkObl6rupV32J2pry4zKRAw
 5bBo9oWtSq33QVOxj/mA4VodCGL/h0406g+nOGCadoFAYZ4EvNa1WqG5iFia9zbczoeZ
 +E3u+0pfYJzpLjubO91fZ77rlTjX9qOMzbtfi/q6WIXkZme/rSiuyvir7+guYhp/2AGJ
 6d8r0aYQ8yrL/6NPeZNwe8FPyLKe697WS6fBnC/8Ocf7bHok30C8pM0n5t898RMM7Xfm
 ugRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b652vpUXjXaZQC/pKdEKHyL4/H09hz7Dq7+8riyYOuY=;
 b=ipPBxtvr3xLxVOucDJshFwS/ias1svU2OYc0A3xThFqk434FjoOYYHebgZ8+ZFfzeV
 OJ2tt4wmZPs4tD3ZPybL4nm3NLTS0t4YR7Zd7rawtidSIvZIQH8Qb6By7qDbtf5yozRI
 ug2DihWq7iirCEKfYmJRGtvssjbbxKlSP8V8mVxkSQzfJsdPfWSBRcnXT+zYEMn2hd5g
 QHdtXDbrlmoC0yoPE3AZkK9MmlHx1HT2H1e74S+m40yfkt1fs1C9y5KE/ZqiFrT88CN8
 MUy7rT9EmStz3EXqvlLWJNN0oLLkjT9xn8Mbyc2Ux7uH9XUaR41056ak7FTqDw41iK3P
 mqqQ==
X-Gm-Message-State: APjAAAW1jYS1cGBGJ2bjc8VebdHxxl7xEe0sOY2TV7imjlW+B4kjjta/
 LAxVFSxs9vjpJRZ9pr9hWeXCOrtEO4toaQ==
X-Google-Smtp-Source: APXvYqyoqlQoUXlj7F1wPzUxrimQkNmDLEbcwcvn/eEqzupDA46MIm+D4vR5yVkVPwMX574tkxQeJw==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr6915536wme.31.1561724204523; 
 Fri, 28 Jun 2019 05:16:44 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id r5sm3818519wrg.10.2019.06.28.05.16.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 05:16:43 -0700 (PDT)
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
References: <20190628113917.15869-1-luc.michel@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f9c429e1-4a1d-959a-04c4-e9b7e94637cf@linaro.org>
Date: Fri, 28 Jun 2019 14:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628113917.15869-1-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH] accel/tcg/translator: add tb_enter TCG
 trace
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
Cc: damien.hedde@greensocs.com, Paolo Bonzini <pbonzini@redhat.com>,
 edgari@xilinx.com, mark.burton@greensocs.com, sakisp@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 1:39 PM, Luc Michel wrote:
> Add a TCG trace at the begining of a translation block recording the
> first and last (past-the-end) PC values.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
> This can be used to trace the execution of the guest quite efficiently.
> It will report each time a TB is entered (using the tb_enter_exec
> trace). The traces arguments give the PC start and past-the-end values.
> It has very little to no performance impact since the trace is actually
> emitted in the generated code only when it is enabled at run time.
> 
> It works already quite well on its own to trace guest execution. However
> it does not handle the case where a TB is exited in the middle of
> execution. I'm not sure how to properly trace that. A trace could be
> added when `cpu_loop_exit()' is called to report the current PC, but in
> most cases the interesting value (the PC of the instruction that
> caused the exit) is already lost at this stage.
> 
> I'm not sure there is a generic (i.e. not target specific) way of
> recovering the last PC executed when cpu_loop_exit() is called. Do you
> think of a better way?
> 
> Thanks to the Xilinx's QEMU team who sponsored this work.
> ---
>  accel/tcg/translator.c | 24 ++++++++++++++++++++++++
>  trace-events           |  3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 9226a348a3..c55377aa18 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -14,10 +14,11 @@
>  #include "tcg/tcg-op.h"
>  #include "exec/exec-all.h"
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
>  #include "exec/translator.h"
> +#include "trace-tcg.h"
>  
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
>     (1) the target is sufficiently clean to support reporting,
>     (2) as and when all temporaries are known to be consumed.
> @@ -28,14 +29,31 @@ void translator_loop_temp_check(DisasContextBase *db)
>          qemu_log("warning: TCG temporary leaks before "
>                   TARGET_FMT_lx "\n", db->pc_next);
>      }
>  }
>  
> +static TCGOp *gen_trace_tb_enter(TranslationBlock *tb)
> +{
> +    TCGOp *last_pc_op;
> +
> +    TCGv pc_end = tcg_temp_new();
> +
> +    /* The last PC value is not known yet */
> +    tcg_gen_movi_tl(pc_end, 0xdeadbeef);
> +    last_pc_op = tcg_last_op();

TL is a target-specific type that does not necessarily correspond to uint64_t,
as you assume in the print message.  More importantly, on a 32-bit host with a
64-bit guest, this movi will generate *two* ops...

> +    /* Fixup the last PC value in the tb_enter trace now that we know it */
> +    tcg_set_insn_param(trace_pc_end, 1, db->pc_next);

... which means that this operation does not do what you think it does.  It
will only set one (unknown) half of the _i64 temporary.

Moreover, this isn't quite as zero overhead as I would like, because the pc_end
temporary is always created, even if the trace_tb condition is not satisfied
and so it (eventually) gets removed as unused.

I'm not quite sure what you're after with pc_end anyway.  As you note within
the cover, you can't reliably use it for anything.  If you remove that, then
you've also removed all of the other problems with this patch.


r~

