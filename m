Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17715C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF99D2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx8gazBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF99D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdbU-0000Qb-11
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvdac-0007cn-V2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:20:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48432
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvdab-0007Z2-6h
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594804832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NmrVjH3XzfnDrOinakxg55/YmVhcihL0FdrmBGUC/Ys=;
 b=Hx8gazBTxDJco6cQk6PYVhG+ea0WqhqsYvo1XWU5fi+MqjSt04T2nwdpb3vtbuZ2h33ZSG
 +XyWibpWMuB4ahmIYSTKzWkms5bOddTGNp0WI6vVsm9t3z/ciogKi7FGDXQLK+XFnkUnP0
 9A6B+T0cYU/9Y0GKvwlBFsvwuvNOoI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-plghDg5INny9OkiXWowsWQ-1; Wed, 15 Jul 2020 05:20:30 -0400
X-MC-Unique: plghDg5INny9OkiXWowsWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6483618C63C0;
 Wed, 15 Jul 2020 09:20:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-240.ams2.redhat.com [10.36.114.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7092910013D0;
 Wed, 15 Jul 2020 09:20:28 +0000 (UTC)
Date: Wed, 15 Jul 2020 11:20:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
Message-ID: <20200715092026.GA8833@linux.fritz.box>
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
 <20200713142949.GD10318@linux.fritz.box>
 <b91329db-303f-41ab-5638-3ec7543b55ac@redhat.com>
 <20200714110837.GB5120@linux.fritz.box>
 <af19cad2-f718-c17b-5856-ed0c8cbd3db3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <af19cad2-f718-c17b-5856-ed0c8cbd3db3@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.07.2020 um 18:22 hat Max Reitz geschrieben:
> On 14.07.20 13:08, Kevin Wolf wrote:
> > Am 14.07.2020 um 11:56 hat Max Reitz geschrieben:
> >> On 13.07.20 16:29, Kevin Wolf wrote:
> >>> Am 13.07.2020 um 13:19 hat Max Reitz geschrieben:
> >>>> On 10.07.20 16:21, Kevin Wolf wrote:
> >>>>> Unaligned requests will automatically be aligned to bl.request_alig=
nment
> >>>>> and we don't want to extend requests to access space beyond the end=
 of
> >>>>> the image, so it's required that the image size is aligned.
> >>>>>
> >>>>> With write requests, this could cause assertion failures like this =
if
> >>>>> RESIZE permissions weren't requested:
> >>>>>
> >>>>> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `en=
d_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> >>>>>
> >>>>> This was e.g. triggered by qemu-img converting to a target image wi=
th 4k
> >>>>> request alignment when the image was only aligned to 512 bytes, but=
 not
> >>>>> to 4k.
> >>>>>
> >>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>>>> ---
> >>>>>  block.c | 10 ++++++++++
> >>>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> (I think we had some proposal like this before, but I can=E2=80=99t =
find it,
> >>>> unfortunately...)
> >>>>
> >>>> I can=E2=80=99t see how with this patch you could create qcow2 image=
s and then
> >>>> use them with direct I/O, because AFAICS, qemu-img create doesn=E2=
=80=99t allow
> >>>> specifying caching options, so AFAIU you=E2=80=99re stuck with:
> >>>>
> >>>> $ ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 1M
> >>>> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 cluster_size=3D65536
> >>>> compression_type=3Dzlib size=3D1048576 lazy_refcounts=3Doff refcount=
_bits=3D16
> >>>>
> >>>> $ sudo ./qemu-io -t none /mnt/tmp/foo.qcow2
> >>>> qemu-io: can't open device /mnt/tmp/foo.qcow2: Image size is not a
> >>>> multiple of request alignment
> >>>>
> >>>> (/mnt/tmp is a filesystem on a =E2=80=9Closetup -b 4096=E2=80=9D dev=
ice.)
> >>>
> >>> Hm, that looks like some regrettable collateral damage...
> >>>
> >>> Well, you could argue that we should be writing full L1 tables with z=
ero
> >>> padding instead of just the used part. I thought we had fixed this lo=
ng
> >>> ago. But looks like we haven't.
> >>
> >> That would help for the standard case.  It wouldn=E2=80=99t when the c=
luster
> >> size is smaller than the request alignment, which, while maybe not
> >> important, would still be a shame.
> >=20
> > I don't think it would be unreasonable to require a cluster size that i=
s
> > a multiple of the logical block size of your host storage if you want t=
o
> > use O_DIRECT.
>=20
> True.
>=20
> > But we have unaligned images in practice, so this is pure theory anyway=
.
>=20
> Hm.  Maybe it would help to just adjust the error message to instruct
> the user to resize the image to fit the request alignment?  (e.g. =E2=80=
=9Cis
> not a multiple of the request alignment %u (try resizing the image to
> %llu bytes)=E2=80=9D)

This would require management tools to automatically do this or we would
break any users that don't manually invoke QEMU. I don't think this is a
realistic option, especially since "management tools" must probably
include all those one-off shell scripts that people use.

> >>> But we should still avoid crashing in other cases, so what is the
> >>> difference between both? Is it just that qcow2 has the RESIZE permiss=
ion
> >>> anyway so it doesn't matter?
> >>
> >> I assume so.
> >>
> >>> If so, maybe attaching to a block node with WRITE, but not RESIZE is
> >>> what needs to fail when the image size is unaligned?
> >>
> >> That sounds reasonable.
> >>
> >> The obvious question is what happens when the RESIZE capability is
> >> removed.  Dropping capabilities may never fail =E2=80=93 I suppose we =
could
> >> force-keep the RESIZE capability for such nodes?
> >=20
> > It's not nice, but I think we already have this kind of behaviour for
> > unlocking failures. So yes, that sounds like an option.
> >=20
> >> Or we could immediately align such files to the block size once they
> >> are opened (with the RESIZE capability).
> >=20
> > Automatically resizing the image file is obviously harmless for qcow2
> > images, but it would be a guest-visible change for raw images. It might
> > be better to avoid this.
>=20
> Well, it seems to be what already happens if the guest device has taken
> the RESIZE capability (i.e., whenever there=E2=80=99s no failing assertio=
n).
> The only difference that appears to me is just that it happens only when
> writing to the end of the image instead of unconditionally when opening i=
t.

I would have considered this as part of the bug rather than a desirable
future behaviour. blk_check_byte_request() tries to catch any request
going past EOF, it just doesn't know anything about request_alignment.

Kevin

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8OyloACgkQfwmycsiP
L9bXxxAArK11JQv8MHHDGQXbG1ebsWwAYA07G/Me9Bf2GD4vANQuRDxFmtzq8Jyp
Y8yLnVSQCgo7fpNYQ00eCBO9kq/ykBngbQUZVL6rrCWs+8DwSK29Z5GWAj41DUKo
pqvcMB9xF9cBch1tj6kx9QVasgj7OXJDGVCrChVPORvLBmLe6bxQaWFrHLyN/o/o
hJbMWtaN4YwAGxs+emuhLgf/LjaC2p889olnKlNsV3KnAlWf2Mf0mcjsS1goPVyW
kIENRU1JOh7UUcHaRk2/6NuaiPWWpsI96AArWnvvAuX401Aj9jY9yr9FGEWGtp+T
pdQE7v+hyz0eLh6yFlSxqXPvujG+rXCFJjG20p3NEkosPBvAvjTt6LHCk83dXeE8
UTLlxVF5GIkn+1kdPx3T6/IfWRlFLi948cVOyg1vWyPks93cIU/lOvqROb5sl/tC
go1++ExihVk8NGuJjzBDTPKNXqRALZMYgLCd6vvdk3GiDRvs7Jw5E+63VGnd0E7M
5Zyqd+iLpWZDBq4lnBpfLMnIam7CHwn6IgCL6uGXajXGVF7LC6gJreImtNh+San1
KWj3rS1FJdVDft0Jdi4o9/qXMK1RpVUxlOMHXr15cAECN8WVh9XtiCYTm1UcNGV5
fD48bUSrfeY8bt/hLA+jibZGSLjLQutVu8CxNeqHujD1YAgA5V8=
=krmH
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


