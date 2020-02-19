Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53506C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFB021D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHRISgfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFB021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4M4K-0003Ac-83
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 04:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1j4M3l-0002j7-Sh
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1j4M3j-000623-U3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:54:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1j4M3j-00060E-IQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582106059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N88VF8Ut/hyyLVBXajE9yPdmQZ8AflrwK7IfSmC29I=;
 b=gHRISgfJc2od8sXa6V6PvE6U9Qt6wi3oSQRyP4pZAhuh9OI+G/QkuFIZ9PfCQTgsHrbWmY
 t/a+HDAjsNU2i88+blG8EgzSymVcOQciyRFdbt2m73LbhSUz8YguVK9Ikq502FR09EgXtN
 C6fgrn0EiFLJSx4ewpcD/LI+Yh5D5jY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-5p4MMMVJO76ubnNupUt-Uw-1; Wed, 19 Feb 2020 04:54:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id g26so1382608wmk.6
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 01:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=+590MGy8slvCwOcarh/x5+GjQgQiBdCOw3lnRNEYUq8=;
 b=k139txOdjmFXheJAekzCNANtgtRI2NHzat6fmBrdgdsdz2FJ9/MUKVCmq1LNjnlUpW
 s3xHx1f9Jue8PTQuttdTDTuKVf8Q26KYKoIft3bzmKK7vyk5kWFthPVMm0tNV/AjND7Q
 Mkv+4tl1dDbPgex34TSyrR7r9MprnsxY1WCAaM9+L+ca0Uc4ODpcTZ23/oqL3pEJSlzw
 1WI35lKgXUxe7KeqADPY9JHgE9OaRrE9UZ9eOA26n8phA+mBOg5ckW05f6WOBzG6t+Si
 G8OK24EIAWE2SKyh5gyEZ6pRnypcH95rIjUcgDcakMrDgVogOmmRc/Ci/LEYmLf2FVZ+
 wB1Q==
X-Gm-Message-State: APjAAAXeBLlUbINXcZBencPLV7PW4oo4jsmNw+aQd8URWnt9FlB6gB+t
 LoDBSdKapX5bwrVFceqvSqS7RmU735p455MDaxXx2vM24A35Vvm4wlEUrd9TtZ40M6VM1P75a/t
 4V/DrubollYAsraY=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr36731482wrc.175.1582106056575; 
 Wed, 19 Feb 2020 01:54:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxztJqRwkbVqb4PRGgJGnIqDWtAG3o0PybRen6hTmJaEvGmq984n2y6ghWTKyEO5UUMDCh4Rg==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr36731437wrc.175.1582106056175; 
 Wed, 19 Feb 2020 01:54:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id t128sm2361371wmf.28.2020.02.19.01.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 01:54:15 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR
 when enabling SynIC
In-Reply-To: <d5a3159d-4cab-ef94-bbfc-e9120324cd3e@redhat.com>
References: <20200218144415.94722-1-vkuznets@redhat.com>
 <9b4b46c2-e2cf-a3d5-70e4-c8772bf6734f@redhat.com>
 <87k14j962l.fsf@vitty.brq.redhat.com>
 <d5a3159d-4cab-ef94-bbfc-e9120324cd3e@redhat.com>
Date: Wed, 19 Feb 2020 10:54:14 +0100
Message-ID: <878sky9a2h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 5p4MMMVJO76ubnNupUt-Uw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Marcelo Tosatti <mtosatti@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/02/20 18:08, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 18/02/20 15:44, Vitaly Kuznetsov wrote:
>>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>>> ---
>>>> RFC: This is somewhat similar to eVMCS breakage and it is likely possi=
ble
>>>> to fix this in KVM. I decided to try QEMU first as this is a single
>>>> control and unlike eVMCS we don't need to keep a list of things to dis=
able.
>>>
>>> I think you should disable "virtual-interrupt delivery" instead (which
>>> in turn requires "process posted interrupts" to be zero).  That is the
>>> one that is incompatible with AutoEOI interrupts.
>>=20
>> I'm fighting the symptoms, not the cause :-) My understanding is that
>> when SynIC is enabled for CPU0 KVM does
>>=20
>> kvm_vcpu_update_apicv()
>> =09vmx_refresh_apicv_exec_ctrl()
>> =09=09pin_controls_set()
>>=20
>> for *all* vCPUs (KVM_REQ_APICV_UPDATE). I'm not sure why
>> SECONDARY_EXEC_APIC_REGISTER_VIRT/SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY
>> are not causing problems and only PIN_BASED_POSTED_INTR does as we clear
>> them all (not very important atm).
>
> Let's take a step back, what is the symptom, i.e. how does it fail?

I just do

~/qemu/x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=3Dkvm -cpu host=
,hv_vpindex,hv_synic -smp 2 -m 16384 -vnc :0
and get
qemu-system-x86_64: error: failed to set MSR 0x48d to 0xff00000016
qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2684: kvm_buf_set_msrs: As=
sertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
Aborted

(it works with '-smp 1' or without 'hv_synic')

> Because thinking more about it, since we have separate VMCS we can set
> PIN_BASED_POSTED_INTR and SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY just fine
> in the vmcs02.
> The important part is to unconditionally call
> vmx_deliver_nested_posted_interrupt.
>
> Something like
>
> =09if (kvm_x86_ops->deliver_posted_interrupt(vcpu, vector)) {
>                 kvm_lapic_set_irr(vector, apic);
>                 kvm_make_request(KVM_REQ_EVENT, vcpu);
>                 kvm_vcpu_kick(vcpu);
>         }
>
> and in vmx_deliver_posted_interrupt
>
>         r =3D vmx_deliver_nested_posted_interrupt(vcpu, vector);
>         if (!r)
>                 return 0;
>
> =09if (!vcpu->arch.apicv_active)
>                 return -1;
>         ...
>         return 0;

Sound like a plan, let me try playing with it.

--=20
Vitaly


