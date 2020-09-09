Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42A8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5316620757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7ylWpfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5316620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzaz-0006uw-HA
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFzZw-0005p8-4J
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:52:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFzZt-0000XY-6S
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599655916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dLE66RuNGYCRDNTtZmCHmJtOppzpOmAMtlfcHcGJHNE=;
 b=Q7ylWpfluFJXfS8PcgtKCCEpb205+4M5He3WlFHhYFFRtfhi8ObhcRl4RFpWQsKvcwyDJo
 r+KKX7xnfeXz5VbfQAHX14N4dBeP0pO2tbHYzHsx2b3bea3qZKWVvXnt7F21M0TS4gh4l/
 s03T2fpIIkCmOmFt89KA7EyfePwvN3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-AuZ9s6XBMdCy3Me8yHoXzg-1; Wed, 09 Sep 2020 08:51:53 -0400
X-MC-Unique: AuZ9s6XBMdCy3Me8yHoXzg-1
Received: by mail-wr1-f72.google.com with SMTP id a10so916117wrw.22
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 05:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dLE66RuNGYCRDNTtZmCHmJtOppzpOmAMtlfcHcGJHNE=;
 b=UdFkeV24QURXeW2ZMd138L8IHe+8h2TlH2hY20mj5snrIxZmGdsG0woLcXpqJE5srT
 5UF366gKCV3+Q+AzldUC41uHF0l9p5RthbZvUnZTxkTHGPmGvS+OJ0qCJdcGHx9rUpFM
 XRuYdcG3PiAiIzJxevQInA7ZOk36YNUfxdR7s0ZCNhCDSuHaNd9Rl1P0TlqpujJW4anA
 nF4u1sv6aTO3mXoWRj/sdm2Yh6ZRZaRqpOJkKwCW6wlHcXWxlyB3/HdVQFja6/KmJcxO
 XZIztQRwlUHO7Pqa22xfsoRf8u+LNxfb1N3MQxD8hN6Op/ann7lyjSnNeBeMQhjSjy3L
 78XA==
X-Gm-Message-State: AOAM533VCJXkPcdbsVZTWXUbF5e1pBVQOdUkwVWb9FSyGNUNWiYtE7Sf
 1IBhqFIys81AMiIn58S/ScYZToPTC3+Ot5WsBkJBpON2i0h2Fm1BS1iAUxNIWzAPCyut6Q2yLYr
 txcRGfUK4QRRYbDE=
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr3437232wmk.10.1599655912673; 
 Wed, 09 Sep 2020 05:51:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlR2T4/7e/145FDg7gAg4X/zVLPlOvuuVxXBrV3UFzpk+Vn5HRzeGaG0qosjAsYkc7H28i4Q==
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr3437209wmk.10.1599655912419; 
 Wed, 09 Sep 2020 05:51:52 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d25sm4254353wra.25.2020.09.09.05.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 05:51:51 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c
 maintainer
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200907111632.90499-1-stefanha@redhat.com>
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
Message-ID: <20491ab5-7d5d-9360-7215-a1a56dbf5ed0@redhat.com>
Date: Wed, 9 Sep 2020 14:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907111632.90499-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

+Alex

On 9/7/20 1:16 PM, Stefan Hajnoczi wrote:
> Development of the userspace NVMe block driver picked up again recently.
> After talking with Fam I am stepping up as block/nvme.c maintainer.
> Patches will be merged through my 'block' tree.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b233da2a73..a143941551 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2895,10 +2895,12 @@ S: Supported
>  F: block/null.c
>  
>  NVMe Block Driver
> -M: Fam Zheng <fam@euphon.net>
> +M: Stefan Hajnoczi <stefanha@redhat.com>
> +R: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/nvme*
> +T: git https://github.com/stefanha/qemu.git block

As this driver is the only consumer of the 'VFIO helpers',
maybe we can:

- maintains them in the same bucket
- add another entry (eventually with R: tag for Alex)

The 'VFIO helpers' files are:
- util/vfio-helpers.c
- include/qemu/vfio-helpers.h

What do you think?

Regards,

Phil.


