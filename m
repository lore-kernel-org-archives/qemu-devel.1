Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44BC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B092073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOLhE4d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B092073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icV6h-0003aX-7K
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1icV61-00035S-8B
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1icV60-0004K9-2v
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:53:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1icV5z-0004K2-Vb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575467615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1bItY3VlK/R7QUzEfTiED1NR3XB+RxnbiIFivpcdxU=;
 b=GOLhE4d6Gu1iQOYUSkfFdGHTI60BAHAlp6+bSOgr/SCVgLXpJ685AX8WwWcxd6HD2Sm0IY
 9QZp+2XApcjYqnkbMnvkvIiFjnWZXb+BG5Uk6Hy+8qzKWH1ECGnXRL0DnGqrLKAUIfB76T
 gENWQiqobEfccIKL+ep+XRnVq9Fg/K4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-twTQ8v8yOCGvH09W1uyRMg-1; Wed, 04 Dec 2019 08:53:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id l20so3665387wrc.13
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 05:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JbunT/ja9JU/BRWbWg+UV5NSnnxoVIInWyWve9LRpWM=;
 b=IfLokcxPnuN14QjZigefaS4RhKhFhiLxNZnEl1BmzSbnjrzPrEYlO3AD8H91gs/PmV
 3c2DAOGdP7KoEgpT3+IeBUEFlN/rWKcSNRl9Jr+6D7I0VisOjj0qFm+SxKFbh30ox54n
 WTwm7EuQj/DXTl3rUy/IJ9CVQ0TLGjz+gWzQEQSAZJT7D4M9nwwp6MOGngFhYHlSNsfc
 F5NivOUwkhMp5GHOZWfrQwjO8NCZX0XR+RSK0bIYWQfJHQr9z3/5gN2+mflgF8xlZm/s
 XscPGUnUyEuV/uG+BcTkkVbewO1yKGikxH7KQFK5At2jxXRq0Qn0FuuUyN5pCWI5ko9c
 cJYQ==
X-Gm-Message-State: APjAAAUEtGDc/hp8sGQc2U757lM2LffYDJhxZ6qIsqS1BTbsVhZhJKG0
 qFMEGRin6DHpXxbVNnS4wD0TjfMl9w+AKycwAmhw5QAdMKsJoW4w3vP5SqzxSqtJzP7Mrq0qaY9
 cLbNsMVOMrfd5OCk=
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr39615093wmc.124.1575467612747; 
 Wed, 04 Dec 2019 05:53:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZdYYEroqPepi9PWforByvomgCbHr/8nblFYn2wfzsbutFK2puEjUdP9HwGsntldywmwxndQ==
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr39615074wmc.124.1575467612491; 
 Wed, 04 Dec 2019 05:53:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id d9sm7771644wrj.10.2019.12.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 05:53:32 -0800 (PST)
Subject: Re: [PATCH] target/i386: relax assert when old host kernels don't
 include msrs
To: Catherine Ho <catherine.hecx@gmail.com>
References: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
 <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
 <CAEn6zmFex9WJ9jr5-0br7YzQZ=jA5bQn314OM+U=Q6ZGPiCRAg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <714a0a86-4301-e756-654f-7765d4eb73db@redhat.com>
Date: Wed, 4 Dec 2019 14:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAEn6zmFex9WJ9jr5-0br7YzQZ=jA5bQn314OM+U=Q6ZGPiCRAg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: twTQ8v8yOCGvH09W1uyRMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/19 14:33, Catherine Ho wrote:
> Hi Paolo
> [sorry to resend it, seems to reply it incorrectly]
>=20
> On Wed, 4 Dec 2019 at 19:23, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     On 04/12/19 09:50, Catherine Ho wrote:
>     > Commit 20a78b02d315 ("target/i386: add VMX features") unconditional=
ly
>     > add vmx msr entry although older host kernels don't include them.
>     >
>     > But old host kernel + newest qemu will cause a qemu crash as follow=
s:
>     > qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
>     > target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret =3D=3D
>     > cpu->kvm_msr_buf->nmsrs' failed.
>     >
>     > This fixes it by relaxing the condition.
>=20
>     This is intentional.=C2=A0 The VMX MSR entries should not have been a=
dded.
>     What combination of host kernel/QEMU are you using, and what QEMU
>     command line?
>=20
>=20
> Host kernel: 4.15.0 (ubuntu 18.04)
> Qemu: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev
> cmdline: qemu-system-x86_64 -M pc -cpu host --enable-kvm -smp 8 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -m 4G,maxm=
em=3D4G
>=20
> But before 20a78b02d315, the older kernel=C2=A0+ latest qemu can boot gue=
st
> successfully.

Ok, so the problem is that some MSR didn't exist in that version.  Which
one it is?  Can you make it conditional, similar to MSR_IA32_VMX_VMFUNC?

Thanks,

Paolo


