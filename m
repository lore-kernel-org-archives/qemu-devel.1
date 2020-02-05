Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD0C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9C52082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYlZHkci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9C52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIj6-0004a4-4X
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izIi9-00043h-GC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izIi8-00030K-4y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:19:13 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1izIi5-0002g4-BH; Wed, 05 Feb 2020 06:19:09 -0500
Received: by mail-wr1-x444.google.com with SMTP id z9so2188163wrs.10;
 Wed, 05 Feb 2020 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3ZKkfdQ0GovnoLHCCx0tLm21SvUGK2m+2mXL0og9CUA=;
 b=NYlZHkcibMqfhzumqOKAE8G3r0knHon8BwYGGTyT3KiDp0QwKXQNrEHlGkLMZHbaet
 0/ZbUSIbJvxnWNPYwb/hiqEKDIFdVVaThAJw2MkbItq60o5v8q4qrYp17i/Lg/52D8ak
 S/CmlrI12CgVDMt8mgAYkg5kJMPA1j5ZdA53Ww8CBO0B4Te70B/6ApkYrYxRPtL1O/0p
 VBBlfrB2Z/4V0/xHeMLYNljz9wj8rxPgjWKmcFXqN+gmzEZH+0yIr5Q8ls7N6tukwy9h
 Wdr6DGayAVB+6eWIjLJxzvWD9wRycJCzY1lZwTmfPujsTW4t/dC/jTJWDjYx4enFKVKJ
 l2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3ZKkfdQ0GovnoLHCCx0tLm21SvUGK2m+2mXL0og9CUA=;
 b=hDfpQj+/1/Kh2REtci0oZ2y13UQcoSFxOmhCXeRefg43CQ5ZmFRMzawNrjsiO80Bmu
 enJpYF+u0KFmQvaqrL0FD4BWQ2fpQyUsvsXMOB/tkdD/rYT5qqi23/TRiMGcBmQpl3wr
 QdolieG2wX6CQESG0NCUFFqMrwSyiUiPsAr86TAgpoGO9MY/3u45CQC82R1c1OHboLUx
 N0Oa79vTmS8PnqP6w04pATQ/nTBO5PJX++pBgL6PItQ4nQer2o60rxkBM8kAulDtIhmw
 eodxQG3QX7r40nL5OUGq/DNfSsj3Ox8aAXUVa+wZHUjM5miV4WoknRl/QnTmHUR1EnJW
 POQA==
X-Gm-Message-State: APjAAAXsj5ti2W+xUj5Ib94AuLUAkaYAHBrrN0NTi3LD9aCrV+s/6kkD
 PP8X9oqS3QksYieJjte5rS0=
X-Google-Smtp-Source: APXvYqyQPliAP/z+b9LJ3LQw/OeC4oVvWPlOvsqHtKAreYQwtMSaj0obX4jKwZRcEOBj5mAEJNhaPw==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr17225807wru.391.1580901548196; 
 Wed, 05 Feb 2020 03:19:08 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c141sm8019247wme.41.2020.02.05.03.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 03:19:07 -0800 (PST)
Date: Wed, 5 Feb 2020 11:19:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200205111905.GE58062@stefanha-x1.localdomain>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
>=20
>=20
> On 30.01.2020 17:58, Stefan Hajnoczi wrote:
> > On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
> > > The goal is to reduce the amount of requests issued by a guest on
> > > 1M reads/writes. This rises the performance up to 4% on that kind of
> > > disk access pattern.
> > >=20
> > > The maximum chunk size to be used for the guest disk accessing is
> > > limited with seg_max parameter, which represents the max amount of
> > > pices in the scatter-geather list in one guest disk request.
> > >=20
> > > Since seg_max is virqueue_size dependent, increasing the virtqueue
> > > size increases seg_max, which, in turn, increases the maximum size
> > > of data to be read/write from guest disk.
> > >=20
> > > More details in the original problem statment:
> > > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
> > >=20
> > > Suggested-by: Denis V. Lunev <den@openvz.org>
> > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > ---
> > >   hw/core/machine.c          | 3 +++
> > >   include/hw/virtio/virtio.h | 2 +-
> > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 3e288bfceb..8bc401d8b7 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -28,6 +28,9 @@
> > >   #include "hw/mem/nvdimm.h"
> > >   GlobalProperty hw_compat_4_2[] =3D {
> > > +    { "virtio-blk-device", "queue-size", "128"},
> > > +    { "virtio-scsi-device", "virtqueue_size", "128"},
> > > +    { "vhost-blk-device", "virtqueue_size", "128"},
> > vhost-blk-device?!  Who has this?  It's not in qemu.git so please omit
> > this line. ;-)
> So in this case the line:
>=20
> { "vhost-blk-device", "seg_max_adjust", "off"},
>=20
> introduced by my patch:
>=20
> commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
> Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Date:=A0=A0 Fri Dec 20 17:09:04 2019 +0300
>=20
> =A0=A0=A0 virtio: make seg_max virtqueue size dependent
>=20
> is also wrong. It should be:
>=20
> { "vhost-scsi-device", "seg_max_adjust", "off"},
>=20
> Am I right?

It's just called "vhost-scsi":

include/hw/virtio/vhost-scsi.h:#define TYPE_VHOST_SCSI "vhost-scsi"

> >=20
> > On the other hand, do you want to do this for the vhost-user-blk,
> > vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Those
> > devices would benefit from better performance too.
> It seems to be so. We also have the test checking those settings:
> tests/acceptance/virtio_seg_max_adjust.py
> For now it checks virtio-scsi-pci and virtio-blk-pci.
> I'm going to extend it for the virtqueue size checking.
> If I change vhost-user-blk, vhost-user-scsi and vhost-scsi it's worth
> to check those devices too. But I don't know how to form a command line
> for that 3 devices since they should involve some third party components =
as
> backends (kernel modules, DPDK, etc.) and they seems to be not available =
in
> the
> qemu git.
> Is there any way to do it with some qit.qemu available stubs or something
> else?
> If so, could you please point out the proper way to do it?

qemu.git has contrib/vhost-user-blk/ and contrib/vhost-user-scsi/ if
you need to test those vhost-user devices without external dependencies.

Stefan

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl46pKkACgkQnKSrs4Gr
c8iA1AgAi73vfGT8NFyxop+QMW08ta8qKXh7ckGH3RE+IwznI2dR/5NEA7jESNwU
Ns/Jgy+SfFioiO6tWqjWwgXOgCSjsY6Iq9U1wDoeklfolSLmxf/jwQ1qLdvzqkhm
w+9Ns9pkX0sDKS0kEBg94ypD6nyHlTgXwz6Bi0G/SgNEvqbcoOFbUFPeIjrXh9Zs
+ZCT3DRL45cw0OPjFw6bB3EKOFOAj9ua7upAnzBN948BHWlQMnKlawjSzdhJu+Y+
aT3w0ix/aEPl/XakF0xAVREO8KXOxjirSf/se453uLgNM0Y0h37XZW630h0a+diC
B0MOmGyrJT0uS0jFXYhQ5dFNilgqTw==
=CE8w
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--

