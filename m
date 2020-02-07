Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5809C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEBA21775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClT6t+Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEBA21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06GZ-0000dB-Qt
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j06Fm-0007b1-Vl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j06Fl-0005PV-IW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:13:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j06Fi-0005NW-Ib; Fri, 07 Feb 2020 11:13:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id a9so3386201wmj.3;
 Fri, 07 Feb 2020 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IrWeMljI65Vfn29EV6+2aK+XfMeKi6wt8FZ2P9md7kw=;
 b=ClT6t+Y/2SNTGYGnQCBvvVDIyi7zLQ+0AINNfmsfZYzRSRsN86mY7VgsENsSoWZgeY
 APOHYkaQAAcNlrLZKHyAmEiLRV185k/dGHHLGzxCXwHncdoLdtrOrFtbJrym7H7jg3TQ
 x1Q38LSiTK+zSqkxej65L6166+IJiPHg1yhZ067VhJb/IgFuCW7QIEas2ThhbX9ho7TZ
 QQsPz1XxUIne2ZNyOEubHoOMUHN5TDNyzPVvokrkP6pb1xOrrw7n0uKqK8/uLjIvm7oH
 UsPNEAd0DLl3P1C280PHW6Y8Nk1itpMD+PyccQFJRrpO6yjBVxaNtUOgcHayaz3ua8Aj
 cc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IrWeMljI65Vfn29EV6+2aK+XfMeKi6wt8FZ2P9md7kw=;
 b=InxIxN2CCLfyugPAJUxHPSk+FInJvVED2k1WoESpVVioGCB/2mXtD5x9x8FEBzo0SI
 LnMc/oPMuisCARTgWV135UeHn63tchaV3JRP+nzdgf1bnkEBqvcP2xWtr/G1zcFA+Hiw
 kRY7eoS6VrGyBUV5oPibNcguIg+SwKikUUOfWzCnf2YPgEI2mJGyqR9BQe+ZGZ0wA1Dz
 paWr1q7d60uQSe+Ft93fFCCwy4nTM3wed4iBkmEnL4wyxU6c23i9XMiSV8PvOFwNdTVJ
 TQ5pmsMEDgn6a104VHJvX0wP61vwAYAqL5oajbMrHpSdLWl0im5e0F/OvtRQX2WLOkdS
 vsSQ==
X-Gm-Message-State: APjAAAVq6TjEquh9K30d2lbDwJdgcA11VMK8dmmK3eSN4WCTPopFq2h1
 MEeaYWP9WqrR/9sN1Ohmgf4=
X-Google-Smtp-Source: APXvYqyPBetcuSLpQTltfKTpdc1S3qQTPHsSu44YJHLzPsfnWtYcEBFpvD8JGHJebiXzp1xu/R+g/w==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr5268437wmj.160.1581091989135; 
 Fri, 07 Feb 2020 08:13:09 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o4sm4015285wrx.25.2020.02.07.08.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 08:13:08 -0800 (PST)
Date: Fri, 7 Feb 2020 16:13:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200207161306.GG168381@stefanha-x1.localdomain>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
 <20200205111905.GE58062@stefanha-x1.localdomain>
 <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
In-Reply-To: <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 11:48:05AM +0300, Denis Plotnikov wrote:
>=20
>=20
> On 05.02.2020 14:19, Stefan Hajnoczi wrote:
> > On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
> > >=20
> > > On 30.01.2020 17:58, Stefan Hajnoczi wrote:
> > > > On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
> > > > > The goal is to reduce the amount of requests issued by a guest on
> > > > > 1M reads/writes. This rises the performance up to 4% on that kind=
 of
