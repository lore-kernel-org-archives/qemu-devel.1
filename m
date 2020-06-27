Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AF4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2C92070A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="JKV2ZtgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2C92070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpIph-0007qs-Ka
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 17:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jpIp4-0007Pb-81
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:57:18 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:36138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jpIp2-00055B-DS
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:57:17 -0400
Received: by mail-qk1-x72e.google.com with SMTP id e11so12147599qkm.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FuqiCQjUYNaoFvrHK7QPL1giLZnmDTR2QiahcdJLY40=;
 b=JKV2ZtgSOJ6+3o5cEJ5b6cTQZVDBP5DVwQTJXMV0FVmCOih064vS1P+TaEFTPu4uCI
 R+84CPII9PyYm3plEDMwx62U4ysg8LcNxdqZS/i1QdgZoilQfb1MbSunBt2rgVdKMEhN
 UuIooCKEjGlMpuPiEh7pLvmXfIPPHgHR0AafByaDzdahRUFCRT++nXc22rHOecG1Vm+Y
 91VooDWU8w4En/PUQZMK/mSSfkFlOJ4DljEpJcyN1yfkK+lKq6n6u5N3KfA5Dhi9w6GD
 W1f9AVnYjZGpCm76CsRzwX5S3cNGU6DY+B3AgF/g011l7yd6EhF67MoXy63tyNPxKexU
 9RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FuqiCQjUYNaoFvrHK7QPL1giLZnmDTR2QiahcdJLY40=;
 b=Dzf2AzKuPsVhvmfu3suVMs6pDTatkC07jUlA+V73pb8j6oYe+ARgwM+d/B7zHqUpUG
 KnXRi24A2LyTS6x1ZK85V6kc4bY4StVrME4bWdNk7Im81N1OMPcm3hBMn8YSSgXF4thA
 BHJVmxGmsqOvVevgaZmIyngnliZ75qobzLRxRYD9r6wuWf405npNx+1zPft1wJdK/M7z
 fnAVsDEAZXKSs78o293HQAFx5Ga+GZYUHXhGbv3Wrg7MwTnQnNQYvW27b6DU4cjGxGlx
 SPEZ18e48jRR1W5oQfjeuweCW+Jw1VA8/ODlAJXNjImT3ZHLHBHKo0AnLWJomRNX+JYc
 zjCg==
X-Gm-Message-State: AOAM5334qFoT3ilB40ePtTHxlD3e5UXBzBv53rdwgcV5foYpBQITPN0Y
 /AT7VfqhkruvfsnYDt+br3f+WA==
X-Google-Smtp-Source: ABdhPJymp+Ah7t+UNVqFeHHDyH+S/83vpKtw8hmaguh5z/XO8eLh/D50LcLwcg/4tQituNQTAaHXGA==
X-Received: by 2002:a05:620a:994:: with SMTP id
 x20mr6676900qkx.367.1593295033607; 
 Sat, 27 Jun 2020 14:57:13 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id k14sm12069788qtm.38.2020.06.27.14.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 14:57:12 -0700 (PDT)
Date: Sat, 27 Jun 2020 17:57:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/2] tests/qht-bench: Adjust rate/threshold computation
Message-ID: <20200627215712.GA46035@sff>
References: <20200626200950.1015121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626200950.1015121-1-richard.henderson@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::72e;
 envelope-from=cota@braap.org; helo=mail-qk1-x72e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 13:09:48 -0700, Richard Henderson wrote:
> Supercedes: <20200620214551.447392-1-richard.henderson@linaro.org>
> 
> Thanks for Emilio's review of v1.  I've split "seed" from "rate"
> as suggested, left the comparisons alone, and expanded the comment
> in do_threshold.

Reviewed-by: Emilio G. Cota <cota@braap.org>

for the series. Thanks a lot!

		E.

