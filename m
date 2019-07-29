Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5652FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237222067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbq6n+Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237222067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7mZ-0001M6-Eg
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hs7m7-0000v7-4l
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hs7m6-0008Is-6f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:41:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hs7m5-0008HF-W1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:41:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so53922562wmj.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=73zTbjBhdCreP9v2bIcpK5krU/bv5GhzhGh5NJwMGQc=;
 b=mbq6n+CsnRymPLyVok2m8fp1pZn4j2bSOl7AKZAmL8wVazZyyxp4zhemS1nAcYnje1
 44KnGm+UafhAgKcIf7Q1RTXCDPvUXlIy1CEHLpUcRb4HpYO95YhCMIX/8EZhjm42ZgAQ
 Fi6yGopu4CM4K6pQcbOblFX+AxFjqPlAMmIf7rgwrOi7nZ7Db0WnjVu2cf7Mb16i02NZ
 XY0IUtDHTM0bA0u9lfjjv4Hh5vQ9RslbgtFPOZhPuc+jSMxzjbwfhXZISkib1/yhcSv0
 byMGVSRmRJOcTcj7G4KR7XDNU5gATmPYEIGCiSVQCQnPfxQ3rnxTKjxQjbL3IbGilIHg
 DSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=73zTbjBhdCreP9v2bIcpK5krU/bv5GhzhGh5NJwMGQc=;
 b=cJfzLYhVsgFvngpjaXbpEKVKlu3WZG30tVYmOVwH9VnO926nPuqbMN2LQRw0+x2Bnq
 kXmukcq42ly24ANgYFLolQrMsVOZERC8IjUAzKH16FJUX/UomRdD83vGp/BXZFRN3NyL
 ehruBRCxs8KI9qwxnIzQp9vmnDvsytVUJvnoTy2Fa3aoYbx5Af4Z1HAJZ4EhT8o9ceVK
 vcXFaHiDFJRSxXFZ/N4IciU1Tm81X7x3U+Fd7Og0vvDsKx1kAtOVhvKXNshTT+GpK+9L
 KjB40NF7n+6toOzp6bS+uIuCezKleTzkx69t/ObY+xIF4TMbK33bhUBpBEyh1pfUZIKF
 11TQ==
X-Gm-Message-State: APjAAAWTkiLaX6HN0BKzyIKX5R7HtMeIaBW1NvVa1YddoWbb33SvpM69
 MFlEl3uEQ6Nj7yQxGBGUsYE=
X-Google-Smtp-Source: APXvYqwz/n8v1gC5nazAucaSHg6iH9Tf2drPGLbUwk3L5OiQltfyZ3be4U7GprC7UgqB9ibtkeLqzw==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr99758954wml.84.1564414880608; 
 Mon, 29 Jul 2019 08:41:20 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x8sm51764279wmc.5.2019.07.29.08.41.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:41:19 -0700 (PDT)
Date: Mon, 29 Jul 2019 16:41:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190729154118.GA21560@stefanha-x1.localdomain>
References: <20190726091103.23503-1-stefanha@redhat.com>
 <20190726091103.23503-3-stefanha@redhat.com>
 <e83e2463-5239-e5c0-cc44-e1e0b74df37c@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <e83e2463-5239-e5c0-cc44-e1e0b74df37c@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 2/5] virtiofsd: prevent
 lo_lookup() NULL pointer dereference
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 08:35:36PM +0800, piaojun wrote:
> Hi Stefan,
>=20
> On 2019/7/26 17:11, Stefan Hajnoczi wrote:
> > Most lo_do_lookup() have already checked that the parent inode exists.
> > lo_lookup() hasn't and can therefore hit a NULL pointer dereference when
> > lo_inode(req, parent) returns NULL.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  contrib/virtiofsd/passthrough_ll.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/pas=
sthrough_ll.c
> > index 9ae1381618..277a17fc03 100644
> > --- a/contrib/virtiofsd/passthrough_ll.c
> > +++ b/contrib/virtiofsd/passthrough_ll.c
> > @@ -766,6 +766,10 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t=
 parent, const char *name,
> >  	struct lo_data *lo =3D lo_data(req);
> >  	struct lo_inode *inode, *dir =3D lo_inode(req, parent);
> > =20
> > +	if (!dir) {
> > +		return EBADF;
> > +	}
> > +
>=20
> I worry about that dir will be released or set NULL just after NULL
> checking. Or could we use some lock to prevent the simultaneity?

Yes, I agree.  I haven't audited lo_inode yet, but it needs a refcount
and/or lock to ensure accesses are safe.  I'll do that and other things
in a separate patch series.

Stefan

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/E50ACgkQnKSrs4Gr
c8j3iAgAlmmrhpX+5EjT3WA3AinUScd4UGS35+bJ0/wg/D8AuVfVuvbf2AV5jOsC
iDq/vxyxZdDttfN5w+GPswZa2XbgC3c8P90829WA2YUzHBVg59D77uoLrQZJWexN
bNeaBQC2cJKv8g0pQvlv1Jy1aIR382MCa/BpsaRdRyvGomfFsx5kIwbaSmvpfUHp
AKVnxDArnyCryRGsQjq0D1Hb/hiKshgxSdwxJyYXnKNxfoLty8s0BZChA20wP0Y/
I/9dt1docczI9s/Trp2pTlR5zhJ1rsDbM2Tf74ZYFpJBh7y2JWaP0NQ7s/YKEIxm
j+U/lqPFfbfaDeB83lc0FB1kBqM8JA==
=+NgF
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