> > > > > disk access pattern.
> > > > >=20
> > > > > The maximum chunk size to be used for the guest disk accessing is
> > > > > limited with seg_max parameter, which represents the max amount of
> > > > > pices in the scatter-geather list in one guest disk request.
> > > > >=20
> > > > > Since seg_max is virqueue_size dependent, increasing the virtqueue
> > > > > size increases seg_max, which, in turn, increases the maximum size
> > > > > of data to be read/write from guest disk.
> > > > >=20
> > > > > More details in the original problem statment:
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.ht=
ml
> > > > >=20
> > > > > Suggested-by: Denis V. Lunev <den@openvz.org>
> > > > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > > > ---
> > > > >    hw/core/machine.c          | 3 +++
> > > > >    include/hw/virtio/virtio.h | 2 +-
> > > > >    2 files changed, 4 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 3e288bfceb..8bc401d8b7 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -28,6 +28,9 @@
> > > > >    #include "hw/mem/nvdimm.h"
> > > > >    GlobalProperty hw_compat_4_2[] =3D {
> > > > > +    { "virtio-blk-device", "queue-size", "128"},
> > > > > +    { "virtio-scsi-device", "virtqueue_size", "128"},
> > > > > +    { "vhost-blk-device", "virtqueue_size", "128"},
> > > > vhost-blk-device?!  Who has this?  It's not in qemu.git so please o=
mit
> > > > this line. ;-)
> > > So in this case the line:
> > >=20
> > > { "vhost-blk-device", "seg_max_adjust", "off"},
> > >=20
> > > introduced by my patch:
> > >=20
> > > commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
> > > Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > Date:=A0=A0 Fri Dec 20 17:09:04 2019 +0300
> > >=20
> > >  =A0=A0=A0 virtio: make seg_max virtqueue size dependent
> > >=20
> > > is also wrong. It should be:
> > >=20
> > > { "vhost-scsi-device", "seg_max_adjust", "off"},
> > >=20
> > > Am I right?
> > It's just called "vhost-scsi":
> >=20
> > include/hw/virtio/vhost-scsi.h:#define TYPE_VHOST_SCSI "vhost-scsi"
> >=20
> > > > On the other hand, do you want to do this for the vhost-user-blk,
> > > > vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Th=
ose
> > > > devices would benefit from better performance too.
> After thinking about that for a while, I think we shouldn't extend queue
> sizes for vhost-user-blk, vhost-user-scsi and vhost-scsi.
> This is because increasing the queue sizes seems to be just useless for
> them: the all thing is about increasing the queue sizes for increasing
> seg_max (it limits the max block query size from the guest). For
> virtio-blk-device and virtio-scsi-device it makes sense, since they have
> seg-max-adjust property which, if true, sets seg_max to virtqueue_size-2.
> vhost-scsi also have this property but it seems the property just doesn't
> affect anything (remove it?).
> Also vhost-user-blk, vhost-user-scsi and vhost-scsi don't do any seg_max
> settings. If I understand correctly, their backends are ment to be
> responsible for doing that.
> So, what about changing the queue sizes just for virtio-blk-device and
> virtio-scsi-device?

That's fine.  If it's beneficial to extend it to the vhost devices then
it can be done later.  I didn't look into it (and the way that
responsibility for these parameters is shared between QEMU and the
vhost-user device backend is a little complicated).

Stefan

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl49jJIACgkQnKSrs4Gr
c8gFHAgAizJaWaZpm2TuXfSKmOcEfJnvmQ5KNk6S2udQ31ddR2FHm+1TuNl0X7SZ
uhBNEurC25GTK4rxXvznes/tlJKeHteNH8zV1ZLTCzgZgjIukcWy6M2+cI6QgnD4
UjoDv02NDLCZ6h7u+hiAmR/AOwCVwrrvniZhXes75KkHvrHSi7518yLtIQ0Bmbq3
xabZYcVtAp/yeHNK9lu/VeQbrloaeBhisQgRMjEgR7kqsqONY173Mrr1ZT/KEc8a
R9ZFHr7xYokJX6CoGa14uZEjovewaS/VMuhaTxiVX1YGbV5YuvlMj6i0As0l/Bde
h8liWkfVfSX+vZ+hfT2P5AJkslDT4Q==
=L+dF
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--

