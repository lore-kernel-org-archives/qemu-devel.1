Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF70C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3D02067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URSJiDjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3D02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hLL-00074j-8H
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7h7D-0003EN-4B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:32:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7h7A-0005mZ-3d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:32:02 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so8298515pgf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cj8XLhIGg9ObYWg/BfwNCAVEba7yGVXC7pfU7/cOItg=;
 b=URSJiDjJn/Jr4kxDxSmQdCmAHWSyXLzvoOaGF80G72T07ML9+tyOzBALuW9RSKEWFY
 0T2u2bWKTcoY+IhO7yLwlDI5lxkuDE6TXtT0b9OLe3jlO7D7xl2G9j5zpqDegHLhZ5Iu
 ONzmcWUnC+G9JB4ZZ/MriWXjRqVd1lW3qXsCzFQ4RyfsTiTRvioR7KBrvX5nhf+ieKfr
 Abe6Zsry3kNR6z1Ucd+9+NYiVPsAqC0gaGJcUAV8ojApL3+1dQzV68CtIPnaH4qDQ/hO
 CuDthpt3SWtecKXmXac9eCNVBAcDhLHdxHMOUX/Uv2zPLMvs6fwnyMgBjJklKfwbJyT6
 UoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cj8XLhIGg9ObYWg/BfwNCAVEba7yGVXC7pfU7/cOItg=;
 b=dQKD7VQwTFrgMjamic9HGHs89E4IUcNy4Pztl1UtB2Vlxd8xKR58/OG9yKH+RVGdYM
 HLy1MmbG94rjfn4GXZoLHAaJKfqWWMbABVFr0SEkH7Fp2+w1k9pHxXJkYiEXOTjM1Qx2
 QPu6Xnv6e7/64AzU6uewSttp6oKHeWDYNjkO0FZUFs1X/d4G7zjAA0xUKMVOa/nwiEYr
 3OITEKCXdyaJVHpheSyWhCE39p4qEfmRlxPbKMQSaSF9Z8ThWb3D7Edmf7PZVnuVTW9E
 XfbnJONwVVwxGWDxt7IKPHMBCFJhB/hNzyqUhq3ztc4chcnI6fHPyVrLDhPplbv83uQL
 0Fww==
X-Gm-Message-State: AOAM5333Utn0tk6ntBBqkGRTLoBw//sFKiNfMud51+3lZ7lvi+9bOfG9
 IZCSMOc2tTz+0vPEVDG2SZ3t/g==
X-Google-Smtp-Source: ABdhPJzZA1s35mT1Wjvh6Mf4P5GpyJkEyvSo7FnqOTc4t8KyFnNYrRFh4NgP7hDyOE7nn0S57yFbIQ==
X-Received: by 2002:aa7:9d0e:: with SMTP id k14mr11670659pfp.162.1597678318306; 
 Mon, 17 Aug 2020 08:31:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z5sm20362905pfk.15.2020.08.17.08.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 08:31:57 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] target/microblaze: mbar: Transfer dc->rd to
 mbar_imm
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <71e1514f-96b5-eb59-d306-51d90c00133c@linaro.org>
Date: Mon, 17 Aug 2020 08:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817140144.373403-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 7:01 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Transfer dc->rd to mbar_imm to improve the readability when
> comparing to the specs.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

