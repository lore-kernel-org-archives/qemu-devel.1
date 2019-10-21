Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14B5205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUZsKbdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14B5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMabq-0002Cu-CU
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaW2-0005FR-9i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaW0-0000xW-GD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:26:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMaW0-0000xE-9s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:26:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id y24so2917005plr.12
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=azQt8Z06gMI9xiCQyxLEYi1cY1m2itmsYE9zyv2qBEI=;
 b=pUZsKbdHjan5IlEaAlDg/TlHLeidLlyxeFOxWUhmtmuquuEzUAqmeqg5c/kRVTvu+L
 2coT12FY9FzqCwvxbVmeiTOgcUITZFpI4m+lu/sXJyPz41foFceCeccMRna6+vey6LGz
 XFFhOHYjyvlzrVIryDQtA9tMTGUOjMQrGbhH+VEG7A0br5KHNNanN2HNTPH9TKGyxUIa
 AyOomVQYY/2bJfP4Tub5I/kgUgcLvCp2iIr/Pue63H9QYIpegrR7Wdasf9iAQGKHPJsF
 hLIEF+5aL0J0SIXKUORJLT2iA5OOghSNnizh/SmWx5o0IMsZpaEQ2mCpeVqly2vLeEb1
 X/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=azQt8Z06gMI9xiCQyxLEYi1cY1m2itmsYE9zyv2qBEI=;
 b=LR9/KsFEXPCEezHyB6pQl2FML+sWlL1ZvIziKdZafmH3dYUidi5NNgEJ4KCGJTrzy8
 3k2JdcQ0RZyaVqreaOKT9Wk53oUZW/LdRrdBrLUsQ6jGfKuINR9MT/gIDLkRncAK2WAe
 2M6py6yV4keVYaFH+4TFlQVofK2dba8nmFCzFt4aWtDT57eyxBm7pqlv1h+cqxA+ALqg
 kpDXVJxeFrkNH+v6sTW7UgU0KUcHYnNnAFas0F4ZtukjC/6cWoTKM8HmjDVkUmH3fxkj
 amrsBWe6KY40tRviBz1XuaTbjRZao2J2jUecx9WoODB5vN9yRCxqGbj7oVGo4eFLT4XQ
 HfYg==
X-Gm-Message-State: APjAAAV6DSEg4g4a3PJ7uvdIZ4oAHyQ4ANdbWORixVFQQ8PaHLk3mtTb
 dQ2lb89gYTF9AfpSj9qeM4UQJw==
X-Google-Smtp-Source: APXvYqz3qQVOk09BMuIQZeJItL77COqRGHxp+w5hqwbCzqRVl/3OvBMHJHjBy/YWCwUcYhsDAEHbKg==
X-Received: by 2002:a17:902:8c98:: with SMTP id
 t24mr25469864plo.334.1571675198926; 
 Mon, 21 Oct 2019 09:26:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d7sm4250271pgv.6.2019.10.21.09.26.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:26:38 -0700 (PDT)
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <155991c2-523f-0721-c7a8-4fbe4986387c@linaro.org>
Date: Mon, 21 Oct 2019 09:26:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 8:52 AM, Richard Henderson wrote:
> On 10/21/19 7:58 AM, Peter Maydell wrote:
>> Since 2008 the tcg/LICENSE file has not changed: it claims that
>> everything under tcg/ is BSD-licensed.
>>
>> This is not true and hasn't been true for years: in 2013 we
>> accepted the tcg/aarch64 target code under a GPLv2-or-later
>> license statement. We don't really consider the tcg
>> subdirectory to be a distinct part of QEMU anyway.
>>
>> Remove the LICENSE file, since claiming false information
>> about the license of the code is confusing, and update
>> the main project LICENSE file also to be clearer about
>> the license used by TCG.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This patch takes the simple approach of just documenting
>> the de-facto current reality; does anybody want to argue
>> for something else? Other possibilities I guess would be
>> specifically documenting tcg/aarch64 as an accidental
>> exception to the general licensing rule for tcg/, or even
>> trying to get it relicensed.
>>
>> Does having tcg/ be BSD-licensed gain the project anything?
>> From my point of view I don't really see it as a cleanly
>> separable module of code -- it's quite tightly integrated
>> with the rest of QEMU, including code in accel/tcg which
>> is variously GPL or LGPL.
> 
> I think this is the best solution.  I've never been convinced that TCG can
> usefully be extracted and reused for something else.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to tcg-next, as I think there's a couple of other things pending.


r~

