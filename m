Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87DAC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0502073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIowMuWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0502073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOMz-0004R2-N1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1isOMA-0003vG-RE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1isOM6-0003VH-VC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:55:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1isOM6-0003Un-RG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579254954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMo9uVILltaja9uUxb1mJaklNZYYnDnYw9d4UEcgmpU=;
 b=aIowMuWGTgWbpHpymN+GW2uFUbB8v1ot2W392bulrfNY854FxiWdTNZ0gXAxS6L+0ZpZsW
 iDhdpmIwTQXClIsvZjZOaMFm+OhBVIKiJ8KXvxpi32c12MocIa9gtmggVlXMUx7N4B9qhM
 8SbTBdUTXpIXXGJ5pWjl1yVyDMukBdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-GfmOTGlTPNazxda-_s5Cpg-1; Fri, 17 Jan 2020 04:55:50 -0500
X-MC-Unique: GfmOTGlTPNazxda-_s5Cpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BC2B108BCDA;
 Fri, 17 Jan 2020 09:55:49 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11280845D3;
 Fri, 17 Jan 2020 09:55:39 +0000 (UTC)
Date: Fri, 17 Jan 2020 10:55:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the
 hardcoded value
Message-ID: <20200117095538.GB7394@dhcp-200-226.str.redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
 <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
 <w517e1rf0fo.fsf@maestria.local.igalia.com>
 <56ec1ead-bba9-f4de-5c87-e81f802dfc79@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56ec1ead-bba9-f4de-5c87-e81f802dfc79@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.01.2020 um 10:12 hat Max Reitz geschrieben:
> On 17.01.20 00:26, Alberto Garcia wrote:
> > On Tue 14 Jan 2020 03:15:48 PM CET, Max Reitz wrote:
> >>> @@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64_t=
 offset,
> >>>   * Writes one sector of the L1 table to the disk (can't update singl=
e entries
> >>>   * and we really don't want bdrv_pread to perform a read-modify-writ=
e)
> >>>   */
> >>> -#define L1_ENTRIES_PER_SECTOR (512 / 8)
> >>> +#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
> >>>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
> >>
> >> Here it=E2=80=99s because the comment is wrong: =E2=80=9CCan=E2=80=99t=
 update single entries=E2=80=9D =E2=80=93
> >> yes, we can.  We=E2=80=99d just have to do a bdrv_pwrite() to a single=
 entry.
> >=20
> > What's the point of qcow2_write_l1_entry() then?
>=20
> I think the point was that we couldn=E2=80=99t, for a long time, because =
the
> block layer only provided sector-granularity access.  This function
> simply was never changed when the block layer gained the ability to do
> byte-granularity I/O.
>=20
> (We=E2=80=99d still need this function, but only for the endian swap, I t=
hink.)

We still can't do byte-granularity writes with O_DIRECT, because that's
a kernel requirement.

The comment explains that we don't want to do a RMW cycle to write a
single entry because that would be slower than just writing a whole
sector. I think this is still accurate. Maybe we should change the
comment to say "can't necessarily update". (The part that looks really
wrong in the comment is "bdrv_pread", that should be "bdrv_pwrite"...)

Now, what's wrong about the logic to avoid the RMW is that it assumes
a fixed required alignment of 512. What it should do is looking at
bs->file->bl.request_alignment and rounding accordingly.

> >>> @@ -3836,7 +3837,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
> >>>          case QCOW2_CLUSTER_NORMAL:
> >>>              child =3D s->data_file;
> >>>              copy_offset +=3D offset_into_cluster(s, src_offset);
> >>> -            if ((copy_offset & 511) !=3D 0) {
> >>> +            if (!QEMU_IS_ALIGNED(copy_offset, BDRV_SECTOR_SIZE)) {
> >>
> >> Hm.  I don=E2=80=99t get this one.
> >=20
> > Checking the code (e.g. block_copy_do_copy()) it seems that the whole
> > chunk must be cluster aligned so I don't get this one either.
>=20
> Hm, how did you get to block_copy_do_copy()?  That=E2=80=99s part of the
> block-copy infrastructure that=E2=80=99s only used for the backup job, as=
 far as
> I=E2=80=99m aware.  It=E2=80=99s different from copy_range.
>=20
> I don=E2=80=99t see any limitation for copy_range.  I suppose maybe it do=
esn=E2=80=99t
> work for anything that isn=E2=80=99t aligned to physical sectors?  But th=
e qcow2
> driver shouldn=E2=80=99t care about that.
>=20
> On thing=E2=80=99s for sure, the raw driver doesn=E2=80=99t care about it=
.

I don't understand this one either.

Kevin

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeIYSaAAoJEH8JsnLIjy/WyQ0P/i3yv0wXYN7fIsk7mWWSOQXn
ZRRwlJkPz83G1k68KKPcqiJxjLOI72vgdwwrMtPuTD3MWHdFGgX8/DelvPfaF/cw
Fw0OFPsguLSz5S/5bsa7VuiBUAPO8DgeMb+S7gWhGuMTo698UlGXT5a2uoYsDUZP
oHpAtXCW1g7bbyp2mZCw+cLPIN+Pru01pkxxv2RlRJcD9MD4Xm7W9Nyt7FegL34l
8DOdfMSG7hNieweXHCJwQSoJWhnZyGq/aZMPnlvRas+1vb18xaiOZ7eNKssgkfTZ
zO+RanVjnhIobiQCvGsK8CI3LDcboLVYH3nyyGw7d5fFR3vET18c5GWyRV/ID0LK
1s6F2UymAZQyGsuxoXjR1RusHu2CAAdauKVihSkunHSQ9D0aZ/cwnwFJnTvhN7cT
Lwzw580vliu7jB+Guztk1hyOYWUE0+JCedORd+BHB5z/Ippp0FeXkd2lmOAi+aIH
XJm3TV7KkcKL0zrbV6u0qKDpojzE8kiAJnWeSgP2lDnqcIymn4j+1FTASzjgaDT0
UziRsgsLm0Yn/RtM4stvAs30BRIwxFlyXQVsxYaJoaxy02D2UyjAPLEjum3bV8MO
EhqxlYB8uXNhzkSgvAgcit4mLVAjru6MNAwkBggYVmnrwWX+u1ua2pEg1irNvgVs
I4600aYycLhIIx0up892
=8nKQ
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--


