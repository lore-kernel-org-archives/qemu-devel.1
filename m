Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08396C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 21:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A322080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXU6cjHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A322080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcyog-0004if-48
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 17:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyn0-0003HQ-RE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 17:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcymw-0003vQ-H9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 17:03:40 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcymu-0003ks-Ia
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 17:03:36 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh12so4663155plb.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z3fQDRde5I4nslskKeYm8/QJPP2z+qsYDVyJHHilyiA=;
 b=qXU6cjHGVD8HCZMMsNXyBvfhBhFR71oc8ulgRpDDYr8y9tUZ15FvtA4Im82oeeCDyJ
 ymqo8LgkPJa3ZTXkVW0WFjR/BMZj8zkDR3e9YLC9K1w9g0OxuTfRNYpfSfW27aW0WhTz
 tJvCug3XWqCMmzOcGiqD6kWgdAZow/M8uC91sOART7FMUeJILdnV0ItPu9Yr8Q86LjT6
 feRK+kdyNlyIQDDtmgywTr0Iql7tF5hSshfaBDJ0COGBYe5zt43NknZlApD41NG5tQ8m
 sOsF91dMpnon+1FBVGcPqgTZ1Cekl/sWnAgrIXGo2YBNZ86KW9YloK2JByHc4wHq+lHz
 u0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z3fQDRde5I4nslskKeYm8/QJPP2z+qsYDVyJHHilyiA=;
 b=ALvy09yXWLuTK614ipHIHx4Gng97AcN4OkQOi2t5eTHj/c7wo88/6cQKKgzCnsE/83
 UHdFhML4Y+KFiVHz4UtY+XTrqr/4VH5x4jpDwg5iZaGZIwLSo7P8H8uABIh3YwLSJCe9
 bK2WleiXeTbMX9rCORskz4Ns3xEdAmAdwaPNZazePiyVzEpAXohsU/BHD1Rm/zorhNpM
 biNGjj792H8YjdPWnWh9wRa7eWRK/ReIFuSvqXiCGOMncPVT9nuTlhlrriLJ29/zTEeA
 PG9Q2KS64l5wLz4MC+GbXCrn0BAXqcp5tW/BhAjRdW47bYU9doRQY9YecVwvZbj0vUQb
 mHTQ==
X-Gm-Message-State: APjAAAUP8PnrLjKRERO/WUOvBsMPdJ83yUdb48BqasHgzxlJlqLXEQug
 mJo6q80QGGZZe0WOXXMOrzPfjA==
X-Google-Smtp-Source: APXvYqxoM8AxQGyPkBLvciaLwjiG4/p/xda3CFUf5rQBb4aOR/Ty1aur1gy7rKwkM7GypMTlh7OO9A==
X-Received: by 2002:a17:902:8b82:: with SMTP id
 ay2mr12105718plb.164.1560805407707; 
 Mon, 17 Jun 2019 14:03:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id f14sm16837515pfn.53.2019.06.17.14.03.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 14:03:27 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-25-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0eb56b80-1a05-5c17-dd85-0566a15cf40c@linaro.org>
Date: Mon, 17 Jun 2019 14:03:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v3 24/50] plugin-gen: add plugin_insn_append
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> By adding it to plugin-gen's header file, we can export is as
> an inline, since tcg.h is included in the header (we need tcg_ctx).
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> ---
> v3
>   - use g_byte_array
> ---
>  accel/tcg/plugin-gen.c    | 10 +++++++++-
>  include/exec/plugin-gen.h | 23 ++++++++++++++---------
>  2 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 9d9ec29765..758fc5d099 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -60,9 +60,17 @@
>  /*
>   * plugin_cb_start TCG op args[]:
>   * 0: enum plugin_gen_from
> - * 1: enum plugin_gen_cb (defined below)
> + * 1: enum plugin_gen_cb
>   * 2: set to 1 if it's a mem callback and it's a write, 0 otherwise.
>   */
> +enum plugin_gen_from {
> +    PLUGIN_GEN_FROM_TB,
> +    PLUGIN_GEN_FROM_INSN,
> +    PLUGIN_GEN_FROM_MEM,
> +    PLUGIN_GEN_AFTER_INSN,
> +    PLUGIN_GEN_N_FROMS,
> +};
> +
>  enum plugin_gen_cb {
>      PLUGIN_GEN_CB_UDATA,
>      PLUGIN_GEN_CB_INLINE,
> diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
> index 449ea16034..316638c736 100644
> --- a/include/exec/plugin-gen.h
> +++ b/include/exec/plugin-gen.h
> @@ -15,15 +15,6 @@
>  #include "qemu/plugin.h"
>  #include "tcg/tcg.h"
>  
> -/* used by plugin_callback_start and plugin_callback_end TCG ops */
> -enum plugin_gen_from {
> -    PLUGIN_GEN_FROM_TB,
> -    PLUGIN_GEN_FROM_INSN,
> -    PLUGIN_GEN_FROM_MEM,
> -    PLUGIN_GEN_AFTER_INSN,
> -    PLUGIN_GEN_N_FROMS,
> -};

Why is this movement in here, and can it be folded back?
It doesn't seem to be used from ...


> -
>  struct DisasContextBase;
>  
>  #ifdef CONFIG_PLUGIN
> @@ -36,6 +27,17 @@ void plugin_gen_insn_end(void);
>  void plugin_gen_disable_mem_helpers(void);
>  void plugin_gen_empty_mem_callback(TCGv addr, uint8_t info);
>  
> +static inline void plugin_insn_append(const void *from, size_t size)
> +{
> +    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
> +
> +    if (insn == NULL) {
> +        return;
> +    }
> +
> +    insn->data = g_byte_array_append(insn->data, from, size);
> +}
> +
>  #else /* !CONFIG_PLUGIN */
>  
>  static inline
> @@ -60,6 +62,9 @@ static inline void plugin_gen_disable_mem_helpers(void)
>  static inline void plugin_gen_empty_mem_callback(TCGv addr, uint8_t info)
>  { }
>  
> +static inline void plugin_insn_append(const void *from, size_t size)
> +{ }
> +

... here.


r~

