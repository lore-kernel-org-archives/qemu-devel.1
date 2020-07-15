Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F3DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 00:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56EF20714
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 00:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU4eOwo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56EF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvrKa-0002H5-Uu
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 20:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1jvrJS-0001ly-V2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 19:59:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42911
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1jvrJO-0002Fb-5r
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 19:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594857580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkZyLbdU1FcpNgqJ/O5L2JdvwluH/GZ0+nIOve4cF8A=;
 b=BU4eOwo165zhW/66jkRUwsg9rM8dA4sJSmLqognq/Lcu6eNYcMBleCLw5l1IVBvkaA6sRq
 AH0zpC/1ZyrPe5FIxjBsds3lP1yPjbKGiNl7h4+Zx7Fb69O4WStTl0gJtDcjas/Dr1Qqx/
 Zjem84KshglepGDOq5KpIhKVF2LCwvo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-04sRrEIjMs-FYh5uJxzCXQ-1; Wed, 15 Jul 2020 19:59:37 -0400
X-MC-Unique: 04sRrEIjMs-FYh5uJxzCXQ-1
Received: by mail-pj1-f69.google.com with SMTP id k7so3979295pjw.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 16:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=+15oueJ6gF9glF0z5elJoKIfGLlkAaW7Tn+HQi2I8+A=;
 b=ZAGcIxxETiArwoLzyMtyzYgTSTmxCoz50Yd20BEW12Klkke1MZrWN7EqgoNmCuiyCg
 zyR0ImiapCdiJ7scQFatWXVYvjmEbcBJ/Ls8yPrGEMWz7ecw0R3RVj3m3jKy7fCthc9k
 qFafk48O/NTSIuBHB0o4QF9wLBxZYdgrpKKvlfXbXksOu4kKR5S2IYs6Z/j7oZXYTn7Y
 7ZzI3LOZIBQO5ucbRe4Os1ONoEzP3nQ+Dg4XF0AnZ9igjLHljOUS47XSjAhC42WVADac
 0UvsmvS9r8JvM8ehCK+4/3ZDbdRaVobAl5jBLC+7P6GuUvjwpP5Ags/Chnj7IeJWz/eQ
 vrLg==
X-Gm-Message-State: AOAM5329N1W0kGWbkoulhtywrmkeDfXjrgm0GKnmnaCY5qBoTUUKXYWf
 CBfdFpWy6LtckU/v+jVpf7Q/S20Il9Lcrua0w+uuPDd/Bb/59k9oPzGFrD9hwcs239IEqFoBWa8
 zJYpW+aDGOSkLIWU=
X-Received: by 2002:a05:6a00:22c2:: with SMTP id
 f2mr1486631pfj.187.1594857576753; 
 Wed, 15 Jul 2020 16:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7d4U1oCsEypfF0zo2MsQH+GIBpqH6zhBh6A/u5wjwP85JAl1FpZB9WBgnVhVkkmHxZSXXcw==
X-Received: by 2002:a05:6a00:22c2:: with SMTP id
 f2mr1486612pfj.187.1594857576487; 
 Wed, 15 Jul 2020 16:59:36 -0700 (PDT)
Received: from umbus.fritz.box ([2001:4479:e000:a00:2394:afbb:e8de:d924])
 by smtp.gmail.com with ESMTPSA id k189sm3050906pfd.175.2020.07.15.16.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 16:59:35 -0700 (PDT)
Date: Thu, 16 Jul 2020 09:59:26 +1000
From: David Gibson <dgibson@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
Message-ID: <20200716095926.74caee16@umbus.fritz.box>
In-Reply-To: <874kqbbdft.fsf@dusky.pond.sub.org>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
 <87y2nvanya.fsf@dusky.pond.sub.org>
 <794f6901-5fe3-f7a1-45e7-f277f687cb6b@redhat.com>
 <87v9iz7cxl.fsf@dusky.pond.sub.org>
 <20200713111344.23c1b313@umbus.fritz.box>
 <874kqbbdft.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/t5mtR9nTc52XVvmzBIrbUUP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/t5mtR9nTc52XVvmzBIrbUUP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jul 2020 18:13:42 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> David Gibson <dgibson@redhat.com> writes:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> >>=20
