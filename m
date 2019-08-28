Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917C8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2A62342A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg2UbcnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2A62342A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2tKz-0002B4-Ej
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2tK1-0001Q9-Rg
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2tK0-0004xo-TY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:28:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i2tK0-0004xL-Mr; Wed, 28 Aug 2019 04:28:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id j11so727430wrp.11;
 Wed, 28 Aug 2019 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ppokBPUzWV6mwCUK3Ppj/3II7eFKYs5kK3B1YBJcCXo=;
 b=Gg2UbcnUSmPHuQuPzNeywA2bHnO5EYrJdzfcPIC23Wv7sWSXOFP6Zb+/LKT0j8b3p/
 vdErjsIqpzYb6u41GLVgBIJYqgNnOsuN9IDNQu7KRzmG818ikB/eHuzKrC7h6l2YqyeB
 7cLAAREd5MvV9HDIhi+piww6Idso36Pr8ilKYui5Nebt3oC5sQCWMW/08OswTd5o1OTB
 JlnDqG+CkirHxvMboJgk9bw7aVPIcegr5B1O6mPVkW6wKPrkE4c4dRaevaLaF0lXQZAK
 Sdx752sLuyLVmMqIqf8gqSfhO0UDSHn/Vrhmry5xibOB52Ixh3xzfEkohK1l3pxvNFBW
 nwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ppokBPUzWV6mwCUK3Ppj/3II7eFKYs5kK3B1YBJcCXo=;
 b=f6nXBfD9WCOv9ZS2koJrjMzBP5jcbh+yS4FbFA8euDIxSmom+vVZsFNKJCLpx6j0aA
 oJoVxYoSHpZjBGTXVpSTP6vMSirOdpF7203L5k9KkTijTOYE/ceONkBx2eBIc2RvSGdW
 UxatLdBq2xmAxpcDwy8bEJmdwRUXM6HJ0/CRKaAiwLhe3PjdfSmNEvMptVcL2a9NxQ2J
 BIkfcblzVlNLWBPB5qwWOctDoKoFZJcyLM+PwRdYKdqY06EG13YlXLQEoil7Vy+U4jN1
 sx8icR0m3p5Wv3xDGSn17MfDzY0J1tL5uU+mmSTLYbMX+mLPjZvg9gBs0B6lc5DZ1YFM
 BLXw==
X-Gm-Message-State: APjAAAVotsbQ9jyV2X5pTCHC43Mod3oEPudzFji6lbUdl3Q+caWzgL/y
 7Y9uuGexKA0VeajU4E7r1WE=
X-Google-Smtp-Source: APXvYqwu6ilCGYLa2rSjXcwp6jqUqmUGUhWwKXJwpWn9fc7ATm25xmwMFf+wVNnbzLw/hKMLuMppwA==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr283259wru.335.1566980931598;
 Wed, 28 Aug 2019 01:28:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 24sm1434465wmf.10.2019.08.28.01.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 01:28:50 -0700 (PDT)
Date: Wed, 28 Aug 2019 09:28:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-ID: <20190828082849.GB5285@stefanha-x1.localdomain>
References: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user-blk: prevent using
 uninitialized vqs
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 11:34:24AM -0700, Raphael Norwitz wrote:
> Same rational as: e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
>=20
> Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
> and event without a physical address. This can cause
> vhost_verify_ring_part_mapping to return ENOMEM, causing
> the following logs:
>=20
> qemu-system-x86_64: Unable to map available ring for ring 0
> qemu-system-x86_64: Verify ring failure on region 0
>=20
> This has already been fixed for vhost scsi devices and was
> recently vhost-user scsi devices. This commit fixes it for
> vhost-user-blk devices.
>=20
> Suggested-by: Phillippe Mathieu-Daude <philmd@redhat.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/block/vhost-user-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mO0EACgkQnKSrs4Gr
c8jZjAf+J7gnMAfwNqGGpCdUvhtAEDiQ+VYgRmGnXpDkBM70iJebY0P+QK3RTaZy
gAL7JnrJQ3N5QR9mrcQYOJHxRegRlefMHdj94UiWu9ZwClsBE4UjHoZm54EXgDLC
fOkvfZ2j0BUUP9q2ZFQtzJ/imM3pkNAv6DScILlAZ5PUNP/t7HNBTyCXjTtYkeRX
JlYIjxE1ji8E1RPjGnZ61S66B44edBEJk4GRqQUYRDUAyWDMM9SEs6hWwmEqS/Uv
zbLoA4Ku3t9/8XSDuiBXOPbCoDigAJs0F++r08PEC3jwAaUX4ie2bIMg2d84cAmZ
0NV6T2oCpAxUQpO/mEPpSL+8EpEEvQ==
=Z29h
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

