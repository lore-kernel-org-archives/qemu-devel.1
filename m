Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C1C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5E92073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTgz1cSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5E92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolJM-0004xQ-Ce
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iokHA-0005dq-Gb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iokH8-0006CJ-Ts
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:31:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iokH8-0006Bq-Pq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578385902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiNoABeQWSVW/vMzs3uuKaOKpFpi5UCB+Ay2aH3MdrQ=;
 b=HTgz1cSr+NWI+OeIeH95+c5p1SBdShAHBVAAw01sW4MD4gfjq8wGiuqkcdJgyRImb1epSb
 bNHhmtExjbtwa3rbHt44Xw/vjob7J+xSUocR4j1/R3Wb+F2TUNiVD1Nk9zZFlQxdXTDqtG
 1Qdj+in3cTF9zKBElXCpBFv1owN/6Fo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-QdMYv7FKMJa4O2mh7OMOuA-1; Tue, 07 Jan 2020 03:31:41 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so10673150wrx.22
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OiNoABeQWSVW/vMzs3uuKaOKpFpi5UCB+Ay2aH3MdrQ=;
 b=Ut4JjpEJIBAXSU7p7EJ1xkSkhVPWA+9N1KGnoGmiUxAByARDbytrHBQ2L/ld9fdBRR
 GEeGkEAyBNUzm5hSameJLgCozSkpid5EzWjbFIQYatviJ0yMXJdc/jeu0rzDM8KycM81
 KxSu90gtXJujBOFGacEyXZh4DaHViltZO4Ec3N1MHybyl09Jb9/O44DXYhC6+K34LV8y
 9ssm8g6z+Ev+jq87fqyu6heqUmarTc1QxfjBoBIH/XpRe3kcLru47H4q5CIikcnDJE84
 MStqyS/tyLS1D44MBEYFrwXLpLfvpUJXgPll5l0MNpHU6Dm24WjnYsArds3cUtKxXiHz
 yITw==
X-Gm-Message-State: APjAAAUyFH+LO1BG1H9Kzzj8tf0U2MtmAjxa+/VO9qGLUZ8A2Oz6r+ea
 HuDf5dK33Js9wXeh798EAifs0L2kDMV8zxlyfFx/TGIxy8ZzZgB6KoyxfG0Qwa28xHnc72wuTOM
 8VJsoHCySDSz4zr0=
X-Received: by 2002:a5d:5267:: with SMTP id l7mr114969235wrc.84.1578385899869; 
 Tue, 07 Jan 2020 00:31:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwX1w8AmSEdGDvfcXip5mlhhuzzYtPHyksZFzqDFeuGK0szt3xgJmV1HUVxwC3F6Ai9TZ39ww==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr114969200wrc.84.1578385899590; 
 Tue, 07 Jan 2020 00:31:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id t5sm74393652wrr.35.2020.01.07.00.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:31:39 -0800 (PST)
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200102203926.1179743-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
Date: Tue, 7 Jan 2020 09:31:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200102203926.1179743-1-vkuznets@redhat.com>
Content-Language: en-US
X-MC-Unique: QdMYv7FKMJa4O2mh7OMOuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/01/20 21:39, Vitaly Kuznetsov wrote:
> When enlightened VMCS is enabled, certain VMX controls disappear, e.g.
> posted interrupts for PINBASED_CTLS. With fine-grained VMX feature
> enablement QEMU tries to do KVM_SET_MSRS with default (matching CPU
> model) values and fails as KVM doesn't allow to set now-unsupported
> controls.
> 
> The ideal solution for the issue would probably be to re-read VMX
> feature MSRs after enabling KVM_CAP_HYPERV_ENLIGHTENED_VMCS, however,
> this doesn't seem to be possible: currently, KVM returns global
> &vmcs_config.nested values for VMX MSRs when userspace does KVM_GET_MSR.
> 
> It is also possible to modify KVM to apply 'evmcs filtering' to VMX
> MSRs when userspace tries to set them and hide the issue but this doesn't
> seem to be entirely correct.
> 
> It is unfortunate that we now need to support the list of VMX features
> disabled by enlightened VMCS in QEMU. When (and if) enlightened VMCS v2
> arrives we'll need to fix QEMU and allow previously disabled features.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - I don't quite like this workaround myself, thus RFC. I'm sure someone
>  will suggest a better alternative.

The patch itself is not a big deal, the only thing is that we should
probably check that we get warnings if the "forbidden" features are
explicitly requested by the user.  On the other hand, for something like
"-cpu Haswell,vmx,hv_evmcs" there should be no warnings.

That said, I'm not sure about the whole idea of disabling features, even
in the kernel.  I would prefer if the guest knew that it cannot use
these features if using eVMCS.  Is this the case for Windows?  If so, we
should teach guest-side KVM about this, not QEMU.

Paolo

> ---
>  target/i386/kvm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 0b511906e3fe..1b0589b79358 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1198,6 +1198,30 @@ static int hyperv_handle_properties(CPUState *cs,
>          }
>  
>          if (!r) {
> +            /*
> +             * Certain VMX controls are unsupported when enlightened VMCS is
> +             * enabled, filter them out here so we don't attempt to set them
> +             * with KVM_SET_MSR even if they are supported by CPU model.
> +             * The list below is for eVMCS version 1.
> +             */
> +            env->features[FEAT_VMX_PINBASED_CTLS] &=
> +                ~(VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
> +                  VMX_PIN_BASED_POSTED_INTR);
> +            env->features[FEAT_VMX_SECONDARY_CTLS] &=
> +                ~(VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +                  VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +                  VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +                  VMX_SECONDARY_EXEC_ENABLE_PML |
> +                  VMX_SECONDARY_EXEC_ENABLE_VMFUNC |
> +                  VMX_SECONDARY_EXEC_SHADOW_VMCS |
> +                  /* VMX_SECONDARY_EXEC_TSC_SCALING | */
> +                  VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING);
> +            env->features[FEAT_VMX_ENTRY_CTLS] &=
> +                ~VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> +            env->features[FEAT_VMX_EXIT_CTLS] &=
> +                ~VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> +            env->features[FEAT_VMX_VMFUNC] &= ~MSR_VMX_VMFUNC_EPT_SWITCHING;
> +
>              env->features[FEAT_HV_RECOMM_EAX] |=
>                  HV_ENLIGHTENED_VMCS_RECOMMENDED;
>              env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
> 


