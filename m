Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD01C4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07327208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCEiFMef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07327208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8N3A-0001Ir-78
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8N1w-0000KW-M2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8N1v-0006mX-PU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:12:52 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8N1v-0006lf-JK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:12:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id y19so27991216wrd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=n8T04u79jUZe66wVUcNWnxBT9Dm4wvJmfZ2mZSFVOl8=;
 b=WCEiFMefSOqIqgjIRLiAUsMJdKLdBjQBwxHYWdjrR530Gkr7zk7GzMkdbv5fog6r8l
 oWdJ6k67hxm+8xnt7OhRgz/WXn7Ly2ysQsOuIDCmGq/W+6Q83WiAYCKNvQRNyjciWwqP
 CpHBQZ9B/nHcji56XCynammpoFU9WrY9+3GENUtrqakdzz6gfKqK29RszEICXNByOYVM
 Ach+CFmxICeV7kf0XsGFErUV2/eZLDgB0lkaSW3auV+xi4rPNZzXPVe4FC6pMJVHgux1
 WsFcK9EHes77HtFn38p+SlF32LEGKtSDU+CE4uw0SUtXSacKUnGwxFAMJ4cf5jNOXKv4
 94ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=n8T04u79jUZe66wVUcNWnxBT9Dm4wvJmfZ2mZSFVOl8=;
 b=ABUyVJYsxKaE0V4/p5CKO150jTslN2nSl4lq98dzqi869LdBXPw+6g8Yx8NuO38XpE
 Y1wFVp+yJBsNaRFG4HZVMPja+dVIKlH0AQFvwH763TI86KXLaJiLRRM2f/knKWOlCJuZ
 IrAIeGG5ToD1UGImlCQRSg1pFhNyQoPL2Ua/ZlfZMC3s+BKyqwJ1AW1l2HEKv1VeTcl/
 WINdsZyWBJi/4ZdXBWW4OkSM9UJH5z3Hdq/QEya85FrDxuca1D5UDdrApVBxKLCoaEbu
 j/bruKKmCdguQS67xs3n1V7RkPwdvaxHaBOLwaiBA5mj+Psg+6584jcLnxYHq7YtRUmS
 xQ/A==
X-Gm-Message-State: APjAAAU3th/bAwOgIJl9iZRzqgRaWq0c8DPhzo7uWDrdvzH2Uvlzr4TO
 JNdE03zraUP8x4Hi5cwYu3k=
X-Google-Smtp-Source: APXvYqzDIda8OqsqahqedAfmTBOwFTAMKoMGLtQb609znzpoBqQmlhiQOrQQtNygGus7J+U0nu/tTA==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr14747361wru.22.1568286770257; 
 Thu, 12 Sep 2019 04:12:50 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id f197sm5983892wme.22.2019.09.12.04.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:12:49 -0700 (PDT)
Date: Thu, 12 Sep 2019 13:12:48 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190912111248.GD23174@stefanha-x1.localdomain>
References: <20190827095437.18819-1-stefanha@redhat.com>
 <20190827095437.18819-3-stefanha@redhat.com>
 <20190903172644.GS2744@work-vm>
 <20190904155121.GA25679@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20190904155121.GA25679@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: Re: [Qemu-devel] [PATCH 2/4] virtiofsd: add --print-capabilities
 option
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
Cc: virtio-fs@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 04:51:21PM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 03, 2019 at 06:26:44PM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > Add the --print-capabilities option as per vhost-user.rst "Backend
> > > programs conventions".  Currently there are no advertised features.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > That looks OK to me, but can someone who understands the json
> > requirement explain what says whether a 'features' entry is optional?
>=20
> I have defined a VHostUserBackendType ('fs') but no
> VHostUserBackendCapabilities union field.
>=20
> I guess this is allowed since many other VIRTIO device types are also
> defined without a VHostUserBackendCapabilities union field (only 'gpu'
> and 'input' have one).

Hi Marc-Andr=E9,
Please review when you have time.  You are the vhost-user.json expert
:).

Stefan

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16KDAACgkQnKSrs4Gr
c8jVhAf+MnO0wa7JSgNN6e8L1Wnq3QL2u2G62Gt2zZMb16kzKZV6CW02oWq0kOMi
n6TGUTlfXCegSd1Dx9ghh3iYEnO/AGoFoKf3s1S8fGUWlgHzVw8ZAiT0Kc615rL4
vIHK555a5mXYSxImutFE+ehozw9fOfyDoC4wtGF9azDJph2wH964aIgMYffICY28
LVLiQl5tEwn8W4rMZF3D45GQMbml+DSCoW+Dwbawn/61GgPsblT15TdP8eTz8g2E
hOlxtu8Q/swHEOLTkVbf9m1zPGwrzKf3iAx/RKA5YysTzPVZYLO2r+1z5J8yVBsn
fXWlUvLJC6aqKYG7NNhZnIAxNf/UFg==
=G8wK
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--

