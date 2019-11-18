Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31953C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 20:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED934206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 20:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O07q4Edj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED934206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWnF6-0001lN-01
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 15:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWnE9-0001MM-Ql
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWnE8-0004m0-In
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:02:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWnE8-0004ld-Bc
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:02:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id z10so20998979wrs.12
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 12:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yypQCGg/HMINO5I+Dp2imVGmvtNFXpNvjFYO5OkTaJo=;
 b=O07q4EdjorZGLOpiPZxatmK36NjUPsPhyNIdGUkHC0An760x7/3No7z4yUX11BzySx
 9l4EQnJsHk9NukfUd1wK3WzB+AWsp5PuB1MUnaPOAsX4Sp6sOP2XDXl+ccIwz8kcwMy2
 Q48BOLaKF+Ld4holGhyHisNX5S3CC1yaDR4/VJgDiyS11XW2uJzIBdCCXaywerDh4OzN
 DDKH+g00mK7KL6eL9i5ha3295V1YO3ELpRzSSjnHM6p44EHSL+xP0krdAg0XfxrsAp8B
 pwhlkq/gUGRjrkLZCuidPJeey2TPQwx5nKJ9SsyWc5Tqyq/a9266kBFC8vG/5qO7YseV
 4EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yypQCGg/HMINO5I+Dp2imVGmvtNFXpNvjFYO5OkTaJo=;
 b=BBAO2MkgoloiJKPBjW2QtOuCXkkdpIyKqaP+0i41iIWyEuqp9+EMh5AGjD45V8be+X
 yWOiu/JvkK3384WQuM6UUZJp9VoKoNqoF+mugPnjQzuExKNSht/3JMokjSzImRm/eEqk
 mUzHnGyh17Lurfz+DyxC2E51Mp2Z6bAQ8Mzcy56u+0+Kc5Zmi6Cqr7JJzDEpGR890Sva
 zQr0HCrME8RCe0ErSKwYlNrEiFc4cP+XwOvwwI1BDUr4xER1ejv9Ir7+5Bip/RLxf9oV
 yFlCjogIbJpPyn7uSBXSgr6Bl9IEx2o/O5i2QXVkYOGNPCtHZGJl6dxd5eCRy8z1ae2k
 o69Q==
X-Gm-Message-State: APjAAAU9aDxz3N5o0oZUS6NMNqP41k/Wj7jVoaTVsbn/QTIK05iPjs9A
 m/4PtA6bZen93HfuI675KSnISIOCr7npmw==
X-Google-Smtp-Source: APXvYqw8Q0dkvW6Mo9IzTncmpMz5Vs4oxb1zoPp16TCq7dbDgiZo1IqBO6I73re3PTGijBAkiXMRYg==
X-Received: by 2002:adf:b686:: with SMTP id j6mr21668812wre.186.1574107342735; 
 Mon, 18 Nov 2019 12:02:22 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id x11sm24681907wro.84.2019.11.18.12.02.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 12:02:21 -0800 (PST)
Subject: Re: [PATCH 2/2] target/arm: Relax r13 restriction for ldrex/strex for
 v8.0
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191117090621.32425-1-richard.henderson@linaro.org>
 <20191117090621.32425-3-richard.henderson@linaro.org>
 <CAFEAcA8FdT8R4_nwUQ1QLBMBST_K0xuHABER3f8kt6JY1vYojw@mail.gmail.com>
 <f8071794-cb5f-d987-0e7d-11a70ba4d2bc@linaro.org>
 <CAFEAcA_qF6e_4_7syRVomag31pMgX02=R7JJ7a5pW_r+MU-aaQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <59a944f9-45f0-b78f-6ec3-5e96fe804767@linaro.org>
Date: Mon, 18 Nov 2019 21:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qF6e_4_7syRVomag31pMgX02=R7JJ7a5pW_r+MU-aaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 6:53 PM, Peter Maydell wrote:
> On Mon, 18 Nov 2019 at 13:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/18/19 2:10 PM, Peter Maydell wrote:
>>>>      /* We UNDEF for these UNPREDICTABLE cases.  */
>>>>      if (a->rn == 15 || a->rt == 15
>>>> -        || (s->thumb && a->rt == 13)
>>>> +        || (!ENABLE_ARCH_8 && s->thumb && a->rt == 13)
>>>>          || (mop == MO_64
>>>>              && (a->rt2 == 15 || a->rt == a->rt2
>>>> -                || (s->thumb && a->rt2 == 13)))) {
>>>> +                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
>>>>          unallocated_encoding(s);
>>>>          return true;
>>>>      }
>>>
>>> These cases for r13 are indeed no longer UNPREDICTABLE in
>>> v8A, but they are still marked as UNPREDICTABLE for v8M...
>>
>> Ho hum.  I knew I should have looked at that doc as well...
> 
> I would like to get this in for rc2 tomorrow, so I propose
> to squash in changes to give the following result (basically
> turning the ENABLE_ARCH_8 checks into checks on a new bool 'v8a'):
> 
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b285b23858e..4d5d4bd8886 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8927,15 +8927,17 @@ static bool trans_SWPB(DisasContext *s, arg_SWP *a)
>  static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
>  {
>      TCGv_i32 addr;
> +    /* Some cases stopped being UNPREDICTABLE in v8A (but not v8M) */
> +    bool v8a = ENABLE_ARCH_8 && !arm_dc_feature(s, ARM_FEATURE_M);

Sorry, I wrote the patch but got distracted with other bugs without getting
around to posting.  I had solved this with a new ENABLE_ARCH_8A, but this
version works for me as well.

Thanks,

r~

