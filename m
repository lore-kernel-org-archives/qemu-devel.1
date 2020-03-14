Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0841CC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 04:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B871A2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 04:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftTbDTyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B871A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCyQE-0000Xk-PW
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 00:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCyPO-0008Qv-3d
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 00:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCyPM-0006fE-Ng
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 00:28:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCyPM-0006el-Gk
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 00:28:20 -0400
Received: by mail-pj1-x1041.google.com with SMTP id f15so5175256pjq.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v3irUYJB8xzUOoxpLWF+E08cxO2jUpY38vqkPcXTIM0=;
 b=ftTbDTyKAl1YcxNiDTidYRpyN6OHpSO2R/amGwE4sgEOzph+fSpZGjTMPZtRO6ayBm
 JHwJam6qz1qZ7urqrmpt4YUzK06o+scCDdNqFXIZtDhgilsv6H0tjvOnNiOhmKapKPPd
 zpl/UpRsKTbQQAhiuva2N+5ywWUIbHh++sLHOGw/nphg50I9RrQ0WbYwsyDN21Mjg9U2
 vjWwV3yvs4+lrXgsaywAZSxWXM/mS0twcqDw3AS4ltsWN+pn4GBxEuFNlBbeRxgceztl
 MmG6VxETLXYl09ilC5R8juh4RJcv1IPYKXTsU4/plRknVWf1LQFZHcKa1c9L0Ds0RQWd
 FwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v3irUYJB8xzUOoxpLWF+E08cxO2jUpY38vqkPcXTIM0=;
 b=Y9ZZW4Mei7WO3oFH8AhJ+qEPGAo5//GSi3/DC5UeeLKRmOSBmQW3b91uoB18H18E4/
 VE712xCtI3Y4hWzWIgI/iEwLvvHgU+cRYBmuGO7m3zTHMLxkQDdVL8dLp6Qk6J+XxUFg
 Hb5n1jwx/NGx+AkIlqgWu2VDOeFH2IBQhh5r5pixy042O8CnGGB42CKbPRb0G7aLdcN0
 5TumBklQAbO9z7DSlRHKzu2TpFm2dJvvV3TSFRs27CoRazNkmPsAWChE+8DexjbOwD56
 5Gq1UUisMXFkyxQZIbfGhwc+4tDVupsOGEhGD7AeYaIqTv/dXNauWwaVL9juVXi8C9BF
 hvlg==
X-Gm-Message-State: ANhLgQ2OZTzUANn76XkgTl1DsLK0BWJn6fWJhMkr6nvb9ceAsXZnFzBc
 +5l6PZj8NlFtxnPRPzMJukTujQ==
X-Google-Smtp-Source: ADFU+vtNzoSmiBTYHVlq3MYjaH/AxmfGWmDj7ULyxfN+8TUfvHT/ydtRZO8bIlBG2R/m8oxAfytfpg==
X-Received: by 2002:a17:90a:33d1:: with SMTP id
 n75mr13031213pjb.167.1584160099141; 
 Fri, 13 Mar 2020 21:28:19 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o129sm6644124pfb.61.2020.03.13.21.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 21:28:18 -0700 (PDT)
Subject: Re: [PATCH v5 08/60] target/riscv: add vector amo operations
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-9-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca349778-4672-6887-15c5-a825702023d9@linaro.org>
Date: Fri, 13 Mar 2020 21:28:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-9-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +    static gen_helper_amo *const fnsw[9] = {
...
> +    static gen_helper_amo *const fnsd[18] = {
...
> +        fn = fnsw[seq];
> +#ifdef TARGET_RISCV64
> +        if (s->sew == 3) {
> +            fn = fnsd[seq];
> +        }
> +#endif

This indexing is wrong, since for seq == 11 you index past the end of fnsw[].

You need something like

    if (s->sew == 3) {
#ifdef TARGET_RISCV64
        fn = fnsd[seq];
#else
        /* Check done in amo_check(). */
        g_assert_not_reached();
#endif
    } else {
        fn = fnsw[seq];
    }

Otherwise it looks ok.


r~

