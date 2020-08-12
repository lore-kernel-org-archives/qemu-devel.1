Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29828C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3DA2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqLvu90s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3DA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uvf-0001r9-UU
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uv2-0001DW-Vd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:52:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uv1-00052H-EB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:52:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id q19so1460849pll.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0/Y+sjALHjJ7KKcWQrbVOeERCp0R6xL94dZMo5Qlln0=;
 b=MqLvu90sKaabisuCh5KkqjEkGZu11/YPhAH4reO0cBBTmGA/do4z0SdopDPSh2UrVi
 yZ8w7mD4SQ1IdBFIkhbJIZ45wZLIUvrjrB41b+R3AJfg/g8Gzn9AUXkAgCtyzzfiuUef
 TKAGuwwftLa/0VIbpV14Vtvu0XLhZOpdRMyvcF4zOvUhZg3gQHnB829wcUAXRtUiDK4y
 bSXFydhDbP25OLLAA32CWZ8pHOqI5CUEPvsJl+3u22mQhKZCOX+85kgDVgbJcjgmfxq6
 5felMm5Ug8GEtbzHuihu1BF7GulVGpU2TfbTcx5VRcrfy5IbpkqHf62cjSIixRYoGXzW
 LjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0/Y+sjALHjJ7KKcWQrbVOeERCp0R6xL94dZMo5Qlln0=;
 b=CSgfN+KngfpOaZlDVqmMKd0JWP2mwz9Y3TUZRuEPmSlNixnwI+xVQIGpZVJQZ78W3x
 8T/XEnsfuueAI3ggvIXNnSqLPEk8sYfrzB3UPUF7oRWM5g0Y8UY7K4i0Ra107GPkZNYd
 d/bpSFgyGh6z+sQz6qsHBn2ybqxRoiKRYAGaKEyp5S1sq4cn9W6lZCI3V8XJGKT65Gvz
 JtMf0f3zMRK/Fi9zHZf2l6RU2121P5DWUJb1ENoYZWT0rQNksjb9CgJ4+HRodor8kqMf
 gdDwJXO4P8K/kpC44zYsDcPg0pRQZuEbvUrWoGoyMb75qoX87PHfrYBxeNtWbkkr6VrX
 HEHQ==
X-Gm-Message-State: AOAM530HxMsshiJzM8HSFE7g/ZCgAqlGyyCmvvVCg6mu9dFr2OE1+j0m
 yMUlpEt8qHVpfC+Az1BwNQvlhg==
X-Google-Smtp-Source: ABdhPJzb0+7JlHulT+V7bUib7ZIhnQZwGymFFnu1sJ3gJ1LbVfAI/Y68n8/8VXlSIEtmix4vaAaLIQ==
X-Received: by 2002:a17:90a:aa90:: with SMTP id
 l16mr1185854pjq.210.1597254726007; 
 Wed, 12 Aug 2020 10:52:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y6sm3108154pfr.61.2020.08.12.10.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:52:05 -0700 (PDT)
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
To: Andrey Konovalov <andreyknvl@google.com>
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
 <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
Date: Wed, 12 Aug 2020 10:52:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 10:38 AM, Andrey Konovalov wrote:
> On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> As reported by Andrey, I was missing the complete ISS info for
>> the Data Abort raised upon a synchronous tag check fail.
>>
>> The following should fix that.  All the twisty little rules for
>> the ISS.ISV bit are already handled by merge_syn_data_abort.
>> Probably the most important bit that was missing was ISS.WnR,
>> as that is independent of ISS.ISV.
>>
>> Andrey, will you please test?
> 
> Looks like WnR is now being set properly, but SAS is still always 0.

Are you looking at ESR_EL1?

On page D13-2992 of revision F.a:

# ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.

which means that ISS[23:14] are RES0, which includes SAS.


r~

