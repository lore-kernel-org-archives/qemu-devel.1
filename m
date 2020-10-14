Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC5C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901BC2222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RI2ADYxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901BC2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnJZ-0003Es-Bm
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSnHU-0001lP-P4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:21:52 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSnHT-0000nk-0K
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:21:52 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gv6so411008pjb.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/Hju540kJqtJpEYf8VHbuGev0rjwVMmjPN5aCVW9Yww=;
 b=RI2ADYxI3R5szbqv8P6TyetYks8Hv+qbb2IQt7o7Ez4q4be46/S8Vdz5o7IJHZb39H
 4wArwJDcLCJUBgMOHk8UdZLFQSK2JR4Ph6X6qfQUGFzMwrjTzrArlXIfOAy87Cc4aLfp
 aiZm1+VOIbuQmnj6dqnUsTXMdONB0Rb7i4raF9fOGM7qQi8/9LCrc4XRnwqLdUVt4VcV
 1p23AltLZ47nXZGPAM/+RStkyPpVfXwYMHDItSm/9UDowcfzBCBiPKXKxTrEICM3N4Lb
 xLkoe9F07zGGNZlBf/AtNKLWYgz/Keq9F+9cqtU78vPzKlM2Bru+2WTR68VCd4oWbOrc
 oNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Hju540kJqtJpEYf8VHbuGev0rjwVMmjPN5aCVW9Yww=;
 b=hwsweUlcqzhvx9Wl1JnPvyE1rSOC4YxKVr7a64/DJ6djpzOzuSLEHgIubZgzZh6bDf
 JHjucytfCzyWzrFJv9TsT1jQJ7yX30ebIYAPMOi+4mF7xO1gPDPJ7cJ4gfcJklLD3OIE
 dByGnSf/TQb4QefnS9b8OpPWFrftwGXjj909YxNLF2PLOeU/pmKT+AFwf0+q8Gg6KhTb
 +4POWDJ+Q8tPgits+ueEeQPkSr+iQxatAAxzjmDWPZ6LzvYYsvhcHwjXwKzcu7PtQuEE
 QAf5zng5eEsnXpbXYCKouSZjVI7KtKA5PDzIzg4YI3Kz4aW3K60fFyXAtigAOgflLmrU
 5yKg==
X-Gm-Message-State: AOAM531o5UZBg5Qh5dGiaUiwEkJ2X0QExz6/TSt/K7XbuXudxyKfHdg+
 +lxPZmpJObLT1Jv9XR9u6lbcrg==
X-Google-Smtp-Source: ABdhPJwg1m2go9q0rSA9e/dh3bJhHcDEjYqFng0Tro4WOMID/4ik8E+mAainvJw8hfH7Bnp7syeyBg==
X-Received: by 2002:a17:902:bc8a:b029:d4:dc57:6c29 with SMTP id
 bb10-20020a170902bc8ab02900d4dc576c29mr622919plb.77.1602706909308; 
 Wed, 14 Oct 2020 13:21:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 3sm481863pfv.92.2020.10.14.13.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 13:21:48 -0700 (PDT)
Subject: Re: [PATCH V3] target/riscv: raise exception to HS-mode at
 get_physical_address
To: Yifei Jiang <jiangyifei@huawei.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20201014101728.848-1-jiangyifei@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee4b99ec-5842-6638-ecff-54096ec0b0e8@linaro.org>
Date: Wed, 14 Oct 2020 13:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014101728.848-1-jiangyifei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 3:17 AM, Yifei Jiang wrote:
> +                if (fault_pte_addr) {
> +                    *fault_pte_addr = (base + idx * ptesize) >> 2;

The shift is wrong.  It should be exactly like...

> +                }
> +                return TRANSLATE_G_STAGE_FAIL;
>              }
>  
>              pte_addr = vbase + idx * ptesize;

... this.


r~

