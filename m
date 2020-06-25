Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC4BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8BE20707
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pd6EMUlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8BE20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joW4M-0007dR-O2
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joW3V-00077D-P5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:52:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joW3T-0003gu-OP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:52:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id d66so3366688pfd.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7d8lpNyJAczEDB+ASs4mSRPCaqTqmMeH0HiqSGcYvkA=;
 b=pd6EMUlEncAamgvRJ+GcHaRhkQAhh+Ju+EkW2ZW1OMjxSa2iVVF8heT3FGbqxNM2XI
 9eyPgKiAZFQImtsPFVAF+77HN/X/se5eDqHqyT6ECqDbfN1P19+wBC2AFlwNhIWKp1y1
 jT8+tSO9H3aDDATAEIlRgvRTiq8IXe8LFcStij5qGNSbykthZiL5nOrc/cd9U5uGQB7q
 U1VVFSFRjC5VwtklEWA4RhjdVev/mL48QkNX76LZnhVdi2WsN8oQUG8yeY7LzwiHsabF
 o4HU1LHwO9bXyLG9bVvHBDMEx8Nh55nxJMZh+QUJrjF/529Si9LRrbnLPdYWxcfDSNPu
 kPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7d8lpNyJAczEDB+ASs4mSRPCaqTqmMeH0HiqSGcYvkA=;
 b=ii3cykodCbrB3jnokDaMOq/KIED4l23LsNXKRTZh64jCMRn64MS7nqPA9QNt+ukt+1
 zC/6Nzh1kkz6i/Mw97y+6/Ymch0zxM0UZnmoe5RZ+m/OtTrE/oNP01+CA4Zc5PEZCYgY
 Co7hoObilwLgWLGmk33T64gRrRyVOL3kXQpxVE8WEWoW1JNYkcQW/aJHm2xr2J/npXwy
 Xk1twcnqA8vKi3LVFvkdG84Mq8Jl7TByRoSpZRPaLJa4hNSa6PMYwXPorq6VUs7XEQ3C
 kuUxYG+pSMC4lWJjXYpXCIAvqZqeqLzdc7Lw1NQjZX+GQrLUlKas5H45jP5pksLBAw/f
 BeXA==
X-Gm-Message-State: AOAM530JoTtaByv6ZbLqnhpPz4BEUG221nEpOQuqBmljr68tvDtT+Jgo
 TYJBipcBx5knIhV+FODoApem6w==
X-Google-Smtp-Source: ABdhPJx/vBJv6rYyXZH377UJ/OEpH3A75WXw2v3pceNBnvNg9Fxwt7xHS0uEkeUQ72U5wQcrbC852w==
X-Received: by 2002:a63:dd09:: with SMTP id t9mr2177877pgg.41.1593107574066;
 Thu, 25 Jun 2020 10:52:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a29sm23492595pfg.201.2020.06.25.10.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 10:52:53 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] target/ppc: convert vmuluwm to tcg_gen_gvec_mul
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-4-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4fdedcf-987e-b72b-6bb5-8056f858fc6e@linaro.org>
Date: Thu, 25 Jun 2020 10:52:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-4-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:00 AM, Lijun Pan wrote:
> Convert the original implementation of vmuluwm to the more generic
> tcg_gen_gvec_mul.
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v3: newly introduced.
> 
>  target/ppc/helper.h                 |  1 -
>  target/ppc/int_helper.c             | 13 -------------
>  target/ppc/translate/vmx-impl.inc.c |  2 +-
>  3 files changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

