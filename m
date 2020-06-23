Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04522064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJDs9j1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04522064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpLO-0001iQ-8o
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnpBh-0005YP-Sm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:06:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnpBf-0007Sm-Cv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:06:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh7so9568337plb.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MgiVyPKQiE159i/baoZD/+r9z0mORJeLztQ05s8WYIU=;
 b=wJDs9j1/RP8++qikZxGbFYK6J8KsbngoIKfEXn9wCsh/U1eeQZzRBLHOHsHjDTKB5d
 Ne6H7bcnthLAvtJyVxnDxbRzhHNOkbVOAuI4jQpPwA6JKYJwHnyqZmvypI7Wugr0dNVF
 QLC4iz5fxpBzWcUR8t8Y6tXo95N9WV+afZnPuKJpKPcEGgyWg8HeFfMw8g7Pg5M9s+oJ
 YuGmXi8C5PH7kj4tnVuReUsssmx5LGKD1/OGAQLJOHKrfFX/snigHYbbxWdsDfE/5wkw
 BxW2Sq2sixYmaI0UbxrEUjIdM0w5MuhaD9FFvEL8fIYq3ggu1qjs20kmnwOIXzp6BAMd
 nSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MgiVyPKQiE159i/baoZD/+r9z0mORJeLztQ05s8WYIU=;
 b=KTCFOeZONP7fESKXj3hUW+5GdIa+Fa3zzs0pYUp4YQQyQW5pLn2rZf+kDKDFu8EYP0
 VLapwHm3OinpSQZ4kCvNML6BXZxQ4sM1iPm2uV4KHzJRAP+R/D772q5I8Bbd++wijF+/
 4xh2Bm+aiQYNbDn8B1KCdfTYU9SmCicpLMNV5VpnDcJY0T2AzihBwxN0FH7uRmE1xnX+
 bdNh2s3BEA7OoYzMAfRxGVmhGzxBVVfwsb/HlN7l5fKKF6g2B1C9RKIjCAEAUkD/0qwP
 m68OIUlMqXWVhfm0MD9RxBnqbZrJ221LI64OZ/gPNSMuBBKOM3VfGqs8fHFNdnNEHg6I
 yJ4g==
X-Gm-Message-State: AOAM531XOybi6D9OCkbm0+zx1THgJu0ocH3ZJNwEugHke2CwkCpmixEr
 3GCChtb+NdRf8uhDL0hSEWrgSA==
X-Google-Smtp-Source: ABdhPJwZxLL/9FZzJkoA9kYcFw0WYa0vQ7LwXIDF8TOjS5fNPj0yItxUceEt1fqgxXGa82AFsSh0vw==
X-Received: by 2002:a17:902:db83:: with SMTP id
 m3mr1666694pld.176.1592942789685; 
 Tue, 23 Jun 2020 13:06:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q13sm18418489pfk.8.2020.06.23.13.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 13:06:29 -0700 (PDT)
Subject: Re: [PATCH v8 00/45] target/arm: Implement ARMv8.5-MemTag, system mode
To: Derrick McKee <derrick.mckee@gmail.com>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <CAJoBWHy9HfD_hBbJNgG5vsM5Wt_kiYYJyYAnxfTNzq2nuohk+w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e54ff84-8355-00c3-bdfb-f05577432a93@linaro.org>
Date: Tue, 23 Jun 2020 13:06:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJoBWHy9HfD_hBbJNgG5vsM5Wt_kiYYJyYAnxfTNzq2nuohk+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, steplong@quicinc.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, david.spickett@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 12:55 PM, Derrick McKee wrote:
> Hi Richard,
> 
> I am currently doing research with MTE, and Arm's FVP leaves a lot to
> be desired.  Is there some way I can get access to your QEMU changes
> that enable MTE for system emulation?  Thanks.

You can apply this patch set to qemu master.  ;-)

But more seriously, this patch set is in the tree at
https://github.com/rth7680/qemu/tree/tgt-arm-mte


r~

> 
> On Tue, Jun 23, 2020 at 3:37 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Version 8 incorporates quite a bit of review (thanks, PMM):
>>
>>  * Include HCR_DCT in the HCR_EL2 update.
>>  * Use a separate decode function for ADDG/SUBG.
>>  * Use the system arm_cpu_do_unaligned_access for user-only as well.
>>  * Fix alignment for LDG.
>>  * Fix no-fault for mte_probe1.
>>  * Rearrage how tagged pages are recorded.
>>
>> and perhaps most visibly, for those tracking the kernel patches:
>>
>>  * Add arm,armv8.5-memtag to the dtb.

