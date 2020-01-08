Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AACBC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051E520673
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEFj1Bdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051E520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8dx-0001XN-8b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ip8dJ-00016t-SD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ip8dI-00055D-Of
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:32:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ip8dI-00054Q-Ki
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578479531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yC7jBnftyRU6h/I5ztxUDZSHEs957mZI73EBj0CIwo8=;
 b=TEFj1BdpjE07WUTpSMfMmdyGccKpH4MVBgqnA9KtIstB8jrwzq0ii/R1IuowLC7+P7C0jH
 8C3uM/MEZ9JTtkUkNj+rXUJmS+U11HfNH2YBmdvU9DOhf2W3/i3RrIL0M/IPP5wP9Mqolz
 LNAusSiMJo74UEAd7G4gNz/aIT/iM5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Kt0Nk4WFNbqu1bCxKfVq5Q-1; Wed, 08 Jan 2020 05:32:05 -0500
Received: by mail-wm1-f71.google.com with SMTP id c4so665591wmb.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=S3X/3FJJOh9UemFynTLZQocz1929SfSf3CumRfk1tZs=;
 b=HqjgD8uHeQ/3GZEbVQU2GCJpZiln6vD5PShcJo2a66pZ16/+rPkYDzZcvnNJ3zikGB
 c+je9mL2RuWyA5JUHC17v7X6qPPfO/US7kIVynZlre3zdkAwnZHYBBmgk7Rd4t+Me1hN
 +7aKvkVE9AfLSkmTNxKg+JW/dqyNrwUjCphGLO6cegZVF3LWepbKiltQOmoEm/QF+qt9
 HFasSxvZMrVvchhomdczRAflcD2VCqjc34VdJQjv47EJ9sMpeGuQYZKAqGtczbuuMBbK
 DCUPi/4beAxp31ZfCqSPb6nMCa6uAPA9fEZ5PcwyN/Eu6cVqDkoKD+O/hBTef+XrLnoV
 YrhA==
X-Gm-Message-State: APjAAAUG8JTQAX0LsPUHqyYquYdCcrzkIHbzlfditTYJ82irQ8pUDm+p
 Xwp7leJn9wpNQwym1Fxsh1wVwRec4NoBhE/4SZzAqx//qgs3sHP3lAiL8zRrLvKI+IPr3HuCoPs
 5/0TgOLB9i0Kz3QA=
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr2984307wmk.1.1578479524602;
 Wed, 08 Jan 2020 02:32:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxaMh4WOpkMgahZ0wH3ix0AeXumc6uDQ4IUFGN/LZ5qIH+Q9LAp6IE+OvtAcNy0zDJNcd+MZQ==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr2984277wmk.1.1578479524385;
 Wed, 08 Jan 2020 02:32:04 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id x10sm3531324wrv.60.2020.01.08.02.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 02:32:03 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
In-Reply-To: <CABgObfYviBXJNOTrSQk6hZC5HpBW4fZL_eJGSC+vs=Fv9h40bg@mail.gmail.com>
References: <20200102203926.1179743-1-vkuznets@redhat.com>
 <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
 <87zhezsc30.fsf@vitty.brq.redhat.com>
 <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
 <87imlnrv3n.fsf@vitty.brq.redhat.com>
 <CABgObfYviBXJNOTrSQk6hZC5HpBW4fZL_eJGSC+vs=Fv9h40bg@mail.gmail.com>
Date: Wed, 08 Jan 2020 11:32:02 +0100
Message-ID: <87a76ys0gt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: Kt0Nk4WFNbqu1bCxKfVq5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Liran Alon <liran.alon@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES
>>
>> the problem with it is that we don't have 'apic_access_addr' field in
>> eVMCS ('virtual_apic_page_addr' is there). By running the same setup
>> with eVMCS disabled I figured out which address can be hardcoded to make
>> it boot.
>>
>
> Maybe it's really hard coded (what is the value? Is it consistent across
> Hyper-V version?) Can you try changing KVM to enable it and see if the
> hardcoded APIC access address works?

Unfortunately, it's not the same even between BIOS and UEFI booted
WS2016 (Gen1/Gen2). It is, however, the same across reboot for the same
image so for example for WS2016Gen1 it is '0x294000' so if I do:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fab7451a5793..8366b2a02b3b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1433,6 +1433,8 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx=
 *vmx)
        vmcs12->tpr_threshold =3D evmcs->tpr_threshold;
        vmcs12->guest_rip =3D evmcs->guest_rip;
=20
+       vmcs12->apic_access_addr =3D 0x294000;

it all works. I'm really puzzled.

--=20
Vitaly


