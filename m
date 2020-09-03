Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACDDC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D7E20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQfKtTVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D7E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmeD-0004ve-0g
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDmct-0003x7-Vn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:37:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDmcs-0001fh-1g
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599129473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ/VRi9Gy4NRzkx8HSdrdNRBpsIvoFNQlOoPJC2TGXQ=;
 b=LQfKtTVNifex1E7t+htroHOrDqM4/M1ebnrY1gSvWrPidI1eSmcm5bI5zUezRGR702C/Qn
 edQK6Y+BZMB2fTWkNCBJWbVgTUAxnHjDQSOIUh5VhTpqPAbt3YXL0vfZGWRniP/nDSXwe2
 nIjpYPQPsUowERE51oe2evL5KPTbd2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-F4jnm32sNMW1v878m9Qltg-1; Thu, 03 Sep 2020 06:37:50 -0400
X-MC-Unique: F4jnm32sNMW1v878m9Qltg-1
Received: by mail-wm1-f70.google.com with SMTP id k12so2277962wmj.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PJ/VRi9Gy4NRzkx8HSdrdNRBpsIvoFNQlOoPJC2TGXQ=;
 b=ix88o+7rlSNnDmszm0NQ4DJ2Pd7RRvkzaofmZhUN5Cf7J7xVuspvth9qQr2heEsbeW
 bvGAh9D83/sR/09VCJDNQXfGEu9RJ33ozllCjjw8NtsGS5EduG8ZkAyQ8xRBkdyZwvbs
 EI+e2nIOE0ShVo0ERM3bt2eZdZ56/0He1CxR3rRJT2vhq0ZkHBoriPi4M7c0vhSKcyoJ
 6E69o+wLFPuUEUdKJR6WH2lSgZoR6IZPJIFh0Wco9M62W66GLFaayIEaixkLXR9QAngJ
 W4Dw8ryy0apHxvlJC0jDQzXKA17EA4x1alfNV9gLbZJfEteH4Vla0dDkjjcOR26os9Rs
 AQDQ==
X-Gm-Message-State: AOAM530L18NP1HuGMPyGEkxwWziPz/r0IVuVCKlRbLGHSeD2p7SUA8t1
 XDspDKblM4gxFbJwjOEpX4wZ91xUmc3esEUzWfZu9eGzOKMy2iAJDnHEoS7Z1ccSeQZMuKVB6hs
 anUv8IbZn6eZ+BF0=
X-Received: by 2002:adf:f846:: with SMTP id d6mr1895319wrq.56.1599129469389;
 Thu, 03 Sep 2020 03:37:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUlijd5KYaGY67SCA8fSUB124ucGUh1UW92f92Myp9jqRdZCJFwrqcQtv5h+99R7kPtBMEog==
X-Received: by 2002:adf:f846:: with SMTP id d6mr1895288wrq.56.1599129469096;
 Thu, 03 Sep 2020 03:37:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8ca5:2b7e:a83f:507b?
 ([2001:b07:6468:f312:8ca5:2b7e:a83f:507b])
 by smtp.gmail.com with ESMTPSA id o124sm3569432wmb.2.2020.09.03.03.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:37:48 -0700 (PDT)
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for specific cpu vendor
To: FelixCuioc <FelixCui-oc@zhaoxin.com>, Richard Henderson
 <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200903094935.2361-1-FelixCui-oc@zhaoxin.com>
 <20200903094935.2361-2-FelixCui-oc@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <612db96b-2f7b-1f98-4da8-46bccff9adca@redhat.com>
Date: Thu, 3 Sep 2020 12:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903094935.2361-2-FelixCui-oc@zhaoxin.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: TonyWWang-oc@zhaoxin.com, RockCui-oc@zhaoxin.com, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, CobeChen-oc@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 11:49, FelixCuioc wrote:
> Flatview_simplify() will merge many address ranges
> into one range.When a part of the big range needs
> to be changed,this will cause some innocent mappings
> to be unmapped.So we want to skip flatview_simplify().
> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>

This has several issues.  In no particular order:

1) you're adding host_get_vendor to target/i386/cpu.c so this does not
even build for the default "../configure && make".

2) you're adding a check for the host, but the bug applies to all hosts.
 If there is a bug on x86 hardware emulation, it should be fixed even
when emulating x86 from ARM.

3) you're not explaining what is the big range and how the bug is
manifesting.

I think you're seeing issues when a guest accesses an adjacent mapping
between the delete and add phases of the KVM MemoryListener.  We're
considering fixing that in the kernel, by adding a new ioctl that
changes the whole memory map in a single step.  I am CCing Peter Xu.

Paolo


> ---
>  softmmu/memory.c  | 16 +++++++++++++++-
>  target/i386/cpu.c |  8 ++++++++
>  target/i386/cpu.h |  3 +++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 70b93104e8..348e9db622 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -699,6 +699,18 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>      return NULL;
>  }
>  
> +static bool skip_simplify(void)
> +{
> +    char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
> +    host_get_vendor(vendor);
> +    if (!strncmp(vendor, CPUID_VENDOR_VIA, strlen(CPUID_VENDOR_VIA))
> +        || !strncmp(vendor, CPUID_VENDOR_ZHAOXIN,
> +                    strlen(CPUID_VENDOR_ZHAOXIN))) {
> +        return true;
> +    }
> +    return false;
> +}
> +
>  /* Render a memory topology into a list of disjoint absolute ranges. */
>  static FlatView *generate_memory_topology(MemoryRegion *mr)
>  {
> @@ -712,7 +724,9 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
>                               addrrange_make(int128_zero(), int128_2_64()),
>                               false, false);
>      }
> -    flatview_simplify(view);
> +    if (!skip_simplify()) {
> +        flatview_simplify(view);
> +    }
>  
>      view->dispatch = address_space_dispatch_new(view);
>      for (i = 0; i < view->nr; i++) {
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 49d8958528..08508c8580 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1664,6 +1664,14 @@ void host_cpuid(uint32_t function, uint32_t count,
>          *edx = vec[3];
>  }
>  
> +void host_get_vendor(char *vendor)
> +{
> +    uint32_t eax, ebx, ecx, edx;
> +
> +    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
> +    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
> +}
> +
>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping)
>  {
>      uint32_t eax, ebx, ecx, edx;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d3097be6a5..14c8b4c09f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -832,6 +832,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>  
>  #define CPUID_VENDOR_VIA   "CentaurHauls"
>  
> +#define CPUID_VENDOR_ZHAOXIN   "  Shanghai  "
> +
>  #define CPUID_VENDOR_HYGON    "HygonGenuine"
>  
>  #define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
> @@ -1917,6 +1919,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
>  void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> +void host_get_vendor(char *vendor);
>  
>  /* helper.c */
>  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> 


