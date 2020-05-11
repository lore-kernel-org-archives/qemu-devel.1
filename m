Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2845720675
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St0qBRPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAOm-0007Cv-7E
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYANL-000641-Kz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:29:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYANK-0005Bw-0E
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589210988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0p45Fn+r4miiKELrnuTBmW3zqlOzzP0A2zaL7ya4Ph0=;
 b=St0qBRPw42IZXOmawu6UwViGZRo7a4OAV1SCIt3M22qEtwdmc/CkAqE74cfCIKkYweOREg
 Mhl3f2tzuaYJtzrDXtJRRs3WWuYrpqXQu539JHxP7Xt1ZPXWv2HmY8Yz2EFZYITNS5YeUQ
 orOAZ6pGgCzQ75Y15pE+mc+5yct6ouA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-xT80-a1aMGq7UpLtEG8ibQ-1; Mon, 11 May 2020 11:29:46 -0400
X-MC-Unique: xT80-a1aMGq7UpLtEG8ibQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 483C28005B7;
 Mon, 11 May 2020 15:29:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6AC5D9DC;
 Mon, 11 May 2020 15:29:43 +0000 (UTC)
Date: Mon, 11 May 2020 17:29:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 1/4] iotests/109: Don't mirror with mismatched size
Message-ID: <20200511152942.GE5661@linux.fritz.box>
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-2-kwolf@redhat.com>
 <8bd8e50f-30b8-f3b7-acd1-6f2cfb32a2f3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8bd8e50f-30b8-f3b7-acd1-6f2cfb32a2f3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.05.2020 um 17:08 hat Max Reitz geschrieben:
> On 11.05.20 15:58, Kevin Wolf wrote:
> > This patch makes the raw image the same size as the file in a different
> > format that is mirrored as raw to it to avoid errors when mirror starts
> > to enforce that source and target are the same size.
> >=20
> > We check only that the first 512 bytes are zeroed (instead of 64k)
> > because some image formats create image files that are smaller than 64k=
,
> > so trying to read 64k would result in I/O errors. Apart from this, 512
> > is more appropriate anyway because the raw format driver protects
> > specifically the first 512 bytes.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/109           | 10 ++---
> >  tests/qemu-iotests/109.out       | 74 +++++++++++++-------------------
> >  tests/qemu-iotests/common.filter |  5 +++
> >  3 files changed, 41 insertions(+), 48 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
> > index 5bc2e9b001..3ffeaf3c55 100755
> > --- a/tests/qemu-iotests/109
> > +++ b/tests/qemu-iotests/109
> > @@ -77,14 +77,14 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
> >      echo "=3D=3D=3D Writing a $fmt header into raw =3D=3D=3D"
> >      echo
> > =20
> > -    _make_test_img 64M
> >      TEST_IMG=3D"$TEST_IMG.src" IMGFMT=3D$fmt _make_test_img 64M
> > +    _make_test_img $(du -b "$TEST_IMG.src" | cut -f1) | _filter_img_cr=
eate_size
>=20
> Why du and not the file length (stat -c '%s')?

Because the test from which I copied had 'du' and the internet claimed
that 'stat -c' isn't portable. Now I see that we do use it in other test
cases, so I guess it would have been fine, too. Is there a good reason
why 'stat' would be better?

Kevin

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl65b2UACgkQfwmycsiP
L9aROQ//bSsCdnzbvwUOCUd4Op/2gQnyor+x5DBbMoGKMpmyjdztur+wCo3icXfL
0sdzfSJse6mgaRmjNQD5dWQ7F4sa+foM6cPLnrUmOpJjLvUIZ07IVniyVTWKLjsk
Ode8UiB678+t6xDFvfZuvb6wYs0GSKg8WBGBzmCtOMP0NxyLtdfrPE7b6yqHrWjC
fadauwfNzlfS5bPQQoGp6MWw1tO7F/srHXD2dP9/QjvIWbLg0EJziZlgiZ00Fb2U
lLhVQPf0WXxWm6PECmgUVLTCf95Un7+72mGw5h04pa7okpb6nkyHwITL8FZ754MM
/QKdvb9yAhqst4OvcciIrRxSjqFFRGrpXaA/SYs6NkvO8OJryiWPpRBT+eqmHEv/
GMVYJM2eDIJJ5HXThcx/6+RwjY5/aphjqhk79x7SS442qFoAED7o7p3adLhP6y6s
E5kvosLuzx6lWhnIYql4lPkoR6VEqWJmvd1QNfTpKghn4nQ+lI4DZQtzL6t4YBHF
lYiFGjlEIvKDy2o+vnOiulWqYEFp5WT5WFGiR6fvDXqlNRECdcOGPRzGjk1FX+ui
N6zF+U8U6ky6Dmg9dZXQ2zMo49AfP6fkltRyz5m8016flD+aHZnI7zsQ4d8Tbsgr
CMhhQwxf7Qm7nbc/UODGWTIBUkUaFY2pKNujc+7O3+t0zddmSVc=
=jAJc
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