> >> The surprising part is that n turns out to be large enough for n^2 to
> >> matter *that* much. =20
> >
> > Is this another consequence of the ludicrous number of QOM objects we
> > create for LMB DRCs (one for every 256MiB of guest RAM)?  Avoiding that
> > is on my list. =20
>=20
> You're talking about machine pseries, I presume.

Yes.

>  With
> print_qom_composition() patched to print the number of children, I get
>=20
>     $ echo -e 'info qom-tree\nq' | ../qemu/bld/ppc64-softmmu/qemu-system-=
ppc64 -S -display none -M pseries -accel qtest -monitor stdio | grep '###' =
| sort | uniq -c | sort -k 3n
>         360 ### 0 children
>           5 ### 1 children
>           5 ### 2 children
>           2 ### 3 children
>           1 ### 4 children
>           1 ### 15 children
>           1 ### 16 children
>           1 ### 18 children
>           1 ### 37 children
>           1 ### 266 children
>=20
> The outlier is
>=20
>         /device[5] (spapr-pci-host-bridge)
>=20
> due to its 256 spapr-drc-pci children.

Right, that's one for each possible PCI slot on the bus.  That will be
reduced by the idea I have in mind for this, but...

> I found quite a few machines with similar outliers.  ARM machines nuri
> and smdkc210 together take the cake: they each have a node with 513
> children.
>=20
> My stupid n^2 sort is unnoticable in normal, human usage even for n=3D513=
.

... as you say, 256 shouldn't really be a problem.  I was concerned
about LMB DRCs rather than PCI DRCs.  To have that show up, you might
need to create a machine with a large difference between initial memory
and maxmem - I think you'll get a DRC object for every 256MiB in there,
which can easily get into the thousands for large (potential) memory
VMs.

I don't know what the config was that showed up this problem in the
first place, and whether that could be the case there.

> >                 Though avoiding a n^2 behaviour here is probably a good
> > idea anyway. =20
>=20
> Agreed.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/t5mtR9nTc52XVvmzBIrbUUP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8PmF4ACgkQbDjKyiDZ
s5Ik4hAAiV1CyfeDFwPjO6mun51au91iO2h2oFMbhNnjxLDQz29vWhYUICZnTsE+
9QweDtUAFIKIOb7ZGflx071vI6c+u/uVPEuvlmwuOAA+Hs/tghOnt/sGiifQzbg6
aQNLo/dSIWm1saU7T+QprR4w5cZ+vpqIbK/LMh7HKEC+8y+5MHqylIE8lqqJKExx
kh1USGvmob/DwnlRZoWyrRB8iXTdQd8ySQxlcSPtdl++nLETiEwmXgBXUR1LsLtU
qGyrKehG/vRRQwdPnWgpsEmkgR4eYHfhO0o5qRMOADUC18qblbpsR7yWc77S0IGM
vd7cWom1+wTquXmwPfHeRt02+7KZK0VgH/yUMMQerYZOvy56wBPfp32kYFBZW8Fa
aD00bqfFfU1xwscpDUtPdIilFxnV+YEvDUXB2HhaTzGaVHu1lMv+Rf47b66bCK0y
VSe5YyJnm3Y0DVK3CPgsZAxwKz/i/XJx1nWoK/YXu0Uc+c/nkSZ47QIVf6ciBy9s
KGWB3suRZPrDNwEfHTiY1CE4Frw6hrd2qu0dUstU5aOSoF0zIXNJRF17y6Y0IbJA
zjIFYSDB3ZrI31gATkp/VHAuWrL0rGDzWjT/k6MPoCcrJhfhhGsvlP6wNnCJyNTq
KWzy3NrQ8DNtKwrmIqAbydEpJPUTIIilf7yFqV9AoDDc3yZTCp0=
=/CpL
-----END PGP SIGNATURE-----

--Sig_/t5mtR9nTc52XVvmzBIrbUUP--


