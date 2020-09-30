Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C81C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051652071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuHy8fF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051652071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYGm-0007L4-3s
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNYG6-0006fW-PU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNYG2-00024V-Og
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:18:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601457521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hLExyzdHsPeln/6WT2UppnqZBUe9wmyC9llYGHLEkU=;
 b=HuHy8fF5CBbXIsttxzGEA6Jr6aUwvyT8zbz1t6P0O+1L9Z0sggezS0vcpN2S6WqK1QLwC7
 HyYwVn5licGu4zRIk4FDHG3LFkljBhsNGPZDxYqgW31c5+SSBk5B2qRE+9Kvzazs1NRKrH
 vC0PCBvrjJyQooGj+zpVL1lI3F0Ar3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450--yvSdmZTPMayWmgNBT2DdQ-1; Wed, 30 Sep 2020 05:18:37 -0400
X-MC-Unique: -yvSdmZTPMayWmgNBT2DdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 175101084D68;
 Wed, 30 Sep 2020 09:18:36 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3551992F;
 Wed, 30 Sep 2020 09:18:29 +0000 (UTC)
Date: Wed, 30 Sep 2020 10:18:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/2] util/vfio-helpers: Rework the IOVA allocator to
 avoid IOVA reserved regions
Message-ID: <20200930091828.GC201070@stefanha-x1.localdomain>
References: <20200929085550.30926-1-eric.auger@redhat.com>
 <20200929085550.30926-3-eric.auger@redhat.com>
 <20200929155951.GB191675@stefanha-x1.localdomain>
 <6ebdb1f7-792b-6fbe-d4b3-f06aafc8deef@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6ebdb1f7-792b-6fbe-d4b3-f06aafc8deef@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, lvivier@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, kwolf@redhat.com, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 09:44:48PM +0200, Auger Eric wrote:
> Hi Stefan,
>=20
> On 9/29/20 5:59 PM, Stefan Hajnoczi wrote:
> > On Tue, Sep 29, 2020 at 10:55:50AM +0200, Eric Auger wrote:
> >> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> >> index ba0ee6e21c..71145970f3 100644
> >> --- a/util/vfio-helpers.c
> >> +++ b/util/vfio-helpers.c
> >> @@ -667,6 +667,50 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOSta=
te *s)
> >>      return true;
> >>  }
> >> =20
> >> +static int
> >> +qemu_vfio_find_fixed_iova(QEMUVFIOState *s, size_t size, uint64_t *io=
va)
> >> +{
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < s->nb_iova_ranges; i++) {
> >> +        if (s->usable_iova_ranges[i].end < s->low_water_mark) {
> >> +            continue;
> >> +        }
> >> +        s->low_water_mark =3D
> >> +            MAX(s->low_water_mark, s->usable_iova_ranges[i].start);
> >> +
> >> +        if (s->usable_iova_ranges[i].end - s->low_water_mark + 1 >=3D=
 size ||
> >> +            s->usable_iova_ranges[i].end - s->low_water_mark + 1 =3D=
=3D 0) {
> >=20
> > I don't understand the =3D=3D 0 case. It seems like we are allocating a=
n
> > IOVA beyond usable_iova_ranges[i].end?>
> It is meant to handle the case were low_water_mark =3D 0 and
> s->usable_iova_ranges[0].end =3D ULLONG_MAX (I know it cannot exist at th=
e
> moment but may happen in the future) where we get an overflow. Given the
>         if (s->usable_iova_ranges[i].end < s->low_water_mark) {
>             continue;
>         }
> I think this prevents us from allocating beyond
> usable_iova_ranges[i].end or do I miss something?

Yes, you are right. Here are the constraints:

e >=3D l
j =3D max(l, s)
e - j + 1 < s
e - j + 1 =3D=3D 0

Assume l >=3D s so we can replace j with l:

e >=3D l
e - l + 1 < s
e - l + 1 =3D=3D 0

The case I'm worried about is when the iova range cannot fit s bytes.
The last condition is only true when e =3D l - 1, but this violates the
first condition e >=3D l.

So the problem scenario cannot occur.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl90TWQACgkQnKSrs4Gr
c8gsMAf+MRUWiPrCRBHqprYb2LE2N75XlMbk1T03NhuyEWQIZBumbZPY+4qpqgKp
o1Q7FAcRlWJnXUNZAkVNH+qb7/JoWkUdSh9g2+Fp/X7w6Yd/EL284WX3QYkPUmra
HUonQgJlK8vJIe1r7UjZUmCwYGT8KRS6f1KGEhxNctZ2rM+HEehRZL5rGpX43nOY
Zukla5ii84G1C8fRBB+TfQs02y64g/nBCWDlnCCYbMzYOWyxdE01AyQ+pIaQLP94
YOeWhyaYLFj95Zn2K+TbvXSbpss1qiZEXseCBioeoY7JGMsyYd4SXDtcddd4FN5n
ZRjT67VLiSK6rtio7u3lYFRMbR9p6g==
=FDRZ
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--


