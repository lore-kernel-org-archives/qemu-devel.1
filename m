Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F5C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6050206EF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfXOcs1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6050206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wYs-0006gX-1d
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wY3-0005j4-4Z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wY2-0000Gg-3H
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:39:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wY1-0000GK-WA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582007997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ydCdCYmRemsTJ61ZeWO3cgvuhYP9TRo4vUOe6SEzFs=;
 b=dfXOcs1B4uMpfNmuh3INAeqPozbOvNbroUTAzfXKsZ8FKtayhjB9UcNVN4idIG/YHRbs58
 ZZz9ZAG/P7PB5LRnhS1d1m44vNd9kh0UISbPuTPrORt3R2wswm15kv9UuggUtZxHer763N
 7KWxw7cN0IkUHfYlsClF36Trj1DSX7o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-tHa8i6T6Moiuqvy2DbxGLA-1; Tue, 18 Feb 2020 01:39:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id y7so699502wmd.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+ydCdCYmRemsTJ61ZeWO3cgvuhYP9TRo4vUOe6SEzFs=;
 b=CHAyH3uvvNimLsWj14vRg924chnz5XtTxpF8z8L1/tlhLuVp2nAdT1HZMUp7dFsQPq
 28nKkxpcBetO5Wi1Qnw/UK6J7hcWO2Bw7sOo2RkaMq3GhmdrEoMO2V7G4plv0kpvC5RK
 3tf5M7uhAwP7TKuPwvGsAQEEkivlP3v2UIu43RCZ3JbGzJ3Y0AAOFWN6C1SmE336FQtO
 Mt0w4oWBoetkZlZZIS0Ljk2EV2JUIbsA09OnEx3Rk/6HJozSD3epdk65x82K/uA/+kFj
 8gzf2xbzPoWXuxjeCI0tIzNJ7hbGIAhL+Xw8lHcnhabh8BJ5ruNesW4v6p2w0N5oNbhn
 wboA==
X-Gm-Message-State: APjAAAXqWbnQ7tX1JHhD5gP3iFRaSuBQ5/ZhkwfDPKXgdg1LM3z/P/G3
 ueHS2VNisaSgcM1CLwtAMT5BTLqKJMqkEIsqobl6oBYhE42xPEDL+i3SL0dJuzzzOc0ulwdAoj2
 mvdoFVPg5Xgoghso=
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr1100879wmj.43.1582007993894; 
 Mon, 17 Feb 2020 22:39:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuX60ogJdv+JEFu+zc5olTYjWtEyGCoW62D8jF+CWPfpYJcJENs++mLyJGJp1dSYTpaBifqA==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr1100846wmj.43.1582007993469; 
 Mon, 17 Feb 2020 22:39:53 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z19sm2125201wmi.43.2020.02.17.22.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:39:52 -0800 (PST)
Subject: Re: [PATCH v3 0/3] arm: allwinner: Wire up USB ports
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200217204812.9857-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1069ca0c-2902-1c76-d111-de6c6129b02b@redhat.com>
Date: Tue, 18 Feb 2020 07:39:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217204812.9857-1-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: tHa8i6T6Moiuqvy2DbxGLA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Niek.

On 2/17/20 9:48 PM, Guenter Roeck wrote:
> Instantiate EHCI and OHCI controllers on Allwinner A10.
> 
> The first patch in the series moves the declaration of EHCISysBusState
> from hcd-ohci.c to hcd-ohci.h. This lets us add the structure to
> AwA10State. Similar, TYPE_SYSBUS_OHCI is moved to be able to use it
> outside its driver.
> 
> The second patch introduces the ehci-sysbus property "companion-enable".
> This lets us use object_property_set_bool() to enable companion mode.
> 
> The third patch instantiates EHCI and OHCI ports for Allwinner-A10
> and marks the OHCI ports as companions of the respective EHCI ports.
> 
> Tested by attaching various high speed and full speed devices, and by
> booting from USB drive.
> 
> v3: Rebased to master
> v2: Add summary
>      Rewrite to instantiate OHCI in companion mode; add patch 2/3
>      Merge EHCI and OHCI instantiation into a single patch
> 
> ----------------------------------------------------------------
> Guenter Roeck (3):
>        hw: usb: hcd-ohci: Move OHCISysBusState and TYPE_SYSBUS_OHCI to include file
>        hcd-ehci: Introduce "companion-enable" sysbus property
>        arm: allwinner: Wire up USB ports
> 
>   hw/arm/allwinner-a10.c         | 43 ++++++++++++++++++++++++++++++++++++++++++
>   hw/usb/hcd-ehci-sysbus.c       |  2 ++
>   hw/usb/hcd-ohci.c              | 15 ---------------
>   hw/usb/hcd-ohci.h              | 16 ++++++++++++++++
>   include/hw/arm/allwinner-a10.h |  6 ++++++
>   5 files changed, 67 insertions(+), 15 deletions(-)
> 


