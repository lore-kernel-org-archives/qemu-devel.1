Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B9C4724C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D9208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTZtquKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWemv-0003Az-RH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWelq-0002OC-S4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:32:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWelp-0007Id-Sp
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588851173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLMeU2OS/uxi0LDqr2G2SeGkq5ksKW7yO92kO3x21Qs=;
 b=BTZtquKqju/UDRwwkXAqHIXQDBYEpSfaMbyElhZ+tbk1VCL7/Z+rNeiZpBjNDDUP37Jbba
 6ncFtZ211rGimDXzwVVnpFW9ud0cw6I/2Jx/G90DnHOSBQtTH2ckBhwcSxqqVmNI8x2p8H
 ouYniKkkCHynwhfygkX5ifytTss+L0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-7VS1Pu7AOZWaS_fXKGt-nA-1; Thu, 07 May 2020 07:32:50 -0400
X-MC-Unique: 7VS1Pu7AOZWaS_fXKGt-nA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0269B84B871;
 Thu,  7 May 2020 11:32:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7D22E19B;
 Thu,  7 May 2020 11:32:44 +0000 (UTC)
Date: Thu, 7 May 2020 13:32:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 26/33] block: Use child_of_bds in remaining places
Message-ID: <20200507113243.GD6019@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-27-mreitz@redhat.com>
 <20200506170426.GI6333@linux.fritz.box>
 <b05ff158-1c8c-4596-235a-1114ac0ff3a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b05ff158-1c8c-4596-235a-1114ac0ff3a1@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.05.2020 um 11:33 hat Max Reitz geschrieben:
> On 06.05.20 19:04, Kevin Wolf wrote:
> > Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> >> Replace child_file by child_of_bds in all remaining places (excluding
> >> tests).
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >=20
> >> diff --git a/block/blkreplay.c b/block/blkreplay.c
> >> index f97493f45a..71628f4d56 100644
> >> --- a/block/blkreplay.c
> >> +++ b/block/blkreplay.c
> >> @@ -27,8 +27,9 @@ static int blkreplay_open(BlockDriverState *bs, QDic=
t *options, int flags,
> >>      int ret;
> >> =20
> >>      /* Open the image file */
> >> -    bs->file =3D bdrv_open_child(NULL, options, "image",
> >> -                               bs, &child_file, 0, false, &local_err)=
;
> >> +    bs->file =3D bdrv_open_child(NULL, options, "image", bs, &child_o=
f_bds,
> >> +                               BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
> >> +                               false, &local_err);
> >=20
> > Why isn't blkreplay a filter?
> I don=E2=80=99t know, but that=E2=80=99s pre-existing.  (It doesn=E2=80=
=99t set .is_filter.)
>=20
> I=E2=80=99m afraid I have little insight into what blkreplay actually doe=
s.  I
> thought maybe in conjunction with the whole replay stuff it might turn
> out not to be a filter.
>=20
> So is it a filter?  If so, no problem.  I suppose we can fix it up in
> the same patch that marks mirror-top and commit-top as filters.

I think it is one. If I understand correctly, it basically just changes
the timing of requests, but nothing about their data.

Adding .is_filter to it in the same patch with mirror-top/commit-top
makes sense to me.

Kevin

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6z8dsACgkQfwmycsiP
L9Z9XQ/+Ph3AVTtHfaqwZxuSJdAAennQWfazv/2u6xvudhQdHhXSt6Qei8Gyt98F
UczlZSqC4UpTZGEJQFwdfEPbfod7DVd4LZaBG+1XEH2I6Sc2ZdHNZhkO4AKBRiZ5
F7I30y8yPiiYjPH36XorOrvfqfiwqoE3WyLnBgaejjWxx5Phar43/12MroxBXE3D
rcq4qVk7TyH0tSxJsVAjCRE8Xt1usbIySdrg2fjXv3qPGzeMLIZ9Rc2lj3SPYwLo
BblJ9lqPc7qGeLvN5VrQ0n8Jl75FQcJj2FGNY+0fpMY0r6Nq++6+Oiy0KL7x2uJJ
6uO13BjR7v8ErM2GCvdgefoZNnFaBXigMDwMq+KUjyBjoO4aAziIIGVfzXuJROY5
MS2X7pgYO4AekgbyRJQeNc67ZlQOHIvzCVn2z061/iBiQWtT5wGhU6wgML13UeCh
CI3361IUhTeyNFXsq8v9Hu1lnsqdhNUBSopU08rXrgjsB0+LfE8WIm5AQ1g8ymKr
icDHyENQzEXGyzHC66mqlF8jJ8P6bmI3dnwfl/LkyweuH+B/Su5AkNat2SECr8g/
ICl3kVGyWgu2cH5FbRaABkOALuhyeOIb90o4sG9ftNmzdOu3n1rZtTwR2SY6lDFC
May2ka/RK7KrpUmoYdPoE+i0sMA+xo9goCBmPL3R/mtwfsafM0c=
=6jBR
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--


