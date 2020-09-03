Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F11C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A632072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmfR5zI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A632072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDol9-0008SV-Pi
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDokb-00080B-QV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoka-0002h3-4w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SUztFL5Af5GXdKiQ70b7UAllrN8kiu2F9AXo1YHlTJ8=;
 b=TmfR5zI7uCbUjOiXBCKk8veCccFv+ahArtUumDSpFK/oil1+e8AmBok+/Pl/sMW+pBo/aA
 JuYAqrtcQMheJBK4Z597VeCvwSyH5YFSQt4ZCeHhPOi0mPmarqAnOM9wNqOMBVDbdzqsEF
 aKsVCg72drKOIHruObzYgJu8dJ+xPFQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-P5NakwjINOqRaoeyjhJj7A-1; Thu, 03 Sep 2020 08:53:55 -0400
X-MC-Unique: P5NakwjINOqRaoeyjhJj7A-1
Received: by mail-wm1-f71.google.com with SMTP id x6so941902wmb.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SUztFL5Af5GXdKiQ70b7UAllrN8kiu2F9AXo1YHlTJ8=;
 b=fDZjJRFreC+t7/0MgXBOwOyiYLF3BtUjZCZTNkgfWGnqBKj7PdfCdTdHMAIXFfX/4l
 ubiSf4uhlM+ZKIrfsShwD1sJSm12M/rvfeXarRaZi5R+Gn4h4F+ounqPGDUFKtSL28Ia
 2ANG/RQGF7vfhpJYiVUqiGLi1dPUsNT66IklD2twGrXbEG8fuCz8CKOh59yinQeBUk47
 jSd/wjCOx903cgkdh2bk6277GZ4YWI25Mz8sH7kbFNEQTf7niaNyXpOrxmFs0p5lRau+
 mhclYO87Jmn3h2gxwLXK8KtbKZ6mgpqSnVeDZYGBEY3MbIiBF91hbAMLKIDUhconBlef
 +wiw==
X-Gm-Message-State: AOAM530rlKtMumo/VKp5Q0/BSaJZp2zhDMunBR1yb9Ra335pdlW0PhJq
 mX8R1UjyXwy2LQjHJxfGLUggCCyPjPZ3zT9NL/tb6+D9kyWdHNOleG5Wjqodo0baTE9/OTNgwoA
 RQS0ZNl78IQrdRvY=
X-Received: by 2002:adf:84c3:: with SMTP id 61mr2277947wrg.131.1599137634031; 
 Thu, 03 Sep 2020 05:53:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzadGi5YgQG9pMhE+2KJOCqO9ddZNtHNcY9qn3SqhRIhp/n7sT/oLJlZZIes925Ut9jRZaWNw==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr2277933wrg.131.1599137633813; 
 Thu, 03 Sep 2020 05:53:53 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id i26sm4424602wmb.17.2020.09.03.05.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:53:53 -0700 (PDT)
Subject: Re: [PATCH 16/63] i8259: Rename TYPE_KVM_I8259 to TYPE_KVM_PIC
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-17-ehabkost@redhat.com>
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
Message-ID: <edcbfa50-c0cd-27f2-f114-2d987715531b@redhat.com>
Date: Thu, 3 Sep 2020 14:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-17-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 berrange@redhat.com, Richard Henderson <rth@twiddle.net>
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
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/i386/kvm/i8259.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> index 3f8bf69e9c..687c0cd536 100644
> --- a/hw/i386/kvm/i8259.c
> +++ b/hw/i386/kvm/i8259.c
> @@ -19,10 +19,10 @@
>  #include "sysemu/kvm.h"
>  #include "qom/object.h"
>  
> -#define TYPE_KVM_I8259 "kvm-i8259"
> +#define TYPE_KVM_PIC "kvm-i8259"

I disagree with this patch, as we have various KVM INTC and only one
KVM_I8259.

TYPE_KVM_ARM_GIC and TYPE_KVM_S390_FLIC are kind of TYPE_KVM_INTC ...

Can we rename it KVM_I8259_PIC?

>  typedef struct KVMPICClass KVMPICClass;
>  DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
> -                       TYPE_KVM_I8259)
> +                       TYPE_KVM_PIC)
>  
>  /**
>   * KVMPICClass:
> @@ -133,8 +133,8 @@ static void kvm_pic_realize(DeviceState *dev, Error **errp)
>  
>  qemu_irq *kvm_i8259_init(ISABus *bus)
>  {
> -    i8259_init_chip(TYPE_KVM_I8259, bus, true);
> -    i8259_init_chip(TYPE_KVM_I8259, bus, false);
> +    i8259_init_chip(TYPE_KVM_PIC, bus, true);
> +    i8259_init_chip(TYPE_KVM_PIC, bus, false);
>  
>      return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
>  }
> @@ -152,7 +152,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo kvm_i8259_info = {
> -    .name = TYPE_KVM_I8259,
> +    .name = TYPE_KVM_PIC,
>      .parent = TYPE_PIC_COMMON,
>      .instance_size = sizeof(PICCommonState),
>      .class_init = kvm_i8259_class_init,
> 


