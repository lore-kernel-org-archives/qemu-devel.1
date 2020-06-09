Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD6C2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD+MKlyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD6C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZUj-0003xE-4C
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZTw-0003W9-2l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:19:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZTu-00079P-Tz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591690777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4OigxPhbm7fjuTV+jyYtDGF9prFcBoHpAQdAR1nFGeQ=;
 b=gD+MKlyQvJaZwHTPuSCqyD8m5ZqwkmFCrNSzqOKInSjYe+3+Z1dhM68HyYitgo/736sfzU
 sVIjB1dneTCwHc7GYTQ1D2ZWO8+5hf7MyWEwwKp8RV16a17t7hqd5JIidYTI0OErxL3adL
 7oIM1fa3QD5B2g/gR6Jmndr6hP1T8N8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ZizLvWYDNQ-VE7Idj3ikoQ-1; Tue, 09 Jun 2020 04:19:36 -0400
X-MC-Unique: ZizLvWYDNQ-VE7Idj3ikoQ-1
Received: by mail-wm1-f69.google.com with SMTP id t145so463039wmt.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4OigxPhbm7fjuTV+jyYtDGF9prFcBoHpAQdAR1nFGeQ=;
 b=j97uCCY58ssreLS7f1wxjHOfS8WWs3Q6SsIpnVv7UeMn2xmCypV8j3zwsOV4siVN7B
 N4k1w+NTJw+kTcHD66Efd0y8xHW6Wvuhq+43RY1DpvLqevJuEW+tqCQUAgLIxUr8eE76
 Ds3gp8BvXlzBKH76fPQc6DiLxjMVfDV0wrqWW3Xy95tFP1Euut943wRTS1PRCYr1aTOu
 KwjJ1XN/sNn4/Xi5FEaqDW+pBBxtZBGgC0UQF9EZOSR6huUVKCzuUS0Aq1alE3PZrQRQ
 Ge4YN8UhF1hJWafbTaS7a4qDPapl+WEMKnE7QoMZFnkSLJrsDLLwdYKFHo50PRi2Ybq8
 QjYQ==
X-Gm-Message-State: AOAM530aGD0AXEjRsWM1XZ9O8RFz+gzS3rvg5AEVjKjDygf12p1FpfEO
 CG5Frido1nwaNxTAl5ACBFZUAzd/2cWXpsEJO1PMryXmoz5pDsct3EMCb6L9ElIecdKf+DeRSnP
 MXg0Xk/oYjDZTS5E=
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr3282842wrx.55.1591690774465; 
 Tue, 09 Jun 2020 01:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX5tHXK0JOKZy3yK2Q0EA4p5iXG7Ws0DhGThcw9fkpwoPX3Jes6xOjmpYx7BjvNq2C3MdiUQ==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr3282811wrx.55.1591690774012; 
 Tue, 09 Jun 2020 01:19:34 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b18sm2315437wrn.88.2020.06.09.01.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:19:33 -0700 (PDT)
Subject: Re: [PATCH v2 18/58] isa: New isa_new(), isa_realize_and_unref() etc.
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-19-armbru@redhat.com>
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
Message-ID: <bd15d6c2-5576-dcad-18cc-5020f094dcbe@redhat.com>
Date: Tue, 9 Jun 2020 10:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-19-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 5/29/20 3:44 PM, Markus Armbruster wrote:
> I'm converting from qdev_create()/qdev_init_nofail() to
> qdev_new()/qdev_realize_and_unref(); recent commit "qdev: New
> qdev_new(), qdev_realize(), etc." explains why.
> 
> ISA devices use qdev_create() through isa_create() and
> isa_try_create().
> 
> Provide isa_new(), isa_try_new(), and isa_realize_and_unref() for
> converting ISA devices.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/isa/isa.h |  3 +++
>  hw/isa/isa-bus.c     | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 02c2350274..3b6215fafe 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -105,6 +105,9 @@ MemoryRegion *isa_address_space(ISADevice *dev);
>  MemoryRegion *isa_address_space_io(ISADevice *dev);
>  ISADevice *isa_create(ISABus *bus, const char *name);
>  ISADevice *isa_try_create(ISABus *bus, const char *name);
> +ISADevice *isa_new(const char *name);
> +ISADevice *isa_try_new(const char *name);
> +bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
>  ISADevice *isa_create_simple(ISABus *bus, const char *name);
>  
>  ISADevice *isa_vga_init(ISABus *bus);
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 1c9d7e19ab..e6412d39b4 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -176,6 +176,16 @@ ISADevice *isa_try_create(ISABus *bus, const char *name)
>      return ISA_DEVICE(dev);
>  }
>  
> +ISADevice *isa_new(const char *name)
> +{
> +    return ISA_DEVICE(qdev_new(name));
> +}
> +
> +ISADevice *isa_try_new(const char *name)
> +{
> +    return ISA_DEVICE(qdev_try_new(name));

We have:

#define ISA_DEVICE(obj) \
     OBJECT_CHECK(ISADevice, (obj), TYPE_ISA_DEVICE)

With:

#define OBJECT_CHECK(type, obj, name) \
    ((type *)object_dynamic_cast_assert(OBJECT(obj), (name), \
                                        __FILE__, __LINE__, __func__))

"If an invalid object is passed to this function, a run time
 assert will be generated."

I'd expect isa_try_new() to return NULL if the type_name is not
registered...

> +}
> +
>  ISADevice *isa_create_simple(ISABus *bus, const char *name)
>  {
>      ISADevice *dev;
> @@ -185,6 +195,11 @@ ISADevice *isa_create_simple(ISABus *bus, const char *name)
>      return dev;
>  }
>  
> +bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
> +}
> +
>  ISADevice *isa_vga_init(ISABus *bus)
>  {
>      switch (vga_interface_type) {
> 


