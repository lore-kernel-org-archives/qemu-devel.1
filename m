Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71313C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69093221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZhsfD9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69093221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3orL-0007jX-IN
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 18:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3oqa-00072e-64
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:58:52 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:39200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3oqY-0007pQ-L1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:58:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id f9so7431929pju.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QnnIcZDIbfq/i7nr6CWOpWg/8xI7vWY4gpm0Kv+LiXY=;
 b=WZhsfD9X3bvGaypquzBiYA/tQvZWFzZDAfabUfq25d1gohGpvZXaviuP41O5PzK8Px
 K/R74gBkguXMRGmO8DyaK6FpybPPDUL/3clfbvP8vz0pjqkiXssUFiqmP8t2geUOkEpv
 Y/+Kb/WnhO98OF3mSgZ8rW2IKT3jtSiwLevdgQFJk5K6s4PTNSRthKxqiYDn5TDF/ART
 Ne2HdqvqTiFGlumR3m3MV4FnA6QiY+grt1hsk664KVRDzvARLxDjFG+8kCQtejPBL0lw
 KSF5aTXuQPXvBnVhC3FRo2iuYsWST3QGilPoHxyPze3woFEDLlE3t7FCrsUlNxbYcKJ5
 I1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QnnIcZDIbfq/i7nr6CWOpWg/8xI7vWY4gpm0Kv+LiXY=;
 b=KVAbCMUEqcX8cga62ZC7COQzu3NoFNHWBk8y9s44F1Fayfop+G/PA+aGPCR8J+ppM8
 Y8xsgIQcCOwjKda0M3JEYjJR/fSp4gPzNf/i+DJ2paE9or7OwtZQBxxCGyxa9Ec6iFJp
 0+0YH6WpLakxUwG3P3EpNTQR9MeYDCDODxGnjiuPDjXDBVmQMQctKS9h8YjuXsFXR1ZW
 QT7/vCzNqShp6tc6VMx6FEQZ+RJ3EkM0rl62DVkPrVTRSWzcI8EgEBKUitdq+fjT5BxD
 9tcB62AszKH89K8N35lGGoLCHwiM9d3Pd9RkbvQQNJE5z6a6uqJxLco4xN6D1/G+dqii
 zN6A==
X-Gm-Message-State: AOAM531+bQf8gi3VhW8sJE8Oh0VuEvsZENEQ/uuie/1OoFS746V9D/mR
 elPapnLyw6Vif55e/BGMMr6CEQ==
X-Google-Smtp-Source: ABdhPJzwt1YxRQJQzWwDgc1LeCRT2MQj4XR//FaESfnsbFn1gF8os30F7aHQdbX/Pj4PtlBAprrCUg==
X-Received: by 2002:a17:90b:f94:: with SMTP id
 ft20mr10942495pjb.69.1596754729318; 
 Thu, 06 Aug 2020 15:58:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n3sm9490152pfq.131.2020.08.06.15.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 15:58:48 -0700 (PDT)
Subject: Re: [RFC v3 17/71] target/riscv: rvv:1.0: add translation-time
 nan-box helper function
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-18-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c63fa4ab-7612-6868-343a-b96b58a5586d@linaro.org>
Date: Thu, 6 Aug 2020 15:58:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-18-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add do_nanbox() helper function to utilize gen_check_nanbox_X() to
> generate the NaN-boxed floating-point values based on SEW setting.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Similarly, do_nanbox will Werror as an unused function.
Otherwise looks fine.


r~

