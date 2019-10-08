Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C4D206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R56VnknM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C4D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHokl-0004KS-SZ
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHoii-0002iP-Ol
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHoih-0005eF-0z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:36:04 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHoig-0005du-Ri
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:36:02 -0400
Received: by mail-yb1-xb41.google.com with SMTP id t1so3945621ybo.11
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XmmXK31FZSSle7mZ2WbSlbHX7vG+J16I2N08bvPWmp4=;
 b=R56VnknMpSIK4TXQ+6uGmZZFupX9vSv8gIrVztxJxlGl7dDmozmfICkMx5ZnOIpWAx
 7va2FUppGmuTUR0EX3reQgQvWFM1N9AFHlRY6BWKneAGPLk7EUvcB0zTxJw12mFkErIp
 sRPZ7gFXUJEFG4uc/rCNHvyAMKkqe7YSoYzV+qYlaIvI3o94nQpr4PBvgQvBn2oE+gFp
 TY3ua7Af7sx/CYLpNdwUkKZOOsaptUMsKrwYj2xCDVjjhOK77DDnqH+Gwfk+bgGs193d
 27vhvhIZWTRT/zQB0cFgnWAMvyrXquQMIEJXcPnrkAju5/p9Vr7oDWpr8hZiPWUyRomW
 4mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XmmXK31FZSSle7mZ2WbSlbHX7vG+J16I2N08bvPWmp4=;
 b=mBXiMtyItiwwtOHEXOZueWOemCM+TeEVmRqmY1nsy03JBvDo4rE0sY+VCZspkGPnNj
 u4VgVkgS1nKFgd7nM+d/4rcxPosm3FoWQmQa6qxEpQDX8FosGGgkxNUNgg34PusjvyaV
 rbny7aKaoDl275g5SlOk2SmHEN5gswIiNFL/GMRs3jzHsJgkNF/iwc6zxALLc9DMoeIs
 mTQU0zNZI4bOSAhyRQ8FYBX9x2FGvHxeFyBmDZfzXy6vZI7X7ZCNpzdTHw4iD5PaqwOC
 Ajl6vmTZHWEBpgDwFMrnxuKU30edshX1wuVP9l2kF3JqaJwTYsa+8LYmlPAxayZboyxF
 kIYA==
X-Gm-Message-State: APjAAAVwh8T/4eETkyuntr1cYQ4nlCF+ID8zOeuicDravcg8r8C0HBRM
 B6sGFa2dFUo+RMsGmcOtT7uN1Q==
X-Google-Smtp-Source: APXvYqxVWvmnPDR/N0bn/OZ+cAvM9OCIbj5gxhfyiAV0Kxyg7sSpYQkmkZRe8QI3o+707ntZWzebTA==
X-Received: by 2002:a25:3383:: with SMTP id
 z125mr12381809ybz.210.1570538161771; 
 Tue, 08 Oct 2019 05:36:01 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id x16sm5086457ywx.103.2019.10.08.05.36.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 05:36:01 -0700 (PDT)
Subject: Re: [PATCH v9 01/13] accel/tcg: introduce TBStatistics structure
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ca3b67ec-8cf7-26f3-5cfe-7a330e11571e@linaro.org>
Date: Tue, 8 Oct 2019 08:35:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> To store statistics for each TB, we created a TBStatistics structure
> which is linked with the TBs. TBStatistics can stay alive after
> tb_flush and be relinked to a regenerated TB. So the statistics can
> be accumulated even through flushes.
> 
> The goal is to have all present and future qemu/tcg statistics and
> meta-data stored in this new structure.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-2-vandersonmr2@gmail.com>
> [AJB: fix git author, review comments]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> AJB
>   - move tcg_collect_tb_stats inside tb-stats.c
>   - add spdx header
>   - drop tb from tbstats and associated functions
> ---

The only quibble I have is with

> +void init_tb_stats_htable_if_not(void);

If not what?

I can only imagine that this phrase is intended to finish "if not initialized".
 But I think it's clearer to just call this "init_tb_stats_htable".

> +void enable_collect_tb_stats(void)
> +{
> +    init_tb_stats_htable_if_not();

Why do we need to do this again, since we did this in tb_htable_init?


r~

