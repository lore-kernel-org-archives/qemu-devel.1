Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3935C31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD99E20862
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTF8dR90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD99E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hchlZ-0003dF-Uu
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 22:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hchl6-0003C4-9z
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hchl5-00087S-9H
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:52:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hchl5-000877-1N
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:52:35 -0400
Received: by mail-pg1-x542.google.com with SMTP id f25so4893390pgv.10
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jbiv6mwgbxEar4mR1o9puUcXrlKVxjnibT3Uhm5MWOM=;
 b=dTF8dR90aqEjjxGGvOCpIZ0qae+/uK4dM5+tKvTC+GTDAuIAV0Z4Ou7hPm4oL7loG5
 XLs0PimR/cr0nZtraPXiMovuQvxy5BGQwEsuPnzr7G41FjX27gyHdR4cnYrPMHUYXE9M
 hhuCAtGHGDTYWoMX10WWBT+ROSB0xteXXzjoRGFXqixEqksiNY96O1PkB54uqfNIgyTV
 NJUb7gbF7dnCginJUJQoJzxCOwAVJz83Be5Hy4MKPvfw/SNcAxCIPWk54bemO2VilSIN
 AEqY3SPO6ZNXLFU8b0WLMq4YDE4kd/SHqKsYT/TIINU9Ssmnkgn/3UDgcV4koYVWEG2q
 vljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jbiv6mwgbxEar4mR1o9puUcXrlKVxjnibT3Uhm5MWOM=;
 b=T7PniZlkao/Yv484UIsRjJj/eggwAeOBEc3bxxUpGIesnI3Wezv7TtWhDA3S4txhXn
 Pf8gHVVZ5Cl3xtzyMHTGYrqVeDUpP6uUHohkFN/B4gbr7FlyL85yaxLTNlewRaK7PrVV
 rHi0uwcwiJRKB36Zw3vf0OImkuur8LAmiN+qPBgks0e3ZBREJnz30Hz3y3QhIpGvTvx4
 tdVWge4YQUczNDuIJjgFQvpn6gVqLYM5INkg5RdqEU3sGD6r1HyN6ClG3bPFr8vSFgAU
 ws5hg2BSQ1vVzfEjTDT4vN2a/UH1mhScugyyjSHrcC+QltNaUCvehs1Pl8J3Q1qLvvd1
 jCZQ==
X-Gm-Message-State: APjAAAWXe2MF1xWpx1CAyzdPaFUo6Co7UmkCZdMkOkzE3ZRYdlwNayeg
 1gIr//zy+tklkhW3nCL0AuTXMg==
X-Google-Smtp-Source: APXvYqz+PJmj7o6Xxx+lIPuuihguzGGIsh+1RqMLy3UHfZknPT0gNIJ++6sfaLdh+BmkLKygJ/ixMw==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr22405543pgp.58.1560739953430;
 Sun, 16 Jun 2019 19:52:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 x8sm9941823pfa.46.2019.06.16.19.52.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 19:52:32 -0700 (PDT)
To: vandersonmr <vandersonmr2@gmail.com>, qemu-devel@nongnu.org
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
 <20190614135332.12777-3-vandersonmr2@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <268e9e0d-847d-c51c-9e5f-d8c77b1bb553@linaro.org>
Date: Sun, 16 Jun 2019 19:52:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614135332.12777-3-vandersonmr2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [Qemu-Devel][PATCH 2/3] Saving counters between
 tb_flush events.
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 6:53 AM, vandersonmr wrote:
> A new hash map was added to store the accumulated execution
> frequency of the TBs even after tb_flush events. A dump
> function was also added as a way to visualize these frequencies.
> 
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c | 59 +++++++++++++++++++++++++++++++++++++++
>  accel/tcg/translate-all.h |  2 ++
>  exec.c                    |  7 +++++
>  include/exec/exec-all.h   |  3 ++
>  include/exec/tb-context.h |  9 ++++++
>  include/qom/cpu.h         |  2 ++
>  6 files changed, 82 insertions(+)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..0bc670ffad 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1118,6 +1118,12 @@ static inline void code_gen_alloc(size_t tb_size)
>      }
>  }
>  
> +static bool statistics_cmp(const void* ap, const void *bp) {

Watch the formatting.

> +static void do_tb_dump_exec_freq(void *p, uint32_t hash, void *userp)
> +{
> +#if TARGET_LONG_SIZE == 8
> +    TBStatistics *tbs = p;
> +    printf("%016lx\t%lu\n", tbs->pc, tbs->total_exec_freq);
> +#elif TARGET_LONG_SIZE == 4
> +    TBStatistics *tbs = p;
> +    printf("%016x\t%lu\n", tbs->pc, tbs->total_exec_freq);
> +#endif
> +}

TARGET_FMT_lx.

> +static void do_tb_read_exec_freq(void *p, uint32_t hash, void *userp)
> +{
> +    TranslationBlock *tb = p;
> +    TBStatistics tbscmp;
> +    tbscmp.pc = tb->pc;
> +    tbscmp.cs_base = tb->cs_base;
> +    tbscmp.flags = tb->flags;
> +
> +    TBStatistics *tbs = qht_lookup(userp, &tbscmp, hash);
> +
> +    uint64_t exec_freq = tb_get_and_reset_exec_freq((TranslationBlock*) p);
> +
> +    if (tbs) {
> +        tbs->total_exec_freq += exec_freq;
> +    } else {
> +        void *existing;
> +        tbs = malloc(sizeof(TBStatistics));
> +        tbs->total_exec_freq = exec_freq;
> +        tbs->pc = tb->pc;
> +        tbs->cs_base = tb->cs_base;
> +        tbs->flags = tb->flags;
> +        qht_insert(userp, tbs, hash, &existing);

If you're going to ignore the result, leave the last argument NULL.

> +    }
> +}
> +
> +void tb_read_exec_freq(void)
> +{
> +    qht_iter(&tb_ctx.htable, do_tb_read_exec_freq, &tb_ctx.tb_statistics);
> +}

Perhaps a comment that this is called with mmap_lock held.

> +extern bool enable_freq_count;

Second declaration.

> +uint64_t tb_get_and_reset_exec_freq(TranslationBlock *tb)
> +{
> +    uint64_t exec_freq = atomic_load_acquire(&tb->exec_freq);
> +    atomic_store_release(&tb->exec_freq, 0);
> +    return exec_freq;
> +}

What are you intending here?  Either this needs a comment that it is called
with a lock held, and this does not need barriers at all (atomic_read,
atomic_set).  Or this should use atomic_xchg and do the load and store in one
atomic operation.


r~

