Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C15C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC69120855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMvS/5er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC69120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlAX-0005sW-I4
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXl8l-00059T-3j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXl8j-0005UU-MH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:00:50 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:43444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXl8j-0005U5-Bk
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:00:49 -0500
Received: by mail-il1-x142.google.com with SMTP id r9so2968047ilq.10
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1ZSVUygWqqvpgPVhgmoisGrNwXh6NiUNOAv/hgDFlws=;
 b=WMvS/5erZw/LIJpzjJZOWcQLVYTSOLBdJ434G0zO/hNV//y6dPbfBJd69XjdwzarKR
 T6iKQ8It9hGBlmiS3mPu8vOGXnfq62mKLYbf5WQ3Vl202PnYeuma8ArNEnaGIYRS+55A
 LMy+KSNIITh6C2yNwn8pFgkk9whH324txyPYTPM5zwMF1wmh6gTO10XrWY2dbBNuYh1S
 ite6nabo8bZtrnYtJx4LZ4hdDdtZDlPHxbbozJr18v4xOAy18+qu5tCiCNdncIPyFeeg
 PxbwacB2JQimMgWVF6FC4sKpIvzJpJh9B1q6j9vMEy0FmeYd+8NUsFBrqyfwxw2WITf3
 Ln/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ZSVUygWqqvpgPVhgmoisGrNwXh6NiUNOAv/hgDFlws=;
 b=jnA5XDWZhZhMPxW5pqFcbW18sxTIjct3Cl/wqHdVE5K0fl2fCft9izop7HhQmRf59+
 4FRT0rEj0eqZPjlWQgCR7ZTVjReyKNN/wHEJ0rJ98WkP6fbaXskrJ5aH10IiVD8jeITa
 hfYM4cL7X6b8QQKSLytCXvK8kxdHRDfQNfcW/4zVqqL9nlUrUZgaBTTZicMJZKGi+DNt
 0vGAA7mCUC2E7De/b4oFDSf4H+Nk17Bsjq6uvhG7fmsx9/NS7W7JLHqtgjxAq/rZDvYQ
 Z3Bk+y2CCo89YJ/wGaKa66Y/QZK+L24TCDZOqqVsIzoWH3ehT5tev+OuM3M9t+pY3lXP
 37Xw==
X-Gm-Message-State: APjAAAVOq3fyAO8HOPJ00o0fTJbsAkQ85aB+yKqlNy9ccCpZnzyxhjKe
 SPEsDOcgYdbPKkbu+35nYQHGuw==
X-Google-Smtp-Source: APXvYqwNPHYFAgo37ak5GwH9s5LjBQOpAHoP/X1P0NkSfMRxyF5pObs7X2rrIeOe7iFy7Kd3cVPykA==
X-Received: by 2002:a92:1d51:: with SMTP id d78mr10050371ild.166.1574337648267; 
 Thu, 21 Nov 2019 04:00:48 -0800 (PST)
Received: from [192.168.44.35] ([172.58.139.152])
 by smtp.gmail.com with ESMTPSA id q7sm1024353ild.81.2019.11.21.04.00.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 04:00:47 -0800 (PST)
Subject: Re: [PATCH v2] exynos4210_gic: Suppress gcc9 format-truncation
 warnings
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
References: <20191121013859.287372-1-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f0190fa3-ac79-e936-6a71-4f6d8df98689@linaro.org>
Date: Thu, 21 Nov 2019 13:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121013859.287372-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 2:38 AM, David Gibson wrote:
> exynos4210_gic_realize() prints the number of cpus into some temporary
> buffers, but it only allows 3 bytes space for it.  That's plenty:
> existing machines will only ever set this value to EXYNOS4210_NCPUS
> (2).  But the compiler can't always figure that out, so some[*] gcc9
> versions emit -Wformat-truncation warnings.
> 
> We can fix that by hinting the constraint to the compiler with a
> suitably placed assert().
> 
> [*] The bizarre thing here, is that I've long gotten these warnings
>     compiling in a 32-bit x86 container as host - Fedora 30 with
>     gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal
>     x86_64 host - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Changes since v1:
>  * Used an assert to hint the compiler, instead of increasing the
>    buffer size.
> 
> ---
>  hw/intc/exynos4210_gic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index a1b699b6ba..ed4d8482e3 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -314,6 +314,14 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>              EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
>  
>      for (i = 0; i < s->num_cpu; i++) {
> +        /*
> +         * This clues in gcc that our on-stack buffers do, in fact
> +         * have enough room for the cpu numbers.  gcc 9.2.1 on 32-bit
> +         * x86 doesn't figure this out, otherwise and gives spurious
> +         * warnings.
> +         */
> +        assert(i <= EXYNOS4210_NCPUS);

You should be able to do

    n = s->num_cpu;
    assert(n <= EXYNOS4210_NCPUS);

    for (i = 0; i < n; i++) {

What's happening here is that the compiler thinks that s->num_cpu may be
modified by the loop, and that's why an assert on s->num_cpu doesn't help.


r~

