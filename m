Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B04C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8CB2087C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQUI878L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8CB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDO3F-0007ha-Lk
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNwk-0002LC-94
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:16:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50309
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNwi-00033h-AZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GQexKUUrhYb+TT33oXtG/AwVBldItpI7z+WN5N/0WfQ=;
 b=OQUI878L6QU1CLhuym1kBKHI4xx0Bfo7o7sD7hOCiuCSJ71mGk//DAuuR9Oe5g9lsuLN0H
 fvODUoTerKqGbO9Fd/QCW034JqnDnPWTgPezszUTrxprM/cbP1qcM3Tv4pTUuIkEagU8Fw
 ZR/kU0g3vjOHkwHG12VU9AC7igAfqA8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-efCf4gwbMxesN76unWWNPg-1; Wed, 02 Sep 2020 04:16:41 -0400
X-MC-Unique: efCf4gwbMxesN76unWWNPg-1
Received: by mail-wr1-f69.google.com with SMTP id b18so1657666wrn.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GQexKUUrhYb+TT33oXtG/AwVBldItpI7z+WN5N/0WfQ=;
 b=nfyz4V0LI4HGWHOpF5dfOKJ+BOPBr5LjmXzDAUBssr3vH8LfHA+6kWDpQAi5xDdoBm
 K1adMM5oZ8mJdk9ntCPl/X/b8BPlPuurR5JyIaaGDWkC2vVHJemxJTbSwFwBzuM9lGwq
 0mWcmt//VczIzHcc8KnfhplCU6TIHnN8/zC3Qddj17SEzIbpaI2Jz6OsQh9XdsMpcpqQ
 +vw/6SXuP7l3Q9gyOMb0QDChiYFtjOnaub8sAZnL0XdHPT9Css0MC3bFHj61wXwPTakH
 UidvtvxJtTE2C0CFZNXLboQ0hqPRO4ogZhNHTQoqP3/s9IEwdh6I1OwCKMBIRTyJuEsd
 5JyQ==
X-Gm-Message-State: AOAM533s/fa6QorTWoCw0956g16+9DaVkv/xiK94emkZW86dj2Gt1snr
 +qc/bu37eJjob3FWr4YOAOOxewuyGmvF2KBr57BLzm6r9SH53KvPzTUU9kmTe8hmYNYeFVDf3vf
 xaqew4AG0TwSKvrk=
X-Received: by 2002:adf:f890:: with SMTP id u16mr5658148wrp.183.1599034600818; 
 Wed, 02 Sep 2020 01:16:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4vT3j+FCp3gdBFyUFciqi03tyVMvBd7EiZZnj0EVX5mEAEB6yaR0E8qKGEUt6xoGWjybAHw==
X-Received: by 2002:adf:f890:: with SMTP id u16mr5658130wrp.183.1599034600617; 
 Wed, 02 Sep 2020 01:16:40 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id r14sm5916388wrn.56.2020.09.02.01.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:16:40 -0700 (PDT)
Subject: Re: [PATCH] usb-host: restrict workaround to new libusb versions
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200902081445.3291-1-kraxel@redhat.com>
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
Message-ID: <b4edcda3-7e01-ae2a-a385-e478c644230a@redhat.com>
Date: Wed, 2 Sep 2020 10:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902081445.3291-1-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 10:14 AM, Gerd Hoffmann wrote:
> Fixes build failures with old kernels (USBDEVFS_GET_SPEED missing),
> on the assumtion that distros with old kernels also have old libusb.
> 
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/host-libusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 08604f787fdf..c5d38cb09c06 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -942,7 +942,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
>      usb_host_ep_update(s);
>  
>      libusb_speed = libusb_get_device_speed(dev);
> -#ifdef CONFIG_LINUX
> +#if LIBUSB_API_VERSION >= 0x01000107 && defined(CONFIG_LINUX)
>      if (hostfd && libusb_speed == 0) {
>          /*
>           * Workaround libusb bug: libusb_get_device_speed() does not
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


