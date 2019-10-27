Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF73CA9EBD
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF3E21E6F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UirjS0/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF3E21E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOjnY-0002R3-C4
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iOjle-00010r-OS
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iOjld-00025g-Ne
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:43:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iOjlb-00023q-CL; Sun, 27 Oct 2019 10:43:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id p4so7224765wrm.8;
 Sun, 27 Oct 2019 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xfOka84Vn+pvRdAHV7hJ4xUSkZMSLr0Qb1RZiDaGiV0=;
 b=UirjS0/3lKLRorH37M/L9spK1wF//aevTqjxVj40aiAmNJHIIgNSZk1xH7ZO2NsqXF
 h8gSeUcxyVcEB4BFsqdqTunZ+1o1pUh32HLTvBKl7Ogle6h0dGZZPEoxlCcCfDrCHwEn
 Kt64Pm5i+xRdBlU+LQL/n1k+NbWqE93Hx1xyoOeK79k7tCk1vtkSzn3BrhQ0kVRo+GS5
 LTaMTNe9J98ad1yKRd0l6i2vpsnFeadh/prBf5O7ZsqtqLEfLT75zF0BbkZzt2Ix2sWY
 8NFPdTCHt73K5q8TuuU5JYdopeUFIL7kT4c+Xzq70bONLxKdX0/o0mxie4gP+udZ4vS9
 Yp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xfOka84Vn+pvRdAHV7hJ4xUSkZMSLr0Qb1RZiDaGiV0=;
 b=aWjE86ZEvgs2yahifb5J2cbP8PWPsYD6TeHv2gSl0b2pJOiz4DiIj8iWxa/85XrSTc
 qziyRNkOkztVz15enlIJLfk7Sv6VacD8EyqZk45lAbLweWAxdWku3r5w5gp5k0XrcZrp
 mFxh4vhma1dfup0r7GyWHyhXT9f0zOuMr8Ly6pLAykVmc+jFz/IZqRhGGYBeeFai/695
 F7XO0xZc2TiGcMO4yFu4Gp5woI0/sGYA4foJwofVY+MaA2MT7ZJ6LeQknQuMSCYA73/b
 kukRUuwKIjBnlDLDiVfjp+v7DaJGxWC4Zp2/zBqzzn6qNxHqqxVUB/Dj+1tsCqRVtSVs
 Q9lg==
X-Gm-Message-State: APjAAAUmSM0hdKE2YaJbhNpIS/Rm8/1YegOar5JyqbTOu8nspk3GebMT
 +iup8B3Oi/Sxlz3CqNaDefw=
X-Google-Smtp-Source: APXvYqx0mZ7N2ZgxbjzVwSPLKhgVki7EErXzXbwa7isRdudktkeiMhcv3gbKBSDmpSBNEnHnVVl8xA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr10924445wrp.8.1572187418307;
 Sun, 27 Oct 2019 07:43:38 -0700 (PDT)
Received: from localhost (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id o187sm1745075wmo.20.2019.10.27.07.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 07:43:37 -0700 (PDT)
Date: Sun, 27 Oct 2019 09:40:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v7 0/8] Packed virtqueue for virtio
Message-ID: <20191027084037.GF4472@stefanha-x1.localdomain>
References: <20191025083527.30803-1-eperezma@redhat.com>
 <20191025073257-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
In-Reply-To: <20191025073257-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 07:34:03AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 25, 2019 at 10:35:19AM +0200, Eugenio P=E9rez wrote:
> > Hi:
> >=20
> > This is an updated version of packed virtqueue support based on Wei and=
 Jason's
> > V6, mainly solving the clang leak detector error CI gave.
>=20
>=20
> Looks good, I will queue this up.
>=20
> It would be nice to add libqos based tests on top,
> based on Stefan's work.

Packed virtqueue support in libqos would be nice now that we have VIRTIO
1.0 support.  I think it could be added nicely now.

Writing a low-level virtqueue layout test is also possible if you want
to test QEMU's packed virtqueue code.  For example, a test case could
trigger error code paths by creating invalid rings/descriptors.

Stefan

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21WAUACgkQnKSrs4Gr
c8i0eQf/YhSFo3JgO/hKS6TTbqFtpQasu7vkr/gAO+w3gBxwEGlliII+snwIDHwn
4N2UshbZtHOg6nKR3BDEqUbIMTGNP/HBDgWjJIbpjP4o4qCsk7Jy/xVEBcSXb+bH
teopwF2MPwAuHjcH35DgTPej4KvTzhJ6QO7uH2dXCl176ZeH8l2/IAMtTOrcYMnO
AdgZ0ZGfEHxDOYWfl0+f7S1QJc+k7fnwjVXbeV/eJ4R/rWVjf6hSfDKmfBploaBp
fAzAfcrdiu8GXx8jE/XUrDB37eavKFXr+/sYmHDRgZ3WU05PUQVtC8cT6GuRa6ye
+bHKqpDUEe7ULpBcqKJMvYgfZT4Fmg==
=OuQJ
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--

