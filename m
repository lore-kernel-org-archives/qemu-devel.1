Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A0C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569B521835
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vG1facKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569B521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvTN-0002GW-E9
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 15:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHvRg-0001Qy-Aa
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHvRe-0004kA-Gz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:46:56 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:38776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHvRe-0004k1-C7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:46:54 -0400
Received: by mail-yw1-xc42.google.com with SMTP id s6so6873516ywe.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b9kRIk0k98mO31M+M3BfnQC9IJoB/0o1KRT+1DgUAmo=;
 b=vG1facKeHYbKuIuOGxQS/MHEKDB0rguRLqe16ID41YWM43+qslpJrKn2e5FYcNx3vA
 KFkd2rUXxB3wBAwlEm/5yO1dPh8OKvkAQ82QpUIXPy3/1umoUPGfxuliCHfg9rc1QD0F
 IYECjk0xdNsc97z8DwxrkE1nk8GtNaLbOl1GKzqOmRXy6aR8gM34L2NYVZx4PK6PhEqc
 zNF1Cc/ZHrUDVD9+ORCRRK/MslpfN4M7KfN35a5ffLYRLbuqqS4BulYCbah/kErAzzLG
 r89LItH6Bd5MJBnK32miwC6SnjoE1BCVyRzaSu1HnxQbScsnT3FcHc/PPmbs8iFF6dWb
 dp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b9kRIk0k98mO31M+M3BfnQC9IJoB/0o1KRT+1DgUAmo=;
 b=s67hERbcIldjF57FokcOLq+ZtMQmnG3DYlwml7pJtPKKTZSTuMW2cYRJhgFGRFxVDu
 70JCc+tcPf5Rs+n1pTf46FRx5F0mhGMGGihh+x028h+4SXSyTN3Gy1+OvvFoX4P6z074
 xuhoM5xDgIbs+1QPAQ225S8ARExaoIo22Gf8J0DVI22WBKXdaDV9LNKK1OS+Dwv+iGQ4
 oAIGplX1FwwLuZrTCf7e2sOzOtp/rLU9xak7GuHNRUxzKIVpNxT3AZFPdhsNMWEiuBtc
 prIct9sbiyb6MDC/tVlFSGske/VO8m7E6BT/pjSsjHFYIz3rJs4kBe+yTAiIU6n4pP92
 kr6g==
X-Gm-Message-State: APjAAAVMGpZbLxff0fSolE/I7X+UJznBngkiWg5HZWQUioTYG3vq4ZTU
 YJNEC/BAvEsFd0TZFbQWDWLQfA==
X-Google-Smtp-Source: APXvYqxEkYS7fBC+GN8YGmzO1eBlXG9I1LVzUjwlfWttLyO9watpaF8KodScV4iNglL/guuPiMuPKQ==
X-Received: by 2002:a81:a08a:: with SMTP id x132mr23348ywg.177.1570564013243; 
 Tue, 08 Oct 2019 12:46:53 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id g1sm4783580ywk.53.2019.10.08.12.46.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 12:46:52 -0700 (PDT)
Subject: Re: [PATCH v9 12/13] tb-stats: adding TBStatistics info into perf dump
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e9103b0f-3853-44d7-9b40-7c86910a3a6f@linaro.org>
Date: Tue, 8 Oct 2019 15:46:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
> index e1d6f2214e..e7b86173e0 100644
> --- a/accel/tcg/perf/jitdump.c
> +++ b/accel/tcg/perf/jitdump.c
> @@ -146,7 +146,20 @@ void start_jitdump_file(void)
>  
>  void append_load_in_jitdump_file(TranslationBlock *tb)
>  {
> -    gchar *func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
> +    g_autoptr(GString) func_name = g_string_new("TB virt:");
> +
> +    g_string_append_printf(func_name, "0x"TARGET_FMT_lx, tb->pc);

I think it was clearer as a single printf.  Use g_string_printf().

But now I see where the missing GString went -- bad patch splitting.  ;-)

> +    if (tb->tb_stats) {
> +        TBStatistics *tbs = tb->tb_stats;
> +        unsigned g = stat_per_translation(tbs, code.num_guest_inst);
> +        unsigned ops = stat_per_translation(tbs, code.num_tcg_ops);
> +        unsigned ops_opt = stat_per_translation(tbs, code.num_tcg_ops_opt);
> +        unsigned spills = stat_per_translation(tbs, code.spills);
> +
> +        g_string_append_printf(func_name, " (g:%u op:%u opt:%u spills:%d)",
> +                               g, ops, ops_opt, spills);
> +    }

Oh, hum.  Does it really make sense to have accumulated averages here?  Why
does it not make more sense to have the statistics about this particular TB?
After all, different TB -- even for the same guest code -- will appear at
different places within the code_gen_buffer, and so have different entries in
this log.


r~

