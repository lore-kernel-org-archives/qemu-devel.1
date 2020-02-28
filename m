Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8DDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70B6246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhI3B+Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70B6246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dNk-0002NW-TR
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7dN4-0001tD-Q7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7dN3-0007si-J1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:59:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7dN3-0007rf-FA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582887592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwIMjCU+2zfimt6H8jJg5Qr0kzmow+224QZINRgNck8=;
 b=UhI3B+NfrsDwb3EYEE9BHYKp2W2l9yTpW9Ha13nWAU6BSMqgUGaXTVaBcjKFu+9W4NOoGk
 AdorY6Zlx4axTrPYyuzyAsccVmK5V3Pd1UiMjkwbD5Qnohofw52I0W7EfKofZ3tNDJkAJS
 G72KFMbnJVrmBI/nOcYd8Frz8whw7yw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-h5RQQtvTO3qgdWdN6LHSmQ-1; Fri, 28 Feb 2020 05:59:51 -0500
X-MC-Unique: h5RQQtvTO3qgdWdN6LHSmQ-1
Received: by mail-wm1-f70.google.com with SMTP id d129so1009057wmd.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SwIMjCU+2zfimt6H8jJg5Qr0kzmow+224QZINRgNck8=;
 b=fIfAFK40V+lqoiasWhl/IzTP6qmhCQWc1uC5yzXhXe1yilQX9qDsL5I6Xx65Fp58ZA
 hyM2mepsye7/s7whmPL/+rvWoKmXLpD/j1BmVkEFTvEzSB066gGWe4L8bJL9kunTEEYx
 8qkRBm+OhjimGnrW6+zT9kQVUp0nLeywUAPVCKTnoBsqzHhYaj5EIRGLXkRzxujU3v4O
 UBKtrTHfTjj+e0W5TuVB/B46l+KFsIG+YsGdAtZ4j+6Zx16k9q7/KaQoMzLewb89jKyO
 ind4/VW/cRdniGeqF5ZGqkbry+R3dHJXzcjVx9gLsrp1/dcIBtPD8b1JyKRP2Z7slWGo
 c+FQ==
X-Gm-Message-State: APjAAAXvbE2xmwpewnPJ8bMYxg1m8dsq6UemT0cCfUW7N6iT8AGJipFR
 5prci5MPAvJpLRNKdSkCALA3IOp9KNZNn5g6gTQ1+zUftzpGbUEAwXcaCjlcHE6ILeYI2k+SKZ/
 NwRRbcSm6RuVVfnI=
X-Received: by 2002:adf:f091:: with SMTP id n17mr4158625wro.387.1582887589815; 
 Fri, 28 Feb 2020 02:59:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGBNuibJAQ65LPCXe72XW6QZemVuhcD0VR+8ExC+VER5yozcBLpPDB5EccHrhySsehS5osSg==
X-Received: by 2002:adf:f091:: with SMTP id n17mr4158606wro.387.1582887589484; 
 Fri, 28 Feb 2020 02:59:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id t10sm11975840wru.59.2020.02.28.02.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:59:48 -0800 (PST)
Subject: Re: [PATCH] WHPX: Use QEMU values for trapped CPUID
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da8ebdd7-26e8-ee3d-39f6-5744e49abcc7@redhat.com>
Date: Fri, 28 Feb 2020 11:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/02/20 22:01, Sunil Muthuswamy wrote:
> Currently, WHPX is using some default values for the trapped CPUID
> functions. These were not in sync with the QEMU values because the
> CPUID values were never set with WHPX during VCPU initialization.
> Additionally, at the moment, WHPX doesn't support setting CPUID
> values in the hypervisor at runtime (i.e. after the partition has
> been setup). That is needed to be able to set the CPUID values in
> the hypervisor during VCPU init.
> Until that support comes, use the QEMU values for the trapped CPUIDs.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  target/i386/whpx-all.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 35601b8176..4fe5a78b29 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -980,38 +980,32 @@ static int whpx_vcpu_run(CPUState *cpu)
>              WHV_REGISTER_VALUE reg_values[5];
>              WHV_REGISTER_NAME reg_names[5];
>              UINT32 reg_count = 5;
> -            UINT64 rip, rax, rcx, rdx, rbx;
> +            UINT64 cpuid_fn, rip = 0, rax = 0, rcx = 0, rdx = 0, rbx = 0;
> +            X86CPU *x86_cpu = X86_CPU(cpu);
> +            CPUX86State *env = &x86_cpu->env;
>  
>              memset(reg_values, 0, sizeof(reg_values));
>  
>              rip = vcpu->exit_ctx.VpContext.Rip +
>                    vcpu->exit_ctx.VpContext.InstructionLength;
> -            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> -            case 1:
> -                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> -                /* Advertise that we are running on a hypervisor */
> -                rcx =
> -                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
> -                    CPUID_EXT_HYPERVISOR;
> -
> -                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> -                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> -                break;
> +            cpuid_fn = vcpu->exit_ctx.CpuidAccess.Rax;
> +
> +            /*
> +             * Ideally, these should be supplied to the hypervisor during VCPU
> +             * initialization and it should be able to satisfy this request.
> +             * But, currently, WHPX doesn't support setting CPUID values in the
> +             * hypervisor once the partition has been setup, which is too late
> +             * since VCPUs are realized later. For now, use the values from
> +             * QEMU to satisfy these requests, until WHPX adds support for
> +             * being able to set these values in the hypervisor at runtime.
> +             */
> +            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx,
> +                (UINT32 *)&rcx, (UINT32 *)&rdx);
> +            switch (cpuid_fn) {
>              case 0x80000001:
> -                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
>                  /* Remove any support of OSVW */
> -                rcx =
> -                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
> -                    ~CPUID_EXT3_OSVW;
> -
> -                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> -                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> +                rcx &= ~CPUID_EXT3_OSVW;
>                  break;
> -            default:
> -                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> -                rcx = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> -                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> -                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
>              }
>  
>              reg_names[0] = WHvX64RegisterRip;
> 

Queued if you need that, thanks.

Paolo


