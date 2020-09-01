Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8D6207EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdpLUKPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8D6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3C1-00039m-03
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD30M-0004gk-11
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD30K-0003hn-3m
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598954103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ge0H5ZBrf27oPyk+7JrfmbQuYls4XE7mP+afTEUCt6w=;
 b=BdpLUKPVxCw5HEo10IFVhD9Q1zO6z/75puOR2UepLcbZupEuCpvWrfWFL8LS0mflWTaJET
 6ogogXGCWMVNyzJqU3CxA3tOKo5WLFGWcZY5uiigsVzdevZhmM1Pj2xC8Y9cabGtO72FwA
 4bwqc2KukgALYw32bcqZjcV1cRa2Kac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-FnZpdwCsMRmCJhToIVS5ZA-1; Tue, 01 Sep 2020 05:55:01 -0400
X-MC-Unique: FnZpdwCsMRmCJhToIVS5ZA-1
Received: by mail-wr1-f71.google.com with SMTP id l15so362829wro.10
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ge0H5ZBrf27oPyk+7JrfmbQuYls4XE7mP+afTEUCt6w=;
 b=p0Y/+ZM9llZS8AJKN1FN2SAm9FfkC6Z48HqUaP3VwcwkP+W7rx1VL/zjjqrUsZ9QCA
 yxUeUHFsLcsarNEQqe/+mtD+eBPMZTHrphfmCcP69MebIYJ/OKZ6SDZ8bUwYfLJhJI55
 mQo3gFsIctX6vRZTGezga2vsCwxl+kwGz1WgCbsLwf2teLsQymPgpuzi0RTInm1l8Tdt
 04G53P9bvmLyC3Sh+BYU3G2/NhzC743kTXatR+WRQQcRQ9pqtyrOmU1+U7mcrtRTxK1I
 ECdYGr+FWQEi0xIcRr6fwfOknSL3t685+XzteRfbN9iXBCGXKn4P9+uTIsFgCi8JFJwE
 +qMA==
X-Gm-Message-State: AOAM5331ydGKPpeHY1dGCZtBKtT2hrks6TnWawz3RrqrQYnE+w1OKONK
 JvXZBDK5aEal5PNq2gk5TT6/EwK/Y1Cwd5p+i+zq0gtpDAIGg797zxPTJIjQH0PTfRUSShph+bn
 H+0vou3dwH/hCoq4=
X-Received: by 2002:a5d:4811:: with SMTP id l17mr1043108wrq.252.1598954100613; 
 Tue, 01 Sep 2020 02:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbUKDo8WuUquLYgqmnRPeU3WHmskc+i1Q25C0HqTXAgoLZAlEhoDZJYPmO7sPVRnzEKTF9IA==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr1043095wrq.252.1598954100434; 
 Tue, 01 Sep 2020 02:55:00 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l10sm1487594wru.59.2020.09.01.02.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:54:59 -0700 (PDT)
Subject: Re: [PATCH v7 7/8] sparc/sun4m: Use start-powered-off CPUState
 property
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200826055535.951207-1-bauerman@linux.ibm.com>
 <20200826055535.951207-8-bauerman@linux.ibm.com>
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
Message-ID: <0f5fc8af-081a-3d2f-83a8-88303fe4e3d0@redhat.com>
Date: Tue, 1 Sep 2020 11:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826055535.951207-8-bauerman@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/20 7:55 AM, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in secondary_cpu_reset(), use the
> start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
> 
> Now secondary_cpu_reset() becomes equivalent to main_cpu_reset() so rename
> the function to sun4m_cpu_reset().
> 
> Also remove setting of cs->halted from cpu_devinit(), which seems out of
> place when compared to similar code in other architectures (e.g.,
> ppce500_init() in hw/ppc/e500.c).
> 
> Finally, change creation of CPU object from cpu_create() to object_new()
> and qdev_realize_and_unref() because cpu_create() realizes the CPU and it's
> not possible to set a property after the object is realized.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  hw/sparc/sun4m.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 7484aa4438..6bf9d27d8a 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -218,7 +218,7 @@ static void dummy_cpu_set_irq(void *opaque, int irq, int level)
>  {
>  }
>  
> -static void main_cpu_reset(void *opaque)
> +static void sun4m_cpu_reset(void *opaque)
>  {
>      SPARCCPU *cpu = opaque;
>      CPUState *cs = CPU(cpu);
> @@ -226,15 +226,6 @@ static void main_cpu_reset(void *opaque)
>      cpu_reset(cs);
>  }
>  
> -static void secondary_cpu_reset(void *opaque)
> -{
> -    SPARCCPU *cpu = opaque;
> -    CPUState *cs = CPU(cpu);
> -
> -    cpu_reset(cs);
> -    cs->halted = 1;
> -}
> -
>  static void cpu_halt_signal(void *opaque, int irq, int level)
>  {
>      if (level && current_cpu) {
> @@ -818,21 +809,17 @@ static const TypeInfo ram_info = {
>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>  {
> -    CPUState *cs;
>      SPARCCPU *cpu;
>      CPUSPARCState *env;
>  
> -    cpu = SPARC_CPU(cpu_create(cpu_type));
> +    cpu = SPARC_CPU(object_new(cpu_type));
>      env = &cpu->env;
>  
>      cpu_sparc_set_id(env, id);
> -    if (id == 0) {
> -        qemu_register_reset(main_cpu_reset, cpu);
> -    } else {
> -        qemu_register_reset(secondary_cpu_reset, cpu);
> -        cs = CPU(cpu);
> -        cs->halted = 1;
> -    }
> +    qemu_register_reset(sun4m_cpu_reset, cpu);
> +    object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
> +                             &error_fatal);
> +    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);

It is cleaner to call qemu_register_reset() after realize().

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
>      env->prom_addr = prom_addr;
>  }
> 


