Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4133BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD77208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WefjqP2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD77208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWetw-0007qg-4G
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWetD-0007Ny-DC
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:40:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWetC-0005eB-JB
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588851629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMgI34jy6EonFkFTEsn9jpOumWL1Zo7Wmh0HTdaC1Yk=;
 b=WefjqP2WmioM08bn0TsrPd2iWOFE0hI0NFLfaEBKsoIRgt5MZiiKUGkjp/AIJVDJq6Wp35
 wWL+AvMPUbbBckdICU2sMYpCShPWyhO8p1VmdS89cH1usMSIB4rIfjWiNPFKj2enh8mIIS
 LqRORVWaLeiZs9oF7FtYBRc/213IV+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-fJ00-GmWM7u3CcVUTHLmjg-1; Thu, 07 May 2020 07:40:27 -0400
X-MC-Unique: fJ00-GmWM7u3CcVUTHLmjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67C451895A34;
 Thu,  7 May 2020 11:40:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 679975D9C5;
 Thu,  7 May 2020 11:40:25 +0000 (UTC)
Date: Thu, 7 May 2020 13:40:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 32/33] block: Pass BdrvChildRole in remaining cases
Message-ID: <20200507114023.GE6019@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-33-mreitz@redhat.com>
 <20200506171315.GJ6333@linux.fritz.box>
 <1a39d014-e921-3a6c-e540-55724ad77bb1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1a39d014-e921-3a6c-e540-55724ad77bb1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.05.2020 um 11:36 hat Max Reitz geschrieben:
> On 06.05.20 19:13, Kevin Wolf wrote:
> > Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> >> These calls have no real use for the child role yet, but it will not
> >> harm to give one.
> >>
> >> Notably, the bdrv_root_attach_child() call in blockjob.c is left
> >> unmodified because there is not much the generic BlockJob object wants
> >> from its children.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >=20
> >> diff --git a/block/vvfat.c b/block/vvfat.c
> >> index 8f4ff5a97e..d4f4218924 100644
> >> --- a/block/vvfat.c
> >> +++ b/block/vvfat.c
> >> @@ -3186,7 +3186,7 @@ static int enable_write_target(BlockDriverState =
*bs, Error **errp)
> >>      options =3D qdict_new();
> >>      qdict_put_str(options, "write-target.driver", "qcow");
> >>      s->qcow =3D bdrv_open_child(s->qcow_filename, options, "write-tar=
get", bs,
> >> -                              &child_vvfat_qcow, 0, false, errp);
> >> +                              &child_vvfat_qcow, BDRV_CHILD_DATA, fal=
se, errp);
> >=20
> > Doesn't it contain metadata, too?
>=20
> Aw, I don=E2=80=99t know...  This is vvfat, I don=E2=80=99t want to know.
>=20
> Do you mean metadata beyond the filesystem structures?  Are those
> structures data or metadata in this context?  Does it even matter?

I can't say I understand what the qcow node is even used for in detail.
vvfat checks the allocation status in the qcow node in a few places,
does this count as metadata?

> I suppose I just don=E2=80=99t want to think about all of that, and the s=
implest
> way to do it is to indeed pass METADATA, too.

Yep, that was my thinking. If we can't decide whether it's just DATA or
also METADATA and want to err on the safe side, setting both should do.

Kevin

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6z86cACgkQfwmycsiP
L9a0/xAAul//Tr0PhigMbpcqBUnlbkSFDI1CIOVAl9sfRkVVnO21qn9n0VB2PPLh
wA5zVyMlazP0VFEVNJE8Myg23yE0hkOTRd/4Yt/dOHRkr7+A24hkAR6BUKZZHw/l
KaRdIIJj84s7G9C4uaXn+fUs4VrLynZpUn/1lJbNH1yiufD0q0YxtgQKX3v720Q3
PbPDDlck7OvGn+pGXnhhZsUr4af0QQ54F8TOIUl6Wt04uaP4DblX9SPOvFXuQiqE
bfwBRVESG+p3sy6TO/Arms7PRwPE6Qt9stCaWXBjykUU5WArKlekb/4fQ7pT0zDd
Kkur3kjoZ2tQWYO0hAQ4PDuqWeeMaze+Dc/yf5m7+9paV+nFJ3hgDKN0dtxZA3UE
wg6ytQTaCVeBOTp5K1bMfQvxyTdyw04DVh0T+TXXmTdrMHZtC24y0b3dpKivFgBL
K3B1O5Bt3weceqTi4jpGiitfaPQKy5pL4JDuSjfm0pJOTvcB8c3vNfLvNgQa1aM6
3q+2oaEtCMEq27aW7dle+W1AgdaeJqZy35CD2uaaP4mY9PzjAvDgTmLSGKDQryli
nehkKGD0RGbEPumDQUNhS1/v+oJZnEovFEdEQLQVjny8fNDoQIwpNz9Qn1fapRzk
3sZJMEbF2VcyaELC5UXEVgBNTofrM94TzflSXKy/FFC3AsOWh5I=
=X3wy
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--


