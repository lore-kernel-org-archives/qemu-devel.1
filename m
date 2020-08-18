Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C935BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BE62063A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byReR768"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BE62063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7w1p-0004fW-Sc
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 03:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7w12-0003xJ-1X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:26:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7w0z-00030Z-CT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597735596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=26K6Cvx+pzLMebKlR4+Gmrhkv5wSgKlu3pbHjE2hMTw=;
 b=byReR768UTkHT285cF3qZbF+6JLs9RWvLMvxaPawxJjdfLucCH2O8xjWxq/aKQKUuFuWs6
 spyZs9DbGAjWMZNwu46Ph7+O0w9qoDXA+M9N6KZosa+tcKAkyfwR9nuznJzPohTohGXEcF
 KCrSTT7tFRjRGTAzv2DpbtTaf4lFIQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-ZWKqpce_N8OwMGr3AS-aYA-1; Tue, 18 Aug 2020 03:26:35 -0400
X-MC-Unique: ZWKqpce_N8OwMGr3AS-aYA-1
Received: by mail-wr1-f70.google.com with SMTP id y6so2396005wrs.11
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 00:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=26K6Cvx+pzLMebKlR4+Gmrhkv5wSgKlu3pbHjE2hMTw=;
 b=d95u2c//uTc0cD1c+uU7Y1lOrz8iak5zEAiv/QDODrcXwCX7xnYPEGf0aZAaHmKQyd
 QNrH463R6DdIC+FK5eKyWFvcBRfou7Uo2/rJizYKbYszPlo9baZlu/0cZ1POd9JThS8k
 T9hessYJ25uotI0ZCYqEYELqV26hlsrVrHlTDdISyCRxV9ohge0rO3YvvGP1TxIAl/AG
 OR6UbFbZpOj8asCWh/ug0+Dh1bWWUy4l+FLjO+CAaj89qHYw98/C7Qjpn9b2VmpTOuo8
 V4qd1MXM/+8rmbBPKRdBWIbbpzUVSyBwujsUF9yAA3rkvequKn7LQwxnB3sYSfGdy9Dr
 lHJw==
X-Gm-Message-State: AOAM532CVqTPZtBI8o2oRX82BS+oTl9WthVolg+0gNR1RprS9rml/DsD
 lsyrM0nkoQcvtOTRGJqll6LqikEiHjDjPqUawe7RzEhLbQ2B9C8Nrg5SCktncPOXSaoHnV4nHDj
 5bNWvlrFd5uF7y3Y=
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr17874210wmy.15.1597735593836; 
 Tue, 18 Aug 2020 00:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkwRTYr7JGCrlC8WS5k2Xku8uuh7PgskxgmgNkEywqwejbfUCxzHnkizru4wQMaKpOxp7H/g==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr17874168wmy.15.1597735593538; 
 Tue, 18 Aug 2020 00:26:33 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t189sm33385299wmf.47.2020.08.18.00.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 00:26:32 -0700 (PDT)
Subject: Re: [PATCH v4 5/8] mips/cps: Use start-powered-off CPUState property
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-6-bauerman@linux.ibm.com>
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
Message-ID: <8c454fa8-12a6-0258-04e8-6f3c093eb333@redhat.com>
Date: Tue, 18 Aug 2020 09:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818033323.336912-6-bauerman@linux.ibm.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 5:33 AM, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
> start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
> 
> Also change creation of CPU object from cpu_create() to object_new() and
> qdev_realize() because cpu_create() realizes the CPU and it's not possible to
> set a property after the object is realized.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  hw/mips/cps.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 615e1a1ad2..be85357dc0 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -52,9 +52,6 @@ static void main_cpu_reset(void *opaque)
>      CPUState *cs = CPU(cpu);
>  
>      cpu_reset(cs);
> -
> -    /* All VPs are halted on reset. Leave powering up to CPC. */
> -    cs->halted = 1;
>  }
>  
>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
> @@ -76,7 +73,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>      bool saar_present = false;
>  
>      for (i = 0; i < s->num_vp; i++) {
> -        cpu = MIPS_CPU(cpu_create(s->cpu_type));
> +        Error *err = NULL;
> +
> +        cpu = MIPS_CPU(object_new(s->cpu_type));
>  
>          /* Init internal devices */
>          cpu_mips_irq_init_cpu(cpu);
> @@ -89,7 +88,16 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>              env->itc_tag = mips_itu_get_tag_region(&s->itu);
>              env->itu = &s->itu;
>          }
> +        /* All VPs are halted on reset. Leave powering up to CPC. */
> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
> +                                 &error_abort);
>          qemu_register_reset(main_cpu_reset, cpu);
> +
> +        if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
> +            error_report_err(err);
> +            object_unref(OBJECT(cpu));
> +            exit(EXIT_FAILURE);
> +        }

Here errp is available, so we can propagate the error to the caller:

           if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
               return;
           }

For example in hw/mips/boston.c:

    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_MIPS_CPS);
    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type,
                            &error_fatal);
    object_property_set_int(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
                            &error_fatal);
    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);

This will be propagated here ---------------^^^^^^^^^^^^^

>      }
>  
>      cpu = MIPS_CPU(first_cpu);
> 


