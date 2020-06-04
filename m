Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2542074B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0tgrsyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2542074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjVm-0002Be-5P
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjTX-0008Vs-J4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:35:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjTW-0007nu-HU
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591252537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XklSV+nmd5DLMd7t8m3AMKlfwxpTiA8L0IB/guLABUY=;
 b=W0tgrsyrpDOQLwyWdw5/Gc0kc7DbezWUqC/E16blvotmh+Ifcr+Ad98Cjii28+IkU/TD91
 yFpNnagMBw1jG3MO47hTXodxMSUyyoAzCvBOKddHbuEgrmRbAtyQO+Q9GiyJ2zKH7kStpF
 +FmNSBGXgso/YtPNsjLnVWF8tTPcXZ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-HRkobcRaO6yzklzk_4IseQ-1; Thu, 04 Jun 2020 02:35:35 -0400
X-MC-Unique: HRkobcRaO6yzklzk_4IseQ-1
Received: by mail-wm1-f72.google.com with SMTP id h25so2439565wmb.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 23:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XklSV+nmd5DLMd7t8m3AMKlfwxpTiA8L0IB/guLABUY=;
 b=E4RjpifpAJ5P7tTKdScKCQod6sJFEfUpqWNT9qGUbyTyEyGGgVQ6gfrtX/u66Zipfa
 0VxxRQLB8v7LQBgZ7Q/wJXmC4j1Ol3uIFRQS/y+aScgT3jEhSl7mTgHO0u+6/UwAfUwS
 SKRpivGoBMY+eD60FbYoNi+qcfBaUDWkmHeNg2A7wHfc0sDOc8RKsyRN/ih0ygkGwkzH
 EUU/E2bzJjUr5Nk1fALwHnb4LhU/vWktvwpMfqV0aqSFn6DhOn87buLJ9dzrdGzCyIbe
 vx5rdcjbMcUIuA/DYk2CR+36/izzSvmkoZI6Gor1MmUlcUu74TPqxsCqFxqVdLNULQ13
 bxPw==
X-Gm-Message-State: AOAM532+EZAYq0DELpEPVLxTsecEx5sf7TwBDQsn/0Expt4cKcB5pDli
 PyfBjTltIRCx+K7I8v76CYbxgfuXLO7xfP7xeJSbp/MZSilwMYKcC3h8I6oKBCVkiRbB5xK8heS
 KgQbwK7W+o6Q2i+0=
X-Received: by 2002:adf:f611:: with SMTP id t17mr2703975wrp.69.1591252534604; 
 Wed, 03 Jun 2020 23:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgOpxgwbwXpABIZ/sVZu+YNP211WTOKL/Nm73DiDUfE+bp9WGV2D4tRXerUSQBt2z/XG3FqQ==
X-Received: by 2002:adf:f611:: with SMTP id t17mr2703954wrp.69.1591252534380; 
 Wed, 03 Jun 2020 23:35:34 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z25sm5802826wmf.10.2020.06.03.23.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:35:33 -0700 (PDT)
Subject: Re: [PATCH 02/13] i386: hvf: Drop useless declarations in sysemu
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-3-r.bolshakov@yadro.com>
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
Message-ID: <310fad46-9ea2-9241-e345-f9aca4875261@redhat.com>
Date: Thu, 4 Jun 2020 08:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-3-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 9:37 PM, Roman Bolshakov wrote:
> They're either declared elsewhere or have no use.
> 
> While at it, rename _hvf_cpu_synchronize_post_init() to
> do_hvf_cpu_synchronize_post_init().
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  include/sysemu/hvf.h  | 22 ----------------------
>  target/i386/hvf/hvf.c |  7 ++++---
>  2 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 30a565ab73..03f3cd7db3 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -30,35 +30,13 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>  #define hvf_get_supported_cpuid(func, idx, reg) 0
>  #endif
>  
> -/* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
> - * the host CPU. Use hvf_enabled() after this to get the result. */
> -void hvf_disable(int disable);
> -
> -/* Returns non-0 if the host CPU supports the VMX "unrestricted guest" feature
> - * which allows the virtual CPU to directly run in "real mode". If true, this
> - * allows QEMU to run several vCPU threads in parallel (see cpus.c). Otherwise,
> - * only a a single TCG thread can run, and it will call HVF to run the current
> - * instructions, except in case of "real mode" (paging disabled, typically at
> - * boot time), or MMIO operations. */
> -
> -int hvf_sync_vcpus(void);
> -
>  int hvf_init_vcpu(CPUState *);
>  int hvf_vcpu_exec(CPUState *);
> -int hvf_smp_cpu_exec(CPUState *);
>  void hvf_cpu_synchronize_state(CPUState *);
>  void hvf_cpu_synchronize_post_reset(CPUState *);
>  void hvf_cpu_synchronize_post_init(CPUState *);
> -void _hvf_cpu_synchronize_post_init(CPUState *, run_on_cpu_data);
> -
>  void hvf_vcpu_destroy(CPUState *);
> -void hvf_raise_event(CPUState *);
> -/* void hvf_reset_vcpu_state(void *opaque); */
>  void hvf_reset_vcpu(CPUState *);
> -void vmx_update_tpr(CPUState *);
> -void update_apic_tpr(CPUState *);
> -int hvf_put_registers(CPUState *);
> -void vmx_clear_int_window_exiting(CPUState *cpu);
>  
>  #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>  
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index d72543dc31..9ccdb7e7c7 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -251,7 +251,7 @@ void vmx_update_tpr(CPUState *cpu)
>      }
>  }
>  
> -void update_apic_tpr(CPUState *cpu)
> +static void update_apic_tpr(CPUState *cpu)
>  {
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      int tpr = rreg(cpu->hvf_fd, HV_X86_TPR) >> 4;
> @@ -312,7 +312,8 @@ void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
>      run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
>  }
>  
> -void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
> +static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
> +                                             run_on_cpu_data arg)
>  {
>      CPUState *cpu_state = cpu;
>      hvf_put_registers(cpu_state);
> @@ -321,7 +322,7 @@ void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
>  
>  void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
>  {
> -    run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
> +    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>  }
>  
>  static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


