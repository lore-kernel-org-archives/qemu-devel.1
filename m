Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1266B206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtPHeEk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1266B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsSt-0002Hx-U3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsS3-00017W-Ly
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:51:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsS1-0005t6-2p
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:51:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so2586167pgm.11
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BC+YGBYZcukSjZ/kDM4YJcsjMLK2h2QJt5f600Xd7Zc=;
 b=RtPHeEk/UyPMQ6tio920kD863FGuIlHVkiZS5A3xoVYO1FEY5SL7xkAy7lycLmDb2d
 0UfNSrJvNcAt2VHsJ1xSnhCnFCplQ1Kybcukxb3kKZqhbiQL6o6+TffisrxDpHi2spU0
 Cvl/1sFHHk5UrYPa9IYrI3hqoVHJrzER4+ReTURqmlCxrRFU1IrjkpIKlGi1DDCGmVdP
 4RN3VoWPXc9k5LkbCIwI6V4L1mLvWW8ZcoO7QzaREJHPj1EdvdkBtAmxR4Mj11Ou7Y3n
 H4YSCchXW9sSesEa+VdTz2RSpaFy+llbjcBC6vU5LD2nAL9vvPcGZUON2Xd/Jyj7sS1d
 Z+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BC+YGBYZcukSjZ/kDM4YJcsjMLK2h2QJt5f600Xd7Zc=;
 b=UkxvQwbb5kVNu7wBT59YG8aVPK77kr/Oq/muKNPwfXBzI7PEo2E+fRN2Kw5aFAAqZS
 w/qVDE0aYWuLbSBgS3cP/bh9cYkL4fHZc3Nk2yGqezeYig5Cdg8l8imvHgH8yX2sG0Tf
 EdAk+I1kAuPLgfjDCBSQTKSK9IAoYKmvm26Xy54OQyiYfvd10JEfNB17zPmIhfTrv/t6
 MV8hZHXfTFkjRp5cbPkIbzncq8BvFGVpE0bFGCl7aISOoJYW97myxzDEJVAQGx0Q8Wbh
 e7XoGuZt1+CW4Chdy9tPDLFHtvX6Z0YW8owxq+qz/8hPBy8anKDDKzNF4Xx17RRhAahu
 xlTQ==
X-Gm-Message-State: AOAM533QmOcxqi0Jm0UBDA8oNDRwkjfNi7OnWfs+9d38nOHuwlbdNffy
 kM0lp7ZeES0XLuawYt0PGeKWvw==
X-Google-Smtp-Source: ABdhPJxQ8smJp6kJgDLC2wUKBGN53tmFDVmW0fcGJxqc7pX5DqsxKki7WQ6MCKPN3JgxrSMilfjRyg==
X-Received: by 2002:a63:62c7:: with SMTP id w190mr3775779pgb.25.1599151863608; 
 Thu, 03 Sep 2020 09:51:03 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d8sm3174570pgt.19.2020.09.03.09.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:51:02 -0700 (PDT)
Subject: Re: [PATCH v6 1/8] monitor: simplify functions for getting a dup'd
 fdset entry
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <730b8930-3462-291d-08b5-6de058ee38c6@linaro.org>
Date: Thu, 3 Sep 2020 09:51:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> Currently code has to call monitor_fdset_get_fd, then dup
> the return fd, and then add the duplicate FD back into the
> fdset. This dance is overly verbose for the caller and
> introduces extra failure modes which can be avoided by
> folding all the logic into monitor_fdset_dup_fd_add and
> removing monitor_fdset_get_fd entirely.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/monitor/monitor.h |  3 +-
>  include/qemu/osdep.h      |  1 +
>  monitor/misc.c            | 58 +++++++++++++++++----------------------
>  stubs/fdset.c             |  8 ++----
>  util/osdep.c              | 19 ++-----------
>  5 files changed, 32 insertions(+), 57 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

