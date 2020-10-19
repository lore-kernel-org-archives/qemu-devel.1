Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC46C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B6B20578
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/bOXX6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B6B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSNp-0002bO-8q
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUSMC-0001na-Ug
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUSM9-0006pI-Rl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603103132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2QVX47yrtHuYSJJ62PC7hrU/jIFmUQxHdAh5Q++Plw=;
 b=b/bOXX6rMlybD0KGS4DsKmQkHSqa5vkYGcyIM4VB2HPWOCKZdJosDBrVR7eymj9kxN4aEo
 IFoQAs1FSGkvvUPf/jPCwfcTlPXHyShwX4iu5jW2kPAnduIQe97k/Dm/3gIUxKhjxKCk8U
 Eu61YEaBdZjZW3JSGvlAU4Nso3nFlRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-80UiZ-npO2SZ_2YZ-vfHHw-1; Mon, 19 Oct 2020 06:25:29 -0400
X-MC-Unique: 80UiZ-npO2SZ_2YZ-vfHHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D12F10199A8;
 Mon, 19 Oct 2020 10:25:28 +0000 (UTC)
Received: from localhost (ovpn-115-27.ams2.redhat.com [10.36.115.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 432D627CC9;
 Mon, 19 Oct 2020 10:25:28 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:25:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] softmmu/memory: fix memory_region_ioeventfd_equal()
Message-ID: <20201019102527.GB83062@stefanha-x1.localdomain>
References: <20201017210102.26036-1-eafanasova@gmail.com>
 <20201017210102.26036-2-eafanasova@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201017210102.26036-2-eafanasova@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2020 at 02:01:02PM -0700, Elena Afanasova wrote:
> Eventfd can be registered with a zero length when fast_mmio is true.
> Handle this case properly when dispatching through QEMU.
>=20
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  softmmu/memory.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 403ff3abc9..3ca2154a64 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -203,10 +203,17 @@ static bool memory_region_ioeventfd_before(MemoryRe=
gionIoeventfd *a,
>  }
> =20
>  static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd *a,
> -                                          MemoryRegionIoeventfd *b)
> -{
> -    return !memory_region_ioeventfd_before(a, b)
> -        && !memory_region_ioeventfd_before(b, a);
> +                                          MemoryRegionIoeventfd *mrb)

Why rename b -> mrb?

> +{
> +    if (int128_eq(a->addr.start, mrb->addr.start) &&
> +            (!int128_nz(mrb->addr.size) ||
> +             int128_eq(a->addr.size, mrb->addr.size)) &&
> +            (a->match_data =3D=3D mrb->match_data) &&
> +            ((mrb->match_data && (a->data =3D=3D mrb->data)) || !mrb->ma=
tch_data) &&
> +            (a->e =3D=3D mrb->e))
> +        return true;

The kernel behaves differently in that a and b are symmetric:

  static bool
  ioeventfd_check_collision(struct kvm *kvm, struct _ioeventfd *p)
  {
  =09struct _ioeventfd *_p;

  =09list_for_each_entry(_p, &kvm->ioeventfds, list)
  =09=09if (_p->bus_idx =3D=3D p->bus_idx &&
  =09=09    _p->addr =3D=3D p->addr &&
  =09=09    (!_p->length || !p->length ||
  =09=09     (_p->length =3D=3D p->length &&
  =09=09      (_p->wildcard || p->wildcard ||
  =09=09       _p->datamatch =3D=3D p->datamatch))))
  =09=09=09return true;

  =09return false;
  }

For example, if a->addr.size =3D=3D 0 then the ioeventfd matches whereas
this patch only does it for b.

Please match the kernel behavior.

A different approach is setting ioeventfd.addr.size to zero when
mr->ioeventfds[i].addr.size is zero in the
memory_region_dispatch_write_eventfds() loop. That way
memory_region_ioeventfd_equal() doesn't need to be modified.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+NaZcACgkQnKSrs4Gr
c8ipnAgAq5Jtfg+FzBOc9Q70+e/zV+rI0mjxaiuUoF4RkN7x0kRY/trjQb2d/IBU
lPAvcM0AdNvSyZ7+8UjwflN92i4GlE5QR95mmxbADLLeXE7DSeGceJxsHIU1iwxO
XGMl8tacyfOv8HMieWqOTJ9aUxhI7B46XMwSIq8n2+RGEV/xmekHoazq5s2YUs71
NpPgyInlpsDOADw2pcVGu9PlStLRc2xa+abhF9x/kJdoGXrwYp92PRZBCmCP8Q9y
Vral/VRRXLxRbqIYFAFfYcOgU+JW4tkE3N78nDgSdhfpVytmPS3FUZOGVqo68tPT
pghZnZ7GSqeW9ihcdkHugFG4AB4vyw==
=FkzS
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--


