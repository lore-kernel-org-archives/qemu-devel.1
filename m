Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E10C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AAA2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNHB9mYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AAA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipvtK-0005AU-7z
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ipvoT-0006gv-Qj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ipvoR-0002Wa-SS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:03:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34212
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ipvoR-0002TH-Np
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578668579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBPTtrBwO/Os2oEoQr9kD/z6Bbab1CkF9YKRfLVY6iE=;
 b=QNHB9mYTpXVi15Mg1iMkbgMZwu5l2fF4kz7TWGNc8skEaPYy9FSmIIzMzaa4eAYpiGTQbx
 TFKHKGkHsUF4y8FW82+Y2iHs7SxqiUzlNIaTuafzobH53cAufaCSSjcBbqPAlfoMt8B9p8
 oefq0bYCKChm+388j78ZRowzPj5KyXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-QRQdwhysP4OhCViqoXK24w-1; Fri, 10 Jan 2020 10:02:54 -0500
Received: by mail-wm1-f70.google.com with SMTP id q26so513340wmq.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 07:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=j9ID5MsDqTyMh6SGiV3GHpxN3lJRpgvwmvNs/3Xk5fg=;
 b=SPGHxW3Lwmg7T6V0/zMnGBNX12YYFp8DeTKxkili7K1HiGoqaP6wdcC1dMhqKzmHtT
 Y63bq0FWzxCsHm4CGqGu/C4lqm1Bm+HU++Pn4ArDTPaYtblODEply3ipEIGuLlHEpf1z
 mPzvnbEuIkXcKuLUM9Hju1e9QL8lvzpCuJ3EeJ6xCnjwV9xyChs4L3TzpM8wriYf72g0
 mDegJh6aXaKJMtWID30hOmZzzjug91tnT+cT1+UdtvWJPcgyyYi+7DsxxG04/5JnsKHM
 leSGEhj3GbV7PeoaW978s3nvyGPrpdl8nbEkVgj2K5d5iUZquAy5+AaTFL3pAlkD5TFz
 eKZQ==
X-Gm-Message-State: APjAAAXK+hbaziiHlb/gENC6ot/5lL12nshHC7myBlGB79j7LohCWeX3
 zqHH72msM/8y18EZF4IxBWgTHSHOQV46tgXqXpVt0bJSQb36KfaAUFgDt2p6JnATfpNL5fNyWGW
 plw4NlwoQIKVnldQ=
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr4277303wrx.26.1578668573005; 
 Fri, 10 Jan 2020 07:02:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyG8hbBZtRWyACGraaIOQA4q7fHIBP4rBMGwi82b8UJhN6/yRVjKQRvlf1kKPW9kUeGKqgNQ==
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr4277262wrx.26.1578668572666; 
 Fri, 10 Jan 2020 07:02:52 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id m10sm2475726wrx.19.2020.01.10.07.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 07:02:52 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
In-Reply-To: <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
References: <20200102203926.1179743-1-vkuznets@redhat.com>
 <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
 <87zhezsc30.fsf@vitty.brq.redhat.com>
 <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
Date: Fri, 10 Jan 2020 16:02:50 +0100
Message-ID: <87zhevpd5x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: QRQdwhysP4OhCViqoXK24w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/01/20 13:08, Vitaly Kuznetsov wrote:
>> Honestly I forgot the story why we filtered out these features upon
>> eVMCS enablement in KVM. As there are no corresponding eVMCS fields,
>> there's no way a guest can actually use them.
>
> Well, mostly because we mimicked what Hyper-V was doing I guess.
>
>> I'm going to check that nothing breaks if we remove the filter. I'll go
>> and test Hyper-V 2016 and 2019.
>
> KVM would break, right?  But we can mark that patch as stable material.
>

While we are trying to understand how APIC virtualization works without
apic_access_addr field (maybe it doesn't?), should we fix the immediate
issue with QEMU-4.2 with a hack like:

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 72359709cdc1..038297e63396 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -357,15 +357,15 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 =09if (vmcs_version)
 =09=09*vmcs_version =3D nested_get_evmcs_version(vcpu);
=20
-=09/* We don't support disabling the feature for simplicity. */
-=09if (evmcs_already_enabled)
-=09=09return 0;
-
-=09vmx->nested.msrs.pinbased_ctls_high &=3D ~EVMCS1_UNSUPPORTED_PINCTRL;
-=09vmx->nested.msrs.entry_ctls_high &=3D ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
-=09vmx->nested.msrs.exit_ctls_high &=3D ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
-=09vmx->nested.msrs.secondary_ctls_high &=3D ~EVMCS1_UNSUPPORTED_2NDEXEC;
-=09vmx->nested.msrs.vmfunc_controls &=3D ~EVMCS1_UNSUPPORTED_VMFUNC;
-
 =09return 0;
 }
+
+void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata) {
+=09/*
+=09 * Enlightened VMCS doesn't have apic_access_addr field but Hyper-V
+=09 * still tries to enable SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES when
+=09 * it is available, filter it out
+=09 */
+=09if (msr_index =3D=3D MSR_IA32_VMX_PROCBASED_CTLS2)
+=09=09*pdata &=3D ~((u64)SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES << 32);
+}
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 07ebf6882a45..b88d9807a796 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -201,5 +201,6 @@ bool nested_enlightened_vmentry(struct kvm_vcpu *vcpu, =
u64 *evmcs_gpa);
 uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 =09=09=09uint16_t *vmcs_version);
+void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata);
=20
 #endif /* __KVM_X86_VMX_EVMCS_H */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3394c839dea..8eb74618b8d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1849,8 +1849,14 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
 =09case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
 =09=09if (!nested_vmx_allowed(vcpu))
 =09=09=09return 1;
-=09=09return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
-=09=09=09=09       &msr_info->data);
+=09=09if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
+=09=09=09=09    &msr_info->data))
+=09=09=09return 1;
+=09=09if (!msr_info->host_initiated &&
+=09=09    vmx->nested.enlightened_vmcs_enabled)
+=09=09=09nested_evmcs_filter_control_msr(msr_info->index,
+=09=09=09=09=09=09=09&msr_info->data);
+=09=09break;
 =09case MSR_IA32_RTIT_CTL:
 =09=09if (pt_mode !=3D PT_MODE_HOST_GUEST)
 =09=09=09return 1;

This should probably be complemented with a patch to not enable
unsupported controls when KVM is acting as a guest on eVMCS + a check
that none of the unsupported controls are enabled.

What do you think?

--=20
Vitaly


