Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAC0205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdThm1Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAC0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ME9-0005eS-Lz
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3M35-0008FD-DX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3M33-0005ZP-U3
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:09:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3M33-0005Xp-IB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:09:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id bj8so1715190plb.4
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4HhoEFe8VeOwQTpSCK7I23HKCrelSH+zQyFEQNk0vW8=;
 b=VdThm1DbksQ4AFoqbCzx0uei/0bJhR1Mphx+0LWMVsWLiwlWgSz7fu5ysXNzg/RIMK
 yf2y5wIcrg7XE9lyGenROAV6r8/jKUXRwzzolPZAEVV/Rsx3c3ajjzD4kSzTpiTPFspi
 IyOEd/+YMQ55oJ/Fhat4wkvS/ITwIGeeWqL8j4Et3dKXQsytvEJfXHHr7370AyuxxofJ
 GRTloZ3xcEzl7bUVqxewOhfWyrLUZEcNBIVo/I1B2CST7OMf0lq36b9/g0abdK36RNiG
 m83m+4o8vzZbwzwTVrukSHEckbKMzjuyNqIqYLCk6eenzyct2rmVT/M9BBT859MbDDbt
 dLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4HhoEFe8VeOwQTpSCK7I23HKCrelSH+zQyFEQNk0vW8=;
 b=S0ISReT62qx+N79cmA2VR/XxRTpM8aTWBslQp6BIc7IrjsFSHB8xg5EHiSiqutE6cq
 LyHYO/UvBpB9RRwfDzAsHbYTYntOX9iKflJHNXQ6xRqvOXkOADAMvT89nY98K3a8lsoV
 rHHiThT3gMH6XxKnsQqqIDlCTs/XDg1geFRbWrW3Cm+0+qRhjngRL40pr54rMAmPcUQz
 /+r1QjzeykX3QSqsULptAO9g0RCkqleeVyNImzCpZVnuzEPoR1wD4Kd2/k78xyyI04qE
 vGncO8j1n3bRd30fniTCiiw+XCYr1TAHuJSvqmsXqLLuNjCygcrhp2Yj8wn0ixeyYpMO
 tqtw==
X-Gm-Message-State: APjAAAXq3ze9UGXx+D+ZIr8cdTqQSDuChnRZLRRocTAj1YwsJ4vTMSuo
 +7jsR8Im8eXun3MKNsQKqgZfZw==
X-Google-Smtp-Source: APXvYqz/db+qyXlKQSmPuc4kyT0TrvZi80S0LrVq9iT+aW7A8SQv//Q24HBoaewsSm5nmlbV3zSdeg==
X-Received: by 2002:a17:902:bd0b:: with SMTP id
 p11mr4196630pls.46.1567091356085; 
 Thu, 29 Aug 2019 08:09:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j1sm2409261pgl.12.2019.08.29.08.09.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 08:09:14 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
 <3b85e9b6-8799-9682-9aaf-b688924cb52e@linaro.org>
 <841ebe5f-dd5e-c59d-d7e9-c246ad7741c0@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f81553cc-0f95-003e-f608-f83f9a7e8dd2@linaro.org>
Date: Thu, 29 Aug 2019 08:09:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <841ebe5f-dd5e-c59d-d7e9-c246ad7741c0@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 Alistair.Francis@wdc.com, alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 5:45 AM, liuzhiwei wrote:
> Even in qemu,  it may be some situations that VSTART != 0. For example, a load
> instruction leads to a page fault exception in a middle position. If VSTART ==
> 0,  some elements that had been loaded before the exception will be loaded once
> again.

Alternately, you can validate all of the pages before performing any memory
operations.  At which point there will never be an exception in the middle.

As it turns out, you *must* do this in order to allow watchpoints to work
correctly.  David Hildebrand and I are at this moment fixing this aspect of
watchpoints for s390x.

See https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05979.html


r~

