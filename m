Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D52C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F032206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1jf5/mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F032206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAUS-0000iR-MK
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDARv-0005T1-Qc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:52:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDARt-0002rF-GO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:52:03 -0400
Received: by mail-pl1-x643.google.com with SMTP id s10so459435plp.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v/Zs848lLTt1/iuJYLIKyVPSq03RB8xrlI60rS4l+lE=;
 b=o1jf5/mb/LXMC+0+IpGzOMJNZGOd2ZuMxVe6Pa5umIQXCgDWfokSXiiYOc2xvG+dhZ
 IxVnJHnviAK26c2gB7V+wIjtvyaNU0Ivw8vD5aF39P6MTR7tPNRCACV63tf733s1vDpk
 G297Od0kyCvzlVpfCxw/3lq1O/lHaRXZ9LDPdgRKIC3Y48XF4f7jU5SlUa4sqoAldzON
 09iR5LpspoMdMnbOWDhK1Dnf0TQtecgb1i34G3yh6W5PURJfer69FLryCYupW0D8s3YW
 iC3e9R2n/N2lRq7i1q0sveOH17akIb/aScFAe+tsG9BKxnjCZDZQ7G3pk31skaQsK+qX
 /+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v/Zs848lLTt1/iuJYLIKyVPSq03RB8xrlI60rS4l+lE=;
 b=sbiO/vvEKKqifz+HSAMlMfllUC663ZPSJtpjR9v36iott1swbPMgKH3TvWAg/WfO6F
 3+9nPomM5bXURH2Nvw64geeOiG0OUiyYAis6IzcvHXV0RaZMm6MlcCGXvvY/OunpqAXQ
 nCgWm5lPM4iMWGeY501yxWjmL3PvVMTdlEoKLRqKcDcvS4GJHKWhO9FzXuEhBRmhiTUZ
 GQKLkaPH4hwHdflQacRyVpgu/migon4tkWlkUpMN778K3rdoCRZegKt2t6WwQwn5w6fE
 +8C31PRIUZjdap5bPkLjEeGn63eSlWynbN5RaXSGcjq1pRgFPir/EBHDO9vkYhXg3f/t
 ovTw==
X-Gm-Message-State: AOAM531Sird6d8vnaRH32ImqLLTz6WFx8/a0WJQc560Z/zxP1eKfS7Oy
 7v7mtUc9Z+eVFLMlk9CUSaYC7w==
X-Google-Smtp-Source: ABdhPJyuQojV1mN7XoMyiFiY8W++m1s76QJt+hmiQzSz/gWzZ6lwk7XG3rvt6B+h3OWfLtNLtYBrcg==
X-Received: by 2002:a17:90a:39c8:: with SMTP id
 k8mr2740568pjf.19.1598982720260; 
 Tue, 01 Sep 2020 10:52:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q4sm2754080pfs.193.2020.09.01.10.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:51:59 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] hw/sd/sdhci: Document the datasheet used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901140411.112150-1-f4bug@amsat.org>
 <20200901140411.112150-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4fec2729-7edf-7516-f826-4ed6dd979eca@linaro.org>
Date: Tue, 1 Sep 2020 10:51:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901140411.112150-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 7:04 AM, Philippe Mathieu-Daudé wrote:
> Add datasheet name in the file header.
> 
> We can not add the direct download link since there is a disclaimers
> to agree first on the SD Association website (www.sdcard.org).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



