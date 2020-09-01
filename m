Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94F8206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iu5Vbar7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94F8206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAQw-0003Vd-VS
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAPu-0002aZ-3J
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:49:58 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAPr-0002UY-FR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:49:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id p37so1075267pgl.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8ifEANnOFnkWKd9qry6HkZCR/efNySP3CF8YCipTVYs=;
 b=Iu5Vbar7JGqjeN+ISEcpd0k4XXR/9X4mQKjrltOjAOeP8BcdErvVqocvTg9lAuhPTV
 fw7YZlXfHXDHnq4JBTx8PRjhYlFmk0/2hUHpxxlEuFfc5j7MxOhefqrvEmvLVB7PLusD
 ZNynTOp8qjDFSc2pLNTFlNI0KQNFAdhDKMjlvjg3sjXTdedkMczf571Y38jHn+q+hXuK
 vVmrB8I4s9FlCxOcnOM3yfQ0v4xQKuJZ9tIL949QwDrV8x1dn06r1QMjoz5487LffX77
 ij+1F4UsvfkstGqjAxTTAbDXmcpedwtkaytf7x3/g+gABeIInEDaIUY1CIGM7oVsSMbw
 55Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ifEANnOFnkWKd9qry6HkZCR/efNySP3CF8YCipTVYs=;
 b=iphh3lbHaUSpz8l+425T6ePgVdHk2GMYeJMzwTEhi6s7tnpYICFwW+RW7w5OeEUCQx
 b4OZtPuKoY9oMzobXFE2ZvGOvd0nATSbfMYQ3JW9KRHpX+RjFfQIAzH0h8qCHULzXufg
 A9gMiN4TE/lKwUvnF2oOrmRJ/b+2OqNtc0OTPieRXoUzRN8JP2sL3Y3Z3yM1c/hIm6Bq
 SBGsCnV0Md2+BQQbyeI/2TUkAyvsZrVLyQcTyhXgbJ436HqPcB31pcCmBpTGV22J7Uh2
 lTzeuaeRHiPOZ9/3oejaCfrViGfZM0Rn1uUa72QBjLotJ+nyNIkRLBJbwMgEGwVKRr0O
 XMSg==
X-Gm-Message-State: AOAM530UVQ/JlR3hLl0Ojfv6NNewNmuKsx3GgIh6byfK6IbmHe0HW10T
 5+oMC5JCMHIuYFqFCIKDKMYA8g==
X-Google-Smtp-Source: ABdhPJxAljdJR0hjLwTHy94WZWG1AnFAUYMEhuXfMWvUv9zJyrG1X7QdNNkxp0JC5sDbpyyA3kd7Wg==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr2414236pga.56.1598982593787; 
 Tue, 01 Sep 2020 10:49:53 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a138sm228105pfd.19.2020.09.01.10.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:49:53 -0700 (PDT)
Subject: Re: [PATCH 2/5] hw/mips/fuloong2e: Convert pointless error message to
 an assert()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc79a73e-ee46-c8a5-3843-0f472b2680c9@linaro.org>
Date: Tue, 1 Sep 2020 10:49:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901104043.91383-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:40 AM, Philippe Mathieu-Daudé wrote:
> Displaying "vt82c686b_init error" doesn't give any hint about why
> this call failed. As this message targets developers and not users,
> replace the pointless error message by a call to assert() which
> will provide more useful information.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/mips/fuloong2e.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



