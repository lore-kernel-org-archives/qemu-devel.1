Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56FDC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E58A20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WORhFg98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E58A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04fo-0005Bx-DL
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j04eU-0003p9-Vf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j04eT-0008Bl-Py
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:30:38 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j04eT-00086R-HB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:30:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so2774287wmh.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bNkn1I5RQS2zEJ4tCzJ+J/IO1PNoIbWPf/20IgEmoiM=;
 b=WORhFg98TF11SWyxj5EMLx7XPVsP0HleoFw+MOf+fr3fvjMKhehDu/5tyWjqVAHK8r
 sl4YvINY8uVEngy/U0l++W8gOA9Gp6lui1mwBOsVatSNgOdriUgML5ef0126pf9Ji0Xv
 7Wjn0k+2BIc7GtJQ1XGeqZJ/yuNQIekV3kAUjyGJeeq3MXkBwzeYta/R2v4kQyRg7ghk
 FlLONebkR8JAjKoe/sYI0hPM/vimlD4AdTAXj+Z+LgOVnBiZp8VvnsG9eO5BlDLZ8+j6
 4d2Zla/Vr5aDIRjQTAZxeRytHZQCopLk9cBmTfA+rA7kbBJg3/qFNVGea0q7ssVWjq27
 NRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bNkn1I5RQS2zEJ4tCzJ+J/IO1PNoIbWPf/20IgEmoiM=;
 b=itIvRHLC8A63VA++4VZJFiqIe7lq88rVSDv5wVXUdS/LwA1EQS/mS8jB96diZhS0qD
 E43h3AY5TzDeG89rKAttrF1QRlOOzmTmO9PO6d9+/l4II6O+1ZwGkZWAp5Q9axGeRxVW
 AEdyEaIogzFR2S+IDhK06JvXT0L240XFCW0OcfasfeJ+1h/6VLlPPMlLYS+Ijz+zO1iO
 uvhXY8GqTOBRwxCaWk9uZR1/0x0SOdj5F9RlUIj+L54WpRr2KWS7zinuy+NHLeWofBPg
 E0Wa08CXNGBP466RZ7yi65CFJsjLF3bUg55fQK76i5bkkB4k7uGaQwkrNBntnIv+zUzF
 6cfg==
X-Gm-Message-State: APjAAAXhHsN39HmoAlU33++6hZXfTitAu6A/8C4D7g3+jELao0QVIOQb
 ZbuBmCNOh5+j5XnwQ1u6qwGQQt/J0aoZUA==
X-Google-Smtp-Source: APXvYqyWd2vwVx6uMiGUMi3p2cBcaw0FzEdghxx1ciGlKQhlQOUgkHaZAeRBzf87yjEF686iJjnWiA==
X-Received: by 2002:a05:600c:2c08:: with SMTP id
 q8mr4756444wmg.45.1581085834458; 
 Fri, 07 Feb 2020 06:30:34 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id w8sm3698050wmm.0.2020.02.07.06.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:30:33 -0800 (PST)
Subject: Re: [PATCH 1/1] target/arm: Split out aa64_va_parameter_tbi,
 aa64_va_parameter_tbid
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200206130847.11166-1-richard.henderson@linaro.org>
 <20200206130847.11166-2-richard.henderson@linaro.org>
 <CAFEAcA-FSQH2dt-mE_qS+WK4m7V2TBfPMoP_hrLLNwsNqG8jKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50d8b779-f51a-f522-1c34-8a7c1e4f2a16@linaro.org>
Date: Fri, 7 Feb 2020 14:30:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-FSQH2dt-mE_qS+WK4m7V2TBfPMoP_hrLLNwsNqG8jKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 2:00 PM, Peter Maydell wrote:
>>
>> +    /* Present TBI as a composite with TBID.  */
>> +    tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
>> +    if (!data) {
>> +        tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
>> +    }
>> +    tbi = (tbi >> select) & 1;
> 
> ...but aa64_va_parameters() always sets
>     select = extract64(va, 55, 1);
> even for the 1-range case, and then we assume in this bit
> of code that we can pull the corresponding bit out of tbi.
> 
> Don't we need to either duplicate the bit returned by
> aa64_va_parameter_tbi() in the 1-range case, or else
> only shift tbi by 'select' in the 2-range case ?

I think we need to force select = 0 in the 1-range case, since "select == 1"
makes no sense in that case.


r~

