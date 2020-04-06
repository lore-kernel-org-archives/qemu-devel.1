Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9457EC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4B32063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPt89h1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4B32063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOen-0002zH-Ih
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLOYG-0001Np-RO
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLOYF-0000kz-H8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:00:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLOYF-0000jx-8P
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586167218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvZGsl+mfC1vIV6x/TThSRiCchmIwWwO4IGLtbW1u9c=;
 b=VPt89h1vd57Jj3HPqxDVkDkrTPhyx0xA1/P+VDtxa6dz9j5uf36kb4xPvpkjRQYi8wZPtY
 4xYZDlYsSpgkxbk5WXuZW5lufQaiipWNmDjubs2xU2izOnHbZR6825TDuQ044meGJPFOZJ
 UUT/6mOHDOvf9SdCncVnV7tXFoaVKj0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-1gpv6-u7OMC3tU0vstTiYA-1; Mon, 06 Apr 2020 06:00:17 -0400
X-MC-Unique: 1gpv6-u7OMC3tU0vstTiYA-1
Received: by mail-wr1-f69.google.com with SMTP id 88so5454020wrq.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lvZGsl+mfC1vIV6x/TThSRiCchmIwWwO4IGLtbW1u9c=;
 b=Dd5sU4OGNU+DoHu0NX9mmh2R2OQNQTD2mMXFmL1cZQcKumwQ6+78ipNRZkcJV2Oqg+
 8Sv0VdLVZAfmUAJkrxnLabproPswTLabU5nhzkkKkExk/HTLQ/9t0qLjDfkBeCuRsjFN
 7xl7iBvcp6ClhkG+VLPoMXYSqB8EqtPdvXTZX6IdQdT5kUp1/PChh7FlvU6yV+VoVquT
 uGqUtjA7vDr9hlkbczWXczViluJ/mn6FgftJB2WKJwM3YzZnDXp8H965DpomU3L66mzD
 FIuwuqUVX0k2RT6cbY6YAvxJCo2lZIkUpQ4N5PVisYsx0vkcGDwGyHYo3aJ1UD4NnWA+
 6gQQ==
X-Gm-Message-State: AGi0PuZKiQLSfxeaty7yKOi9RwuE5RUwJrWdorxjB4HTE1N0KFHjM6ha
 nIP7f0QyN3shtNbLPYeoYa/uuPTdzxt/J4JNTimKbY8Qi6c0udN9PdR9mgBowvx0BOfajGutX5I
 1nmnUpkY5Crq6sck=
X-Received: by 2002:a5d:4988:: with SMTP id r8mr3888181wrq.248.1586167215612; 
 Mon, 06 Apr 2020 03:00:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypKayENzJE7tRful42VTyax8Gs4EKSQcIgxcjYCeQjJKVT0YS+/27QY5Racjd1dkct4flzcBgA==
X-Received: by 2002:a5d:4988:: with SMTP id r8mr3888157wrq.248.1586167215325; 
 Mon, 06 Apr 2020 03:00:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id k9sm8085997wrn.89.2020.04.06.03.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 03:00:14 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] hvf: Support AVX512 guests on capable hardware
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <cover.1585607927.git.dirty@apple.com>
 <1da0fc0a4f119e951ae11b29ff26ee587f4748aa.1585607927.git.dirty@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9d908a5-c0ee-fba6-4763-e1542a114637@redhat.com>
Date: Mon, 6 Apr 2020 12:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1da0fc0a4f119e951ae11b29ff26ee587f4748aa.1585607927.git.dirty@apple.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: r.bolshakov@yadro.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/03/20 02:16, Cameron Esfahani wrote:
> @@ -458,7 +459,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
>      macvm_set_cr0(cpu->hvf_fd, CR0_CD_MASK | CR0_NW_MASK | CR0_ET_MASK);
>      macvm_set_cr0(cpu->hvf_fd, 0x60000010);
>  
> -    wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
> +    wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK | CR4_OSXSAVE_MASK);
>      wvmcs(cpu->hvf_fd, VMCS_CR4_SHADOW, 0x0);
>      wvmcs(cpu->hvf_fd, VMCS_GUEST_CR4, CR4_VMXE_MASK);
>  
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 1a1b150c97..dccd5ceb0f 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -157,13 +157,20 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>      hv_vcpu_flush(vcpu);
>  }
>  
> -static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
> +static inline void macvm_set_cr4(CPUX86State *env, hv_vcpuid_t vcpu,
> +                                 uint64_t cr4)
>  {
>      uint64_t guest_cr4 = cr4 | CR4_VMXE_MASK;

I think you need to add the host CR4.OSXSAVE bit here too?  (You can
read it from CPUID).

>      wvmcs(vcpu, VMCS_GUEST_CR4, guest_cr4);
>      wvmcs(vcpu, VMCS_CR4_SHADOW, cr4);
>  
> +    /*
> +     * Track whether OSXSAVE is enabled so we can properly return it
> +     * for CPUID 1.
> +     */
> +    env->osxsave_enabled = ((cr4 & CR4_OSXSAVE_MASK) != 0);

This new variable doesn't seem necessary.  Instead you can just set
env->cr[4] here, and everything should work fine.

Paolo


