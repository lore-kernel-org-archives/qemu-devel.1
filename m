Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D995C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2AD2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv+mF416"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2AD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHRx-0007W6-Gw
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHRH-0006tD-0m
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHRG-0005gl-Kp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:37:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRHRF-0005Qr-09; Wed, 22 Apr 2020 11:37:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id u16so2907790wmc.5;
 Wed, 22 Apr 2020 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IwF9K0dMPQeUU9IVlN/o/KXLfjpUlazL+/rfRsoXZBI=;
 b=Mv+mF416YQoaCYGmPjulCRmhEZLxEb9SkvaJ79rhNckekcYOykVQc2urjxMwGDVMtL
 K1zl+3ApSEM4hVITlI8zq16DTbe89v0lv+IHMSaVLZvEHd08zHhX7vpwI1VlaQ6/S8zW
 YshtpI11dVVBQ4uPVcypsGNPRcvm4x0siTpxYX2DODE1zravqFsmvJXLOjYhNgOUapnN
 Wm+hG33pBgY2fTvzZpuxe3E6b8Q0v6AOx9r+pgVyApreSmzyIEG8jZNlCLN4wtsRfbLt
 uQG7LTLyrEcWp0Zqb55VkChimzxahY/3Y86+t6bME8FrK8H5sLgrdJcf8ELVS2FSzlDX
 HULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IwF9K0dMPQeUU9IVlN/o/KXLfjpUlazL+/rfRsoXZBI=;
 b=pcbzGd0NGSFeB1h2PnqRRdSFhsRVo6FCAh+Py2lQDk1kQ4sfJIxLDlejJM4+MwYBPf
 Q5Kal/5r6NMCQOv4B6S7nMa22JxWEri3qdRI/m0tAYIYvMpJsM8NgpyVCkhUydaJcj92
 4j0ytSJjQRBBdzu/ugxvt2lOJcT1uIwnkymlaqpFemdqSETYjbqg2XFBrtGy9dmKZR9r
 TMF9+sIM1tMO0m6xqpZJZbt7vuAdfr5+q5P8xGRYoQARXEKCYjb2VDRn54vdasG45Mbg
 beNdu5/Fy8yR2MfTRXcZatpEfG61KrXDO3+21VOsaVaDftiJi0evq/putvnhpQ6/OdfZ
 P4Ow==
X-Gm-Message-State: AGi0PuZNKUbXWjJv4ZooMtz9l18vAT6VjtEGEGV8YD8olDYsNJGw3/2J
 efpO9vecx7EF/RHG/NbcbvU=
X-Google-Smtp-Source: APiQypIjDTuPYo96AWgGZmjMcKfTkBu9QxfRaTaZMxBWjhmKbao7zEyfRKuv8dUb2Kf/ESz1c5VRCg==
X-Received: by 2002:a1c:a512:: with SMTP id o18mr10826862wme.138.1587569842917; 
 Wed, 22 Apr 2020 08:37:22 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n2sm9694928wrq.74.2020.04.22.08.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 08:37:21 -0700 (PDT)
Date: Wed, 22 Apr 2020 16:37:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/3] block: use int64_t as bytes type in tracked requests
Message-ID: <20200422153720.GD47385@stefanha-x1.localdomain>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
 <20200330141818.31294-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20200330141818.31294-2-vsementsov@virtuozzo.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, kwolf@redhat.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org,
 ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 05:18:16PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We are generally moving to int64_t for both offset and bytes paramaters
> on all io paths. Convert tracked requests now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h |  4 ++--
>  block/io.c                | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gZLAACgkQnKSrs4Gr
c8gPUwf+NRZ5gSJpq082P5lczNwuHyAB2LPxZg4HDGYpiz1XC9LwVqSgFMYlZ3TR
vpXyTYraCrrjoHhCXqQPkiGJTRTvhMQ1z+eWChqieoux/GCn89fyzSIeEGHZaT4Q
rdVuxADnCPCvOzqICbVOTcRDa3BzPLqAi7q3qzaRvisZOSuFl6w6/NR2Lgj+ci/7
j2Di3Bz3PS11fhDchJl+k89HVnI9uwxUKLMv8qIDRU90Bm61Sf07HvCIUD//usy3
wkaVgiOPNSCoJCJaQjDyIWZV9SNtR6VFBmSk4cpKR1RhODVk/08Z+1YAcuwK0j1s
GG6/y3ZiKBvYnevhE5S+2P9hf7+H8A==
=adHK
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

