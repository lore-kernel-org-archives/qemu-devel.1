Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB34C43445
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2DE2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHNe0GWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2DE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k045k-0000Hz-EH
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k044x-0007le-Az
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:26:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k044t-0000RP-OA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595859966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f1nruIkH4Jxy3iYFtzV56x29iyq7meu8IAa80mcmG9U=;
 b=WHNe0GWLZZ8f5dVv082SAKrzIGIsu8FYpW4hB55UomEP0JDxF60dnDVniM8s8P7+/yv+Hn
 dwZlHeIYuZIH84VF/YKHy1B99eJhSNVtbOsC5L2EXdWfhlDVGzd8brShl+YBfL9gRB73mR
 +A33A02VbFnEEBSPF3HkqaLN+aCAmUk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-HfBQ8c4XOZiUTwcqah257g-1; Mon, 27 Jul 2020 10:26:04 -0400
X-MC-Unique: HfBQ8c4XOZiUTwcqah257g-1
Received: by mail-ed1-f69.google.com with SMTP id t9so4205493edw.22
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f1nruIkH4Jxy3iYFtzV56x29iyq7meu8IAa80mcmG9U=;
 b=qLYAtTK0t3Z+JjeTLaklBvkS5vvu7q8rLRHLJDcBMQoo0gKJfCPsEPxkbyhOcMqLF3
 KvjRanqzdn8LMog6ZSXBaQroEfqLU2YqxFjR8c32lnglXB7cJAK1fkPNLDFfreu1r8Mq
 Uot1MqCIP8V1gzpA0Cvask9mZ8l7EM9nWrfgNBawIVyiSBtmm/aRk8ssxandMxQa3Du7
 7IbUj7GXSrDDloJPdqaE1l5+xcB08Q0Br99+bhw1HmUdPLy84KKJ6UurjsArbeOLk8ZB
 StoKTCdacSZPKd7xDTxzDOqz17UETH6OEdVG8DNXPHqL4kAgEQXqU+kLsfo3eMFNWPYG
 8gtg==
X-Gm-Message-State: AOAM532B4JWJhQyNUFZ2T11beu3dwXynsnSJr0jUXqKpeycdtXtLWZLB
 uJYByzQCUk/DBVF0lTJqWBW5bCV2Tw4dV+TsghNgLGrFnZX+lUbjn300UXRPYYxf+0LWmyeZXBV
 9L76vdF0rMX0vEks=
X-Received: by 2002:aa7:c2c5:: with SMTP id m5mr21848568edp.214.1595859963494; 
 Mon, 27 Jul 2020 07:26:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDWgGpsFMchR6ZFZCZfU+cqnKvMRdof7Z3evMmiHu9CRMtY5tMZWINXENouaTTbny2Jds5Lw==
X-Received: by 2002:aa7:c2c5:: with SMTP id m5mr21848526edp.214.1595859963130; 
 Mon, 27 Jul 2020 07:26:03 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id a1sm7176764ejk.125.2020.07.27.07.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 07:26:02 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] ppc/spapr: Use start-powered-off CPUState property
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-4-bauerman@linux.ibm.com>
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
Message-ID: <1d97ef8a-13fc-201d-1fbd-263397a6021c@redhat.com>
Date: Mon, 27 Jul 2020 16:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723025657.644724-4-bauerman@linux.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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
> PowerPC sPAPR CPUs start in the halted state, and spapr_reset_vcpu()
> attempts to implement this by setting CPUState::halted to 1. But that's too
> late for the case of hotplugged CPUs in a machine configure with 2 or more
> threads per core.
> 
> By then, other parts of QEMU have already caused the vCPU to run in an
> unitialized state a couple of times. For example, ppc_cpu_reset() calls
> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
> kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
> start-cpu RTAS call to initialize its register state.
> 
> This problem doesn't seem to cause visible issues for regular guests, but
> on a secure guest running under the Ultravisor it does. The Ultravisor
> relies on being able to snoop on the start-cpu RTAS call to map vCPUs to
> guests, and this issue causes it to see a stray vCPU that doesn't belong to
> any guest.
> 
> Fix by setting the start-powered-off CPUState property in
> spapr_create_vcpu(), which makes cpu_common_reset() initialize
> CPUState::halted to 1 at an earlier moment.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  hw/ppc/spapr_cpu_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> NB: Tested on ppc64le pseries KVM guest with two threads per core. 
> Hot-plugging additional cores doesn't cause the bug described above
> anymore.
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c4f47dcc04..2125fdac34 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -36,11 +36,6 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>  
>      cpu_reset(cs);
>  
> -    /* All CPUs start halted.  CPU0 is unhalted from the machine level
> -     * reset code and the rest are explicitly started up by the guest
> -     * using an RTAS call */
> -    cs->halted = 1;
> -
>      env->spr[SPR_HIOR] = 0;
>  
>      lpcr = env->spr[SPR_LPCR];
> @@ -274,6 +269,11 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>  
>      cs = CPU(obj);
>      cpu = POWERPC_CPU(obj);
> +    /*
> +     * All CPUs start halted. CPU0 is unhalted from the machine level reset code
> +     * and the rest are explicitly started up by the guest using an RTAS call.
> +     */
> +    cs->start_powered_off = true;
>      cs->cpu_index = cc->core_id + i;
>      spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
>      if (local_err) {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


