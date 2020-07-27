Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD47C43446
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE69420825
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpaTwtn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE69420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03vV-0001Fa-4o
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k03uf-0008Nl-LF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:15:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k03uc-0007F5-MT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595859329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hvaGpv0VQMlEk7R7m7Nsyhs/O10vHvxs6gfdYnzr7zM=;
 b=PpaTwtn+FF+V2o1Y8O3BNG3Bm5C9tP/WeZbnqFAZhUZkiUfosRilKJDrU3yRbGLVcHpeLQ
 aouf9rhDOv0mWCr7Kk2sCbqFZ9QN5vKCVF02EsrFJi7e/VhlCDmfQXdTtoJsBYTu/LWPfb
 7aGn1ISd4e51+rSJnEC4A1VnTxYELEU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-iUKzV5VuO5Czl0nl5xYQvQ-1; Mon, 27 Jul 2020 10:15:27 -0400
X-MC-Unique: iUKzV5VuO5Czl0nl5xYQvQ-1
Received: by mail-ej1-f72.google.com with SMTP id gv21so6065085ejb.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hvaGpv0VQMlEk7R7m7Nsyhs/O10vHvxs6gfdYnzr7zM=;
 b=XI91/it/KR3EE0kYKl3Dpbxp40XS6qDhaBs4igPZkhRjzykk6oGNbTlYWHLx/MrPX8
 9Lukq7qpH+oorSzzzrc/6tZlpyrgtR1v7x+dfxTc0E8o26vCHTwPJf9Emq9gERGimFlO
 +XJwe3dC45bHQxaLFWsLF0JuaqMqlVxjtrIxvV6e4fCTjnINXu7/hzUVbSFcWtENBa0q
 +PIp0lfGKHI7feZ9MR9VmCRtlsqqhhyG0NUIvQ6GAkrEv33SVdKnckL8OoKI46zEsDcA
 VM5YDLs1a/R55rHQVn78A/Sf2si0IZrXcFiAJCZrknstrBpL38Xrf6TFcMEP5v7PhJx/
 i83Q==
X-Gm-Message-State: AOAM532f3YBDK6koQ9/u/f/hiPPC7elU6vAJug4iUkXQc6eiX02qY5pL
 8HjjCoxlmzM0GcNjwEvOQRMe/9IIJ851clKYOjUL3e+BXjUI2FA0EkmXFq60b0E1qsXqYBj7jZB
 2UONKHdfkPwZMWEU=
X-Received: by 2002:a17:906:178b:: with SMTP id
 t11mr20587018eje.489.1595859326659; 
 Mon, 27 Jul 2020 07:15:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFYQ7kG01I4nNYOcGU8Aq3R8C0ZZqEKScLNxcwI1R9UobpDxePwVTa2l62YG5KGo5Zzh2Jtw==
X-Received: by 2002:a17:906:178b:: with SMTP id
 t11mr20586983eje.489.1595859326382; 
 Mon, 27 Jul 2020 07:15:26 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id o15sm7629392edv.55.2020.07.27.07.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 07:15:25 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] sparc/sun4m: Use start-powered-off CPUState
 property
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-8-bauerman@linux.ibm.com>
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
Message-ID: <d56ebc7f-815e-73f2-9cb5-6ff16e2c9a2e@redhat.com>
Date: Mon, 27 Jul 2020 16:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723025657.644724-8-bauerman@linux.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/23/20 4:56 AM, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in secondary_cpu_reset(), use the
> start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
> 
> This makes secondary_cpu_reset() unnecessary, so remove it.
> 
> Also remove setting of cs->halted from cpu_devinit(), which seems out of
> place when compared to similar code in other architectures (e.g.,
> ppce500_init() in hw/ppc/e500.c).
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  hw/sparc/sun4m.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index f1d92df781..fd74e516bb 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -218,15 +218,6 @@ static void dummy_cpu_set_irq(void *opaque, int irq, int level)
>  {
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
> @@ -810,7 +801,6 @@ static const TypeInfo ram_info = {
>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>  {
> -    CPUState *cs;
>      SPARCCPU *cpu;
>      CPUSPARCState *env;
>  
> @@ -818,11 +808,8 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
>      env = &cpu->env;
>  
>      cpu_sparc_set_id(env, id);
> -    if (id != 0) {
> -        qemu_register_reset(secondary_cpu_reset, cpu);
> -        cs = CPU(cpu);
> -        cs->halted = 1;
> -    }
> +    object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
> +                             &error_abort);
>      *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
>      env->prom_addr = prom_addr;
>  }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


