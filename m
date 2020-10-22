Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBEC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8CF22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo14QIUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8CF22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaH0-0005Lc-W4
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVaDQ-0003Bg-OE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVaDO-0000Tn-Qt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603371667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrFaqz8jmEXL4W/sAivTEW2aw+UAUFDNQ55k/lHbhxA=;
 b=Oo14QIUGxcQoS4h9R88EGr5k/N0fWZqtoy5bcE3ZdMnkj8iLJraSWXE1iyuc63aWiAa5PY
 lsuv67lXt7FsttoIBrrJPLiHShfihs7wumpO79+al/ypvElEQkcUtqdi2YlkdpCNEKeMjq
 PMYQ9d48A08mRRLQKLXWXRL8jHVX9Ns=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-oh0TgHyJPn-_8x4axUffjw-1; Thu, 22 Oct 2020 09:01:06 -0400
X-MC-Unique: oh0TgHyJPn-_8x4axUffjw-1
Received: by mail-wm1-f72.google.com with SMTP id r19so560067wmh.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KrFaqz8jmEXL4W/sAivTEW2aw+UAUFDNQ55k/lHbhxA=;
 b=iYWFtpPUZn+IEay+XB1JI4JGH1Uet3XOoSRazuCGnP87M42s6NR3kNt8Mc1gFSYat2
 4A5yhrHyMPfJaXm/iP6BcVhWpUtVHnXMO8ovH94zvEZETV/sdblSJksVurdCPF1lNYUe
 Geb7Hf5vsqI7UKymri++nCvTXU/oGpC6107wy1fgQNLL04lpIxD9dpI53tSUd+BRzuNa
 /K/fdW4H+molJcPhKI6/qHXJPKNLt6kjuN8XirQmsSlGW9CloLrcOg1b9tO8v/iq+5Xc
 fMkXfI+PYOEajh2fuITx1C48yDaljVXDA5bLTKQ195inGyOHM+QCnHoIDii7MmTJVQKd
 JVsQ==
X-Gm-Message-State: AOAM531jt4SXEzXkJtKPpfFj9FLTQaSOD2pxcuhxkxc6aWSKzaSWPuVu
 OmBRkIf+J/F0BfR+aaibo20KCxPLEBuVlL5bb/znsXb2u5tbRSWzSWksWDwwyRUxl/H0xIgLxyE
 LjojedLLCQ51QL18=
X-Received: by 2002:a7b:c350:: with SMTP id l16mr2542907wmj.135.1603371663225; 
 Thu, 22 Oct 2020 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuSbA9lAV9F7blpa/QyKqJZzhFTacs5D2/fRbWnbv0rfsVuv/z2A3utl73CGkfOwOzS33nxg==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr2542880wmj.135.1603371663005; 
 Thu, 22 Oct 2020 06:01:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n5sm3641052wrm.2.2020.10.22.06.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 06:01:02 -0700 (PDT)
Subject: Re: [PATCH] i386/cpu: Expose the PTWRITE to the guest
To: Luwei Kang <luwei.kang@intel.com>, rth@twiddle.net, ehabkost@redhat.com
References: <20201022040122.30086-1-luwei.kang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d21bf6c-a6b3-c0fe-d291-9661fa6436fb@redhat.com>
Date: Thu, 22 Oct 2020 15:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022040122.30086-1-luwei.kang@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 06:01, Luwei Kang wrote:
> PTWRITE provides a mechanism by which software can instrument the
> Intel PT trace. The current implementation will mask off this
> feature when the PTWRITE is supported on the host because of the
> Intel PT CPUID is a constant value(ICX CPUID) in qemu. This patch
> will expose the PTWRITE feature to the guest.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  target/i386/cpu.c | 24 ++++++++++++++++++++++++
>  target/i386/cpu.h |  4 ++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index aeabdd5bd4..242ba8a870 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -672,6 +672,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
>            /* missing:
>            CPUID_XSAVE_XSAVEC, CPUID_XSAVE_XSAVES */
> +#define TCG_14_0_EBX_FEATURES 0
>  #define TCG_14_0_ECX_FEATURES 0
>  
>  typedef enum FeatureWordType {
> @@ -1302,6 +1303,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          }
>      },
>  
> +    [FEAT_14_0_EBX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, NULL, NULL, NULL,
> +            "ptwrite", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = {
> +            .eax = 0x14,
> +            .needs_ecx = true, .ecx = 0,
> +            .reg = R_EBX,
> +        },
> +        .tcg_features = TCG_14_0_EBX_FEATURES,
> +    },
> +

Please add a dependency on the processor tracing flag too.

Paolo

>      [FEAT_14_0_ECX] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> @@ -5764,6 +5785,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *eax = INTEL_PT_MAX_SUBLEAF;
>              *ebx = INTEL_PT_MINIMAL_EBX;
>              *ecx = INTEL_PT_MINIMAL_ECX;
> +            if (env->features[FEAT_14_0_EBX] & CPUID_14_0_EBX_PTWRITE) {
> +                *ebx |= CPUID_14_0_EBX_PTWRITE;
> +            }
>              if (env->features[FEAT_14_0_ECX] & CPUID_14_0_ECX_LIP) {
>                  *ecx |= CPUID_14_0_ECX_LIP;
>              }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1fcd93e39a..9fffe6eb6f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -541,6 +541,7 @@ typedef enum FeatureWord {
>      FEAT_VMX_EPT_VPID_CAPS,
>      FEAT_VMX_BASIC,
>      FEAT_VMX_VMFUNC,
> +    FEAT_14_0_EBX,
>      FEAT_14_0_ECX,
>      FEATURE_WORDS,
>  } FeatureWord;
> @@ -798,6 +799,9 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>  /* AVX512 BFloat16 Instruction */
>  #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
>  
> +/* Intel PT support PTWRITE */
> +#define CPUID_14_0_EBX_PTWRITE          (1U << 4)
> +
>  /* Packets which contain IP payload have LIP values */
>  #define CPUID_14_0_ECX_LIP              (1U << 31)
>  
> 


