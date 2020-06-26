Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92013C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7682078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBRojo9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7682078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonbs-00081X-Ms
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jona1-00060u-VX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:35:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jona0-0007nb-ES
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593174939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBDROPdMdiU3ktGuOWS4DtRfwg5c+JdpWyg/Ls4ctNI=;
 b=iBRojo9o2uJHy6rPXToDO3zpNrXfPPt3Y4fMQuKhnDVV4G6H/V2NAXy5eLvoc6BZoUCapn
 RPy0pID1muqA/lnk5gydCW3eGEsHxdha2vcA7p57xkZmVu9mOUjMrvC3Qh6OBi+Qp5UN4x
 v205ybk8M1oaP6edbKQpWgxhdj3Tuas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-TG_h-FdrPA6KWPBmTkyLWA-1; Fri, 26 Jun 2020 08:35:37 -0400
X-MC-Unique: TG_h-FdrPA6KWPBmTkyLWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 014AF804012;
 Fri, 26 Jun 2020 12:35:36 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B0A2610F3;
 Fri, 26 Jun 2020 12:35:35 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:35:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 14/17] block/nvme: Replace BDRV_POLL_WHILE by
 AIO_WAIT_WHILE
Message-ID: <20200626123534.GU281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-15-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-15-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3yk1sSvxP8cRAjBs"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3yk1sSvxP8cRAjBs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:35PM +0200, Philippe Mathieu-Daud=E9 wrote:
> BDRV_POLL_WHILE() is defined as:
>=20
>   #define BDRV_POLL_WHILE(bs, cond) ({          \
>       BlockDriverState *bs_ =3D (bs);             \
>       AIO_WAIT_WHILE(bdrv_get_aio_context(bs_), \
>                      cond); })
>=20
> As we will remove the BlockDriverState use in the next commit,
> start by using the exploded version of BDRV_POLL_WHILE().
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3yk1sSvxP8cRAjBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7165YACgkQnKSrs4Gr
c8i+LAgAv+JLM1ovhq30l6OHNK15hXr62i1FWTZhPIKmP7Fg5K15b5Voaz16Ceox
TaxlzjagERceKIMhA6PG3mkHD4Oz4HN207aXdPWnUqOzi4M2Sf5+iaqqef7TmfxB
incPAZiJTSgdWBDy25wmYJdqRhmy6j6chUCg5s8x5GQuuHmnIeBbGuo9YjN3EXH+
WLcfDlHp7LeabMtnhuV9Dc1od0Q18zt/HBpZKorK4vb1UwNSmjNP8ib0Nq4vdcQE
ryATXwDYzSTJ0XqM1ta3qkBJor+ZDN2/hzpddk7b5I7tymMg1R93NOs6Mo6iPfOw
8VPcIWFLCI/MGRcuPcIjHzemACMI8g==
=lxhM
-----END PGP SIGNATURE-----

--3yk1sSvxP8cRAjBs--


