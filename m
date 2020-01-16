Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CB4C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA4720730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHvyhhQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA4720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6VA-0008VW-W6
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1is6U8-0007QM-PJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1is6U4-0002MP-TT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:51:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1is6U4-0002Lp-N0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579186255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIX/D3lbWp9aCSHnuQ/f2BWGKDu+USFlyp9Wn/BEg4A=;
 b=FHvyhhQHhulaUMfTA8Gl93NQeM1wwgR0tAPLE+TmmyxM5Kyz4HPiLAl3rFHgysMhx6rlDW
 PGZRQH294HXYIwNRar36qjk0day5Fc4uTIZ9RVuzdnpNMNOwvtC2zn1JXurp1Oez1WPkAZ
 tI+Q081V1piwHAA2XbLFjRogOWeHLfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-AnUDmJkFNYeqY8v_ixVx_Q-1; Thu, 16 Jan 2020 09:50:52 -0500
X-MC-Unique: AnUDmJkFNYeqY8v_ixVx_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7740A800D41;
 Thu, 16 Jan 2020 14:50:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9FD60C85;
 Thu, 16 Jan 2020 14:50:49 +0000 (UTC)
Date: Thu, 16 Jan 2020 15:50:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
Message-ID: <20200116145048.GG9470@linux.fritz.box>
References: <20200116141352.GA32053@redhat.com>
 <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
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
Cc: sgarzare@redhat.com, mlevitsk@redhat.com,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.01.2020 um 15:37 hat Max Reitz geschrieben:
> On 16.01.20 15:13, Richard W.M. Jones wrote:
> > I'm not necessarily saying this is a bug, but a change in behaviour in
> > qemu has caused virt-v2v to fail.  The reproducer is quite simple.
> >=20
> > Create sparse and preallocated qcow2 files of the same size:
> >=20
> >   $ qemu-img create -f qcow2 sparse.qcow2 50M
> >   Formatting 'sparse.qcow2', fmt=3Dqcow2 size=3D52428800 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> >=20
> >   $ qemu-img create -f qcow2 prealloc.qcow2 50M -o preallocation=3Dfall=
oc,compat=3D1.1
> >   Formatting 'prealloc.qcow2', fmt=3Dqcow2 size=3D52428800 compat=3D1.1=
 cluster_size=3D65536 preallocation=3Dfalloc lazy_refcounts=3Doff refcount_=
bits=3D16
> >=20
> >   $ du -m sparse.qcow2 prealloc.qcow2=20
> >   1 sparse.qcow2
> >   51=09prealloc.qcow2
> >=20
> > Now copy the sparse file into the preallocated file using the -n
> > option so qemu-img doesn't create the target:
> >=20
> >   $ qemu-img convert -p -n -f qcow2 -O qcow2 sparse.qcow2 prealloc.qcow=
2
> >       (100.00/100%)
> >=20
> > In new qemu that makes the target file sparse:
> >=20
> >   $ du -m sparse.qcow2 prealloc.qcow2=20
> >   1 sparse.qcow2
> >   1 prealloc.qcow2         <-- should still be 51
> >=20
> > In old qemu the target file remained preallocated, which is what
> > I and virt-v2v are expecting.
> >=20
> > I bisected this to the following commit:
> >=20
> > 4d7c487eac1652dfe4498fe84f32900ad461d61b is the first bad commit
> > commit 4d7c487eac1652dfe4498fe84f32900ad461d61b
> > Author: Max Reitz <mreitz@redhat.com>
> > Date:   Wed Jul 24 19:12:29 2019 +0200
> >=20
> >     qemu-img: Fix bdrv_has_zero_init() use in convert
> >    =20
> >     bdrv_has_zero_init() only has meaning for newly created images or i=
mage
> >     areas.  If qemu-img convert did not create the image itself, it can=
not
> >     rely on bdrv_has_zero_init()'s result to carry any meaning.
> >    =20
> >     Signed-off-by: Max Reitz <mreitz@redhat.com>
> >     Message-id: 20190724171239.8764-2-mreitz@redhat.com
> >     Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >     Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> >  qemu-img.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > Reverting this commit on the current master branch restores the
> > expected behaviour.
>=20
> The commit changed the behavior because now qemu-img realizes that it
> cannot skip writing to areas that are supposed to be zero when it
> converts to an existing image (because we have no idea what data that
> existing image contains).  So that=E2=80=99s a bug fix, and I don=E2=80=
=99t think we can
> undo it without being wrong.
>=20
> The problem is that qemu-img will try to be quickthat about making these
> areas zero, and so it does zero writes (actually, it even zeroes the
> whole image) and in the process it will of course discard all preallocati=
on.
>=20
> Now, about fixing the problem I=E2=80=99m not so sure.

Wouldn't just passing -S 0 solve the problem? It should tell qemu-img
convert that you don't want it to sparsify anything.

Kevin

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeIHhIAAoJEH8JsnLIjy/WqDcP/0fFF4UXfxCIZs+aAs6W5/B6
zQIxB1Vwzrkvn4o4WHfKlJ8TPt6+t6IbzpszCKOEZAQLqFmkKksAbwkMWQ2poffu
SmWV/2m/jtQYseamYHvH8fMHgwqx+5U4WxAiAB9L0n3ztIaxfRtcLEBC6Q5Ju4EB
oU2ymXsiMSVi7+0ZLJBE95iYUqjg8ThfFdKWF+xZrd0J5RdlMZcKDO5SZhxsAm+w
1rmmD+D1a7VDMiYwTJHRKjvTjJ8OTBBy15ckpBZ+6c6yJzwJVROyCBMzl43biwYQ
IoG5qk2O47ycsRhO5onUW6KaxriKzd1K9wNy96wYdtzrNh5Z2Eun0bMl1mTwGoxs
JpLcYRaxpyyGSJZDgZ8yaZ079XnwL0RUMXPU0kSTGojlndyMyLr9R6WUkyuAA+xh
9tq22oTamMOSsXI8l7fG+0fAjwiE8o2ldawKYwdYkriiygyL2Q4r8P8aORyuj1GY
xKLkxPMhZJIK+S7Gxyu77StrQxQMka7hpnVe6rotrDHNv/3BVfwoZlp1+AfPD5RW
hMyaCcGd20Dpz+zZ6WoPpXy8xml268Tbl5O7ukgUt+clN8DS4STPigXGSir0NAUe
w+PqC3Zrdbi1gZJybg6fBTRIddfnU1ssr2xLVyR70h+LaDVCh61nhr1ifFOUnt3c
3qrWyGsqJ9DgD/4UPq0W
=aYsK
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--


