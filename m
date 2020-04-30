Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7954DC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444662070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSV9W5Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444662070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEdo-0001CR-6d
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEYj-0003IM-M6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEYi-0001CK-P8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:09:21 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUEYi-00018L-CF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:09:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id s10so2639956plr.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=LgjUQk/EGFtc53ThLQ03ghkSZx4QRIKElwfLRyRylEY=;
 b=qSV9W5TfucKkLa/rrCXEtKqr3jl+TLiBlMgg1yYvnWPV8b5jynCsvqF/szPGW5ym0g
 Eo20OuhJi1h6ByaEy6aru26bKNcwDunLPldrB4EYjwyYvyJnOTnrIyZJKqScVr0QS5br
 cIYpovo5jLrrmcnUyf6OmCsTGh9aSp/1vrngPMOvql/fiTa7unAan7OTqVcR8HWhPMyN
 b/TxxugUsKRaTv7P8kkuzsf0gelsjIs35BTPdL2BRqqAvMBYxE9NWQlHUitnSgQ2pNam
 5HFQo2ZsNeZExnmwpnrsc1WbzAFsiOoELwYyFPe9PbN0fCCHvvaxFWdefoiVVkq1IvxN
 4c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LgjUQk/EGFtc53ThLQ03ghkSZx4QRIKElwfLRyRylEY=;
 b=S4sCRjtvNHkFGg0JxMVY7tUxwvpTrnVsGhAaiRzfkS7BjT+xku/r8ZvfWlKUR3oFMr
 aAiw8iP2zrOeme6ZOCgxtx4lM4zRQW4IdLtcxBIr/lCo+P4nrTtaRIyisZ7f4UfF01PS
 8WdkZOfnOFZ0vl4ff8TCoUgHfEeaKjrqz2RcEiV4PpV4jBxL1oNDITfGwoMMjcPcGHfc
 nubyfBYV2OpJzINZo8WdBV3iUiL526EkvAgMXdnry7VOaJ6kabHJ2jMiiuJlhXltfsO7
 PNdhPR77H+Hk6Q8Sih2IMqPg37IcQHHUKymILduXAKIgZIH6aFkV9Ha9BVnbpgX7U3OY
 MRMA==
X-Gm-Message-State: AGi0PuZMWw1dzYtYhi3MRfAxJnfJV3RhUH1603BES1K+V+Ym9yyzL4QI
 6NvUTHt1nqz2xoaW0z4xHRMKOTZ0mIU=
X-Google-Smtp-Source: APiQypIfH+CMBI5zKQ4f4VqClCdcFk+C4AVdSGD61AbHM4f5hrOvoqsNcHW1dzqHV2b90IEniZS7ig==
X-Received: by 2002:a17:902:59cc:: with SMTP id
 d12mr449901plj.237.1588273758411; 
 Thu, 30 Apr 2020 12:09:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d29sm421946pgm.83.2020.04.30.12.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:09:17 -0700 (PDT)
Subject: Re: [PATCH 11/36] target/arm: Convert Neon load/store multiple
 structures to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a442928e-b986-df54-f787-a9a25682975c@linaro.org>
Date: Thu, 30 Apr 2020 12:09:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon "load/store multiple structures" insns to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 124 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          |  91 +----------------------
>  target/arm/neon-ls.decode       |   7 ++
>  3 files changed, 133 insertions(+), 89 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

