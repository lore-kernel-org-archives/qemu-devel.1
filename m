Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A00C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C324922574
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkjyUDNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C324922574
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOL0-0004ZE-1A
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvOKC-00044s-SI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:02:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvOKA-0001rf-Fg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594746153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1mZ+EEAp72DaYLDlLXQg8Hd36zs+2KsegAFpGlehiQc=;
 b=dkjyUDNq0yi/1/kHvipQnwhwo39fOmvaKhHcKfc9m/o/aAPjsZdp1TrxHLXY3f0BdE8U75
 Mu3toX2d4EB0xga3dnTiMhReSzX+pMpcLs986DTa/NU1cZ/iLx2Y+xldw9BF0Kaws7/XsS
 pTUz+p6i8EXjaG8Sfuw9QyjYyWSbfv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-miY-LTzAOVau1M2YKp2-Jw-1; Tue, 14 Jul 2020 13:02:29 -0400
X-MC-Unique: miY-LTzAOVau1M2YKp2-Jw-1
Received: by mail-wm1-f69.google.com with SMTP id q20so4842307wme.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 10:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1mZ+EEAp72DaYLDlLXQg8Hd36zs+2KsegAFpGlehiQc=;
 b=siizuny4FBcjKs8C3lnhOUrKtpgFrtcLcY1h9n+YwHqSXYFBUukw3tdfEWZnMBBVuF
 z/x3FpMAJSAe9sL/UMgA6Eu6GSRJizH3HFfrM/n75OBoM66vENXTwZymxcHPSP78KgWo
 9UvwwCcrTyMQLqAsP6JpJPbrc8CXOcxbqh84J7b27ucuUo7tC+g0bu0QDLyAP315iwaD
 Dng9aVr68e5/3NjSR1rY8lGQ7VbTuXVy9pAQL6R+vyU6jegDXEMA4sYxlE3NyKow9+eU
 P5NmEukKIcytkdivHLTygzJGT/kaCSG0vojtGbKNmH3OMdPdwutrPCMtE7gbw44d8e4s
 uzUg==
X-Gm-Message-State: AOAM533dfaP38aP7LiuBgzjnUVpyqXs0hM6YCohukhUcRKIKjQAAJ9Tj
 kUH4rx+vVeg+mLHmDffQuSVvIA9eOW4y9lWQv1hX1NvQY6DaB2JGRzIXet8cNmjWAvdtpeoW6fv
 Ai1qjRBcSaJy2kBM=
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr5038917wme.55.1594746147220; 
 Tue, 14 Jul 2020 10:02:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/o6A4d9fCicJy89TcZB0TzQGGJbkp2NIAzQ5ztzB3orGjRpXAStnU01n9LOQ6P77AXbpEhQ==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr5038897wme.55.1594746146946; 
 Tue, 14 Jul 2020 10:02:26 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 33sm32159275wri.16.2020.07.14.10.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 10:02:25 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
Date: Tue, 14 Jul 2020 19:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

Hi Pratik,

On 7/14/20 6:17 PM, Pratik Parvati wrote:
> Here is a brief context that might help you.
> I am referring hw/arm/versatilepb.c
> 
> The ARM PrimeCell UART (PL011) device created as follows
> 
> |dev = qdev_create(NULL, "pl011"); s = SYS_BUS_DEVICE(dev);
> qdev_prop_set_chr(dev, "chardev", chr); qdev_init_nofail(dev);
> sysbus_mmio_map(s, 0, addr); sysbus_connect_irq(s, 0, irq); |
> 
> Whereas the PL031 RTC device is created as
> 
> |/* Add PL031 Real Time Clock. */ sysbus_create_simple("pl031",
> 0x101e8000, pic[10]); |
> 
> What is the difference between these two devices creation?

Both devices inherit SysBusDevice, which itself inherits QDev.

You can create QDev objects with the qdev API, and
SysBusDevice objects with the sysbus API.

sysbus_create_simple() is a condensed helper, but only allow you
to pass qemu_irq objects, not a 'chardev' property. So for this
case you have to use the qdev API instead.

> How do I know
> which method to use while creating an object?

SysBusDevice are plugged onto a bus. QDev aren't.
The sysbus API results in smaller code, easier to review.

> 
> Thanks & Regards,
> 
> Pratik
> 
> 
> On Tue, Jul 14, 2020 at 9:39 PM Pratik Parvati <pratikp@vayavyalabs.com
> <mailto:pratikp@vayavyalabs.com>> wrote:
> 
>     Hi Support team,
> 
>     Can someone please guide me to understand the difference between
>     *sysbus_create_simple *and *qdev_create*?.
> 
>     I understand that these two methods are used to create a new device.
>     But, when to use these functions is not clear to me.
> 
>     Regards,
>     Pratik
> 


