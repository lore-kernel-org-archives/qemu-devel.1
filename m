Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903CAC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9C42064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/kAR8ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C42064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF8m-0002ps-Mw
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1idEVI-0000DW-Dv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1idEVF-0003yt-VA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:43 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1idEVF-0003w1-Cb
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:22:41 -0500
Received: by mail-ot1-x342.google.com with SMTP id i15so5907959oto.7
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+8cUyT1Lf+4L8XZshnnb3bBeNvCQNOiW1dT/SRoEk8g=;
 b=t/kAR8owd+iRH0RQaZpGRqIj9UiatUZlb1TwI917jUpOOYVUQXPJitnior+gS9MBKF
 3aMWCk/7qZKq0YBF6blMcWZITPu5hkfDS8miw3f0ZPBjQRlhSLTqbriWWlxpPRsZwM8T
 z+efisOMoWCbHDXniczObHqUBRxVf6fgK0ewka/V21z+53gOuHRpXj+qj6KYBJOtBYMc
 5mFMW8cPjLJ2F2h5fhNE9FeP7FLEFlGyvcG4NBzAnGMnkcXwmvkhwLeCzslCMnvbfr61
 nLniwh0WTM8zsoK/eJeHcO3JSjc/d2tf2w2nwhwIXIlLOcVG74u+8sLwkF2zn54p7xhP
 M0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+8cUyT1Lf+4L8XZshnnb3bBeNvCQNOiW1dT/SRoEk8g=;
 b=NusiJLVEeHu+Zmd3xtJzeLeTVpDsqeH/qQFoyQXjR3maQemdEzmRXvvaOxbck62RDf
 1uxV4t/4ruYv5Y1e9eB1OqjvFTr2wfsd9I4wLyygYAEgYmNZQQK2+/a+w+AcpuLe7j1h
 9/bH1UFa4Hl5Dxhh+5yVeyjVJEnrOUpalUveQa8XqQSTRMNuEOTRQ9k7tVBBhg6xkJcG
 J5+uMM4ZK7kJgnvarpbj5K7yrOB5m2CDUyhrqaAtqUgHqnMxpQ1MVCBhmEc0QjPEn4Fw
 Hkx5E6LgN6vH+3yiKW4zl/JaoR8v8qLy+afWm34B17YcjPzUYl2rJfODqz+La0GhFQ4N
 k5Nw==
X-Gm-Message-State: APjAAAWpbKqKWusD1mrZFBKZDp5MVnXjz4Muv4Qbb6hdXY5JgHN2tYAQ
 HY/03nhSQ1Tsa7FWuk8LVXGuAQgaZiN5UCQCAFCCdeZU
X-Google-Smtp-Source: APXvYqzvfujyFtYr5PZKgG2pftw8UMeLLVW5w8N1lQaid36Y//Wlghf0dxDXMCl2MuIcHlIM61+AXw4qGIDY2vXAwUU=
X-Received: by 2002:a9d:674f:: with SMTP id w15mr440865otm.243.1575628123545; 
 Fri, 06 Dec 2019 02:28:43 -0800 (PST)
MIME-Version: 1.0
References: <3a1c97b2-789f-dd21-59ba-f780cf3bad92@redhat.com>
 <1575627817-24625-1-git-send-email-catherine.hecx@gmail.com>
In-Reply-To: <1575627817-24625-1-git-send-email-catherine.hecx@gmail.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Fri, 6 Dec 2019 18:28:32 +0800
Message-ID: <CAEn6zmGDOsOx7yG42MJxLMUAVUtKH2f8vjLLO5txZ=kUb-QpyQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: skip kvm_msr_entry_add when kvm_vmx_basic is
 0
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo and Eduardo
I digged into the put msr assertion bug a little more, and seems I
found the root cause.
Please have a review.

Best regards.
Catherine

On Fri, 6 Dec 2019 at 18:25, Catherine Ho <catherine.hecx@gmail.com> wrote:
>
> Commit 1389309c811b ("KVM: nVMX: expose VMX capabilities for nested
> hypervisors to userspace") expands the msr_based_features with
> MSR_IA32_VMX_BASIC and others. Then together with an old kernel before
> 1389309c811b, the qemu call KVM_GET_MSR_FEATURE_INDEX_LIST and got the
> smaller kvm_feature_msrs. Then in kvm_arch_get_supported_msr_feature(),
> searching VMX_BASIC will be failed and return 0. At last kvm_vmx_basic
> will be assigned to 0.
>
> Without this patch, it will cause a qemu crash (host kernel 4.15
> ubuntu 18.04+qemu 4.1):
> qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
> target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
> cpu->kvm_msr_buf->nmsrs' failed.
>
> This fixes it by skipping kvm_msr_entry_add when kvm_vmx_basic is 0
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---
>  target/i386/kvm.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index a8c44bf..8cf84a2 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2632,8 +2632,13 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
>                                           f[FEAT_VMX_SECONDARY_CTLS]));
>      kvm_msr_entry_add(cpu, MSR_IA32_VMX_EPT_VPID_CAP,
>                        f[FEAT_VMX_EPT_VPID_CAPS] | fixed_vmx_ept_vpid);
> -    kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
> +
> +    if (kvm_vmx_basic) {
> +       /* Only add the entry when host supports it */
> +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
>                        f[FEAT_VMX_BASIC] | fixed_vmx_basic);
> +    }
> +
>      kvm_msr_entry_add(cpu, MSR_IA32_VMX_MISC,
>                        f[FEAT_VMX_MISC] | fixed_vmx_misc);
>      if (has_msr_vmx_vmfunc) {
> --
> 1.7.1
>

