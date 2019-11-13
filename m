Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDAFC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69266206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUDcAagz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69266206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUplH-0003XH-EO
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 05:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iUpkA-00035M-Mx
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iUpk7-0001Qt-Ma
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:19:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iUpk6-0001PI-30
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573640357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRe8wHhBMDDzX3KOxjr8uoW4NYiTvpZK6wCNT5fI1PA=;
 b=dUDcAagzJ3jPjwy2BxNHZKP/frn8XNgWtUItWnJESOysTnGybHly6CwF3Kr9qVYQ+lScPA
 xCj1axiQjiuQQaXuv+cFQfa9vL1R1qrPQZQUBAon/yCJN69SMzCtrbwC6SdKFbtUY3Wvyn
 W0C5jCdM+MLnnFSYzKJkpKy1T6IE0KY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-DSIHgzVvMbee3AzfvWMZ2w-1; Wed, 13 Nov 2019 05:19:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id m68so1080925wme.7
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 02:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=nFtt3jp4ZQIg+EhCBJghRSXJhp/M0r51X+zNE6hZvAI=;
 b=DikxiUC/Qxen6CG5kMpP4I8udXlf7jKnkfJl8314FJddRg3kjS80204YxUHLh5ZEZV
 H0v7xMuJ5+BEv1XsB/VGuwOerH0AMLV71PlsjjhNZcbJOs0RpaLvgTO5BW7mJU+5bqaJ
 Ht4tkPOqdHkR4oomWLWLuDHeR/ABalHArBaRpIE4I1QBxLZQxfsBEDfqSymLgiF1nijK
 KOCVlm2BXeOluMDwgYJn5XFLmDKcHncZbO7DMdD+ddinnMeAD+hBiJbC0r8Em4vgbolv
 PLhNMksrLF0vVr6DQtnlGit5idNbGkUeMQEu8mpHEIWGhSb7ClJVtsqQj/fUSvVMZYAB
 v+9g==
X-Gm-Message-State: APjAAAXMXw7Q3YRVeQqswCtt6q/VyzNdFXmZp5OKGxAG50igNdzik5gD
 0XYUKqqsSrjiMVLMutsA3vjxpwVdwmmEfnpt4tIQovrwWNWxy4xKUv06+7hd2QW27z+rNbWNsZe
 RHJIiRn7oI1tkECc=
X-Received: by 2002:a7b:c858:: with SMTP id c24mr2100229wml.174.1573640354818; 
 Wed, 13 Nov 2019 02:19:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6fQSIlxkg6xPhhV4JBJ3SgC16/A6995o7JCp9t/K8ye8WH2oJvVq79EarLmmk55OAtUMMGg==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr2100202wml.174.1573640354460; 
 Wed, 13 Nov 2019 02:19:14 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id s17sm1620809wmh.41.2019.11.13.02.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 02:19:13 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH V4] target/i386/kvm: Add Hyper-V direct tlb flush support
In-Reply-To: <20191113094716.GA57998@rkaganb.sw.ru>
References: <20191112033427.7204-1-Tianyu.Lan@microsoft.com>
 <20191112144943.GD2397@rkaganb.sw.ru> <87eeycktur.fsf@vitty.brq.redhat.com>
 <20191113094716.GA57998@rkaganb.sw.ru>
Date: Wed, 13 Nov 2019 11:19:13 +0100
Message-ID: <87bltgkrj2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: DSIHgzVvMbee3AzfvWMZ2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Wed, Nov 13, 2019 at 10:29:00AM +0100, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> > On Tue, Nov 12, 2019 at 11:34:27AM +0800, lantianyu1986@gmail.com wrot=
e:
>> >> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >>=20
>> >> Hyper-V direct tlb flush targets KVM on Hyper-V guest.
>> >> Enable direct TLB flush for its guests meaning that TLB
>> >> flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
>> >> bypassing KVM in Level 1. Due to the different ABI for hypercall
>> >> parameters between Hyper-V and KVM, KVM capabilities should be
>> >> hidden when enable Hyper-V direct tlb flush otherwise KVM
>> >> hypercalls may be intercepted by Hyper-V. Add new parameter
>> >> "hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
>> >> capability status before enabling the feature.
>> >>=20
>> >> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >> ---
>> >> Change since v3:
>> >>        - Fix logic of Hyper-V passthrough mode with direct
>> >>        tlb flush.
>> >>=20
>> >> Change sicne v2:
>> >>        - Update new feature description and name.
>> >>        - Change failure print log.
>> >>=20
>> >> Change since v1:
>> >>        - Add direct tlb flush's Hyper-V property and use
>> >>        hv_cpuid_check_and_set() to check the dependency of tlbflush
>> >>        feature.
>> >>        - Make new feature work with Hyper-V passthrough mode.
>> >> ---
>> >>  docs/hyperv.txt   | 10 ++++++++++
>> >>  target/i386/cpu.c |  2 ++
>> >>  target/i386/cpu.h |  1 +
>> >>  target/i386/kvm.c | 24 ++++++++++++++++++++++++
>> >>  4 files changed, 37 insertions(+)
>> >>=20
>> >> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>> >> index 8fdf25c829..140a5c7e44 100644
>> >> --- a/docs/hyperv.txt
>> >> +++ b/docs/hyperv.txt
>> >> @@ -184,6 +184,16 @@ enabled.
>> >> =20
>> >>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>> >> =20
>> >> +3.18. hv-direct-tlbflush
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> >> +Enable direct TLB flush for KVM when it is running as a nested
>> >> +hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L=
2
>> >> +guests are being passed through to L0 (Hyper-V) for handling. Due to=
 ABI
>> >> +differences between Hyper-V and KVM hypercalls, L2 guests will not b=
e
>> >> +able to issue KVM hypercalls (as those could be mishanled by L0
>> >> +Hyper-V), this requires KVM hypervisor signature to be hidden.
>> >
>> > On a second thought, I wonder if this is the only conflict we have.
>> >
>> > In KVM, kvm_emulate_hypercall, when sees Hyper-V hypercalls enabled,
>> > just calls kvm_hv_hypercall and returns.  I.e. once the userspace
>> > enables Hyper-V hypercalls (which QEMU does when any of hv_* flags is
>> > given), KVM treats *all* hypercalls as Hyper-V ones and handles *no* K=
VM
>> > hypercalls.
>>=20
>> Yes, but only after guest enables Hyper-V hypercalls by writing to
>> HV_X64_MSR_HYPERCALL. E.g. if you run a Linux guest and add a couple
>> hv_* flags on the QEMU command line the guest will still be able to use
>> KVM hypercalls normally becase Linux won't enable Hyper-V hypercall
>> page.
>
> Ah, you're right.  There's no conflict indeed, the guest makes
> deliberate choice which hypercall ABI to use.
>
> Then QEMU (or KVM on its own?) should only activate this flag in evmcs
> if it sees that the guest has enabled Hyper-V hypercalls.

That was my suggestion as well when KVM patches were submitted, but if I
remember correctly Tianyu said that if we don't enable 'direct tlb
flush' flag in eVMCS on first VMLAUNCH, underlying Hyper-V won't give us
a second chance so we can't enadle it after guest writes to
HV_X64_MSR_HYPERCALL. This is a very unfortunate design/implementation.

--=20
Vitaly


