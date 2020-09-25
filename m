Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9539C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303C6206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/dGJq1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303C6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvZM-00017v-6Q
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLvY6-0000F3-Oz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLvY3-00057r-Rq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:46:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601070393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFHV2p2T6W1zsI3twiSVhyKSedUXvxYEy3SFwozY6do=;
 b=e/dGJq1tYJCpkcjWa5lCZRe0JWaW7OHNQS2+OGraz+odKKbk3FsgD+R75j7qTQJ4u+PX5q
 oDuecD6FQjBElJJKOdI48JwKC0k/Cj90AXOtOPCDnVH0L9H0r6tkHSeea/AUu88Q9sqIc4
 PF9anSSwi27BggTxI8gHNiovdssMRKE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-mV-cWbuvNq2ICAAGaRBjrw-1; Fri, 25 Sep 2020 17:46:31 -0400
X-MC-Unique: mV-cWbuvNq2ICAAGaRBjrw-1
Received: by mail-wm1-f69.google.com with SMTP id b20so133220wmj.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 14:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tFHV2p2T6W1zsI3twiSVhyKSedUXvxYEy3SFwozY6do=;
 b=duOL2rBQrPW3VltC9WgUqQYmrhDHZLKmaNrgZAIHYy04fWyPR+167lym4mx0unpSiF
 FMIqwDbku8JCGFU7tRxgj53RSqNMXRzRLEJ0okz/ykfNwoymcf6cbJf+4hY20frZ5lsT
 I5hgj9E+luBZRgtv/CG17LisXKwpP7Kc5PPrDkaz3rDXFEFPvrDVEtgpsTZ6OpCim4jh
 4gjgg9g4prjWHSCEJ07tgBBcXZfeeHBJqZHBIOOvqd36CbkBzP2uiKjVsQMA07bxCHay
 bM66+z4omNXx1/otDuNaRjJhTqu4FLd5NTssh7nX2w0w4EWX5o957EDOPttOcQ6FqqFh
 sLSw==
X-Gm-Message-State: AOAM531N7jONnFsTD3jzVAKYQFjw6bSHD2IJ3vxfGADUsFRyVVLQ+oQ8
 hPxvVh2WR0t8tw8SbKuzRWbtldyCNwwz3+2Vw4ukHHuN63pPK23TaD/jrL5d9SQg2i8YJoqbO2Z
 mybOo/CaipOfx+yY=
X-Received: by 2002:a7b:c958:: with SMTP id i24mr615939wml.50.1601070389803;
 Fri, 25 Sep 2020 14:46:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGStkYX88H9h82oVfeCorCyovR+c65aeNMCo27SmSvpthFUp1DGUjbHbgG1sHteumUbKwmpQ==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr615923wml.50.1601070389535;
 Fri, 25 Sep 2020 14:46:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id a15sm4640958wrn.3.2020.09.25.14.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 14:46:28 -0700 (PDT)
Subject: Re: [PATCH] i386: Document when features can be added to
 kvm_default_props
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200925211021.4158567-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70cf3a0b-ddb8-129a-201f-ec583c3883d1@redhat.com>
Date: Fri, 25 Sep 2020 23:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925211021.4158567-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 23:10, Eduardo Habkost wrote:
> It's very easy to mistakenly extend kvm_default_props to include
> features that require a kernel version that's too recent.  Add a
> comment warning about that, pointing to the documentation file
> where the minimum kernel version for KVM is documented.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3ffd877dd51..c8558bb49ac 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4098,8 +4098,14 @@ static X86CPUDefinition builtin_x86_defs[] = {
>      },
>  };
>  
> -/* KVM-specific features that are automatically added/removed
> +/*
> + * KVM-specific features that are automatically added/removed
>   * from all CPU models when KVM is enabled.
> + *
> + * NOTE: features can be enabled by default only if they were
> + *       already available in the oldest kernel version supported
> + *       by the KVM accelerator (see "OS requirements" section at
> + *       docs/system/target-i386.rst)
>   */
>  static PropValue kvm_default_props[] = {
>      { "kvmclock", "on" },
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


