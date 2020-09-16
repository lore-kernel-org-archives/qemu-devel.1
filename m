Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F6BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC2720771
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="slpJXFeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC2720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXSI-0006Ad-F2
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIXQr-0005B1-4A
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:25:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIXQo-0004V0-Qi
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:25:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id g4so6930724wrs.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SlmJPF4x1wZbMthVYIT+8Nt2l4p3ZqF+QSLiYEXwP4I=;
 b=slpJXFePhA0BHGYw4aTAb3bzUrsgPmCsP3FN1M7jWZqKdLmg/lzdFx+clInzDsdvfI
 +69UCU+sWqyUWYRMmYeRpUgvpAPfmaI/zc7ulAw6AwTOwdQc3IigZUWE/ubqD1mn9wgX
 M+Y0UtprWRfEblqcG/Co8fcW8GtxSO3VVpHCOhlNWevMi8Y9Xd84wRVFmDNsNNCQeAqQ
 5IzijgGn+aSY5lnixk9lk0kr/IF+KEWS07pabhMQVgcbWcgs9sLy7jDKzfCfpQ/2iNWV
 04a7U9Bm2SqPDvdcmNN+anLQOtKTf/8+Q/fHygFWyDh1QoEHN1pZSYSn7Yyff1hf6S+A
 Jq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SlmJPF4x1wZbMthVYIT+8Nt2l4p3ZqF+QSLiYEXwP4I=;
 b=iozm+4AvS79apqsHwUMAKVw+e7JJT/4ZjyNqNZc2VNbJZhSKtlItnfl2HdHikqZj8y
 spAd6Iyd7oAt+sOteiR0QFxIsO6IUEx8at0a3KQQEx+ekXIlioxZkbM4evL1o7Zdl696
 2B8xqCNlBRUj9C/E3PTkTN2mYRRdclv0tHRtGz1vZZFoCua4JCt2jgW8iCD61Cwh6iHI
 +K021wYBWU1VPVD5mn69vxY2Fm+3IH9ZVTgfzxEKQFy4ku1OE7Gx3xdNyyMervYZf64Z
 UKn1ssFFMBuV0OeC0kTRdRU2Fjci8WzZV45vhgu/7wpVPpgXNpxgsi93V/YQomUQzOvZ
 P9NQ==
X-Gm-Message-State: AOAM531hqfhdLR+p4KXf79CPqoT/rVI7FNY885MAvZuAQRMtwJ/EM3v0
 ADmA6CiH3mBKpIVPZAklCLLvDA==
X-Google-Smtp-Source: ABdhPJyo/LS06psBs8yolMfHpx7eosKjUrHkmxB8Xy34Zw+2khkGuV8O57LrdF2UQjzwQ7k3uMKdOA==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr25906538wro.69.1600262705148; 
 Wed, 16 Sep 2020 06:25:05 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id d18sm33170353wrm.10.2020.09.16.06.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 06:25:04 -0700 (PDT)
Date: Wed, 16 Sep 2020 15:25:03 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [BUG] Migration hv_time rollback
Message-ID: <20200916132503.mrfdjaghblkhxocd@tartarus>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm>
 <20200916115950.tsarwvk2dwgiceoe@tartarus>
 <878sd9j4s1.fsf@vitty.brq.redhat.com>
 <875z8dj367.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ddcko4qldhsydqz2"
Content-Disposition: inline
In-Reply-To: <875z8dj367.fsf@vitty.brq.redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ddcko4qldhsydqz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 02:50:56PM +0200, Vitaly Kuznetsov wrote:
[...]

> >>
> >
> >
> > Oh, I think I see what's going on. When you add 'kvm=3Doff'
> > cpu->env.features[FEAT_KVM] is reset (see x86_cpu_expand_features()) so
> > kvmclock QEMU device is not created and nobody calls KVM_SET_CLOCK on
> > migration.
> >
> > In case we really want to support 'kvm=3Doff' I think we can add Hyper-V
> > features check here along with KVM, this should do the job.
>=20
> Does the untested
>=20
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 64283358f91d..e03b2ca6d8f6 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -333,8 +333,9 @@ void kvmclock_create(void)
>      X86CPU *cpu =3D X86_CPU(first_cpu);
> =20
>      if (kvm_enabled() &&
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE)=
 |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2=
))) {
> +        ((cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURC=
E) |
> +                                         (1ULL << KVM_FEATURE_CLOCKSOURC=
E2))) ||
> +         (cpu->env.features[FEAT_HYPERV_EAX] & HV_TIME_REF_COUNT_AVAILAB=
LE))) {
>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>      }
>  }
>=20
> help?

It appears to work :)

>=20
> (I don't think we need to remove all 'if (kvm_enabled())' checks from
> machine types as 'kvm=3Doff' should not be related).

Indeed (I didn't look at the macro, it was just quick & dirty).

>=20
> --=20
> Vitaly
>=20
>=20

--=20
Antoine 'xdbob' Damhet

--ddcko4qldhsydqz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9iEiwACgkQ3AmjLzzl
jz67kAf/Sg4zQ7EnL88len0Pu3qNaJsnCtb+87dK1B8dSdTSrFU0dohbB8kB6XX0
lBaCVjEV8qJT2DePBl8TCoMegpKQ7lW28jAKEDldFdnouOgIIs1wpweGfQhEsyUJ
YywIWBDX1fDlt27auV7Wl79KzVmJRN+rFIzJbIq7WO87gvmDAUsNTwimyCbmJl71
ldSLkWPkm+PCaPZ/TP5vhE/ZLoJpPoVaKhquMcLFoFGP6OhfafhGRkTEQdFOXGOz
q8j1jctp98YkREkQnTX/Rq5FRTEV36Apy2tATu004wBzjPPJ+0/LtzH8znGVeaav
uirQYi4zDrgGClC+BtsoPNwR7PmY7w==
=qkcP
-----END PGP SIGNATURE-----

--ddcko4qldhsydqz2--

