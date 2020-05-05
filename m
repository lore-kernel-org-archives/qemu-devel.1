Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4EC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CCA206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwpBjHN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CCA206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxp3-0006hg-AN
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVxlz-0002ji-Oh
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:38:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVxly-0008Og-Mr
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588685889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PjtFndofswV84lGCDXEx/tJcJK6oxiPjaaH5034F7k=;
 b=NwpBjHN5D5fRpEvueiAOk3punAwsJL+FSiSyvZbmNPCWWK8HJe6tahslmb9U6D+DVrL5Uf
 dN2jFnEbEHZo2eZz6tyt7qbMSkKRw5L6prijW592BN6jPoiVQP9zmGQG3q46EtkGp6udOk
 40sC820SEEWp4LwA9R6Dan2hoTmyznI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-2TkA3j0NP3WWZlQQutLj-g-1; Tue, 05 May 2020 09:38:07 -0400
X-MC-Unique: 2TkA3j0NP3WWZlQQutLj-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA6C800D24;
 Tue,  5 May 2020 13:38:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8EFA2E037;
 Tue,  5 May 2020 13:38:05 +0000 (UTC)
Date: Tue, 5 May 2020 15:38:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 03/33] block: Add BdrvChildRole and BdrvChildRoleBits
Message-ID: <20200505133804.GL5759@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-4-mreitz@redhat.com>
 <20200505111936.GJ5759@linux.fritz.box>
 <aa2c60ac-0e41-bf3b-d81d-fe504c42c172@redhat.com>
 <20200505125413.GK5759@linux.fritz.box>
 <3b03c233-7aa7-b292-d05a-c9a79d7e9703@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3b03c233-7aa7-b292-d05a-c9a79d7e9703@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.05.2020 um 15:20 hat Max Reitz geschrieben:
> On 05.05.20 14:54, Kevin Wolf wrote:
> > When you're the author, the meaning of everything is clear to you. :-)
> >=20
> > In case of doubt, I would be more explicit so that the comment gives a
> > clear guideline for which role to use in which scenario.
>=20
> OK, so you mean just noting everywhere explicitly how many children can
> get a specific flag, and not just in some cases?  That is, make a note
> for DATA and METADATA that they can be given to an arbitrary number of
> children, and COW only to at most one.

Sounds good to me.

> >>> blkverify:
> >>>
> >>> * x-image: BDRV_CHILD_PRIMARY | BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
> >>> * x-raw: BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
> >>>
> >>> Hm, according to the documentation, this doesn't work, FILTERED can b=
e
> >>> set only for one node. But the condition ("the parent forwards all re=
ads
> >>> and writes") applies to both children. I think the documentation shou=
ld
> >>> mention what needs to be done in such cases.
> >>
> >> I don=E2=80=99t know.  blkverify is a rare exception by design, becaus=
e it can
> >> abort when both children don=E2=80=99t match.  (I suppose we could the=
oretically
> >> have a quorum mode where a child gets ejected once a mismatch is
> >> detected, but that isn=E2=80=99t the case now.)
> >=20
> > Well, yes, this is exceptional. I would ignore that property for
> > assigning roles because when it comes to play, roles don't matter any
> > more because the whole process is gone. So...
> >=20
> >> Furthermore, I would argue that blkverify actually expects the formatt=
ed
> >> image to sometimes differ from the raw image, if anything, because the
> >> format driver is to be tested.  This is the reason why I chose x-raw t=
o
> >> be the filtered child.
> >=20
> > ...I don't think this case is relevant. If blkverify returns something,
> > both children have the same data.
>=20
> Another argument is that right now, bs->file points to x-raw, and
> .is_filter is set.  So x-raw is already treated as the filtered child.

I admit defeat. :-)

