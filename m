Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D992206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihrd50Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D992206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju0C0-0003eC-H1
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 17:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju0BC-00038j-2G
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:03:34 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju0BA-0008RI-5f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:03:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id p3so3056613pgh.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YZiKQH8gnB5mj4utBfSI8q1PiCadk1xemrgzTDz055Q=;
 b=ihrd50LrTxcsDw00mVJmpFO9m/yg3v39jg2mJEtw7UUkpa1kuGdZLWevOemPdfa3H2
 THPcyMT4ShKCtmCrSukN9dWU1x+7Ljynfndc/dOF8tUcsOH8ostB45V8zZa+pTx5CSoM
 0Nzce73NCUJcLgfDUxouxMFpXMLJxW9A5z2V6tCG06a75uUQ1JGvkTq2PjutnTXAlQly
 xPpMOXwNteKCoSwqXbBI2OuPmQxG8VNBQWbaECEVw8g2zZC0wNzmI4D73Ayy1kcYpq/6
 CquirqkJGi6qrYTVhLgt8dSzwIAzQcjvtc4uWL8H3Ma7LXSefo5GjTJmFPp9lKlqGxg6
 JR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YZiKQH8gnB5mj4utBfSI8q1PiCadk1xemrgzTDz055Q=;
 b=EU5yABzJfrNdrXfbdxuNUo6Yh52EcuQ41dG5PlfswYBNPLR0owXkhsE8EwLB9EJGJ1
 jHrvYHH8hWdeCL3GXPKpkouzgM0l1TgGnubitU66lQIeIgA+1f8ipwwGuHKkzsfyreT7
 RO73cr4q0oPVtkoE4Raiv3gFCGHpDe9/X1w48dj3n/BgthMU+DqX6dUW74SAXIGCd8tG
 Olo95+8qObxDGRqeoVf3Xq8DC2v9MesPMPB6LoTF2/qdBFvC5eTS8veM4B2WG/kTmHZ0
 cg+uIenJ94rRxfePq69gJTNFgG6XoNdlDe7UcYkaDyLlGXJHRxpKOJ20U/pLDvrL8qhv
 4BpQ==
X-Gm-Message-State: AOAM531O7lJxSJEnXKnrDf09A1sRu1alVQ235OuqbNQ1MYQQsljM7Ogw
 u2PkS4/Y1omIjib2imttx+N/TA==
X-Google-Smtp-Source: ABdhPJwT/I/PZT2y7fug89PnFW4RtRepYu1/u+4q4lMf8xPJcr4QJ53yJIJzLfmdfVc+50IK28e9Xw==
X-Received: by 2002:a63:fc43:: with SMTP id r3mr60441981pgk.423.1594415010254; 
 Fri, 10 Jul 2020 14:03:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t137sm6875945pgc.32.2020.07.10.14.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 14:03:29 -0700 (PDT)
Subject: Re: [PATCH v1 04/13] cputlb: ensure we save the IOTLB data in case of
 reset
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ebfe683-5c6b-064b-7bab-3b9624f0a3f8@linaro.org>
Date: Fri, 10 Jul 2020 14:03:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:13 AM, Alex Bennée wrote:
> Any write to a device might cause a re-arrangement of memory
> triggering a TLB flush and potential re-size of the TLB invalidating
> previous entries. This would cause users of qemu_plugin_get_hwaddr()
> to see the warning:
> 
>   invalid use of qemu_plugin_get_hwaddr
> 
> because of the failed tlb_lookup which should always succeed. To
> prevent this we save the IOTLB data in case it is later needed by a
> plugin doing a lookup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - save the entry instead of re-running the tlb_fill.
> v3
>   - don't abuse TLS, use CPUState to store data
>   - just use g_free_rcu() to avoid ugliness
>   - verify addr matches before returning data
>   - ws fix
> ---
>  include/hw/core/cpu.h   |  4 +++
>  include/qemu/typedefs.h |  1 +
>  accel/tcg/cputlb.c      | 57 +++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b3f4b7931823..bedbf098dc57 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -417,7 +417,11 @@ struct CPUState {
>  
>      DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
>  
> +#ifdef CONFIG_PLUGIN
>      GArray *plugin_mem_cbs;
> +    /* saved iotlb data from io_writex */
> +    SavedIOTLB *saved_iotlb;
> +#endif
>  
>      /* TODO Move common fields from CPUArchState here. */
>      int cpu_index;
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 15f5047bf1dc..427027a9707a 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -116,6 +116,7 @@ typedef struct QObject QObject;
>  typedef struct QString QString;
>  typedef struct RAMBlock RAMBlock;
>  typedef struct Range Range;
> +typedef struct SavedIOTLB SavedIOTLB;
>  typedef struct SHPCDevice SHPCDevice;
>  typedef struct SSIBus SSIBus;
>  typedef struct VirtIODevice VirtIODevice;
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 1e815357c709..8636b66e036a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1073,6 +1073,42 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      return val;
>  }
>  
> +#ifdef CONFIG_PLUGIN
> +
> +typedef struct SavedIOTLB {
> +    struct rcu_head rcu;
> +    hwaddr addr;
> +    MemoryRegionSection *section;
> +    hwaddr mr_offset;
> +} SavedIOTLB;
> +
> +/*
> + * Save a potentially trashed IOTLB entry for later lookup by plugin.
> + *
> + * We also need to track the thread storage address because the RCU
> + * cleanup that runs when we leave the critical region (the current
> + * execution) is actually in a different thread.
> + */
> +static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSection *section, hwaddr mr_offset)

Overlong line.

> +{
> +    SavedIOTLB *old, *new = g_new(SavedIOTLB, 1);
> +    new->addr = addr;
> +    new->section = section;
> +    new->mr_offset = mr_offset;
> +    old = atomic_rcu_read(&cs->saved_iotlb);
> +    atomic_rcu_set(&cs->saved_iotlb, new);
> +    if (old) {
> +        g_free_rcu(old, rcu);
> +    }
> +}

I'm a bit confused by this.  Why all the multiple allocation?  How many
consumers are you expecting, and more are you expecting multiple memory
operations in flight at once?

If multiple memory operations in flight, then why aren't we chaining them
together, so that you can search through multiple alternatives.

If only one memory operation in flight, why are you allocating memory at all,
much less managing it with rcu?  Just put one structure (or a collection of
fields) into CPUState and be done.

> +
> +#else
> +static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSection *section, hwaddr mr_offset)
> +{
> +    /* do nothing */
> +}
> +#endif

Surely better to move the ifdef inside the function so that you don't have to
replicate the definition?

> +        SavedIOTLB *saved = atomic_rcu_read(&cpu->saved_iotlb);
> +        if (saved && saved->addr == tlb_addr) {
> +            data->is_io = true;
> +            data->v.io.section = saved->section;
> +            data->v.io.offset = saved->mr_offset;
> +            return true;
> +        }

Should that test in fact be an assert?  Why would this fail?


r~

