Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC498206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CruS9nXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC498206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhC0M-0000Bh-3P
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jhBy6-0006VX-8J
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:01:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jhBy5-0007Sd-04
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591362064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NxjfxFpY3wz71tGMnNanWCnUz6EzamHKgSpcdySVfWc=;
 b=CruS9nXjjwxkoNOUv6EmxAr1B2Peszt3+0UqAcmkrZkcchBRPWtx42hQ3gVbpQO8Idil+D
 /IWTE5l3W+hl+3JALXoJDlbBM5hygrL0tX+mhceB3/pmj1MUYFPRyHmTKO2dR/c2jitb8n
 //NB7FvgksgCtKTXxmL11th0/c3J1yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-eWInqntDM2CxGHY413294A-1; Fri, 05 Jun 2020 09:00:46 -0400
X-MC-Unique: eWInqntDM2CxGHY413294A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234271054F93;
 Fri,  5 Jun 2020 13:00:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-112.ams2.redhat.com [10.36.113.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA00E891C1;
 Fri,  5 Jun 2020 13:00:43 +0000 (UTC)
Date: Fri, 5 Jun 2020 15:00:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
Message-ID: <20200605130042.GK5869@linux.fritz.box>
References: <20200415190207.21118-1-berto@igalia.com>
 <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
 <20200605111431.GI5869@linux.fritz.box>
 <89f29fa3-d5e4-fd9f-5d51-0b2ffce82ade@redhat.com>
MIME-Version: 1.0
In-Reply-To: <89f29fa3-d5e4-fd9f-5d51-0b2ffce82ade@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.06.2020 um 14:11 hat Max Reitz geschrieben:
> On 05.06.20 13:14, Kevin Wolf wrote:
> > Am 03.06.2020 um 15:53 hat Max Reitz geschrieben:
> >> On 15.04.20 21:02, Alberto Garcia wrote:
> >>> Although we cannot create these images with qemu-img it is still
> >>> possible to do it using an external tool. QEMU should refuse to open
> >>> them until the data-file-raw bit is cleared with 'qemu-img check'.
> >>>
> >>> Signed-off-by: Alberto Garcia <berto@igalia.com>
> >>> ---
> >>>  block/qcow2.c              | 39 ++++++++++++++++++++++++++++++++++++=
++
> >>>  tests/qemu-iotests/244     | 13 +++++++++++++
> >>>  tests/qemu-iotests/244.out | 14 ++++++++++++++
> >>>  3 files changed, 66 insertions(+)
> >>
> >> Sorry for the long delay. :/
> >>
> >> The patch itself looks good, but I=E2=80=99m not sure whether it is ex=
tensive
> >> enough.  Let me just jump straight to the problem:
> >>
> >> $ ./qemu-img create -f qcow2 \
> >>     -o data_file=3Dfoo.qcow2.raw,data_file_raw=3Don \
> >>     foo.qcow2 64M
> >> (Create some file empty foo.qcow2 with external data file that=E2=80=
=99s raw)
> >>
> >> $ ./qemu-img create -f qcow2 backing.qcow2 64M
> >> $ ./qemu-io -c 'write -P 42 0 64M' backing.qcow2
> >> (Create some file filled with 42s)
> >>
> >> $ ./qemu-img compare foo.qcow2 foo.qcow2.raw
> >> Images are identical.
> >> (As expected, foo.qcow2 is identical to its raw data file)
> >>
> >> $ ./qemu-img compare --image-opts \
> >>     file.filename=3Dfoo.qcow2,backing.file.filename=3Dbacking.qcow2 \
> >>     file.filename=3Dfoo.qcow2.raw
> >> Content mismatch at offset 0!
> >> (Oops.)
> >>
> >> So when the user manually gives a backing file without one having been
> >> given by the image file, we run into the same problem.  Now I=E2=80=99=
m not
> >> quite sure what the problem is here.  We could make this patch more
> >> extensive and also forbid this case.
> >=20
> > I guess what we should really be checking is that bs->backing is NULL
> > after the node is fully opened. The challenging part is that the backin=
g
> > child isn't managed by the block driver, but by the generic block layer=
,
> > and .brv_open() comes first. So we don't really have a place to check
> > this. (And there is also the case that the image is originally opened
> > with BDRV_O_NO_BACKING and the later bdrv_open_backing_file().)
> >=20
> >> But I think there actually shouldn=E2=80=99t be a problem.  The qcow2 =
driver
> >> shouldn=E2=80=99t fall back to a backing file for raw external data fi=
les.  But
> >> how exactly should that be implemented?  I think the correct way would
> >> be to preallocate all metadata whenever data_file_raw=3Don =E2=80=93 t=
he qcow2
> >> spec doesn=E2=80=99t say to ignore the metadata with data_file_raw=3Do=
n, it just
> >> says that the data read from the qcow2 file must match that read from
> >> the external data file.
> >> (I seem to remember I proposed this before, but I don=E2=80=99t know e=
xactly...)
> >=20
> > I don't find preallocation convincing, mostly for two reasons.
> >=20
> > First is, old images or images created by another program could miss th=
e
> > preallocation, but we still shouldn't access the backing file.
>=20
> I=E2=80=99d take this patch anyway (because its motivation is just that o=
ther
> programs might produce invalid images), and then not worry about the
> case where we get an image produced by such another program (including
> older versions of qemu) for which the user overrides the backing file at
> runtime.
>=20
> > The other one is that discard breaks preallocation,
>=20
> The preallocation is about ensuring that there are no
> fall-through-to-backing holes in the image.  Discarding doesn=E2=80=99t c=
hange that.
>=20
> > so we would also
> > have to make sure to have a special case in every operation that could
> > end up discarding clusters (and to add it to every future operation we
> > might add).
> >=20
> > It just sounds very brittle.
> >=20
> >> (In contrast, I don=E2=80=99t think it would be correct to just treat
> >> unallocated clusters as zero whenever data_file_raw=3Don.)
> >>
> >> What do you think?  Should we force preallocation with data_file_raw=
=3Don,
> >> and then just take this patch, even though it still lets users give
> >> backing files to a qcow2 file at runtime without error?  (Except the
> >> backing file wouldn=E2=80=99t have an effect, then.)
> >=20
> > Honestly, maybe passing a backing file at runtime to an image that
> > doesn't logically have one is just a case of "then don't do that".
>=20
> Perhaps.
>=20
> But seeing I wondered whether I didn=E2=80=99t already propose this at so=
me
> point, there is another reason for preallocation:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00644.html
> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00329.html
>=20
> All in all, I think data_file_raw should be interpretable as =E2=80=9CYou=
 don=E2=80=99t
> have to look at any metadata to know which data to read or write=E2=80=9D=
.
> (Maybe I=E2=80=99m wrong about that.)
> Without any preallocation of metadata structure, it looks to me like we
> break that promise.
>=20
> (Yes, we could also force-zero the external data file during creation,
> and blame users who put a backing file on images that don=E2=80=99t have =
one =E2=80=93
> both of which are not unreasonable!  But we could also just preallocate
> the metadata.)

Makes sense. I'm not against preallocation during image creation. I just
think it shouldn't play a role in deciding whether an image is valid or
not.

Kevin

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl7aQfoACgkQfwmycsiP
L9ZLBhAAsBcg15/zcITqv1xUKtqEBoSrdNL3AG6VrewKGRVPGBjC5wEZFrsr+ctK
9F0pFG4Lr48frjslFiaCUCDA5RYxiOeA7oZ6I0SOoK8Bfi7e+vX4mm9vfG0oXRn7
c3ATwVQun6UkUUn16TFSntvu0etcQzeCq/yOUQM1VYgbIwakJb9CSBRGCVTytg3x
abIgJ/191d5Lx16AAalGrYDoNL6+HSsXBRZXYyfhLanE5ED3IAD9jyYjlgbU+4zV
IBc78CJUYI0gXzplLvRQhH9E60sGP/+yP1ZCfyt/yvPnLRB4Qx+4WFkRIhGsrT+U
Vc2hj9znmofSSUvPA/zGm03N9kE5LDUZkF2I9monYYBNc3xqgSyNtZC3oyX1L7bo
cxByw+v6VPif3FL7U5zZLPTBok67PtnLC0dOxWb4oaVZtJxhSks3nxFyCzLTMmAF
FNyMBfXaU/rUDm29PCMbCaxbSeUX+75zNyyOfSmXTDDrzpJ3fLwQJInA39D8s65Y
66Impkhyhwt31dEwmF+XbaFGWmS9j+val8esxsPhBpxurDYrHXsJhPfwie5jHUCe
IX5fBTHd1efZ07lcacydFkRZojKzbwAGWYu9NSYmjL627EmKdMAJalFYcCfwJAkE
HARU+yBi/PGpa3Qy9agvrZW3oyxTq26hsNPtqVqDTlAj/ZOYRJI=
=p5W4
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--


