Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF19C2065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKGQkpxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF19C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9t0-0006fZ-3D
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jg9s9-00062A-3P
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:34:41 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jg9s6-0001EC-4G
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:34:40 -0400
Received: by mail-pl1-x643.google.com with SMTP id y17so1546239plb.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4neyI7w/aPFVvIQR2mi0T1kfTloVSrPlHZ3gtXs8pEg=;
 b=CKGQkpxedfXA3y2L3n3566Fp6FCKDI8u3dz36Mu7vCHo+UTwUHy6VoTBDEGE6rQn+8
 jCCVy6Aadb38cy2dXtLcq9BijE0L/D9fFZ8jJc1TnnaMTNkk71eyGdz/EDeqa//Nt+Kb
 xB2YVHu82bBbkc0cEM5cH/kui2upJb/CI1b0zC3qOywGMwAnOYc0XVeVEWK5ql0WPQz7
 WLutEMXcgpSzVaI3JwtxiYzz4ZA+IQpfaieFtmHXkBt6vSQyRPwJ5r2DTRjGs2JGzXmD
 IYXTHFRPk6G9bqgxYkIib2UEoZTfEsIJnV/IyQ+YTs5fkbkiI806gZ4ipzd/V8/zJgfW
 dX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4neyI7w/aPFVvIQR2mi0T1kfTloVSrPlHZ3gtXs8pEg=;
 b=PVY3d5qjxRySRFc58VfQgOtDENcNn7KBVEF6vWcuws3wzH207Q6wqva7cQhFh+8nzT
 bt+X+d2oNncTzDHn3f5BQGcAb3RmC5piBvrsp0qPnraCMVaMz95u7n+mZ5lQ78x2EQzG
 PpG6Sk/lyKsT6HbtoGFWqivrlgwiVYTBXkYYQ0VEmBIimayreJMIY4EEF1UIPqJBZ1MJ
 lAE45eJPmtGZiJOGK8hDxxpX4eKaog5kax7fRZtGlXhQRRKxJtYakKmMhvjzrmhP++iN
 NnAnkF6n8FDw2zTkP3guB9i0mgxekBvE/k75VQFWpfQymxzAk9lnUXqG4SJOiY5ZMT5o
 sheA==
X-Gm-Message-State: AOAM532+xFoeoQH00C8r5kdOGDQfj7TbFL/XGXS2adappB+Wd5w4hJ+5
 TdIRWL3ReeRP7ODL/nY/0/Msbw==
X-Google-Smtp-Source: ABdhPJzGd0zf7P7lqIb7NgKBzF3Ha8UcjzngZ2o0ecPgcyPM21f25u65wzCome4hVDKQHA86+o8ESg==
X-Received: by 2002:a17:90a:65c9:: with SMTP id
 i9mr146533pjs.201.1591115675105; 
 Tue, 02 Jun 2020 09:34:35 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e1sm2636854pgj.0.2020.06.02.09.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 09:34:34 -0700 (PDT)
Subject: Re: [PATCH v1 5/9] cputlb: ensure we re-fill the TLB if it has reset
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d27ce2e9-f6a3-0f54-83ed-888d731002fb@linaro.org>
Date: Tue, 2 Jun 2020 09:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602154624.4460-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 8:46 AM, Alex Bennée wrote:
> Any write to a device might cause a re-arrangement of memory
> triggering a TLB flush and potential re-size of the TLB invalidating
> previous entries. This would cause users of qemu_plugin_get_hwaddr()
> to see the warning:
> 
>   invalid use of qemu_plugin_get_hwaddr
> 
> because of the failed tlb_lookup which should always succeed. We catch
> this case by checking to see if the list of entries has been cleared
> and if so triggering a re-fill.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index eb2cf9de5e6..b7d329f7155 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1091,6 +1091,20 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                                 MMU_DATA_STORE, mmu_idx, iotlbentry->attrs, r,
>                                 retaddr);
>      }
> +
> +    /*
> +     * The memory_region_dispatch may have triggered a flush/resize
> +     * so for plugins we need to ensure we have reset the tlb_entry
> +     * so any later lookup is correct.
> +     */
> +#ifdef CONFIG_PLUGIN
> +    if (env_tlb(env)->d[mmu_idx].n_used_entries == 0) {
> +        int size = op & MO_SIZE;
> +        tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
> +                 mmu_idx, retaddr);

Ouch.  What if the target has a soft tlb fill, so this requires a call into the
OS, so this fill actually raises another exception?  This will not be happy fun
making.

I recall I had objections to recording this translation, saying that "we can
always get it back again".  Clearly I was wrong, and we should just preserve
the required CPUTLBEntry details before they're lost by a device.


r~

