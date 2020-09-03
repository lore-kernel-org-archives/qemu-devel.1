Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18792C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE454206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+fbs97r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE454206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsT3-0002er-04
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsSJ-0001MO-Ep
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:51:23 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsSH-0005wV-T7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:51:23 -0400
Received: by mail-pj1-x1043.google.com with SMTP id gf14so1743841pjb.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e1stpSr8uqmLURqWYE/DF88zia9kJJTSzN5BZzY9IdU=;
 b=u+fbs97r8QGmUo2xwEZmfg51FETVmJE/kUPsICPBm8rWy0apeh816Ox5U98fF11rHG
 63j/UVcMEbqD78a/UFJitqFC7WL/5KJ4gSWyFQglNnPEIP5Jiq+JQBJOdD+3R5ekx63t
 ZBLDSLUix31hWq8TOis5J6ZiHxUb0OONJQwHMEdzvfLZhQetzmFSMqoZ/qUouha3r7Sh
 oEL9kTHJBmh8esOqDcrossMkCP+CCD+KlSbrZj7olLyZPC/9pATitHiSieiiRHELR618
 KmBPkqFo7oF8Yxfl4IIJD3gn4zzBiK8wU1vOTY0HtTIhGEnonTllq3zUtKxItRWDCB+7
 eTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e1stpSr8uqmLURqWYE/DF88zia9kJJTSzN5BZzY9IdU=;
 b=pavYk1vcH88w9d4VTwksF25qA4+dsMQAVqkpsvJQPWG6shmgmFtlZKjpxwJXS86hkb
 NszRdXIqz8hpnuLmgodJsMwblpVTOnWdJGMrkxL27PaVOFLDaogiuWARJ3HHDd/w4LkA
 7Wx2hftFi7pdAyzpIKnpHbrlt6Hx59hEKn0BY4EBcK8Wq1otIms+4mdYkow15Fgnka9m
 HB1tOCYz3uz/JX7EyJCD1f3d9VrjoCUbBdt3yLUAYCSWMjDR2JEQtNl6GdwoQPZnBzgS
 0CU86f6KBEmxEdLvvXcTGJn0eoSJH8utpZDS4fbIXh9TICrsazmDezRXNmYw1Lev+Jar
 +AfQ==
X-Gm-Message-State: AOAM531wQmb2UyrcTdBlkKfjqljzpa4benNElBD7u1idLXNkxLgHVdJR
 TR6vT7WHKm9UmrkciPK8xRJKLQ==
X-Google-Smtp-Source: ABdhPJzot2Q6vm6PSSjraimiSxIEKmUj3HK2em2nH2GUtGygxQWiRXO71cv8gWMwvIM2iYplzqAfDQ==
X-Received: by 2002:a17:90a:6e45:: with SMTP id
 s5mr4024604pjm.12.1599151880584; 
 Thu, 03 Sep 2020 09:51:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 14sm2684402pfv.42.2020.09.03.09.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:51:19 -0700 (PDT)
Subject: Re: [PATCH v6 2/8] util: split off a helper for dealing with
 O_CLOEXEC flag
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-3-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5100a9d-e917-e40a-046c-59b92555c2c7@linaro.org>
Date: Thu, 3 Sep 2020 09:51:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> We're going to have multiple callers to open() from qemu_open()
> soon. Readability would thus benefit from having a helper for
> dealing with O_CLOEXEC.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/osdep.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


