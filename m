Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F50ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E041A218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3MjuNlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E041A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIETw-0005rD-MF
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tQ-0001hy-NR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1JF-0000NW-IA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:02:38 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:33982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1JF-0000NN-CG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:02:37 -0400
Received: by mail-yb1-xb41.google.com with SMTP id m1so225765ybm.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 19:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QpMRAGzqyaKVSZ/WsucxIHXQWGc+xR6gtPuc7Rlbolg=;
 b=L3MjuNlgOJOkQVn3AvLDwrMN39qiriqpRbt8s11ROImBWeBQ5CtnUTQ/2n/zvd4dNt
 MvOZYyMDhq677B1uy8r6Ka2BXGQZzgjW0sEQ76dJ9WMMp9qypsaFKVT/F8zwsLoMGWlm
 6Znz7Nu+kD+828cR6ki1LO03stwF3Lbz6vbifoCaxpwmmgIHdH1/AXtY3xUOxn8w5kBg
 lkRDchbm9BFrQH+XW7MMnMK+LTYklQu1xh9N0i4vLxM0pZdWFfStaw/W2q66X+FqeLay
 5FX/UI1qEfRl+qaTJ/Z8LBGEMpRzseakelCvr7m6DsDWFtS7dohUWS/DXDPY1YPhGudJ
 4/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QpMRAGzqyaKVSZ/WsucxIHXQWGc+xR6gtPuc7Rlbolg=;
 b=dFwvvTrm3vAmnZrHmPysiEyIaUQQuhFq8i9xm7OlD53CuYugv/4YurKTH/au4c/VQ+
 UXb4qmmzqEq4ux870ThtuS273ht9nXs+yqZpd648WPNrvtF3n7H5EHQiN+agG0BhzmSm
 a3JcE1+AiMsagYJggM3rYJS1uamzMtL9q2Ad5Ubc7eR3CMLD8LlhJRRmeaNDs1YPX/Jb
 Jfll4mlhru+tx2loreSN/GCEV98gym9iRyBHWvJOwFZNO1n3G+YgefyJF8h4CikVaTd7
 usaZxWNOch1foHjdlSF8VwC2HMsSSGjEZHbWn82R6xKAUunloa1dS6Aujf6ayFDoMK5/
 djmQ==
X-Gm-Message-State: APjAAAUDHnz057NsYrF3COLunMHPneIVyVLuuLZnVQvmGL1YhN8BIY71
 XUWdFCTBlplTbgFu+ahJZp3GJw==
X-Google-Smtp-Source: APXvYqxbHIA+rTBgzfZwJk9dzEbz73E9ouPc1Q1Xlk3oZsXHK9NlIJm5AngJNVLOWJRwlszqIiXK3Q==
X-Received: by 2002:a25:9947:: with SMTP id n7mr479699ybo.263.1570586556693;
 Tue, 08 Oct 2019 19:02:36 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id b73sm227571ywe.35.2019.10.08.19.02.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 19:02:36 -0700 (PDT)
Subject: Re: [PATCH v2 16/21] hw/timer/exynos4210_rtc.c: Switch main ptimer to
 transaction-based API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ffd005c7-62b1-b2b1-fcac-a157afff7533@linaro.org>
Date: Tue, 8 Oct 2019 22:02:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the exynos41210_rtc main ptimer over to the transaction-based
> API, completing the transition for this device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/exynos4210_rtc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

