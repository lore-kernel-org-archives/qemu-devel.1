Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078CB208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTMuBhHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078CB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEr5-0003MM-0L
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEZ8-0002Yh-IY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:16:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEZ4-0003Kl-LV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:16:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id 67so2294216pgd.12
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Jlwzo35vvjMnhBg5jjD5gQJxj45DXQ1gaS0XT6337gM=;
 b=sTMuBhHvrAkNcVTHM7KdG6R+l36+10Ax8gUpCKITkLxnmlXlHS+2Od6RbXTKpGsAGb
 nRLlw5ky4VyCYUxHy7VQIDEbaHBA3BYfsuLUosdG6cWKxBUqKIjTX0E7HAcA3K3BYFAE
 6EotDXWr5MR6v33SCwMQ2isYj61/IfUrqCu0/P1KC9uamV6tpukosdFJkyyC0qUksv9u
 OR3Ny/Ukpd7P0ySC8IM9MIwqIgOWu8CEigjExVzmg6b60UXSt+W4NZ3p5Ik0kdYj7rpO
 zzFQlDRadneip0SNzF61zs8q6Hz9hbJRpPEOxNwI0bC00lkQsn5RQGe60FNV1kl4ajKL
 5Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jlwzo35vvjMnhBg5jjD5gQJxj45DXQ1gaS0XT6337gM=;
 b=dWEVi9GmQYUjq9kWXQTq99Sv4XAqDkpxs10L07RBHS0pqqAGT8wqbPv2enrzn3j2o3
 clPBH5BNBtA8e7vbeEYPmeU1jco55Xip+pPe5DBD0xRAqFIQrkRi3jbwNZD/K1UR3t5K
 0K/EvnmUzz6xWybQz+psJyydZTWrGgxWvkM3pobgfhvlgIBN7SlZmxcDkadykBnEO+RX
 uaIKE+befPr8OdD9c4anBOPAzoCHdUhg2BQuS3p11eRs3LwpdU5anO8nhlL+mmbWpg8t
 x9ktvN5c+HjI78bZw3oRqIs06ad7EaiN9KEsgtK+nXiyeN0ztbr0OB1yFL7TPKwVFImc
 3D5Q==
X-Gm-Message-State: AOAM531kLKsfXSHyvvv0qaklzDM+GEfRpPIWWvc/l2nSvuIHqud3qcBh
 2Q3SeAZfAgudAJ7RXDq6wAsIPhQGpE05vA==
X-Google-Smtp-Source: ABdhPJw9VU/Z52pasnTR+oVQYxBDzh9F7bsfIZcZFwA2nS4SGumMqGbphcCI+X6hIG1oAJqpNCaPVw==
X-Received: by 2002:a63:b20d:: with SMTP id x13mr12968049pge.136.1600190180715; 
 Tue, 15 Sep 2020 10:16:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y202sm14763700pfc.179.2020.09.15.10.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:16:20 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] configure: also skip deprecated targets with
 target-list-exclude
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b0148d6-511f-d5f7-6291-abebf1cfb06e@linaro.org>
Date: Tue, 15 Sep 2020 10:16:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 6:43 AM, Alex Bennée wrote:
> Now the user has to make an even more deliberate decision to
> enable a deprecated target rather than getting it as a side effect of
> using --target-exclude-list.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


