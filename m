Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22059C3402A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ECA222D9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2X07HQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ECA222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lST-0007Io-V6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lRS-0006f1-HN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lRR-0003Tz-EF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:48:26 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lRR-0003Tm-8N
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:48:25 -0500
Received: by mail-pg1-x544.google.com with SMTP id j4so9673265pgi.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LiCijNbzuC8RSIE0Pupj5y6DhyoVJYGiC6hfznvkmhk=;
 b=z2X07HQJTuJ07gzmhYfVAjW5d+C1Wl5Wndgexb6Bbs37hlBooGkf3Jxx1Uop3qaS+a
 M1ThxuD+zbQ0mkewHMymy9+yeUdS4WwxE2GMgxLyUHKFZJk2ckifq5ntuof8A2wNfb1w
 7yXMm/j2lRAX5bbxRgDUq0+HjiepukSfmg72XZPJrNqUFRpG7zQ/GeBtQU+WcMIu8Gd3
 5xu8ZoERQjxMqwqUtr1PXGoKjl9e1KrkjxRVFaGnEOOLfMzJjK9kIAmBdJRNHrVw0i4E
 p58AWfdthTww6IbSPCfoPpgv7Ro5RuY7zE/0TA/fev6IT0sebb+LfRSAovMnKA0fVzzP
 N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LiCijNbzuC8RSIE0Pupj5y6DhyoVJYGiC6hfznvkmhk=;
 b=rYQEUPVJVDlj6R06eiCqrPfIVc1gkQz41LwKFUt8HboEonh/5noMqqTaINkpwdeidd
 RE9EAHIXd0HcksSGKq6tVuqY3vsXf5CCEV/dRyMwV6C5QfddqVrf7+73Zm3YJXDIBIA7
 f8PkgHH+fTO3dhHkdUEp6Uo9tpzgs5i5qGlSotTKpQgskXENnFmq0LBJg2MbD8U4W4CG
 fTJaAYo8O/1soLiRBPg8mIoPYKDc3xp0aF9EbuzgblHXgcfz5bBrd7tYRQHhR7vAu7kq
 eyxSCZ6oCxk0i8US7xf6YVWayFJ4ctqkredNwtBp3uLgy+C1kfJiTWnImkf4cP2d3r5Y
 rVHA==
X-Gm-Message-State: APjAAAUr2x6DfhFSqFHpc/HLjLNBSx7B+N7IGqTiXiPm8egJA/LFpWbi
 3apaL0r4P6OLv5amC3wVXMjL6Q==
X-Google-Smtp-Source: APXvYqx/PAG4FQ4kYd6R1e3ccMk8QiQq4opx7K2IGdxNygRUlAjbCLWNPoTp/1rvixHACyf828kPDw==
X-Received: by 2002:aa7:968c:: with SMTP id f12mr17720037pfk.235.1581965304287; 
 Mon, 17 Feb 2020 10:48:24 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s18sm1715449pgn.34.2020.02.17.10.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:48:23 -0800 (PST)
Subject: Re: [PATCH v5 09/79] arm/aspeed: actually check RAM size
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-10-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <afa585fb-3e4f-599f-12d6-731236f267f8@linaro.org>
Date: Mon, 17 Feb 2020 10:48:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-10-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> It's supposed that SOC will check if "-m" provided
> RAM size is valid by setting "ram-size" property and
> then board would read back valid (possibly corrected
> value) to map RAM MemoryReging with valid size.
> It isn't doing so, since check is called only
> indirectly from
>   aspeed_sdmc_reset()->asc->compute_conf()
> or much later when guest writes to configuration
> register.
> 
> So depending on "-m" value QEMU end-ups with a warning
> and an invalid MemoryRegion size allocated and mapped.
> (examples:
>  -M ast2500-evb -m 1M
>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
>       0000000080000000-00000000800fffff (prio 0, ram): ram
>       0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
>  -M ast2500-evb -m 3G
>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
>       0000000080000000-000000013fffffff (prio 0, ram): ram
>       [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0, i/o): max_ram
> )
> On top of that sdmc falls back and reports to guest
> "default" size, it thinks machine should have.
> 
> This patch makes ram-size check actually work and
> changes behavior from a warning later on during
> machine reset to error_fatal at the moment SOC.ram-size
> is set so user will have to fix RAM size on CLI
> to start machine.
> 
> It also gets out of the way mutable ram-size logic,
> so we could consolidate RAM allocation logic around
> pre-allocated hostmem backend (supplied by user or
> auto created by generic machine code depending on
> supplied -m/mem-path/mem-prealloc options.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> v3:
>   * replace
>      [PATCH v2 07/86] arm:aspeed: convert valid RAM sizes to data
>      [PATCH v2 08/86] arm:aspeed: actually check RAM size
>     with a simplified variant that adds ram_size check to sdmc.ram-size
>     property
>   * use g_assert_not_reached() in default branch
>     (Cédric Le Goater <clg@kaod.org>)
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

