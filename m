Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C588C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CD520658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diuq8vuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CD520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmLv-0007M6-Fe
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDlJc-000091-2L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDlJa-0003S6-UM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:41:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDlJa-0003GW-N6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584348098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vrxrm2nFPNOwJmJYXjlr6oyRPLOz9tW4pgWwronWOw=;
 b=diuq8vuDkA+3uisqPwJZxojSf+aWSnmHcfI5ZfMt7GxakmRF2ccsr/y7HVyBwE80d31UIG
 UCe+nQ3j5WfjBz+Q3vbeI65D9Aw0WcJmAXee1mWn2iQh1RxIAFpPJPSde5ZX7B/Do142Hk
 812BgOTofXv2LtyNYbTvhvUiQY051eQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-5dfYYT_BOd-lZjR7HbPGXA-1; Mon, 16 Mar 2020 04:41:36 -0400
X-MC-Unique: 5dfYYT_BOd-lZjR7HbPGXA-1
Received: by mail-wm1-f70.google.com with SMTP id s20so4670273wmj.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9vrxrm2nFPNOwJmJYXjlr6oyRPLOz9tW4pgWwronWOw=;
 b=rttsuUu8wpU3f9LtERWlBMKABAEGQI69QAYkl5uHmh+Rf9tbF1OUKVuu4k/Sth03at
 VP14O5ZUnIBy6Fbq/ggLClLyKkmW8zONuoL8ufkrwjIRRz3oYLD3ZLUxqR+lAvLjGYh9
 BIQGsBwhcbDnMymaS+6ogqJW3YyO2nBKtaIlloaUpjTaOuy8NiVTsjzj9HJQJ8wzNdaf
 eiQ5kA9hVr8cNwCI8m38j39fssFPVv+Iynepo3BVSKh/73WtrPuC2klg8u1upZgw6QWy
 rAIPI1nUAJdAs23tmbC09rqCTuPrKmkGoGOPsxVZdmMCkYMZhb8XLqdBixfVZZSJEQ3g
 950w==
X-Gm-Message-State: ANhLgQ0VPPLswOp59+6rwFeygsOyzvqtPgopzK1p/3t5LgwVq8/owBbw
 ylnxYs2mrhsNKq7/jagWODwKSx45LnLCmQy6wdzdGmJCeLp7SqRnE72jd1spiI865W0MyIp/022
 UN+O22KmtgjdIDGw=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr30481342wrs.96.1584348095169; 
 Mon, 16 Mar 2020 01:41:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu9nulhvqDZLtePWNRMmDXhEG7ZpUhoV3LFr7A6ePsf33BcvPsTpxJTBT0Z8qWCPTAgLJfFMQ==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr30481322wrs.96.1584348094925; 
 Mon, 16 Mar 2020 01:41:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id x17sm54970176wrt.31.2020.03.16.01.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:41:34 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
To: Xiaoyao Li <xiaoyao.li@intel.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200316053314.194936-1-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e90ff880-c395-9013-6855-eaa4be7969be@redhat.com>
Date: Mon, 16 Mar 2020 09:41:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316053314.194936-1-xiaoyao.li@intel.com>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 06:33, Xiaoyao Li wrote:
> Current Icelake-Server CPU model lacks all the features enumerated by
> MSR_IA32_ARCH_CAPABILITIES.
> 
> Add them, so that guest of "Icelake-Server" can see all of them.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 92fafa265914..5f09d114e1c2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3425,7 +3425,12 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>              CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
>          .features[FEAT_7_0_EDX] =
> -            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
> +            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +        .features[FEAT_ARCH_CAPABILITIES] =
> +            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
> +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
>          /* Missing: XSAVES (not supported by some Linux versions,
>                  * including v4.1 to v4.12).
>                  * KVM doesn't yet expose any XSAVES state save component,
> 

Hi Xiaoyao,

you need to add them as a new version of the CPU model.

Paolo


