Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9847C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705602073B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjsgDJ9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705602073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI2VH-0006hd-MZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2Uc-0006Gc-SD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2Ub-0008BI-Ea
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:50:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI2Ub-0008Ap-4v
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:50:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id s23so4234193plq.13
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 20:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vYSK+QZGTfqXcI0RKza85sUIJZRikjtw45NuTzVCe+E=;
 b=MjsgDJ9g/+E7oGWY8QpluUXI7fMtDnGU4T0RBbM11u8QQmtk2xMML8KHiQOr62B79A
 cv8yUuAwMyoUkQTfbjFB2m0mSHpqHfBi3YsPS35kUbyFesuQCkOj2MuDVd5YfgJ9RM1H
 99IdMLVSO1KefxzvjWrzfkXyEBoGWNK8bOIg3QsQ19hD+Wq3NbxTK/dkY0cNiqy8LdWS
 JkU5F21S1owepNzoZBsoTdTlB1F/M2ziHeDG5tjypiN9b2Gq5oqkpV0rRT3VDkMBW9hU
 yfMq0z+gE+9poesU6q0NMq9dyAzUeERM3F2jUkBX9VyzhUSMUpZ7qzXA6dHhLkURGR65
 bFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vYSK+QZGTfqXcI0RKza85sUIJZRikjtw45NuTzVCe+E=;
 b=gFWxL68rYBk0WeM3czw+FNbM46xFyvYa/xR8NDkxuKEXqXJ5a5kYuCuYaAF/yLwcpL
 fHy/UOzYXUGdit2tcJWWoFBBpPDoW+rh/5pfqDe6RxfHUGNiu6FbCA9zGEeqcqaG89Tr
 urs7fVONzuBjWYb4lLruixEiZREnHJ42CWcL+9r9MennvxGZxtptQBH2f72EpFn4kU/b
 ty9M6IemXKpyNGssiQ3rI5q8wzNnAPPP5Rc8LeVjSCo/5hQJDKv7sXRxX4bNzTwcElbS
 7l9PWMtaoRymZeE6A/QrY9lKdQWvllASARmWF+YG3skiXAPl2R7jx8gHsx0u07FV6upp
 vguA==
X-Gm-Message-State: ANhLgQ1GB92mSSHbFZwKH6T7YfT78aBATKtQCStasWqHlKYKINyDb88p
 GqJkOnhWgulhLLeDKa/TTq0i+Q==
X-Google-Smtp-Source: ADFU+vveCbNEF7eiOG6NaXWevzWCYUPo6azrIL4HVTk01Bzy04OcqkJCIIHGeV+XiAJfbfkPl7tNGw==
X-Received: by 2002:a17:902:7445:: with SMTP id
 e5mr2151242plt.308.1585367439744; 
 Fri, 27 Mar 2020 20:50:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id w5sm5242658pfq.80.2020.03.27.20.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 20:50:38 -0700 (PDT)
Subject: Re: [PATCH v6 58/61] target/riscv: vector slide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-59-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fb54142a-7e99-e456-f8b2-f7ca1c99ca80@linaro.org>
Date: Fri, 27 Mar 2020 20:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-59-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  17 ++++
>  target/riscv/insn32.decode              |   7 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  17 ++++
>  target/riscv/vector_helper.c            | 128 ++++++++++++++++++++++++
>  4 files changed, 169 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


