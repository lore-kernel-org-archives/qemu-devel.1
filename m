Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D030D2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVQ8WUcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D030D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jng9f-0001Vy-3x
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jng8p-0000Xp-Op
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:26:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jng8o-0001Tu-1T
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592908017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9FVErCbBpiCGmMkNHyoUdCA77hLC6xbLiRIcUSWYGM=;
 b=JVQ8WUcTeZNp3zVqF4Dg2p7Me8BDWh83+MEBvZrTt6DSQiZNqmmD0DAK6JeDfUDL3kJYRv
 6FmGODvgxtLxg8q/jLOJKy1TU33ixHrEGWkHgGoFXdpA+BtGf7IA2GcKTGqNk3BaMY6BHO
 wjihBiirafqgwoD5p9KoPCpswYTPYcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-IaElMXctNia_m3vIUM-jgQ-1; Tue, 23 Jun 2020 06:26:54 -0400
X-MC-Unique: IaElMXctNia_m3vIUM-jgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0CBD800597;
 Tue, 23 Jun 2020 10:26:53 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-78.ams2.redhat.com [10.36.115.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6E135C296;
 Tue, 23 Jun 2020 10:26:52 +0000 (UTC)
Date: Tue, 23 Jun 2020 12:26:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
Message-ID: <20200623102651.GE5853@linux.fritz.box>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
 <w51eeqb9f43.fsf@maestria.local.igalia.com>
 <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
 <eaa796ca-9379-def8-0c2c-0f4b3ca500de@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eaa796ca-9379-def8-0c2c-0f4b3ca500de@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.06.2020 um 11:48 hat Max Reitz geschrieben:
> On 22.06.20 11:35, Max Reitz wrote:
> > On 19.06.20 18:47, Alberto Garcia wrote:
> >> On Fri 19 Jun 2020 12:40:11 PM CEST, Max Reitz wrote:
> >>> +    if (qcow2_opts->data_file_raw &&
> >>> +        qcow2_opts->preallocation =3D=3D PREALLOC_MODE_OFF)
> >>> +    {
> >>> +        /*
> >>> +         * data-file-raw means that "the external data file can be
> >>> +         * read as a consistent standalone raw image without looking
> >>> +         * at the qcow2 metadata."  It does not say that the metadat=
a
> >>> +         * must be ignored, though (and the qcow2 driver in fact doe=
s
> >>> +         * not ignore it), so the L1/L2 tables must be present and
> >>> +         * give a 1:1 mapping, so you get the same result regardless
> >>> +         * of whether you look at the metadata or whether you ignore
> >>> +         * it.
> >>> +         */
> >>> +        qcow2_opts->preallocation =3D PREALLOC_MODE_METADATA;
> >>
> >> I'm not convinced by this,
> >=20
> > Why not?
> >=20
> > This is how I read the spec.  Furthermore, I see two problems that we
> > have right now that are fixed by this patch (namely (1) using a device
> > file as the external data file, which may have non-zero data at
> > creation; and (2) assigning a backing file at runtime must not show the
> > data).
> >=20
> >> but your comment made me think of another
> >> possible alternative: in qcow2_get_cluster_offset(), if the cluster is
> >> unallocated and we are using a raw data file then we return _ZERO_PLAI=
N:
> >>
> >> --- a/block/qcow2-cluster.c
> >> +++ b/block/qcow2-cluster.c
> >> @@ -654,6 +654,10 @@ out:
> >>      assert(bytes_available - offset_in_cluster <=3D UINT_MAX);
> >>      *bytes =3D bytes_available - offset_in_cluster;
> >> =20
> >> +    if (type =3D=3D QCOW2_CLUSTER_UNALLOCATED && data_file_is_raw(bs)=
) {
> >> +        type =3D QCOW2_CLUSTER_ZERO_PLAIN;
> >> +    }
> >> +
> >>      return type;
> >>
> >> You could even add a '&& bs->backing' to the condition and emit a
> >> warning to make it more explicit.
> >=20
> > No, this is wrong.  This still wouldn=E2=80=99t fix the problem of havi=
ng a
> > device file as the external data file, when it already has non-zero dat=
a
> > during creation.  (Reading the qcow2 file would return zeroes, but
> > reading the device would not.)
> >=20
> > So it would need to be QCOW2_CLUSTER_NORMAL.  Which is kind of the
> > point, when you think about it =E2=80=93 with data-file-raw, all cluste=
rs must
> > always effectively be QCOW2_CLUSTER_NORMAL and be mapped 1:1.
> >=20
> > Well, and that=E2=80=99s in turn the point of this patch.
> >=20
> > I interpret the spec in that the metadata can be ignored, but it does
> > not need to be ignored.  So the L1/L2 tables must be 1:1 mapping of
> > QCOW2_CLUSTER_NORMAL entries.
> >=20
> > We could also choose to interpret it as =E2=80=9CWith data-file-raw, th=
e L1/L2
> > tables must be ignored=E2=80=9D.  In that case, our qcow2 driver would =
need to
> > be modified to indeed fully ignore the L1/L2 tables with data-file-raw.
> >  (I certainly don=E2=80=99t interpret the spec this way, but I suppose =
we could
> > call it a bug fix and amend it.)
>=20
> I just realized that this is not possible.  data-file-raw is an
> autoclear flag, so the image must appear the same to qemu versions that
> do not support it.
>=20
> If we want to fully ignore the L1/L2 tables or interpret them some
> non-default way (like you=E2=80=99re proposing), we would have to add a n=
ew
> incompatible flag.

We could drop the data-file-raw autoclear flag (causing new QEMU
versions to downgrade any existing images) and call the new incompatible
flag data-file-raw (leaving the user interface unchanged).

Kevin

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl7x2OsACgkQfwmycsiP
L9YhEQ/+Id8VHejeMy1B2vMkigbTUBsTeXD6btYYYFXeiAZDsbAt3ZIa3ix1fKtz
fLkwUhr7ctOyj7JQ9DAao9WAQox9xoPX32QKZvNW/cH3GdyZXSW315XVUjaPyiol
cH+AsPdZh7/v8BatKkA6tZ8nuCvHJE29rzIHdx81Z+KNSUc8q3i4EqNuAeMFiI3h
ApBPE+gD1ugm9eNIVIkBgbZGoaDx54pQzTjq4qxBGxaHg7fuCmi1DRZ0scH8xPZ3
pDrE9V3vTTvymf3NoTgYOxw2zuCvovQWup6vtrDS3fVRAhPcCf7MazgLm7GCuAvi
e09uiYinxfrF7pWmh20Z+KwYJeq+bPigmf1FrnXhpWhCyMR4bhxhEMfqp2EHwGZo
34lW6JmCrlWKAGtovcD+lQC04IiLkKW3K6j2izPypcSlse5njFIsdjnRKV2kpjYO
aEqoYYa0lLfUVPqxX9weF63lYnHMWCXC9hx7VEj4oRA3beweIz5DJ8WgGExHqFPp
LSOUYn7XW/2t9KRi/vXs1uwHDazud+k4LyD7Lg3W5zNl7tJK/rbpS/HWaTD/RC9x
99MzW3sDeqXktJiIsRhhva6mwfhN/WB69MitRu2oRaBAcMQBr56BE7HH5ytPjLsD
hlujFWjE7FjpeNB/GP6vBlSsAsDSaAx5I/tyNu2xCaj+kFiAC6Q=
=NcQj
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


