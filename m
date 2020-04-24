Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4CFC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3902220776
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE29SwGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3902220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvwz-0008Td-Ba
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRvvy-0007PE-AT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRvvw-0003Vq-Gl
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:51:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRvvw-0003U1-3J
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:51:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so10176657wrm.13
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=62UsEGK7yal4e04pzFLahb7YEwFOGsBHH2w1zRlK0uM=;
 b=nE29SwGNESi2eYtooY1CUg7QzJv1ThkTxNVClHw4HEt1y1Oyri/RRPXYKcrcRfWQx3
 oJJmSTk5jf8FcRR6L2FbLgEmu9c0v0NDxh0ZW6Ukn8YkG6V7wNK4D/KyNhBAimo4G/YL
 PDTTTvmM+paJhnH4TiSuxApub4pl89P3h5VtAYRU6nd/71JqcFBfK8F7ImqvBzly8F2b
 thph8BnWNM+IPJ5jYs8HgR9uboQ/CsqO/dZps95L1u0UNgNLlZHZ2HN9e/jtXeAeWN4M
 xdxTH2Ef2c1qdo6xlFo4HEhf68LBvPCWOU7EO62049mBemGV99opF6eLUWPo7dpgjYH9
 QXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=62UsEGK7yal4e04pzFLahb7YEwFOGsBHH2w1zRlK0uM=;
 b=Olz6Leh0NexcSUbqDS9LyTmjIBOOaqegIDiX1swdhNOU8CzbT4Ax0ldP+BSPKTr2nJ
 GNq8Ek9uYwxH+0ZC5la7n5oJ1MlbH0hpeF6FApLxPdh1/4ut/ksmNPImJgzGQ+v8ylLA
 vHK9fzI0U+Z81Jm+Mc/Pf7TPYrH9H4TE0lbawJgjlteMZThs2kxR3UHZXLRdjSz4Vt48
 siIm0gQ4NB4MHENJMmihgsnO5CjB6a71Kz/33qvtREhx2OLA3+ngrIhqmNFczz5WAH1G
 e4cXsDNr9rL2WWHVQfuyUFEEVAKwEf8kYxbQ4kl/YfyHY6uWAD0v/00Kd6o0nXXHyvDS
 aBiQ==
X-Gm-Message-State: AGi0PuZsgIWVVkF2Geb8Hma01gD1eIW9O7+FoUwYAr2lBvJ2HEdF41xN
 ic9C6JcZ40BxZiLyhd+unOU=
X-Google-Smtp-Source: APiQypLLb0o7wGOB+AYLsdTJOmLidY9sc5tQlN1ldvqyBoZDbk2niLDCbcYIkCP4JJBQDDBLkO8vuw==
X-Received: by 2002:adf:f881:: with SMTP id u1mr10180497wrp.348.1587725506678; 
 Fri, 24 Apr 2020 03:51:46 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f63sm2292067wma.47.2020.04.24.03.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 03:51:45 -0700 (PDT)
Date: Fri, 24 Apr 2020 11:51:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Simran Singhal <singhalsimran0@gmail.com>
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
Message-ID: <20200424105144.GD174193@stefanha-x1.localdomain>
References: <20200402065035.GA15477@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20200402065035.GA15477@simran-Inspiron-5558>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 12:20:35PM +0530, Simran Singhal wrote:
> Replace manual lock()/unlock() calls with lock guard macros
> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
>=20
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
> Changes in v2:
>         -Drop changes in file hw/rdma/rdma_utils.c
>=20
>  hw/hyperv/hyperv.c     | 15 ++++++-------
>  hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>  hw/rdma/rdma_rm.c      |  3 +--
>  3 files changed, 33 insertions(+), 35 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6ixMAACgkQnKSrs4Gr
c8iWBAf+J6lxzG7VMkuPC1HawLaJYpvNNBIps24RmU5ESvkeexhgoH75vO0INpx/
hjhII0BJdMsvbFlF6HyWUo1tHsgnMu0aIbHPxjNehgARTE8d1sDetsScxFCh6zDk
9F4n9YuoXHHWrSOXQu5ZPHSBwAAviRcTww/R+3INqS1b82vxDJx9YxUOXl0QexrA
PIis173bcjbjqSKMW2hltvLWNeVIAqx4flm8iQfcWx1ES+Bhbjwep0UjNwEnSgzJ
RHPsF0BpyKzAzXEOZdsl9Q8mbjWMV1yhCQYamihg+yL5FmiW02BG/op726EfXE7u
+UGoEMGxZZqkkgvyzWrguL51fNx3Ww==
=as7j
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

