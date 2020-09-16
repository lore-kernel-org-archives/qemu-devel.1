Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D49CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E340A22240
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OorQ+/gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E340A22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWaT-0007NI-ML
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIWMM-0000p5-JY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:16:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIWMK-0003k7-M9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600258582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PEOr/2G1n1nCZbajL1C4h74rXsnVuP1foPnAS/GD2kU=;
 b=OorQ+/gzJNt5TkiVzKJ2oc8zwoVIjtmfQQgcfVnnafRGDTo59G74/BILYT5XmC9IOh62SM
 yqb558B/dB+8ipMv1puGz3HjhOErvWKY5xdHHAC1OfzQlSjETX8j5ZQZyP+JotuZQDEoKA
 VW3V/ZjcIsNPTClTaq7D4UO84j0GzTM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-hsjOsDZqNc2J79w91Km_pg-1; Wed, 16 Sep 2020 08:16:19 -0400
X-MC-Unique: hsjOsDZqNc2J79w91Km_pg-1
Received: by mail-wm1-f69.google.com with SMTP id m20so955411wmg.6
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=PEOr/2G1n1nCZbajL1C4h74rXsnVuP1foPnAS/GD2kU=;
 b=bORuj0XsqUKiCY8IRFYWx7H8Zn0CFVV8JB6B/VsKfHERDrGGC1+zINW7Tkn/ZBvPa7
 75j6h/jS2R5vT7UEp+u/OsNBuFNazka8Eu7SYeBKhUsdQ9ziq/Z+yassDQr7e8fA6afQ
 AO+WojFrFnAZdb+lCngo919pzltqbGqt5kFh4rRyIzvO3FOZiVN2hzWVcrfbi75a3xRE
 sA+TED5Wly6QnBZbeAFpDikHc6J+SjVFAgJuO3qFN/C4asO6XFm2Z/LkTe31qlj/kk/a
 9Zmi3thwp53CheWPNmkbKlsOMmJN8KxTsQqUfD3xEUjuTdC+xifbsg9UKKcTDwbcwucK
 5a4w==
X-Gm-Message-State: AOAM533zl7Oikjt9Ndjvl/KP9oKNuql/HNkmRWcQwVr+DAZZOE8PI7cU
 bqcl/yoaFJBkGtAsRqCm8HxhAX1YZ3bcU8u7QcI/EAEWLzq15sadnn3OA2v2tNFy9Urfga26KPv
 pKQV93s1lPZtRj4A=
X-Received: by 2002:a1c:5a05:: with SMTP id o5mr4201541wmb.7.1600258576642;
 Wed, 16 Sep 2020 05:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBsEobzGS2xwDtZgtHnkoZqQNtSwNIZv7jcKlzRFy8dVwN0kgtDzbt9ySDB6eQF+1fKzuNlg==
X-Received: by 2002:a1c:5a05:: with SMTP id o5mr4201527wmb.7.1600258576410;
 Wed, 16 Sep 2020 05:16:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id m10sm5033353wmi.9.2020.09.16.05.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:16:15 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Antoine Damhet <antoine.damhet@blade-group.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [BUG] Migration hv_time rollback
In-Reply-To: <20200916115950.tsarwvk2dwgiceoe@tartarus>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm> <20200916115950.tsarwvk2dwgiceoe@tartarus>
Date: Wed, 16 Sep 2020 14:16:14 +0200
Message-ID: <878sd9j4s1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:41:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Antoine Damhet <antoine.damhet@blade-group.com> writes:

> On Wed, Sep 16, 2020 at 12:29:56PM +0100, Dr. David Alan Gilbert wrote:
>> cc'ing in Vitaly who knows about the hv stuff.
>
> Thanks
>
>> 
>> * Antoine Damhet (antoine.damhet@blade-group.com) wrote:
>> > Hi,
>> > 
>> > We are experiencing timestamp rollbacks during live-migration of
>> > Windows 10 guests with the following qemu configuration (linux 5.4.46
>> > and qemu master):
>> > ```
>> > $ qemu-system-x86_64 -enable-kvm -cpu host,kvm=off,hv_time [...]
>> > ```
>> 
>> How big a jump are you seeing, and how did you notice it in the guest?
>
> I'm seeing jumps of about the guest uptime (indicating a reset of the
> counter). It's expected because we won't call `KVM_SET_CLOCK` to
> restore any value.
>
> We first noticed it because after some migrations `dwm.exe` crashes with
> the "(NTSTATUS) 0x8898009b - QueryPerformanceCounter returned a time in
> the past." error code.
>
> I can also confirm the following hack makes the behavior disappear:
>
> ```
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 64283358f9..f334bdf35f 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -332,11 +332,7 @@ void kvmclock_create(void)
>  {
>      X86CPU *cpu = X86_CPU(first_cpu);
>
> -    if (kvm_enabled() &&
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> -        sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
> -    }
> +    sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>  }
>


Oh, I think I see what's going on. When you add 'kvm=off'
cpu->env.features[FEAT_KVM] is reset (see x86_cpu_expand_features()) so
kvmclock QEMU device is not created and nobody calls KVM_SET_CLOCK on
migration.

In case we really want to support 'kvm=off' I think we can add Hyper-V
features check here along with KVM, this should do the job.

-- 
Vitaly


