Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8591C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F7A2222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hg6k+uO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F7A2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSizb-0007f1-9J
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSiy5-0006Zq-4X
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:45:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSiy3-0007gr-6l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:45:32 -0400
Received: by mail-pf1-x444.google.com with SMTP id f19so6790pfj.11
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bekVVwx3fg5RyV2lzAVABqy3iI2WaUm9OTRp1uhf2Uo=;
 b=hg6k+uO0U0vAdj8r5W5MdEloBMX3A3VeU4AZB0lODmE2OfD6srAIawlRPuZerUV6Ea
 gv0pwHlaYYMmTA3t+MtO3AqQEb8Cq7Dcu6bNvAPgowuU3jJZ4stniwQ5HXP0vp+wexk6
 jGxCEhi7L98BmhDpR6+jfmUB8QRjEgfgUa0fo92Z0QXXEVJ/j3PF9+EIf1nLac24lrTD
 AbM4NDmqsXh47grRbGzp0c8w9SKxaMLDHQ08d8W0LZ7HW0WJSzS9e6xncERumcS+D9YE
 R94iKppz3HglhQE8aABJaRL7beNySLciTp1KyWXkhMjFODxT7SKUVT9Z0MElEc0Dad50
 6OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bekVVwx3fg5RyV2lzAVABqy3iI2WaUm9OTRp1uhf2Uo=;
 b=FgY4+vqzhfsujjfwlNHHmiZPiMPyOyUCnCzUdlEdvk14i5HFlWXB4bWz+IAb54LvvS
 B8S045jfDyfosAbfiE3e3+tXq6JFFnZvKRYArdCgHu4nbwJkt7BVcic5GKQCPauNIqaF
 qgtEx+vLxmrEj3Er90r2r7sAWy9gkZ1T+Xdp27DiLPhP5XmkdDGeUSAYm3GrZqo/9A5p
 nlLUTJEwz92K4B0udwqp/P6Lp5OxD7KT9VeaQ9Qu3c9lDoYoGpe706MG6fb8MNxAufZJ
 V6Rp9WjJhVBt3O1yJ72dKokbEmtUpWN2hu2cVFbLUVIUG7VFzf8wLuVjc7XimrpwOv/L
 SmRQ==
X-Gm-Message-State: AOAM533uK5s0JZJnuKzp5YlJKd9XqBU13cfWkIhjE50Z5vRNthJ8CgTs
 koxW1digvSSekWcgc36CW5VZyw==
X-Google-Smtp-Source: ABdhPJyhBCLjYPXrat9Hj/b/h7B5hxSrFg+VMwaeiDUv/CSryJFB1Y6GBoE+IXP8Bj1NAj+zfhjS4g==
X-Received: by 2002:a63:ab07:: with SMTP id p7mr4358636pgf.326.1602690329555; 
 Wed, 14 Oct 2020 08:45:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t9sm3937411pgp.90.2020.10.14.08.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 08:45:28 -0700 (PDT)
Subject: Re: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
To: Jiangyifei <jiangyifei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
References: <20201010080623.768-1-jiangyifei@huawei.com>
 <20201010080623.768-2-jiangyifei@huawei.com>
 <0bc022ca-35f6-8579-51f1-65005e89a9a3@linaro.org>
 <cbbaee32aaca498294e599ba7768279a@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d4fa7cd-b534-5635-302a-6ef0c4b8426a@linaro.org>
Date: Wed, 14 Oct 2020 08:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbbaee32aaca498294e599ba7768279a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 yinyipeng <yinyipeng1@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "Wubin \(H\)" <wu.wubin@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 3:21 AM, Jiangyifei wrote:
>> Would this be a good time to expand mstatus to uint64_t instead of
>> target_ulong so that it can be saved as one unit and reduce some ifdefs in the
>> code base?
>>
>> Similarly with some of the other status registers that are two halved for
>> riscv32.
> 
> I agree with you that it should be rearranged.
> But I hope this series will focus on achieving migration.
> Can I send another patch to rearrange it later?

Well, that changes the bit layout for migration.
While we could bump the version number, it seemed
easier to change the representation first.


r~

