Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4696AC4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD8820692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBUV0xqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD8820692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Mzx-0006b7-4p
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8Mz1-0005cz-UC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8Mz0-0005Gj-T3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:09:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8Mz0-0005GJ-J8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:09:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id i1so27383960wro.4
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ORhCuiJqK8de4jn/N+7sdbMV/7a8UDUHQf0OIqc2dBs=;
 b=iBUV0xqP3B/GIKko4JBdcxWyKxUifJFHXb8aGXiKDd4UtT9KAKDOd9x0pgwf4wqVGZ
 GklTCp9ZtdVjMo5eeqyuxOmC2NIJX6dUOP8H5C2Bx93z35uoWy3HFw62NLIhnwrPwcC9
 N8mh6wI3W/s4eQb10F3OgVfFYaRCQmQp6ZeCCFyLWfjtoYuOVu9uOweeo0iEF+y+9pXb
 eweZYch8UqxKE1k356a9z/ftiEQEMVaSrN/zE0cObaVuYZViGG7B6ZjDeAjHjND/dAaU
 qGJRiOZb/TCB/zHbyIoFksFzsqgk8etC1IgVwj8srMJAVz67bayD0b36oyWKPB1vxmVe
 ND/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ORhCuiJqK8de4jn/N+7sdbMV/7a8UDUHQf0OIqc2dBs=;
 b=N2hz0mgDxACKK9wrYjDOB3BBCIfRrXL7ZqWF9zaOMaDT37Z28qUmIus0ZaoWOQgM2g
 4vKJNqPgh2hSg+1Tj6dRWtpDRY0bLX5788YZu63SLa9HH7Du0XYhPIuSGup8eVh6bqoS
 qhbraK9NrgLSwkDyNEVdgK07UR+UhTrB1eEoAZJhy8Q+3qBroeMKC36NY5yzDLsG4pew
 Sf9XfQsqsJmHugf/K76xa40iczn2c9G69QE+4inlxnP/zQ73WypedE6+Vaf4CriF6jj0
 r+oepH1h06d5tV01Ty1GST9f1hzHTHit3K40988fwULDbO3kjHKgNudUGtiJ5vctggDy
 ELVQ==
X-Gm-Message-State: APjAAAXq9fvMiYnZrEpB0nBa3Q0CGv0epIe2dKG3h105JDFPjLjOm46V
 4g3Ub9QJ0KPk0mOf/zf4lW8=
X-Google-Smtp-Source: APXvYqyXXRCia8Chi9jJ+Dt1UX5Rz8Q/rj6duJ+76PUzKD1ECTTJUV5TeqYv6vzi/QnYRjbCGfybPg==
X-Received: by 2002:a5d:6943:: with SMTP id r3mr6169582wrw.21.1568286589554;
 Thu, 12 Sep 2019 04:09:49 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id u22sm44938662wru.72.2019.09.12.04.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:09:48 -0700 (PDT)
Date: Thu, 12 Sep 2019 13:09:47 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190912110947.GB23174@stefanha-x1.localdomain>
References: <20190903192505.10686-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20190903192505.10686-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_REPLY_ACK
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 10:25:05PM +0300, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This is really simple, since we know whether a response is
> already requested or not, so we can just send a (successful)
> response when there isn't one already.
>=20
> Given that, it's not all _that_ useful but the master can at
> least be sure the message was processed, and we can exercise
> more code paths using the example code.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16J3sACgkQnKSrs4Gr
c8itygf9F9q+H2F3xMPFabOP4muNBjtlazROSQBZc6EesSxrERPM0PZ2+6u92FJE
4hkpbP4Bvzu30m4NhApWH99iDeJpIQlg0OMccDv6lLplKzuqOEAECAJmzKhK4zFZ
wYjWeJFMcTunV8EN1u1x6wrnUzo0ibBfeyWqKQT93Xe4wQAFXnFWWSATKIf2UzII
Y9J57Oy00dGuVKw79MP2GpoVkgESpWo4d+8DiEKw6wVhS5UcljRygPyROsxZChVz
j5xW3hxA2VKU0+HpKtLWbT+WZs2qwZynXC1kB1DrCKUJWQ4p1zXtdGA0ZOHfS/IV
UBKNEow8c7x/0bvLUwgUQ6hH5deqOA==
=vbYK
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

