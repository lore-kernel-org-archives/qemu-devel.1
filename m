Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02980C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323C0206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vb5FKwoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323C0206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZyl-0002eY-4g
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 15:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZy4-00027C-Vz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:21:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZy2-0007yl-Es
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:21:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id r10so6029518pgb.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=d6sn0vcYdHHLiroTj9OvS1IZnUzqp3JVkiPdOZLorUo=;
 b=Vb5FKwoUwkmLnEmeRKlGqwviHcpOZkAOWWRdqUQlFozlCkCXXt6oKZOpKOaOzu0jZp
 KhkhBvptgEGYE0IBOraGUzsJYJti9PNJcjb4dDZkOXcI51OQd9r9j9nlOn/xYNMF4BJv
 lOCdV/Gjx5o34JdSpb+f8lS2PEYzc6XhD47Is3bDOMK/oLIT04VhneYUIdJH6hjDJMFL
 QK8eNu8uZAoCoTNHlpmBfnTs25fFcCZWRcjwUc/b1DwOc1hsAdrS2FOIK5idQMVhMY/+
 TvHtEG5oI1Lu5Vmbjvm0Uhcj9RmY2pNZsH/CBuSDZhQnz8t/7o4aALHOZo0Lpg4qqTh7
 mJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d6sn0vcYdHHLiroTj9OvS1IZnUzqp3JVkiPdOZLorUo=;
 b=LefEkmv4eCZSG2mUlKlo8PTU6BPBdyWIidPhHQnQSMx8C9VJ0C70g9F3PxjzJi6Pue
 bKBt1BFpUhTsaDovJyNlORFXyVMBDoWcIv4nZ4IIyaMfYduxZ1Rabr8EoX8J2jQZmP0L
 MbQQyde8c/6nMhiV4ON/ceisNwR3xD4AObx6ZZRa2KHp/tDZ+0WpMvGHVAtf5+9M/LCD
 7f+pKor1UH6Y+RjH7wSO76IOGGw9QZY1fL3ntfuo6qSLu+ccX3LmUJWwlcdhJmi6zwAB
 QkdYhGW+zRv9KcPrTbGUDMixCkSFjWZCU6PSqrGlm4SlEuPJaPkxH9iz5mOrzzOF+WkQ
 HS3A==
X-Gm-Message-State: AOAM533VWZ6630/BmccMNOblQ7WP2PNaIlsuYTN2isJxiN5tvV/Cr0oD
 7vVb1HST6lpcKhnhpKyat3zTO982u1YX6A==
X-Google-Smtp-Source: ABdhPJxeVDA6f4wMc1OTy4SaQijxJekMBcme0EIcYuEz3uwMTYlP1NJWliaWc4yKRZvBE9SsEK6UcQ==
X-Received: by 2002:a17:90a:8c:: with SMTP id
 a12mr4627046pja.155.1604085700400; 
 Fri, 30 Oct 2020 12:21:40 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id fy13sm4166667pjb.10.2020.10.30.12.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 12:21:39 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Get correct MMU index for other-security-state
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201022164408.13214-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77a9f90c-5106-27c7-ed74-8d68967e0cfa@linaro.org>
Date: Fri, 30 Oct 2020 12:21:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022164408.13214-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 9:44 AM, Peter Maydell wrote:
> In arm_v7m_mmu_idx_for_secstate() we get the 'priv' level to pass to
> armv7m_mmu_idx_for_secstate_and_priv() by calling arm_current_el().
> This is incorrect when the security state being queried is not the
> current one, because arm_current_el() uses the current security state
> to determine which of the banked CONTROL.nPRIV bits to look at.
> The effect was that if (for instance) Secure state was in privileged
> mode but Non-Secure was not then we would return the wrong MMU index.
> 
> The only places where we are using this function in a way that could
> trigger this bug are for the stack loads during a v8M function-return
> and for the instruction fetch of a v8M SG insn.
> 
> Fix the bug by expanding out the M-profile version of the
> arm_current_el() logic inline so it can use the passed in secstate
> rather than env->v7m.secure.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/m_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

