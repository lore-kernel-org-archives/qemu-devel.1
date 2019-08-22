Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE77C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B21233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3N9K3ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B21233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pND-00007U-UL
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i0pMS-00083R-5y
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i0pMR-0001fO-3Y
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:50:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i0pMQ-0001eZ-Sg; Thu, 22 Aug 2019 11:50:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so5895406wrd.7;
 Thu, 22 Aug 2019 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dKvnAfjTvEpof9fFCOW7G5T4TEsS3IlcGBScWvo9vpE=;
 b=o3N9K3geCCbTs44YghM/GkY7QXji3RRc9LRNnxfJciT+CVKSJP8oHZqmJiOTw0nTR1
 FzXg1X7fzw6hykVdtFScHapMM09v8bs6N66ljuoSkEAYccM1NeZlLvmUkLBunOvuLreW
 h6wWMC1lLw1cz9zXzQ7QdfOHz6tZos+t/HF6wDTKGblpo3ddIVNGVnQyKxkXOYs0mM6y
 Sq2RFKIGUamb95JrdCPcyvvZbPdu/H79MEt/4IuNeiUuEYDYBYXJjkREJklYeHwNTJyY
 ET5S99uuiSYgUUu4WxG7T0NQnDK2CX3CMMJIumF50dIy9zMeaxWh0QbsBhR1l0SkBmie
 SjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dKvnAfjTvEpof9fFCOW7G5T4TEsS3IlcGBScWvo9vpE=;
 b=d6Z9+ICaFrthVcxKQcejlcRD9QPkrm+tWspEa5TNZjtvbfwBvvqUy+yytPheS2dUMm
 LVh0xyIv4DQ98r6xAd3VDigKF1rAwwSoRKfiK5htCDhlVZZjs+mrYv+wRGT2C4/mmAhe
 H4yA4txUOLqIAJU8jd8lc4YhpU6PZA5W1eUAyrvLCCN/uu2RTIUnvCyyWt+s6vhEbBF2
 jn+O3VfNGy3xqRAS4R/14OuowKdy8vwE441yvK0SdDSNYJ+LeskvEJKJcCW1Yr6NTY8a
 IcKzSM/hVS6A6z0XvQKQKV7PewzMndd8EtM1K63p/901JQTp47d8I01DW5l9Zlp7CtNW
 0rFQ==
X-Gm-Message-State: APjAAAVPChlYfjA7KCN5SMj/BcxdXl81bbCfJQuXYcf9dG6VZ2bRZPzD
 ef255BqbZws/RQ+yzv4LI4M=
X-Google-Smtp-Source: APXvYqzkYnFhAV9OVFjPxVh+1J0SNM9Iv8S63BKWxmgRcvBtUNFMEniI/mxogbZrEgBJGOdjsBg+fA==
X-Received: by 2002:adf:facc:: with SMTP id a12mr46516087wrs.205.1566489049305; 
 Thu, 22 Aug 2019 08:50:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c19sm4382259wml.13.2019.08.22.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 08:50:48 -0700 (PDT)
Date: Thu, 22 Aug 2019 16:50:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190822155046.GA20462@stefanha-x1.localdomain>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is new parameter qiov_offset for io path, to avoid
> a lot of places with same pattern of creating local_qiov or hd_qiov
> variables.
>=20
> These series also includes my
> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
> with some changes [described in 01 and 03 emails]
>=20
> Vladimir Sementsov-Ogievskiy (12):
>   util/iov: introduce qemu_iovec_init_extended
>   util/iov: improve qemu_iovec_is_zero
>   block/io: refactor padding
>   block: define .*_part io handlers in BlockDriver
>   block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>   block/io: bdrv_co_do_copy_on_readv: lazy allocation
>   block/io: bdrv_aligned_preadv: use and support qiov_offset
>   block/io: bdrv_aligned_pwritev: use and support qiov_offset
>   block/io: introduce bdrv_co_p{read,write}v_part
>   block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>   block/qcow2: implement .bdrv_co_preadv_part
>   block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>=20
>  block/qcow2.h             |   1 +
>  include/block/block_int.h |  21 ++
>  include/qemu/iov.h        |  10 +-
>  block/backup.c            |   2 +-
>  block/io.c                | 532 ++++++++++++++++++++++----------------
>  block/qcow2-cluster.c     |  14 +-
>  block/qcow2.c             | 131 +++++-----
>  qemu-img.c                |   4 +-
>  util/iov.c                | 153 +++++++++--
>  9 files changed, 559 insertions(+), 309 deletions(-)

qemu-iotests 077 fails after I apply this series (including your
uninitialized variable fix).  I'm afraid I can't include it in the block
pull request, sorry!

Stefan

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1eudMACgkQnKSrs4Gr
c8h/1Af+KefbQScfZUdWOm2QJ9g660JuUlf8+NizAck8IknslHSnc7NVVV/WO9EV
hSRBr3qQCEaawY/wKT5IfCbsXvIU5qrfZXU3hIsNZBgGU6E62Q1wqLkNhvzOHaoP
zxd1NT5d1bCooW5HT33lpryk4rSRM5PU/o3/bH/k5Y8ghYIVcybIOqAnkY5WXbOL
2mpQcyRSrD2fmwuntxgep9az0OxOF055pAszouGSIG1jio0h47Ha2J8x4Gfahp0L
C7uDq6t89MddKKwIoZNG8H7cGQ1BP+jFBK5oI++90Lw2iVCfiBMzkpAwLgAgtxtI
DUE+v+hR0hn/XYXzy9rMrJJ3XJd9Gg==
=vT2p
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

