Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A79C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CCB2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TipNrf5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CCB2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDog1-0002Ls-AE
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoeS-0000p4-RG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoeR-0001sP-1L
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U6La/qVi2+fxzxv0OwHJMk5/GOTYwpXBuNbIBbxXxWY=;
 b=TipNrf5UPlPWE7Im5+ZS+a02PVHzeYH+c89MEiyxo5lNCSQB/4CvvIYklPwu/FGZc26f2Z
 Bo6d3hsY3DOVetwxqJtSwdIDXwDn5/IQ6vgWwoQTc6EluDHQW2w6vdzqjzR6eD6e3wexVk
 x4PvhKd2qOtazLbFXmtoHhTWI6kbP1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-WrXtnDWuPFusMAUYSVSSnA-1; Thu, 03 Sep 2020 08:47:36 -0400
X-MC-Unique: WrXtnDWuPFusMAUYSVSSnA-1
Received: by mail-wm1-f72.google.com with SMTP id k12so2354141wmj.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=U6La/qVi2+fxzxv0OwHJMk5/GOTYwpXBuNbIBbxXxWY=;
 b=qibpuqABBSn4SogGkV+n5sqhlmMBc8uTbBqZiMoOa44Z7H6be07e2v9SkE1II0RWh2
 VsxoU73p3OEHVvBdX9C8BPKEKIJ1tRzehyQ24pRm+XIHslKAArqonW/coZ7utY+SyaHs
 TMAXdIF+Acn5iKh2qd57MkScbKkxRrPbgapqMrjJf1WXP2wl23azanKa0PrsRMPdcE8j
 27fTwwiUgAMaNlfCbM10KVwa6FOejiQqxxYOXYBsIcOGYzZ4fI9WhIMBG0+i8lRgCq+I
 VwFVUV/e89XhCVwUggTohk71LvcMEf9rmPaFsF13NR6iAd6D8Q9kNb7TS2IE+fee/UVf
 vp1Q==
X-Gm-Message-State: AOAM530zQ3z9QlwiYB/q5a+wE/E4V0er527N+ETFsU7wjeMP6dDObJVZ
 Hv3ZikY2ZxonbyNliiW8AVfsIsW/S2gZ9yxMwkzkGZ14Y9+VjjsHkPp37eT1MknEe06GapG+i1w
 J4TrzzvXFwZ2pyjI=
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr2273646wmf.1.1599137254850;
 Thu, 03 Sep 2020 05:47:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN0Du8ikjF4DHgga24K6phzsssa6CiwNbo5t2yc2XbpRYRpO46LOjLIQ/VXV7nUw+MDeYOfQ==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr2273635wmf.1.1599137254692;
 Thu, 03 Sep 2020 05:47:34 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 91sm4759925wrq.9.2020.09.03.05.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:47:34 -0700 (PDT)
Subject: Re: [PATCH 15/63] i8259: Rename TYPE_I8259 to TYPE_PIC
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-16-ehabkost@redhat.com>
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
Message-ID: <bb2d291d-158f-0e79-e384-f6d011b4922e@redhat.com>
Date: Thu, 3 Sep 2020 14:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-16-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> This will make the type name constant consistent with the name of
> the type checking macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/intc/i8259.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index 344fd04db1..e536cc90be 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -37,10 +37,10 @@
>  
>  //#define DEBUG_IRQ_LATENCY
>  
> -#define TYPE_I8259 "isa-i8259"
> +#define TYPE_PIC "isa-i8259"

I disagree with this patch, as we have various PIC and only one I8259.

>  typedef struct PICClass PICClass;
>  DECLARE_CLASS_CHECKERS(PICClass, PIC,
> -                       TYPE_I8259)
> +                       TYPE_PIC)
>  
>  /**
>   * PICClass:
> @@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
>  
>      irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
>  
> -    isadev = i8259_init_chip(TYPE_I8259, bus, true);
> +    isadev = i8259_init_chip(TYPE_PIC, bus, true);
>      dev = DEVICE(isadev);
>  
>      qdev_connect_gpio_out(dev, 0, parent_irq);
> @@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
>  
>      isa_pic = dev;
>  
> -    isadev = i8259_init_chip(TYPE_I8259, bus, false);
> +    isadev = i8259_init_chip(TYPE_PIC, bus, false);
>      dev = DEVICE(isadev);
>  
>      qdev_connect_gpio_out(dev, 0, irq_set[2]);
> @@ -451,7 +451,7 @@ static void i8259_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo i8259_info = {
> -    .name       = TYPE_I8259,
> +    .name       = TYPE_PIC,
>      .instance_size = sizeof(PICCommonState),
>      .parent     = TYPE_PIC_COMMON,
>      .class_init = i8259_class_init,
> 


