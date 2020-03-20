Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DFCC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A27020754
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbZCpQKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A27020754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIH6-0000k5-Ee
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jFIFv-0008C2-Rf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jFIFu-0006c8-LN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:04:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jFIFu-0006bN-By; Fri, 20 Mar 2020 10:04:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id f130so5451204wmf.4;
 Fri, 20 Mar 2020 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=73KCCYSwGSq9irnuaUcZKSkQ2zWBpWoys7duxTzinOE=;
 b=DbZCpQKKxHBpQIgzBVgmn5Nhyts62skPrKx4h2Tx02nPg4lIyUly6znObMFygFlCQ7
 UspKQyS1m0TOnJKmpJcmWOfS5Wo2KXyppJ6brp6zxH9LPMGg1S5NyZcr7PKCVlFqBXtO
 M9hjp2ogMhLEqyBsHVY6dmA5ibqr4quXfvEfnpbnZxbZ4eowPoUtYdchwVAyGbv473/s
 KpjfljjDoQT5jldyBxTPgzKVIXTo410JJ4wD1KV1bTi+oq/IN8LmsaLGlJ6/HTUgc8A4
 gVdkKSQgH4+MMhP+T/JTvsfqRzdmChVdeqfhgVE6tfs5JAHU6Qlw9y964p4IrUWNRZyv
 wF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=73KCCYSwGSq9irnuaUcZKSkQ2zWBpWoys7duxTzinOE=;
 b=BhLauPzBnOxa6A0Rqi3ulA1GJE4UVDdYX2TOBalJAqEPPnKcBMVUo2KS7CkZ3+fegN
 7GAcYC7GanIVXjnL/a2EUSgvSHYveWdQK8NBcK6pn7uGfKDR6TiSuQ/kJZEdlTnBkkYe
 eHWTDurAgThRpttABJCbjMsjmj6STfs4/7Vs2kplrWQTeBaanqB3bGcMevh95ZbNvwGA
 wY7VLKTXtn1PpQbPGK/r25ghnaZ4vzZW2quo2ieCiZq5spsUPWp0rv4N9WYDkUXF0IhP
 gnJ4AsKBGqjeLI1Rzvlm/oHIWXnhl+l+dWrxDrv65+HJjPndZwbcwDmW4I83h6P+bDwO
 Y8Jw==
X-Gm-Message-State: ANhLgQ2PLQpawcAm+YecxPqq5UA2eMpnvoqg1+lfNlaHsB1Xw3ZKYJ0S
 RRsrxcIsuZS56Ytf0mHMeVA=
X-Google-Smtp-Source: ADFU+vu1UkY+uJLdm+mzwhBu8KZsG5zoPXlqyJ2iVgnF1APfInZ9YBGqKQZLCEzFcWJrHWl3quJ1Vw==
X-Received: by 2002:a1c:b686:: with SMTP id g128mr10447572wmf.75.1584713049028; 
 Fri, 20 Mar 2020 07:04:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p10sm4172337wrm.6.2020.03.20.07.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 07:04:08 -0700 (PDT)
Date: Fri, 20 Mar 2020 14:04:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent
 Clang warning
Message-ID: <20200320140406.GA138042@stefanha-x1.localdomain>
References: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 11:29:27AM +0800, Chen Qun wrote:
> Clang static code analyzer show warning:
>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
>         flags &=3D ~BDRV_O_RDWR;
>         ^        ~~~~~~~~~~~~
>=20
> In iscsi_allocmap_init() only checks BDRV_O_NOCACHE, which
> is the same in both of flags and bs->open_flags.
> We can use the flags instead bs->open_flags to prevent Clang warning.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

This can go via Paolo's SCSI tree.

> ---
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
>=20
> v1->v2:
>  Keep the 'flags' then use it(Base on Kevin's comments).
>=20
> v2->v3:
>  Modify subject and commit messages(Base on Kevin's and Laurent's comment=
s).
> ---
>  block/iscsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 682abd8e09..50bae51700 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>          iscsilun->cluster_size =3D iscsilun->bl.opt_unmap_gran *
>              iscsilun->block_size;
>          if (iscsilun->lbprz) {
> -            ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);
> +            ret =3D iscsi_allocmap_init(iscsilun, flags);
>          }
>      }
> =20
> --=20
> 2.23.0
>=20
>=20
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl50zVYACgkQnKSrs4Gr
c8ivZQf/ZUeVWKUHOMH/mnrkpp6hvahHi3xc06MRKHPuN0B3vNZ+0MGWHen74qHJ
wfqvDEdF3onbddapTQwszioUbjjsizkVFYFZMt+QqEDwk6fga9HM/b9bOUGVzloZ
XSIEr3HdGsNutgAXvE0JfdAxU4Tzw5bwjusKFtjFga6D6kbAMdg8vAJJuDBTDGOa
OxQCoPFuB3iV4nwzI8u2RQPGcoPNRLEVKuhRHMeqi/1V3WtLJYWZY5vJXENrHeY0
ecJc6TkSDtdSQm0lSG4HBe0a/HMH3f/REkY8zVmJ5aU3QTLaYKcCuhBtq9MDvBGj
5X4EjJKPBANVPWaxxxXF4vf/SHLZlw==
=lkRs
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

