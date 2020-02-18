Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39604C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06601208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eav9x2rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06601208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46NP-0008HO-9O
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1j46MD-0006PO-VZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1j46MC-0003Qw-Of
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:08:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1j46MC-0003QF-L6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582045703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UElfjQTcLbQO7IyfE4STTOOkMQtQknD+YWDOvlNlKv4=;
 b=Eav9x2rKEDPzAc7KzVp013fue5P8DPl2G7aXgNHMNtVaZQvQMQFTwTDaFBJaErkVFtT/zI
 3GoIMydKo6yXj1x7XTmG7U9QPHEanC9sk30rwHRXlADKFeBQf6lg4dqkMksWof4ahP0ljC
 QrlVl3thf1hpXNC/RSaJmV4BmgTQ8W8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-9HfnaqlPNo6aR4gZKgiyVg-1; Tue, 18 Feb 2020 12:08:21 -0500
Received: by mail-wm1-f70.google.com with SMTP id p2so317284wma.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=bQ24iXtvMkreFZJJl4JQ5Z/nYZE2Ewp8tzNT/yktqgQ=;
 b=q/unmcSY5BrK4CN4k1ZCdWSZN6oWyiLwy/GscXhGTFlEuj6M3+jakokMBvySzBCGRn
 ligHISvVl5Y/VtyZOBsZJ2UYqdjHpflHLGaMZUqT5pQ1LOsAAfKLUjmvCW8U9wXmK6XL
 tCXI/lVfkFsTDxeFYAY4ak4oiSYUkfqqXsXq8B5F8NRPsBlsb2uQv8203jwIi0Ktlx1t
 vMtIWxPB1OR5fpQ5ck1KEUbR5Q+PtqXdH5OXYYiLu12QUb2Nf5jTxF26uVkNTznZ3iaW
 //oHkJKeP/lBlji0ZkpvJiZ4OY9zrsqMoolYr87QEZjGWxKZiY0+eyOY3zyD8RNopTiX
 o5TA==
X-Gm-Message-State: APjAAAXLWcMvshAAnq4q9Q5fN11FYGpf/76ClVgQt34Kp3PODS1jdAg8
 YxEVit62x4xCdVOznKEeHO6tP+T9Vis66kyo9C5i/JF2AMCDgao9swzF7SArqHWqlF0tAhAIoHn
 kEEptm0dtZg+anzc=
X-Received: by 2002:adf:f744:: with SMTP id z4mr25738795wrp.318.1582045700382; 
 Tue, 18 Feb 2020 09:08:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4269LzqtF1igS5EeXvERpHG3e2WaJaLsyunGtXgftLoNRPN2kjNmkBgQzhHGcdLTjfzTsYg==
X-Received: by 2002:adf:f744:: with SMTP id z4mr25738770wrp.318.1582045700126; 
 Tue, 18 Feb 2020 09:08:20 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id p15sm4075130wma.40.2020.02.18.09.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:08:19 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR
 when enabling SynIC
In-Reply-To: <9b4b46c2-e2cf-a3d5-70e4-c8772bf6734f@redhat.com>
References: <20200218144415.94722-1-vkuznets@redhat.com>
 <9b4b46c2-e2cf-a3d5-70e4-c8772bf6734f@redhat.com>
Date: Tue, 18 Feb 2020 18:08:18 +0100
Message-ID: <87k14j962l.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 9HfnaqlPNo6aR4gZKgiyVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/02/20 15:44, Vitaly Kuznetsov wrote:
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> RFC: This is somewhat similar to eVMCS breakage and it is likely possibl=
e
>> to fix this in KVM. I decided to try QEMU first as this is a single
>> control and unlike eVMCS we don't need to keep a list of things to disab=
le.
>
> I think you should disable "virtual-interrupt delivery" instead (which
> in turn requires "process posted interrupts" to be zero).  That is the
> one that is incompatible with AutoEOI interrupts.

I'm fighting the symptoms, not the cause :-) My understanding is that
when SynIC is enabled for CPU0 KVM does

kvm_vcpu_update_apicv()
=09vmx_refresh_apicv_exec_ctrl()
=09=09pin_controls_set()

for *all* vCPUs (KVM_REQ_APICV_UPDATE). I'm not sure why
SECONDARY_EXEC_APIC_REGISTER_VIRT/SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY
are not causing problems and only PIN_BASED_POSTED_INTR does as we clear
them all (not very important atm).

>
> The ugly part about fixing this in QEMU is that in theory it would be
> still possible to emulate virtual interrupt delivery and posted
> interrupts, because they operate on a completely disjoint APIC
> configuration than the host's.  I'm not sure we want to go there though,
> so I'm thinking that again a KVM implementation is better.  It
> acknowledges that this is just a limitation (workaround for a bug) in KVM=
.

The KVM implementation will differ from what we've done to fix eVMCS. We
will either need to keep the controls on (and additionally check
kvm_vcpu_apicv_active() if guest tries to enable them) and again filter
VMX MSR reads from the guest or do the filtering on MSR write from
userspace (filter out the unsupported controls and not fail).

Actually, I'm starting to think it would've been easier to just filter
all VMX MSRs on KVM_SET_MSRS leaving only the supported controls and not
fail the operation. That way we would've fixed both eVMCS and SynIC
issues in a consistent way shifting the responsibility towards
userspace (document that VMX MSRs are 'special' and enabling certain
features may result in changes; if userspace wants to see the actual
state it may issue KVM_GET_MSRS any time) May not be the worst solution
after all...

--=20
Vitaly


