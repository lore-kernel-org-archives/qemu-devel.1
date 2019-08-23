Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0067BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62A22173B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6A85DVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62A22173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DLv-00032o-BS
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DL1-0002U1-NZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DL0-00045f-Ir
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:26:59 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1DL0-00045E-A9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:26:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id d3so5945093plr.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ewZHl98JDZzEIGY2vftjUzR4hyNDpSWY/+z3/L+Ka9w=;
 b=J6A85DVHuRwKAAiijhsSQq/A6NI2V5LUm1p0GFUM19BkTb/85H/D7z2jKslERHEtzj
 /NIEFUhxh46HM41eQIjtbUdu+uN4QW3FssDRAW2Xly2mDQUEkSlaGvs/+z3TZreFp0r8
 0Pt2yuhKIhyeR+CQRkMbbSj8OZuMsvegnMAw0pNYOSVhnCKtKH8R2bZVAwfhrgvAJIMm
 Ih3fUUMVt9qL694JCAfjXJxw27hcdYavJjHlP6cC1wYtjTKq5PjnQUYJzf0hNJh3ozvD
 q23tQy3qzDvOeWCfzCn1tbwAGBUWeSicDaZvmvkJ+pebrTG1txZ7iKim3A553ucJeaa0
 crrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ewZHl98JDZzEIGY2vftjUzR4hyNDpSWY/+z3/L+Ka9w=;
 b=iT+Ntrja87qAIN2AT6Hbq08WH4qkXzZ0DsC9Ys8W4Ee17sVwbICLNF69Lw7GAsZWEm
 YTKqkVxLLbtW0DTXsXXwm/C56VwdaXGh9CY/WJ1dy6mlExnGkTZOwecenFq25ukVui8I
 kAXxyMvv12Vda20S8b1r9rg9cMSTL4UsNJUCR0WW3sqctccqwEznFaiygtOKP/BC4Mv1
 UikbR0VyhriiaElCIJJIJm8NunrqKkL/teraziy0TYwopGe0/s3Bn75gbTV2fdtJE2sm
 VCLcxCyxIP7yPONAaiE+Mk1N5C0340wf4zvI7xhsw19YlmCJvuodPmDg579RXVkDGE0n
 W0cw==
X-Gm-Message-State: APjAAAUQw0v54D7El4uHn81vVaxXW+xsxmakZVOR8dQvNqXdeBewCHOo
 10et/DewfLXCkRT1MM9Qz+D3Sw==
X-Google-Smtp-Source: APXvYqwEhweg6BnhH/wVwH2+yZKuncUKc9hW2palH3+1AUTS1GdHwa1zGqceH8h98Vhfg6QIISkVAA==
X-Received: by 2002:a17:902:5c3:: with SMTP id
 f61mr5648394plf.98.1566581217473; 
 Fri, 23 Aug 2019 10:26:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l123sm6688874pfl.9.2019.08.23.10.26.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:26:56 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <218d4102-32cf-6f31-6d4f-103f89edc323@linaro.org>
Date: Fri, 23 Aug 2019 10:26:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143249.8096-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 4/6] hw/arm/fsl-imx: Add the cpu as
 child of the SoC object
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:32 AM, Philippe Mathieu-Daudé wrote:
> Child properties form the composition tree. All objects need to be
> a child of another object. Objects can only be a child of one object.
> 
> Respect this with the i.MX SoC, to get a cleaner composition tree.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: reworded commit description with Markus suggestions
> ---
>  hw/arm/fsl-imx25.c | 4 +++-
>  hw/arm/fsl-imx31.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


