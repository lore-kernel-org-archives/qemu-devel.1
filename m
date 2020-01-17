Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C798C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BBD20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkT+gD1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BBD20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQB4-0006fX-Eq
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1isQ9m-0005cg-6Z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1isQ9f-0004VG-5O
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:51:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1isQ9e-0004UV-Nk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579261869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLrln4+VSajByokn3+3/SH9r01GWIU1icd0vzUYCsFs=;
 b=AkT+gD1Dit8qfnsWecf1jgpZ871obcNyS0nIbkhMtZ89/hHUFGP7nVcjxOById4Az2kWGi
 2SfTJJSJNkzymzQv6B6Oln9ultVpKyF/g7fHTDEc7n+CABMdglAv8EeLJ9h7nMqmLOsGMh
 jTazh5j9I5EYuSHffB4/Nz+0avf8Aj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-kDHVvgK-MGm8gC0GWrbPLA-1; Fri, 17 Jan 2020 06:51:08 -0500
X-MC-Unique: kDHVvgK-MGm8gC0GWrbPLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99196DB61;
 Fri, 17 Jan 2020 11:51:07 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 579571BC6D;
 Fri, 17 Jan 2020 11:51:05 +0000 (UTC)
Date: Fri, 17 Jan 2020 12:51:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the
 hardcoded value
Message-ID: <20200117115104.GE7394@dhcp-200-226.str.redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
 <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
 <w517e1rf0fo.fsf@maestria.local.igalia.com>
 <56ec1ead-bba9-f4de-5c87-e81f802dfc79@redhat.com>
 <20200117095538.GB7394@dhcp-200-226.str.redhat.com>
 <f0de9a2b-6ce2-22a5-8bfe-526100fcd544@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f0de9a2b-6ce2-22a5-8bfe-526100fcd544@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
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
Cc: Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.01.2020 um 12:01 hat Max Reitz geschrieben:
> On 17.01.20 10:55, Kevin Wolf wrote:
> > Am 17.01.2020 um 10:12 hat Max Reitz geschrieben:
> >> On 17.01.20 00:26, Alberto Garcia wrote:
> >>> On Tue 14 Jan 2020 03:15:48 PM CET, Max Reitz wrote:
> >>>>> @@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64=
_t offset,
> >>>>>   * Writes one sector of the L1 table to the disk (can't update sin=
gle entries
> >>>>>   * and we really don't want bdrv_pread to perform a read-modify-wr=
ite)
> >>>>>   */
> >>>>> -#define L1_ENTRIES_PER_SECTOR (512 / 8)
> >>>>> +#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
> >>>>>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
> >>>>
> >>>> Here it=E2=80=99s because the comment is wrong: =E2=80=9CCan=E2=80=
=99t update single entries=E2=80=9D =E2=80=93
> >>>> yes, we can.  We=E2=80=99d just have to do a bdrv_pwrite() to a sing=
le entry.
> >>>
> >>> What's the point of qcow2_write_l1_entry() then?
> >>
> >> I think the point was that we couldn=E2=80=99t, for a long time, becau=
se the
> >> block layer only provided sector-granularity access.  This function
> >> simply was never changed when the block layer gained the ability to do
> >> byte-granularity I/O.
> >>
> >> (We=E2=80=99d still need this function, but only for the endian swap, =
I think.)
> >=20
> > We still can't do byte-granularity writes with O_DIRECT, because that's
> > a kernel requirement.
>=20
> Ah, yes.  But that makes BDRV_SECTOR_SIZE the wrong choice.
>=20
> > The comment explains that we don't want to do a RMW cycle to write a
> > single entry because that would be slower than just writing a whole
> > sector. I think this is still accurate. Maybe we should change the
> > comment to say "can't necessarily update". (The part that looks really
> > wrong in the comment is "bdrv_pread", that should be "bdrv_pwrite"...)
>=20
> Hm.  But we wouldn=E2=80=99t do an RMW cycle without O_DIRECT, would we?

file-posix with a regular file has request_alignment =3D=3D 1 and wouldn't
cause an RMW cycle, I think. I won't try to make a statement about all
non-O_DIRECT cases in all protocols.

The important point is that some cases exist which would get us RMW.

> > Now, what's wrong about the logic to avoid the RMW is that it assumes
> > a fixed required alignment of 512. What it should do is looking at
> > bs->file->bl.request_alignment and rounding accordingly.
>=20
> Yes.

Who'll write the patch? :-)

Kevin

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeIZ+oAAoJEH8JsnLIjy/WOF0P/AxFCZf5ElfxFHWIbAWKJBTg
OqnSwaguSFIeM3u2d2QFW5JDJiP2mHkiJ5W1ue+FyeAqqhFcX1Ri3XkqErydDR1s
prOo8DQwbY8cM2b6rO/CrYlMqRDTG/Wp6q2CkV793waZmC61kOw77UgcJPOItrry
9pIsiEV9KNPiuKqBYK62Eqz1pbJGsNRXb+UFRktm7gkadpp4qIsD/Hmu53m6S1eL
uXSUz53G4j7SchUfISKMesxbh3sj/k0aqvlsDxrAmCijoTNqYa7wiA9h3DpkYu8t
Ytmf+6ii/fFmiW7P05dOvFG7PQpz2PCg+TEnMz/L9PzzSIR5+IaHvL2Bp7T2YgSo
/7aGrrMHvOtdR05JFUN6YYEgL28e/54rDEfcFS6KhV9w5ZTQ7d75uREQE+BHmPJr
Dhp0//7QGEs+nG3dg0hbu6+LzQhky2ENh/HODyF/PJ30dj5Rjp/tnrJJpGrVjnJa
wvx/YQR94UHMYz5wIHlXdPmJEP0w4kBH/sr4BndaPOfDpGKLkewlPZLYcP3dSGMh
yfqwFoTPwZG4debHclQrSW+LyeSE1o+cwGCukFYys/inYKWgCP7QxHbafNysE1Bx
mlU4Nt93W+P3vY4KJT9YOEpbYO8XFX2NcHQnN7V1+gDf0YDgia5ZwNX8L8fHLseb
QyBQwJ76ky5Ev4ddqbfV
=ylSo
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--


