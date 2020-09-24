Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56360C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8AD221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8Iug7xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8AD221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWsx-0007QE-O4
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWrW-0006Ua-HH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:25:02 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWrS-00069P-Qs
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:25:02 -0400
Received: by mail-pf1-x443.google.com with SMTP id b124so317259pfg.13
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HEj65C3KLyf8BwTjs+zoI4GIWetVf0bs5jRBh9sqQHs=;
 b=t8Iug7xFPQFzAWMyTO+ZWjcBo/5ZlRQDSNGIIKnaJdhhB9sbyogYL+8bs19voodLxG
 UeB9xNOn/0EKCfl4q530d4bvao681pjamsKue0hQVgjl+qVwHbrWZ0GZHzZeQ0e3T6mQ
 QgymhNmPWDlbQbYVpNp1ikpR3Nphw+zvpQjs6tJjzGXArBwyl19SkzBDVxY9TV8aVPfy
 pBVNqWumIn7NmB/vLHt3drvH4b32KgDasgm443oKogM/52jM7GMx1QEEZW5yxnUS67h0
 5nB4eg4/j3f2w2b1+GBbxIDfOvoweLXkgnKMRu8/5zg432SPk5EOj5NSI2E6zNs+gSPE
 j1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HEj65C3KLyf8BwTjs+zoI4GIWetVf0bs5jRBh9sqQHs=;
 b=o8om4coF8QUyNKNpZ/WWMkN9Nu49z6P56XSqhwQ0SqM1H4TPLLLQmrtq2YFLkAEG2v
 HxZxbCCuM89U82hmCtoASwRkyo7MO5VyzIRsdZjZHmflvxCn71sIi46P+dC0POLQwBhL
 FkCXiWv4ZU80HkoMWQLmtSO0mOQxKCuggV9g0aoWa8a5rzAfoEBcjqaZ1NqJAkZZQxjI
 d5tV8CiyDLnO5fEa1lf8dsKs1HJlGMoi6OKqiBdbCTuhXMogzTGyim5YzihUZDIAscYE
 eyVJJiJqGRMy35EsuAbuGwaKWfqUuZpw4GDqvYzHy8FOjHe8ruu84e/eZh77Ik40aiTr
 6Oyw==
X-Gm-Message-State: AOAM533QCIIG2FPyUA8jjYZa3K/eEF8CtqoP/f1MBnUdf6vBHkAcS7UB
 ovyXQstmao9qE8hCaCvUxPrlLjgfsK03eA==
X-Google-Smtp-Source: ABdhPJy2m7+VecA9sHB+9F3B3Uoc4a1X/9z3NY+no/6uskp1MFDPIauSY9tRYHusoGHhK1d1RBRQXQ==
X-Received: by 2002:a62:52d3:0:b029:142:2501:3a00 with SMTP id
 g202-20020a6252d30000b029014225013a00mr521830pfb.79.1600975496336; 
 Thu, 24 Sep 2020 12:24:56 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f19sm250695pfj.25.2020.09.24.12.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:24:55 -0700 (PDT)
Subject: Re: [PATCH 1/4] qemu/bswap: Remove unused qemu_bswap_len()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <195f22a4-7e28-a674-018d-b5dc05f69625@linaro.org>
Date: Thu, 24 Sep 2020 12:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923100220.674903-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 3:02 AM, Philippe Mathieu-Daudé wrote:
> Last use of qemu_bswap_len() has been removed in commit
> e5fd1eb05ec ("apb: add busA qdev property to PBM PCI bridge").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/bswap.h | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

