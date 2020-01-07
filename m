Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C62C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEC8206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BH/Zo8UW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEC8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionl3-00071Y-9A
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ionfR-0002zK-UH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ionfP-0007dc-SJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:09:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ionfP-0007cd-Ol
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578398937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UqXgxoabqLbbYDl1EERybiFw7Yu6N6KgfnlUPqX0AI=;
 b=BH/Zo8UWVFw152Dm69hzgBRhT2UucNl8WhxeSyPSlBv/maQWClMuZVQSqME6mFX0laPH7B
 vDGzeqr0iBHWlevg1srTl/jWZUA6+2c9jXrc5YPsnFr48aEutid44xR+AP+0Z4eCUBieZO
 0aWNjB3MTEAOU7SijN48BWJGXG5K6sg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-XWgxvSSnNfy66x9JAkZg8w-1; Tue, 07 Jan 2020 07:08:54 -0500
Received: by mail-wm1-f70.google.com with SMTP id q26so1887898wmq.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Grw1tyESGLinhtxOIpeXyy7JzPwANRKzddYm76xprfw=;
 b=c6NoC19Ob7/8hUXyuAF0ciKnKtbb+sBNqYADvdw89fwcyW+5rtF+TBUWEG729fP/FO
 dHk8H7BHKGNyXV1U4qgyyTDbvcp4Qa+mKtzlMLY7ATO6J0e2TA5S3LrPm9yhxbejAtLn
 oH89aNsgBsjYlmJ8Mr1MepkvcCMgPJ7m0Cc3nEYKNvA1a2Ufb80AuFwwk9CTw2WgGdPH
 Adq9ksCXD+slZivwQ7vCvUQGocbCq1rJ88nzDxidoQ+UhM/6nUe+eG0NQYpGT9GmVwzx
 eQ/IwWAPHqa0LxZWFkaGAJPVnWEWwMr9CWjqaWA+XWuPoVt1ckyX76U6bDkPJDjVCOV9
 kwzQ==
X-Gm-Message-State: APjAAAV6sqLHlbLgiGJO+TZyiI1puLHAoDf+l7I7Hd6Esczp854I0NAT
 IyBMIdzgeC10ubIlbGE8ims9zLVEEDoBuhdzDUr0x8Sq41FovpBO8umdU3gnd0DMbpMoS7xbkzN
 AuI4LS4WFFjkAnfk=
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr42064516wmc.158.1578398933589; 
 Tue, 07 Jan 2020 04:08:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYfJ4tcUsD4bqGjvLlY+GaIZ66+4ZTbPQ7CqXhiK+TI3OkXWyhFU5651oJ8GnaeAcg4xpzHQ==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr42064497wmc.158.1578398933389; 
 Tue, 07 Jan 2020 04:08:53 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id q3sm78945644wrn.33.2020.01.07.04.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 04:08:52 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
In-Reply-To: <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
References: <20200102203926.1179743-1-vkuznets@redhat.com>
 <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
Date: Tue, 07 Jan 2020 13:08:51 +0100
Message-ID: <87zhezsc30.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: XWgxvSSnNfy66x9JAkZg8w-1
X-Mimecast-Spam-Score: 0
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/01/20 21:39, Vitaly Kuznetsov wrote:
>> When enlightened VMCS is enabled, certain VMX controls disappear, e.g.
>> posted interrupts for PINBASED_CTLS. With fine-grained VMX feature
>> enablement QEMU tries to do KVM_SET_MSRS with default (matching CPU
>> model) values and fails as KVM doesn't allow to set now-unsupported
>> controls.
>>=20
>> The ideal solution for the issue would probably be to re-read VMX
>> feature MSRs after enabling KVM_CAP_HYPERV_ENLIGHTENED_VMCS, however,
>> this doesn't seem to be possible: currently, KVM returns global
>> &vmcs_config.nested values for VMX MSRs when userspace does KVM_GET_MSR.
>>=20
>> It is also possible to modify KVM to apply 'evmcs filtering' to VMX
>> MSRs when userspace tries to set them and hide the issue but this doesn'=
t
>> seem to be entirely correct.
>>=20
>> It is unfortunate that we now need to support the list of VMX features
>> disabled by enlightened VMCS in QEMU. When (and if) enlightened VMCS v2
>> arrives we'll need to fix QEMU and allow previously disabled features.
>>=20
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> - I don't quite like this workaround myself, thus RFC. I'm sure someone
>>  will suggest a better alternative.
>
> The patch itself is not a big deal, the only thing is that we should
> probably check that we get warnings if the "forbidden" features are
> explicitly requested by the user.  On the other hand, for something like
> "-cpu Haswell,vmx,hv_evmcs" there should be no warnings.
>
> That said, I'm not sure about the whole idea of disabling features, even
> in the kernel.  I would prefer if the guest knew that it cannot use
> these features if using eVMCS.  Is this the case for Windows?

Honestly I forgot the story why we filtered out these features upon
eVMCS enablement in KVM. As there are no corresponding eVMCS fields,
there's no way a guest can actually use them.

I'm going to check that nothing breaks if we remove the filter. I'll go
and test Hyper-V 2016 and 2019.

> If so, we should teach guest-side KVM about this, not QEMU.

This is not required when enabling eVMCS on a genuine Hyper-V because it
correctly filters out unsupported features, however, to not break
KVM-on-KVM-using-eVMCS case we'll have to move the filter from host to
guest.

Thanks!

--=20
Vitaly


