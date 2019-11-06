Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BEBC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686B020869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3SW8mXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686B020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGvr-0005h0-K2
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSGus-0004jB-8M
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSGur-0007zR-4t
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:43:50 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSGuq-0007xu-SD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:43:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id q70so2351384wme.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=v31fEkgwXp8SELPxnFeI+H2hYH5lK/wUKHznRj7SoXE=;
 b=c3SW8mXxTeconF1fXD7u6ricZNPaxRyUxnO+uMSqcOFrydx6GO/EGz6pxVCS58TXGQ
 bs551aj/5w8VPaMIaH9iFWFrb6Z63FugVMEAgbcnkU67/FC8LIodqWh9OCg6eT4GXqEV
 Bwls671N/Hz5OrlM0FwGW6bkL3RI7sZ7ZNJqWFBORrgSdlSw9enXh9FYVTJysQpkYeeU
 9bXJMj9Yd8XjGSyAQq2FLgpM9pzqevN1Rgetf80vtdoaWRwdE3e7mu3HmXSuZTRceFaF
 aAGL7fV4ILBgAEsW2Kcq++1NJ6oSxLB31twMSTSDVp/h4bAvnSXMU6nELlMEM9SqXEez
 ValQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=v31fEkgwXp8SELPxnFeI+H2hYH5lK/wUKHznRj7SoXE=;
 b=Xu8EQwA7iQACvYdV1MHerhD5yPWx+Nv+Wit1773g9Amwr0HhJlDXRYDIbf3OHeXJC0
 +Jb24CrT+ckUbHx3JKEiyxmICbyE8Ipq6dCv10U816xoWQfMgYEf7EGmK7mEi0HKqsL/
 FfdbZeu7hBWIRu+bJprB/N6T/9yz+5EkjTNP13uOptUoE95R+wSxrHtHXPYqeOaZR6Z+
 KyBRZ6u86nGFLGtc4dVD6vFA0Avx3Jt8T2y3CjRU8TgXonTfdJzKIFW/kOm1xo/iuccn
 2smCTnrNlPgSJ0frgQrtwoPOEIF2cd1arAnslj8f5x8o4XGRoBJkFEaUuJceaXhmC9DW
 XT0A==
X-Gm-Message-State: APjAAAWZnovXelh+evZYlUcquHfZj1HzjGBM1Ka3iRmgmR9Aa2yCWATJ
 zTysKfKKbstGqSgr7OIwuqI=
X-Google-Smtp-Source: APXvYqxstNgqeFH+RzorSCme69eWeZGQKPmZ8MdpufkRDxMeu9YnCs6VaiQXcAg84+zJnAS040B0KA==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr1361258wma.38.1573029827418; 
 Wed, 06 Nov 2019 00:43:47 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id d11sm19336229wrn.28.2019.11.06.00.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 00:43:46 -0800 (PST)
Date: Wed, 6 Nov 2019 09:43:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: guest / host buffer sharing ...
Message-ID: <20191106084344.GB189998@stefanha-x1.localdomain>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 11:54:56AM +0100, Gerd Hoffmann wrote:
> The issue of sharing buffers between guests and hosts keeps poping
> up again and again in different contexts.  Most recently here:
>=20
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg656685.html
>=20
> So, I'm grabbing the recipient list of the virtio-vdec thread and some
> more people I know might be interested in this, hoping to have everyone
> included.
>=20
> Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> resources" is really a good answer for all the different use cases
> we have collected over time.  Maybe it is better to have a dedicated
> buffer sharing virtio device?  Here is the rough idea:

My concern is that buffer sharing isn't a "device".  It's a primitive
used in building other devices.  When someone asks for just buffer
sharing it's often because they do not intend to upstream a
specification for their device.

If this buffer sharing device's main purpose is for building proprietary
devices without contributing to VIRTIO, then I don't think it makes
sense for the VIRTIO community to assist in its development.

VIRTIO recently gained a shared memory resource concept for access to
host memory.  It is being used in virtio-pmem and virtio-fs (and
virtio-gpu?).  If another flavor of shared memory is required it can be
added to the spec and new VIRTIO device types can use it.  But it's not
clear why this should be its own device.

My question would be "what is the actual problem you are trying to
solve?".

Stefan

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Ch8AACgkQnKSrs4Gr
c8jJkQf+OXfiNkWYIcdcWyI1Jb83nIWtxUvep2NE3eZ1qcZk4MgmN5D4fAnr3T0n
vOLAaJvryIB62LxqUhpKkvL1Bjs/U4xo7n3R4Nr2x6/Tu3KHMYNrWGeEIRHnz+Kb
CnK9LiO8Y7JRmQ2CjlBCCBshO8CDFrxAA2VLkGcqU95yxxvrAAZ2rzpRmn16pBth
rhCLUHsNB8hKaJof0ITCFexJFcwLELATD/YmPZioJu2E/mcV5qKjm89gz/7VdlE3
ke/a0WFC2BIh/wm3MaAPKyn7hgd9yOafmEEVl+qCE86K1j+jzv8K4dvB5FdPOW2A
ayt+fhrKECTHRXvWoZ1AD1V5gtUs2g==
=AAPk
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

