Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F83C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0F420735
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Du03l7UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0F420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kan0i-00040K-SP
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 16:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kamys-0002bp-Ec
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:39:42 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kamyq-0007ZV-HO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:39:41 -0500
Received: by mail-pl1-x644.google.com with SMTP id k7so1427523plk.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hUb+gkieEfDL7eoj0CTHtKlf+5UQGIpn4Qyj8glC2Ps=;
 b=Du03l7UFHquSWCnML7n8lXsUWunFlNxGpjvTF5buK6M69uoH5h06OW7e2Im494BNNH
 uT+Kx9Ljxf71MkTwc2xkm3dTUt8R4s9uQpQm0qCfCgp5tYSIjJWyfhkGp7K/1kBS33uW
 uO23/i+JafvN4OwakFJnVqydydGVs+CX9NPWxa2HEFSnbpb/C9LHFU96y+yy/fUjmKAr
 uRwTlawYzsSebeDofywtTfX2PvhLvwGbMUlB/0X+1Nox5R2JzOjShD6kOyVC2z+G+NYF
 /fkSD4Q52/t8RGSU9mJt1bR6tz9k2wqPPT9Xwzr7AvWqwGcdIQcP+wpB7OhMOf802oiw
 Uy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hUb+gkieEfDL7eoj0CTHtKlf+5UQGIpn4Qyj8glC2Ps=;
 b=nO2VmYURxoa5iAaXhYpcJ/eMEdJz2HgljqJHq8io3wMxs2PypEHc9U1TxkseqH6lMK
 7gJROKzxoiVHUarfhNrPetN6ar4wmIS0bdND08/s0UXHeXq6ioDkVopKb+9KCvtnfYl0
 UJNWjrBF1yYoJucZZ4kFXEYFJsWMecQ4PbTQhA1vF4G660UTW/6dEKRriRIS0IYbRv4i
 pATaesRzm7eEjA0vK4yr3ux6plOKYZwNd6Hn/q7mocCXbqllsQHjAJtTnpQRwmTfCD1j
 X5EwHuI7z8RkIQksCiHxKHzAGJXJsLXlIyzTINstt0hqMgX6CQ62aenZAj20KYuVArT+
 emBA==
X-Gm-Message-State: AOAM530eky7tvxR1SsvROSg6Q2L6GaFu146/0oNnS0elVK6LSd1/KOkH
 wV+wdN1qAh0RyngExlLyiLUIOQ==
X-Google-Smtp-Source: ABdhPJzSDjxjhov13NvTafpocwoJ/YPLV5uas5eWi27bgHKQ35K3TZqpDfa43sgPMF//x2A9kqm3XQ==
X-Received: by 2002:a17:902:a9c9:b029:d6:2d8f:f7b4 with SMTP id
 b9-20020a170902a9c9b02900d62d8ff7b4mr4204940plr.2.1604612379061; 
 Thu, 05 Nov 2020 13:39:39 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id x26sm3435245pfn.178.2020.11.05.13.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 13:39:38 -0800 (PST)
Subject: Re: [PATCH] target/openrisc: fix icount handling for timer
 instructions
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160457727672.17573.9713521384015502561.stgit@pasha-ThinkPad-X280>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d3185b27-4df1-20b3-605f-cb82e158bb89@linaro.org>
Date: Thu, 5 Nov 2020 13:39:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160457727672.17573.9713521384015502561.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: shorne@gmail.com, proljc@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 3:54 AM, Pavel Dovgalyuk wrote:
> This patch adds icount handling to mfspr/mtspr instructions
> that may deal with hardware timers.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>  target/openrisc/translate.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Looks correct, but it would be better not to duplicate the code from
trans_l_mtspr, and use an is_jmp code (called DISAS_UPDATE_EXIT in some other
targets).


r~

