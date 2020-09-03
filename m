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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEED8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6620D2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebqdEjdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6620D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoff-0001ql-2O
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDody-0008EU-Jf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:47:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDodw-0001r0-Oe
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKOYbSpXqpEFR+xjzMLfCAkn7MGr2ti0r84yWq8CQZA=;
 b=ebqdEjdYHOYHgqTrCBoh+z7+sHeAZE/4c0V6N3F7vTE47Bq2PRFjyfM9j8b9RkoH2t1DTe
 JqYU3BLrEqrKgldJPImN2egb6wWRugyMWhTwTMQLf4hxx4I3i/bHvPaMAKh9kiNqX6VRcu
 TGTYcrsVBiY76LxbLmwa7PRGMvwYCkw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-RJB0VDZwO6qkf6SsL1cvyw-1; Thu, 03 Sep 2020 08:47:06 -0400
X-MC-Unique: RJB0VDZwO6qkf6SsL1cvyw-1
Received: by mail-wm1-f69.google.com with SMTP id c72so927089wme.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HKOYbSpXqpEFR+xjzMLfCAkn7MGr2ti0r84yWq8CQZA=;
 b=d/vAgvBH/cNbaRYLZ2F0wXhhI06O4+tb+6prXBXlXWdRXQiL3R7uwSXFD1csMn0+Se
 cAvz2zqeYXdLPVrk/OTlXKKD7nX+UrhkfJpn8Hcyle2LVS1ciTIY4f6fIN9rKkJL0pcm
 ivfr13hT72AK1J7kUgmQ0JfTRIapPKfhxXHzQVZY6D6x7pVNsYTfXReod/YO1Gqkh71X
 B/+zjqBdKv9EvqLLmBjRATfhfQZzoUmAwK/Myh1dDm7/xPkQKbBoWHmQEdFuBugMC8t6
 QLSSQO3/FiXpZUnTc0dvfQnHzm1mTKVA3q1m7shsbf1IqwCgGl9ZoqGErGLDysHbc8LH
 Tg8A==
X-Gm-Message-State: AOAM530sbwfJlml546TSjekL9br1iI8gSGe0bHgVY4F+3LNIiRPfvLWw
 RftxFOKcUa3MyCFG8raMTc7bW1zOJ9mIh7err6UvooQiXFb/OaInYZdiOQMry953O71KPP9IRrY
 WzF4Szujk8DCvnxQ=
X-Received: by 2002:a05:6000:1631:: with SMTP id
 v17mr2245188wrb.411.1599137225071; 
 Thu, 03 Sep 2020 05:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynCr2Vo2ZVLhcQt5GFIMTyZLDoqMGpbV5wNDmWkO1rOWNpKJ10MVPxzjeMq64KyJhRp+E3zQ==
X-Received: by 2002:a05:6000:1631:: with SMTP id
 v17mr2245166wrb.411.1599137224864; 
 Thu, 03 Sep 2020 05:47:04 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p9sm4050678wma.42.2020.09.03.05.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:47:04 -0700 (PDT)
Subject: Re: [PATCH 14/63] i8254: Rename TYPE_I8254 to TYPE_PIT
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-15-ehabkost@redhat.com>
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
Message-ID: <9a2be0a5-1d7f-1813-5bdb-2c741f07c593@redhat.com>
Date: Thu, 3 Sep 2020 14:47:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-15-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
>  include/hw/timer/i8254.h | 4 ++--
>  hw/timer/i8254.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
> index 1a522a2457..ddd925074f 100644
> --- a/include/hw/timer/i8254.h
> +++ b/include/hw/timer/i8254.h
> @@ -45,7 +45,7 @@ typedef struct PITCommonClass PITCommonClass;
>  DECLARE_OBJ_CHECKERS(PITCommonState, PITCommonClass,
>                       PIT_COMMON, TYPE_PIT_COMMON)
>  
> -#define TYPE_I8254 "isa-pit"
> +#define TYPE_PIT "isa-pit"

I disagree with this patch, as we have various PIT and only one I8254.

>  #define TYPE_KVM_I8254 "kvm-pit"
>  
>  static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
> @@ -54,7 +54,7 @@ static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
>      DeviceState *dev;
>      ISADevice *d;
>  
> -    d = isa_new(TYPE_I8254);
> +    d = isa_new(TYPE_PIT);
>      dev = DEVICE(d);
>      qdev_prop_set_uint32(dev, "iobase", base);
>      isa_realize_and_unref(d, bus, &error_fatal);
> diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
> index c01ee2c72a..86f455f67e 100644
> --- a/hw/timer/i8254.c
> +++ b/hw/timer/i8254.c
> @@ -39,7 +39,7 @@
>  
>  typedef struct PITClass PITClass;
>  DECLARE_CLASS_CHECKERS(PITClass, PIT,
> -                       TYPE_I8254)
> +                       TYPE_PIT)
>  
>  struct PITClass {
>      PITCommonClass parent_class;
> @@ -370,7 +370,7 @@ static void pit_class_initfn(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo pit_info = {
> -    .name          = TYPE_I8254,
> +    .name          = TYPE_PIT,
>      .parent        = TYPE_PIT_COMMON,
>      .instance_size = sizeof(PITCommonState),
>      .class_init    = pit_class_initfn,
> 