> >> So there is no general instruction on what to do in such cases that I
> >> followed here, I specifically chose one child based on what blkverify =
is
> >> and what it=E2=80=99s supposed to do.  Therefore, I can=E2=80=99t real=
ly give a general
> >> instruction on =E2=80=9Cwhat needs to be done in such cases=E2=80=9D.
> >=20
> > Maybe the missing part for me is what FILTERED is even used for. I
> > assume it's for skipping over filters in certain functions in the
> > generic block layer?
>=20
> Yes.
>=20
> > In this case, maybe the right answer is that...
> >=20
> >>> For blkverify, both
> >>> children are not equal in intention, so I guess the "real" filtered
> >>> child is x-image. But for quorum, you can't make any such distinction=
. I
> >>> assume the recommendation should be not to set FILTERED for any child
> >>> then.
> >>
> >> Quorum just isn=E2=80=99t a filter driver.
> >=20
> > ...blkverify isn't one either because performing an operation on only
> > one child usually won't be correct.
>=20
> Good point.  It would work if filters are just skipped for functions
> that read/query stuff, which I think is the case.  I don=E2=80=99t think =
we ever
> skip filters when it comes to modifying data.
>=20
> In any case, I wouldn=E2=80=99t lose too much sleep over blkverify whatev=
er we
> do.  It=E2=80=99s a driver used purely for debugging purposes.

Yeah, I'm not really worried about blkverify per se. It just seems like
an interesting corner case to discuss to make sure that the design of
the role system is right and doesn't miss anything important.

> > Maybe the more relevant question would be if a FILTERED child must be
> > the only child to avoid the problems we're discussing for blkverify. Bu=
t
> > I think I already answered that question for myself with "no", so
> > probably not much use asking it.
>=20
> blkverify is just a bit weird, and I personally don=E2=80=99t mind just t=
reating
> it as something =E2=80=9Cspecial=E2=80=9D, considering it=E2=80=99s just =
a debugging aid.
>=20
> Regardless of blkverify, I don=E2=80=99t think FILTERED children must be =
the
> only children, though, because I can well imagine filter drivers having
> metadata children on the side, e.g. config data or bitmaps (not just
> dirty bitmaps, but also e.g. what to cache for a hypothetical cache drive=
r).

The example of a caching driver that uses a child node for the cached
data (probably on a fast, but small disk) was what made me answer the
question with "no".

But as you write, having a pure metadata child could make sense, too.

Kevin

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6xbDwACgkQfwmycsiP
L9ZkRA/+PyHEosicGB/SsSVPro1ZrR7HHXg0M1QWpmAKmTNFihboDXANcLb8/0mD
65U+AbfTqfHqMXrDRnAEf7/Al+6s5rA9uKyveZ7r43sUIUJ+qSqAApGB6VV+lKtr
DGBFcQfxGThFDR1V7CHPRH8EtGvCzADcMLzikOO5pDsXJlugi/pOSqABS02dQAQt
QpQo2uq/HoUtV0tJGfT8+jBMwprgk0a/VotTBZ00G8Qdmzhkd3a6hYZLI3xS7FIi
0Q9I0owcmxMAVPvLZOu87ogm1TQ6xsDmXHjbO+/so37yaYTrwJqod1/tPU4RZJO/
ecu7PzbCGftO1aEzIRR4g+dNa3T3URQ99CVjbYyYRuOiwke84nYiJRcmMMX5XvTe
NTrFZbPcAhbzLAo7Xl9L4qlKbeq5PyztyTj6GXwa7P0GnkvtEplyoYMm2d9xrPOP
pUnbVvkBdPzpSRxYvdZp6W3SkLS1UerBdQC1hH6Xul0dkgk/g0SqrsaNDfmTOCgo
cUxgYzcnbrV/dqGPLOEinRvybMAV9479RFbfHQehh1LqKuCUE424boX9RNzzYr3G
APB2zSmQmtA3iaNa3QQnOAjkbWP8+Fstwl3Mor7D2CTIPa3Mtxyd1Ae4kGFfA3vK
a7KwPxf6wBOMeQz3eAyDEIgcP8L0V81qmeEd/jr78LuXQU8mu80=
=vWl6
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--


