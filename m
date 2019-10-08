Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E8C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25CA206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz3Cnjll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25CA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpHA-0003R6-Uj
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHpG5-0002vh-Te
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHpG4-0007yE-DF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:10:33 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:46130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHpG4-0007wF-47
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:10:32 -0400
Received: by mail-yw1-xc43.google.com with SMTP id h10so3383849ywm.13
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pZBYwVCXfON5ZWQbTPWXBeSs8pU1t4DvdYb7NPJLfCY=;
 b=Pz3Cnjll/P/LDtRSeA1hgYWm8/G2Gxmprpho/daQJQo8w21GZs+BzcRXvhgzRGUsgH
 7xFUUn9x1xzw0YqrWXu7zjfe4OzEWhMFVUCej1IBQ8TXcBx2hz3g5K9/BX1r1Sff6tup
 ULn7tVNo7E4Y6fclSYgZp7tJZpQEN0zC03+WNfwu/Q8Hc+sn2UUdRt71crcKt0E0MPzf
 sPGHdk+8RN5YkmVWwuKnF4lg8ej2UNm5+VwVKYwGvSHFbPc2n67yo6HpmOSRtd7b1tRI
 EkVy3CCTIh9m71XwBn4mNKEWZeywsasaMlM+W7xNWqbz2VrJHoQ7/xjmnr5zIaUDr3Mv
 rxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pZBYwVCXfON5ZWQbTPWXBeSs8pU1t4DvdYb7NPJLfCY=;
 b=KD2PfYHLt2MbxpQ5dciMsoTwUog7d6bt193Cxo6OJEq3ev+WZgKcXNE89rH4451c8u
 27zez7KvEl7wmqbIYJ1tP5rNyddjAnsxMIPFcO0/sDjVFCMplOqqAGbrnng7+3+sP6La
 iVi/V6nfqnbChITDcRACs6FXTlDPqs9a9FjOWZGiCN/X1NrgiwN6wv72joKOPz8jKSTs
 3Cpafe1lZCVHpa4TGvS9s92opFFD/256CPyclJ5Alym0s61c8kjJoEqWoQvupzwXc1Jb
 xCIbuI7GhaNLn5Tg1ciMxLjU5Tna/ibxkTdRx4BtBbES8Pp8pWS/FeAHehCtmAJdwS5/
 moyg==
X-Gm-Message-State: APjAAAVnHv2RaKh9jIEbOOYhIZvZgATeK32a1jtIsV5KZRM8S/0MDsCu
 GFLJZMnVmnL+WLKVLUNq68+Jkw==
X-Google-Smtp-Source: APXvYqzs1BpbgMgzr9hh+ANGFcxCoSw/Msw2tNwrrLJMDfL/vnTNtE99qakr+a1woItwSIpWgIKpHQ==
X-Received: by 2002:a81:7484:: with SMTP id p126mr24218338ywc.87.1570540230786; 
 Tue, 08 Oct 2019 06:10:30 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id v62sm4670687ywc.105.2019.10.08.06.10.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 06:10:30 -0700 (PDT)
Subject: Re: [PATCH v9 02/13] accel: collecting TB execution count
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1de71f0e-3380-ef5e-6f85-c75cd7fd7846@linaro.org>
Date: Tue, 8 Oct 2019 09:10:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TBStatistics *stats = (TBStatistics *) ptr;
> +    g_assert(stats);
> +    atomic_inc(&stats->executions.normal);
> +}

tcg_debug_assert.

> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 114ebe48bf..b7dd1a78e5 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1784,10 +1784,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      /*
>       * We want to fetch the stats structure before we start code
>       * generation so we can count interesting things about this
> -     * generation.
> +     * generation. If dfilter is in effect we will only collect stats
> +     * for the specified range.
>       */
> -    if (tb_stats_collection_enabled()) {
> +    if (tb_stats_collection_enabled() &&
> +        qemu_log_in_addr_range(tb->pc)) {
> +        uint32_t flag = get_default_tbstats_flag();
>          tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
> +
> +        if (flag & TB_EXEC_STATS) {
> +            tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
> +        }

Is this intended to be

  tb->tb_stats->stats_enabled =
      (tb->tb_stats->stats_enabled & ~TB_EXEC_STATS)
    | (flag & TB_EXEC_STATS);

so that the flag eventually gets cleared?  I also don't understand placing
stats_enabled within a structure that is shared between multiple TB.

I can only imagine that TB_EXEC_STATS should really be a bit in tb->cflags.  It
wouldn't need to be in CF_HASH_MASK, but that seems to be the logical place to
put it.

> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 70c66c538c..ec6bd829a0 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>  
>      ops->init_disas_context(db, cpu);
>      tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
> +    gen_tb_exec_count(tb);

Too early.  This should go after gen_tb_start().

>      /* Reset the temp count so that we can identify leaks */
>      tcg_clear_temp_count();
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 822c43cfd3..be006383b9 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -32,6 +32,15 @@ static inline void gen_io_end(void)
>      tcg_temp_free_i32(tmp);
>  }
>  
> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +        TCGv_ptr ptr = tcg_const_ptr(tb->tb_stats);
> +        gen_helper_inc_exec_freq(ptr);
> +        tcg_temp_free_ptr(ptr);
> +    }
> +}

I think this could go into translator.c, instead of gen-icount.h; it shouldn't
be used anywhere else.

> +#define TB_NOTHING    (1 << 0)

What's this?


r~

