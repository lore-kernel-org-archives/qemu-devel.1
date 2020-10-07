Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABD5C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31B221D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MshUXTNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31B221D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5DS-00027J-0Z
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ5At-0008Pu-Mk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ5Ar-0003nk-Tp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602060709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1FUXLdUR9dxHOuPdjb92xujb1Kr3CLsubnTA4Shn5Q=;
 b=MshUXTNCwl6GlfAai9i/z2y3cBfIS2fYuiuT8CZJvsUgLYnXbzrWbxxJmbf/5yAPf2W9/8
 KogHsntvtmujKvVDmrFccBwRw5MxRiYN9Fp47LpVnPmDTRZ59T0km4I2Dhz4U9FqLnG4AT
 YQFp8BhadCW2bQ7EZY42l2HgRjez2zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-TRWgFJvoN8SNVcNeSetIzg-1; Wed, 07 Oct 2020 04:51:46 -0400
X-MC-Unique: TRWgFJvoN8SNVcNeSetIzg-1
Received: by mail-wm1-f70.google.com with SMTP id p17so281328wmi.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x1FUXLdUR9dxHOuPdjb92xujb1Kr3CLsubnTA4Shn5Q=;
 b=rEe1gahHCRMg1EG1UiUpj3qg13AxRdelAjRyQMMB431uovZv/1jkBYUXCXY06Hyzlk
 Dz17xiLAnBpIZEj3izUbH1DQXQYY7kO424VMRTSk58A9cB1q1HbGBxAARCXPXMjw0EjY
 KfUB9gHGMElctJgrOF7VdUh0pFgaEvziPfDDSCZcBd0GoVddWRLfdDwCzV+ZxmEpBHPs
 kn/ibc+ugOnSXfRusdbI0WwmFDwm32KxYecx3xFV6rSfCNt+8Gd/nbVOzeZtL70wN/Qr
 ULOZELYBzrsPmEjLC2lIaA67TRkNrjjuOONivLdasxOfJ/LHX/b+2L4OM+nzufoHEtie
 AVpQ==
X-Gm-Message-State: AOAM530JwJJ0WISypC0qApljfXMrKjgGD4OspEBiIvZf+eVngX9RmvAh
 VEQI+gqY0nnk4FxV29dfccu+MYZ1xHj9gzMX3oU3+YWY3wyoyfoyN0Jyt3fg6hBdvXxFlj6ImzY
 Ty617MoDkJiMKwrk=
X-Received: by 2002:a5d:548f:: with SMTP id h15mr2332973wrv.108.1602060704709; 
 Wed, 07 Oct 2020 01:51:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzswsax+C31xoWFziVfeBYDXgdZ5Vg0nETiylM/0ghfiBkOU/yXkD6ax6xGodL7yTfDaMdS4g==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr2332952wrv.108.1602060704488; 
 Wed, 07 Oct 2020 01:51:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id v8sm1764583wmb.20.2020.10.07.01.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:51:43 -0700 (PDT)
Subject: Re: [PATCH V13 2/9] meson.build: Re-enable KVM support for MIPS
To: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-3-git-send-email-chenhc@lemote.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6947e0d6-30c3-cf31-03ad-c57499e4ae35@redhat.com>
Date: Wed, 7 Oct 2020 10:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602059975-10115-3-git-send-email-chenhc@lemote.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 10:39, Huacai Chen wrote:
> After converting from configure to meson, KVM support is lost for MIPS,
> so re-enable it in meson.build.
> 
> Fixes: fdb75aeff7c212e1afaaa3a43 ("configure: remove target configuration")
> Fixes: 8a19980e3fc42239aae054bc9 ("configure: move accelerator logic to meson")
> Cc: aolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  meson.build | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 17c89c8..b407ff4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -59,6 +59,8 @@ elif cpu == 's390x'
>    kvm_targets = ['s390x-softmmu']
>  elif cpu in ['ppc', 'ppc64']
>    kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
> +elif cpu in ['mips', 'mips64']
> +  kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
>  else
>    kvm_targets = []
>  endif
> 

I'm queuing this one, sorry for the breakage. :(

Paolo


