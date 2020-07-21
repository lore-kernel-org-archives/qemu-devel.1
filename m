Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC37B20702
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UesV5xbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC37B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqKx-0005z4-8O
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxqKC-0005Xw-Sn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:20:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxqKA-0002N0-EB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595330437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jYY4f1HMy5ti8jiS7EnEyxExBtkN15iF8YR4vMNr/I=;
 b=UesV5xbKj2ORMohCq0M/Ws+B3ASEPvWGuTIVq4VKbNkaOB3Yq5ckh8sgcfrm0wR5WFGmzA
 qlVLPTXSpZNK1EPcMmUPHBdg6UKAUCBixRnbIN62troywfv00YBQp6YNLVEwa1J/ID2Wdb
 tb3JiFea12IxdxqrRVy+F/+L+vuHk5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124--y0dOyDvOXmE07FLbAw0Hw-1; Tue, 21 Jul 2020 07:20:35 -0400
X-MC-Unique: -y0dOyDvOXmE07FLbAw0Hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51992855BF0;
 Tue, 21 Jul 2020 11:20:31 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 320A0277B9;
 Tue, 21 Jul 2020 11:20:30 +0000 (UTC)
Date: Tue, 21 Jul 2020 13:20:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1 2/2] iotests: Test sparseness for qemu-img
 convert -n
Message-ID: <20200721112028.GA18481@linux.fritz.box>
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-3-kwolf@redhat.com>
 <4197f423-6501-b7d4-9214-6c7979d77bd7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4197f423-6501-b7d4-9214-6c7979d77bd7@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
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

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.07.2020 um 12:19 hat Max Reitz geschrieben:
> On 20.07.20 15:18, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/122     | 34 ++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/122.out | 17 +++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >=20
> > diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> > index dfd1cd05d6..1112fc0730 100755
> > --- a/tests/qemu-iotests/122
> > +++ b/tests/qemu-iotests/122
> > @@ -281,6 +281,40 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST=
_IMG".orig
> > =20
> >  $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
> > =20
> > +echo
> > +echo '=3D=3D=3D -n to an empty image =3D=3D=3D'
> > +echo
> > +
> > +_make_test_img 64M
> > +
> > +# Convert with -n, which should not result in a fully allocated image,=
 not even
> > +# with compat=3D0.10 (because the target doesn't have a backing file)
> > +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -o compat=3D1.1 64M
> > +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> > +$QEMU_IMG map --output=3Djson "$TEST_IMG".orig
> > +
> > +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -o compat=3D0.10 64M
>=20
> It=E2=80=99s a shame that with this, the test will no longer pass with
> refcount_bits=3D1.  (Or an external data file.)

You mean because of the compat=3D0.10? We already use that in this test
case, however just with "$QEMU_IMG convert" so that $IMGOPTS doesn't
apply.

I guess I could just override $IMGOPTS for this line to get the same
behaviour here and make sure that none of these options are used.

Kevin

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8Wz3wACgkQfwmycsiP
L9azqQ/+Owc99r74hA3XpUXugCHxBaCWl4y13dggOQbJjURBd8TVE+89ONmx8nzD
nX/tvmMKKKx/7mXw47G2cjzaQFifcZ5zy7dw6epfCTB7iFrOxFWnRHQB16KO6Arp
tM0a9BRoSObF3y8RlnXD1Tl2/VImrp0yrJbghUNSmm8ch0XDUNul9ox2z+TsmxRW
nNr3JwhextVA7Ihqg4AlswektBLP0CpOLIZYTScGlmszOUjduESTaQzES4FZRQGS
f3C3iEU8KMubTPgPm2j7Ls1Gj6gxpiG+c6nAoegH1elp0InJLd69znIx6Ggs3ZyI
iih3/Rn/TNT7LrchVWUlOdIGHmjc9QYmG3BVwVetwwA6uyoXpkAd87e0GTG8OEJO
CZpLfM1hj/eJB0mvrgW4Rbc6pNrJuOgm6FdRuEKqMtqOqpjp+Ba5+Tm1ktOZQaCm
6v2VW+nK9pxfV1i+68XpsBjzVILPqWQiT6DBoDj9QfCSxC1xSGBpboqI39JvqqmE
DlZfQFzON2nsH1xYbIndQubU/QDTaVPfaDv7HiUED7FFREd7EFlRKEsdYmhn8SKJ
NNt6Qu9bpPRvm0Kz75rCesox3mihzXSDsxQzy7VHQVMnkrngLUOiB/NsLjCr9P0k
w/ur6reXnnV7wbSBltRN0BQ3nMJQ2OEeyaCTaVZwSHXu2USjXyY=
=Lpcl
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


