Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8473BC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B08B206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5lwGcXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B08B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsVw-0006fv-Hl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsUz-0005fl-3F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:54:09 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsUw-0006FL-8s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:54:08 -0400
Received: by mail-pj1-x1043.google.com with SMTP id k15so1829780pji.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fC0PV6j8015hkE+E7XkRSfLSCaiCAfjaNDXl1ihZU+8=;
 b=R5lwGcXKZSkM23bWPXqTFbI1/3CvG2bsD/DixS3RKhRfQmkgGgt0N93kxRGQFGhkTb
 1MXsxajA6uaa26yTfiS3Fu/qEaPlSeWcKfSASusJhuKHaEwr5J3/Oka0QjUv2GqlQphA
 VU5DXQoXCp/4uNGHjVbUhoL0BAg6J027Na10CgcrNfygzW2EZ5lnG7iBcgLyM8LmFkMf
 8Kh42TN9tdO2gT9dx3Lef+NKaws+SWtGTt8uKSHjwCtGZomNGLkLzsjOlQBAjbhi2AJy
 Wl0SkhYhoIeTmX7Mn0CsifbYFqqjRPr9VKEiSzvZW1TFJchZVBhtTZdnl6fB89THnx0D
 eMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fC0PV6j8015hkE+E7XkRSfLSCaiCAfjaNDXl1ihZU+8=;
 b=Ugad03c4eHm5ezo/KcSei8MfXLywN+trtp4LC+Q92a6CjkAg/bv+tjKfjxFKSIpMZN
 CXWEFF4Y+PZo98gMOHb2SNsdhgp9L5MN80Zu1BR/18M3hceZnJFD266qVpWEoI0AEzUu
 JG6cvm3ul90bOMuCLb98tTGxgO90pM7P9yLhy6XFiONMwGM3e0Z3dOblkv4BQJC8HrDO
 aoCIA/M+tsHs/1/3o0B+q0lNDDpT76lt/v+swBLKC2+B1nS6p2NqktDRppp8HuKkfC4G
 /PytpP9aMoC61ZdrY6XVAvuX2X9NEPtF3eQ4qzeurur0CUAgk8/CdrYlIrviUbCdITEF
 YuTA==
X-Gm-Message-State: AOAM532WkbB5lvdGSrsL3O+sgU6TqIY0pjUL+p5SnFwPiPWxwE/eKlVu
 QeBakX4bQVgCXZiGLgfcTfJZyg==
X-Google-Smtp-Source: ABdhPJzMvAp7ZrA006Nor+dGPbF8JB0SkysJ8fg5kPyLvxMgL0WG6/O4kalzNAbNc8kO7efeyDDg+Q==
X-Received: by 2002:a17:90b:183:: with SMTP id t3mr3927946pjs.21.1599152045042; 
 Thu, 03 Sep 2020 09:54:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j19sm1173616pfe.202.2020.09.03.09.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:54:04 -0700 (PDT)
Subject: Re: [PATCH v6 6/8] util: introduce qemu_open and qemu_create with
 error reporting
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-7-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b3f7dfb-f5fc-9815-08e6-b7de0f2b107e@linaro.org>
Date: Thu, 3 Sep 2020 09:54:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-7-berrange@redhat.com>
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
> qemu_open_old() works like open(): set errno and return -1 on failure.
> It has even more failure modes, though.  Reporting the error clearly
> to users is basically impossible for many of them.
> 
> Our standard cure for "errno is too coarse" is the Error object.
> Introduce two new helper methods:
> 
>   int qemu_open(const char *name, int flags, Error **errp);
>   int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
> 
> Note that with this design we no longer require or even accept the
> O_CREAT flag. Avoiding overloading the two distinct operations
> means we can avoid variable arguments which would prevent 'errp' from
> being the last argument. It also gives us a guarantee that the 'mode' is
> given when creating files, avoiding a latent security bug.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


