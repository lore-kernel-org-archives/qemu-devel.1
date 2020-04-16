Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04611C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB32E20786
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiYrYq7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB32E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBiE-0005uq-UM
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 17:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jPBhC-0005Gr-9o
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jPBhA-0003qN-Rb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:05:14 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jPBh5-0003nE-Lo; Thu, 16 Apr 2020 17:05:08 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t40so82199pjb.3;
 Thu, 16 Apr 2020 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PwyPJFrJEaJK0d51Wl22d7Xw2dD/MAk+ZGhZww+aErk=;
 b=WiYrYq7bLfQGBKB/hDACxgkxkn8k8ggrt/Pn52QkPutygThc63Kt4stRwDqDOKCKca
 x+mtYpgQJnvE9b49pS7PFcHP/igYonkCxwxDgCAiYdQ1OoBwc9BfvUuyZI0HP2UeR1u+
 K/wqnJgSu/4TwOqzmRzEbJE0X0EQLoCC5jJCy9ZeG0jF7wopQ22UO0P51MqjUpZzgIZu
 AYrmcERzhvURXCSpOYWZBTRwrgRvWa2YQ0ouai2whPYO1qVfQYF6AeA6BGNsUS2pnW/0
 yy6CRFFTQDWalaS3hH7onC/M5uc6aLEiAGjWi+pcFG8vlrntm+Yau4ZuZvXVxAzeN99Z
 sfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PwyPJFrJEaJK0d51Wl22d7Xw2dD/MAk+ZGhZww+aErk=;
 b=kJu99lHJmU5EJ2Cr6lDLpLcoms4yAGmNQomCTl1+tmN8SqlpwZTMzG4KkJdoOvUTgE
 OlBziEaECLW9Bk7iyoy81YpzYT90lqkofvaaQg31vQ4Tx9xIbNZ0URIodt6TFXc0ipUx
 6Efznv3XENjBtEnANuRxiSx4+bNXKkNQIucK7OON29trEreA9F8XYBsxU6YNG/DLnTFi
 cGiI9tyNjN8TrfydY6lBRqVU2Q3p2MRIMT6KL77SwcZa/RFyvN3qfBGIObgLojCiDz6S
 Go+TULgjj35/HUi6wt/rDdmXra48k/ZPN6LEX+eEoRCtSdqO1yphtBL6/GWrb+WjnuPA
 hvnQ==
X-Gm-Message-State: AGi0PuaplB8YbyBrq4g2aLOJ2v/eCf9Ko6R9cIoSRmVgkvbPVWk3PkQi
 YcpC0JQbMaxkANgNY3i4gbhQmXP0
X-Google-Smtp-Source: APiQypI/CRNncRnMYgjZr30tCu7V++fj87avwbbADZuSmY3ikWg1oTs6lizaSDjh7x1Yikq+ajtZHg==
X-Received: by 2002:a17:90a:5217:: with SMTP id
 v23mr233686pjh.127.1587071106044; 
 Thu, 16 Apr 2020 14:05:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 e4sm14816443pfn.199.2020.04.16.14.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2020 14:05:05 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] hw/arm/fsl-imx7: Connect watchdog interrupts
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200322211919.11335-1-linux@roeck-us.net>
 <20200322211919.11335-9-linux@roeck-us.net>
 <CAFEAcA9drmvK5aiCtugLFABKf9t+XMkt6AhS75VhzABzXVMhGQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5ed81c7f-01ec-4e1a-9886-89879c3eedfd@roeck-us.net>
Date: Thu, 16 Apr 2020 14:05:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9drmvK5aiCtugLFABKf9t+XMkt6AhS75VhzABzXVMhGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 4/16/20 8:29 AM, Peter Maydell wrote:
> On Sun, 22 Mar 2020 at 21:19, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> i.MX7 supports watchdog pretimeout interupts. With this commit,
>> the watchdog in mcimx7d-sabre is fully operational, including
>> pretimeout support.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
>> diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
>> index 47826da2b7..da977f9ffb 100644
>> --- a/include/hw/arm/fsl-imx7.h
>> +++ b/include/hw/arm/fsl-imx7.h
>> @@ -228,6 +228,11 @@ enum FslIMX7IRQs {
>>      FSL_IMX7_USB2_IRQ     = 42,
>>      FSL_IMX7_USB3_IRQ     = 40,
>>
>> +    FSL_IMX7_WDOG1_IRQ    = 78,
>> +    FSL_IMX7_WDOG2_IRQ    = 79,
>> +    FSL_IMX7_WDOG3_IRQ    = 10,
>> +    FSL_IMX7_WDOG4_IRQ    = 109,
> 
> irq 10 for wdog3 seems to match the kernel's dts, but it's
> a bit weird that it's way out of the range of the others.
> Did you sanity check it against the imx7 data sheet and/or
> real h/w behaviour that it's not a typo for
> one-hundred-and-something? (108 would be the obvious guess...)
> 

I actually did check, for that very same reason. To be sure I looked
again. 10 is correct per datasheet. 108 is TZASC1 (TZASC (PL380)
interrupt).

> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 

Thanks,
Guenter


