Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CBEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8632320897
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/rOTSSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8632320897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWR72-00080z-IB
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWR6R-0007bm-To
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:29:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWR6Q-00025V-F5
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:29:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so7170934wro.8
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t3L9sMjbAx21Arm3CWAsK8tovua5w8PzSPMPxRRJEk0=;
 b=P/rOTSSwP/vOKo5h9WlW3m6haadvlzNOp8VbT3YgqNrdfG8g8i1aENfMwcBrkkO9gC
 Dp1L5VlIQbucNFGjjxd9JURayaPkkzmMoj9A4cTEv10ju9F8ZQbeZNclncWSncjD4PJ/
 AJZQCrQl+cPVEdKXMj9wRF5Jy2tEyvfVLLNlVvEQf+t42JOsdCtlCqX9t/tk7vs1OsGk
 tvVF0hICVXXVi5c0ujcMZG+qhqXUQWXiucHip9wxabEqOBftU6Si3lCzvfbr0hjmut9B
 zwY2FfUIiGekF4ZXd/BlD2Fh4mIvRfNWa3H1AF9Cvxy6LJ+nPs7qgesqcJzb7qZeNQ8x
 xr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t3L9sMjbAx21Arm3CWAsK8tovua5w8PzSPMPxRRJEk0=;
 b=iZsD1mNNd0p/+29dUkkJwxFv81c6hVkxW5f5Xp+vIAOJmUsvW6K2K+MQwgCvc1W5S2
 wnHoJ9oWFFkX94iHD1F6mGBhuZmwTd/HpMh5CDBGYSnavSWUDWWhXyPW6aVXLJMTDLIO
 SB2Hr4DzGmbPjswcc0GFdaeTuIycy/LdWLfOUtNQI15682xpXL5gKMXaDnsUE4g76xXl
 5GM0ZYzkWY7l05CH2Kj5vqU61RSlV6susaXKO0cxdtBjVBhVoqU9ILCDNPU9gYYQV/8c
 1XT5+HdDUtsVgFebYrDDWRJ6fj6LQiiW2xiEJxUYDHMDdXNg61a+a+QKyvWaqIsgxO+t
 H7Ow==
X-Gm-Message-State: AOAM533zgDHwRMts4+C3l5EA9xV+9zX/4Wsgy/6oq/GZFGD9fB/mQ1Ke
 dN5JjO20IDf/pMy/qu48P0k5ZpDseR4=
X-Google-Smtp-Source: ABdhPJyK0Nkes2G3Jd7ahnBZVyORXGuHHf/+UE7f/U08EsnO9GUd/0ztpmnc0uLquL6kq0DPWQds5g==
X-Received: by 2002:adf:c443:: with SMTP id a3mr2752107wrg.143.1603574969129; 
 Sat, 24 Oct 2020 14:29:29 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y7sm12567812wmg.40.2020.10.24.14.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 14:29:28 -0700 (PDT)
Subject: Re: [PATCH 06/20] hw/timer: Renesas 8bit timer emulation.
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-7-ysato@users.sourceforge.jp>
 <4db6d116-e5b6-e9cf-d6a3-27a2e4a131dd@amsat.org>
Message-ID: <902aa0bf-25c7-a9b4-6853-82efd1db92c1@amsat.org>
Date: Sat, 24 Oct 2020 23:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4db6d116-e5b6-e9cf-d6a3-27a2e4a131dd@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/24/20 11:27 PM, Philippe Mathieu-Daudé wrote:
> On 8/27/20 2:38 PM, Yoshinori Sato wrote:
>> Rewrite for clock API.
>>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> ---
>>   include/hw/timer/renesas_tmr.h  |  55 ----
>>   include/hw/timer/renesas_tmr8.h |  67 ++++
>>   hw/timer/renesas_tmr.c          | 477 ----------------------------
>>   hw/timer/renesas_tmr8.c         | 540 ++++++++++++++++++++++++++++++++
>>   hw/timer/Kconfig                |   3 +-
>>   hw/timer/meson.build            |   2 +-
>>   6 files changed, 610 insertions(+), 534 deletions(-)
>>   delete mode 100644 include/hw/timer/renesas_tmr.h
>>   create mode 100644 include/hw/timer/renesas_tmr8.h
>>   delete mode 100644 hw/timer/renesas_tmr.c
>>   create mode 100644 hw/timer/renesas_tmr8.c
> ...
> 
>> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
>> index 8749edfb6a..5288660cda 100644
>> --- a/hw/timer/Kconfig
>> +++ b/hw/timer/Kconfig
>> @@ -36,7 +36,7 @@ config CMSDK_APB_DUALTIMER
>>       bool
>>       select PTIMER
>> -config RENESAS_TMR
>> +config RENESAS_TMR8
>>       bool
> 
> Build failure:
> 
> undefined symbol RENESAS_TMR

And:

In file included from hw/rx/rx62n.c:27:
include/hw/rx/rx62n.h:29:10: fatal error: hw/timer/renesas_tmr.h: No 
such file or directory
    29 | #include "hw/timer/renesas_tmr.h"
       |          ^~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

