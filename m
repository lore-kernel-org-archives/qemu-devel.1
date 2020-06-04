Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49F4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D313206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2STnMDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D313206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjiZ-0003Ej-RT
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjfb-0007XQ-Fi
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:48:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjfa-0001Vu-Fv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591253285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mo8vRnVpvyrzXL3ppxByau5If54VpLWTECZ2cQnoX9A=;
 b=F2STnMDuFauVuBWDfPFDOrQShtLxbtc/vXf9LAE4GYetY81AjQuD68a6f6HZz9RH836xQR
 bh+Qaen+TdzozEuixtyVxZ5WRp2OynbeOP82UF2s9sjaKzORClqRDTlO27Tpn6j8o8MQdb
 TW4zVRdYQFKnkQGZbehg6wobzDTiMWE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-FEEongpwPFqidMNELGDrxg-1; Thu, 04 Jun 2020 02:48:03 -0400
X-MC-Unique: FEEongpwPFqidMNELGDrxg-1
Received: by mail-wr1-f71.google.com with SMTP id f4so2006990wrp.21
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 23:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Mo8vRnVpvyrzXL3ppxByau5If54VpLWTECZ2cQnoX9A=;
 b=bCucbBfxxY/NwjKodBLsWIt4UMeDHyszehaa+AFPnc0bTAHDtSe98oGB19x2Qqn6Sm
 o93LpHAgxWBlsjsTwAsXO5Wp8u0qfh0UeZd4uWVbgT0gHtjvPfJ7VMBr9xlwKrYtOYtH
 TtuXuKb6KzzjhxF5pi45Muy/T4cTF3AkatUxFlqxutzbP2GpYakXtjkEdSxm5JPyF7jz
 jWmkqqg3rr52WESc25GwlShTcTnRY5Qm1LyDyfDCME018npU5kA5boytuTGOv0+kJLjP
 sbt+lHvgTZ65oEdNJfPn9cI8Ar0mPXeCKXy4eH/NHTTr34ZuCWUyJSyVUEMUlLfthX+0
 PJzg==
X-Gm-Message-State: AOAM531HK50ZvgDvxpXGWADHLOvuSLZA8NDRiuhsXDPugs29rnaBx5eD
 WPLTfHyshpR73v3yGPJ0Ybz5Rd35AZMsE0GxI0h+lJ+4NXBt3ASu6Xjd4BrNm3qNWTVXfLjSNk7
 gImnKYiOFmNdaYNg=
X-Received: by 2002:a1c:154:: with SMTP id 81mr2477402wmb.23.1591253282548;
 Wed, 03 Jun 2020 23:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWc+sKUkZu4AhYSCwSJGfLHoA0F427dpBfY3GigSmZwnSkwvPhDihoMJw/Q3AisE1u48TbHw==
X-Received: by 2002:a1c:154:: with SMTP id 81mr2477380wmb.23.1591253282270;
 Wed, 03 Jun 2020 23:48:02 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j190sm5930056wmb.33.2020.06.03.23.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:48:01 -0700 (PDT)
Subject: Re: [PATCH 06/13] i386: hvf: Use IP from CPUX86State
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-7-r.bolshakov@yadro.com>
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
Message-ID: <a2911f10-b199-5c9b-c704-4e5457afd1bb@redhat.com>
Date: Thu, 4 Jun 2020 08:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-7-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> Drop and replace rip field from HVFX86EmulatorState in favor of eip from
> common CPUX86State.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  target/i386/hvf/hvf.c        |  6 +--
>  target/i386/hvf/x86.h        |  3 --
>  target/i386/hvf/x86_decode.c |  6 +--
>  target/i386/hvf/x86_emu.c    | 86 ++++++++++++++++++------------------
>  target/i386/hvf/x86_task.c   |  4 +-
>  5 files changed, 51 insertions(+), 54 deletions(-)
> 
[...]
> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
> index 56fcde13c6..e3ab7c5137 100644
> --- a/target/i386/hvf/x86.h
> +++ b/target/i386/hvf/x86.h
> @@ -294,7 +294,6 @@ typedef struct lazy_flags {
>  /* Definition of hvf_x86_state is here */
>  struct HVFX86EmulatorState {
>      uint64_t fetch_rip;
> -    uint64_t rip;
>      struct x86_register regs[16];
>      struct x86_reg_flags   rflags;
>      struct lazy_flags   lflags;
> @@ -302,8 +301,6 @@ struct HVFX86EmulatorState {
>  };
>  
>  /* useful register access  macros */
> -#define RIP(cpu)    (cpu->hvf_emul->rip)
> -#define EIP(cpu)    ((uint32_t)cpu->hvf_emul->rip)
>  #define RFLAGS(cpu) (cpu->hvf_emul->rflags.rflags)
>  #define EFLAGS(cpu) (cpu->hvf_emul->rflags.eflags)
>  
[...]
> diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
> index 1daac6cc2b..834baec3ea 100644
> --- a/target/i386/hvf/x86_task.c
> +++ b/target/i386/hvf/x86_task.c
> @@ -38,7 +38,7 @@ static void save_state_to_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
>      CPUX86State *env = &x86_cpu->env;
>  
>      /* CR3 and ldt selector are not saved intentionally */
> -    tss->eip = EIP(env);
> +    tss->eip = (uint32_t)env->eip;
>      tss->eflags = EFLAGS(env);
>      tss->eax = EAX(env);
>      tss->ecx = ECX(env);
> @@ -64,7 +64,7 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
>  
>      wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, tss->cr3);
>  
> -    RIP(env) = tss->eip;
> +    env->eip = tss->eip;
>      EFLAGS(env) = tss->eflags | 2;
>  
>      /* General purpose registers */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


