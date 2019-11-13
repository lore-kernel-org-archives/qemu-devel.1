Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A89C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426622196E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fILCsb5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426622196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUozM-000697-RQ
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iUoya-0005bk-7y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iUoyY-0002wU-WE
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:30:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iUoyY-0002uq-SP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573637410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DVCP2/08CFgN2W7uLnMfcZ1lja7Zvdm5cWOXP2OiuY=;
 b=fILCsb5/AuqC1Saf1IPy4yVVPJ3yKTk8liRCUdi2alG22oA4GYfvNcYgySZbLdKORaNpIN
 pI97saCmphvdTxR9PcSxdwJC/jXXvzc9j9ZtjSW7YVAlLLGuvmmsIaJdxtyA8vPucEvvKP
 J3kgUATLYBifMVYFfrLb7u2nNZe1Kr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-aZVcdqS9NvaQxbsQTLggLA-1; Wed, 13 Nov 2019 04:29:03 -0500
Received: by mail-wr1-f70.google.com with SMTP id b4so1242669wrn.8
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 01:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=q2dbQnHC18PohRp9CEMTpQ5WoArG6QRXmOe76T9Og9w=;
 b=kwVPd/qWVut3ylf8Fq/mw0zUULHWgkf0Cn4vnwwCAuA7ovC2y4zp7kAPL+KugE0Osr
 MJfMZctfHjF4fTiPM5gNBnVXuSdF6BOCEH05ssCLibSL/6+kNjqyfhFU7QZmWYiI1wLs
 EXML+V/XOabn4rbLwDVliK3vwqiTxwFMArySRcnjqcLfRT6f0HTOfaqHTypAmYheNBXs
 y4pfjYo9+eGe6crHU2w8Dn08Hx61TkH+w6ItMCD3YDvGTwLv969HNfKqqn6VtDL91vqx
 2/Fzy3eGyvIOLEXRj7XMM4Teo+6TgG9x7z9Gqcw/NysdPu//SLrqfq2hldjTeiBroWqF
 1OKg==
X-Gm-Message-State: APjAAAXP+j9lzlyy5B/19+zfJn9BNvvefoySqmO4wt6yeimgre+8KcNr
 WYlUokYiiOKQNpf0WRftTYQ4hKbSRbuNoa6cNrLwzVl5N+oQxDmoBXQFXF1nJcFvFUUehHry3OA
 /3Mj1V9h+MjAbJeo=
X-Received: by 2002:a05:600c:2944:: with SMTP id
 n4mr1815550wmd.57.1573637342342; 
 Wed, 13 Nov 2019 01:29:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6/0hwS2Qik9hidsciA/TR+XW47vLE5hlxH1gDrr6kcqUzz1spT90WZp2P2T6BqXjkDS5uag==
X-Received: by 2002:a05:600c:2944:: with SMTP id
 n4mr1815524wmd.57.1573637342047; 
 Wed, 13 Nov 2019 01:29:02 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id b196sm1748684wmd.24.2019.11.13.01.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 01:29:01 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
 "lantianyu1986\@gmail.com" <lantianyu1986@gmail.com>
Subject: Re: [PATCH V4] target/i386/kvm: Add Hyper-V direct tlb flush support
In-Reply-To: <20191112144943.GD2397@rkaganb.sw.ru>
References: <20191112033427.7204-1-Tianyu.Lan@microsoft.com>
 <20191112144943.GD2397@rkaganb.sw.ru>
Date: Wed, 13 Nov 2019 10:29:00 +0100
Message-ID: <87eeycktur.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: aZVcdqS9NvaQxbsQTLggLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Tue, Nov 12, 2019 at 11:34:27AM +0800, lantianyu1986@gmail.com wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>=20
>> Hyper-V direct tlb flush targets KVM on Hyper-V guest.
>> Enable direct TLB flush for its guests meaning that TLB
>> flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
>> bypassing KVM in Level 1. Due to the different ABI for hypercall
>> parameters between Hyper-V and KVM, KVM capabilities should be
>> hidden when enable Hyper-V direct tlb flush otherwise KVM
>> hypercalls may be intercepted by Hyper-V. Add new parameter
>> "hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
>> capability status before enabling the feature.
>>=20
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v3:
>>        - Fix logic of Hyper-V passthrough mode with direct
>>        tlb flush.
>>=20
>> Change sicne v2:
>>        - Update new feature description and name.
>>        - Change failure print log.
>>=20
>> Change since v1:
>>        - Add direct tlb flush's Hyper-V property and use
>>        hv_cpuid_check_and_set() to check the dependency of tlbflush
>>        feature.
>>        - Make new feature work with Hyper-V passthrough mode.
>> ---
>>  docs/hyperv.txt   | 10 ++++++++++
>>  target/i386/cpu.c |  2 ++
>>  target/i386/cpu.h |  1 +
>>  target/i386/kvm.c | 24 ++++++++++++++++++++++++
>>  4 files changed, 37 insertions(+)
>>=20
>> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>> index 8fdf25c829..140a5c7e44 100644
>> --- a/docs/hyperv.txt
>> +++ b/docs/hyperv.txt
>> @@ -184,6 +184,16 @@ enabled.
>> =20
>>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>> =20
>> +3.18. hv-direct-tlbflush
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Enable direct TLB flush for KVM when it is running as a nested
>> +hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L2
>> +guests are being passed through to L0 (Hyper-V) for handling. Due to AB=
I
>> +differences between Hyper-V and KVM hypercalls, L2 guests will not be
>> +able to issue KVM hypercalls (as those could be mishanled by L0
>> +Hyper-V), this requires KVM hypervisor signature to be hidden.
>
> On a second thought, I wonder if this is the only conflict we have.
>
> In KVM, kvm_emulate_hypercall, when sees Hyper-V hypercalls enabled,
> just calls kvm_hv_hypercall and returns.  I.e. once the userspace
> enables Hyper-V hypercalls (which QEMU does when any of hv_* flags is
> given), KVM treats *all* hypercalls as Hyper-V ones and handles *no* KVM
> hypercalls.

Yes, but only after guest enables Hyper-V hypercalls by writing to
HV_X64_MSR_HYPERCALL. E.g. if you run a Linux guest and add a couple
hv_* flags on the QEMU command line the guest will still be able to use
KVM hypercalls normally becase Linux won't enable Hyper-V hypercall
page.

>
> So, if hiding the KVM hypervisor signature is the only way to prevent the
> guest from issuing KVM hypercalls (need to double-check), then, I'm
> afraid, we just need to require it as soon as any Hyper-V feature is
> enabled.
>

If we do that we're going to break a lot of setups in the wild which run
Linux guests with hv_* flags (e.g. just to keep configuration the same
for Windows/Linux or by mistake/misunderstanding).

When Hyper-V enlightenments are enabled, KVM signature moves to
0x40000100 so if a guest is still able to find it -- then it knows
what's going on. I'd suggest we maintain the status quo.

--=20
Vitaly


