Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5DBC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB11D206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWj2tgNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB11D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7cb-0006xa-14
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ix7bz-0006Ts-Tc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ix7by-0002Ie-5o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:03:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32353
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ix7by-0002II-1e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580382229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysnc02IrGZRr75lRD5Y5zD8LkutuR6ZXlRHRWGANGd4=;
 b=EWj2tgNZ6dXmpyWjik2A67hZnRcXLcME1zzHqMOvQPmVFqjQa/waDNt+xS5KZCzvrt4KwG
 2Zmz6fWiVYRp96T2BnUoufb0V9FwKB/gyrLAx1eaWfl8vHsUxfjxPZs/Vu0w5gTdqADdDz
 maWjMPX0JE6ZOyipaej3+viOmiJIpGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-NE4-rVvoMlSI66JRnuN1rw-1; Thu, 30 Jan 2020 06:03:47 -0500
X-MC-Unique: NE4-rVvoMlSI66JRnuN1rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 052C4100551D;
 Thu, 30 Jan 2020 11:03:46 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD6B5C1B2;
 Thu, 30 Jan 2020 11:03:38 +0000 (UTC)
Date: Thu, 30 Jan 2020 12:03:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200130120314.5d4ad113.cohuck@redhat.com>
In-Reply-To: <20200130105235.GC176651@stefanha-x1.localdomain>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/dYAYDJttwU6UCIo+vbbte=D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/dYAYDJttwU6UCIo+vbbte=D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jan 2020 10:52:35 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > On 29/01/20 16:44, Stefan Hajnoczi wrote: =20
> > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote: =20
> > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > >> Stefan Hajnoczi <stefanha@redhat.com> wrote: =20
> > >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIPro=
xy *vpci_dev, Error **errp)
> > >>>  {
> > >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> > >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf=
;
> > >>> +
> > >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> > >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > >>> +        conf->num_queues =3D current_machine->smp.cpus; =20
> > >> This now maps the request vqs 1:1 to the vcpus. What about the fixed
> > >> vqs? If they don't really matter, amend the comment to explain that?=
 =20
> > > The fixed vqs don't matter.  They are typically not involved in the d=
ata
> > > path, only the control path where performance doesn't matter. =20
> >=20
> > Should we put a limit on the number of vCPUs?  For anything above ~128
> > the guest is probably not going to be disk or network bound. =20
>=20
> Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MAX
> (1024).  We need to at least stay under that limit.
>=20
> Should the guest have >128 virtqueues?  Each virtqueue requires guest
> RAM and 2 host eventfds.  Eventually these resource requirements will
> become a scalability problem, but how do we choose a hard limit and what
> happens to guest performance above that limit?

There's probably two kind of limits involved here:

- a hard limit (we cannot do more), which should be checked even for
  user-specified values, and
- a soft limit (it does not make sense to go beyond this for the
  default case), which can be overridden if explicitly specified.

VIRTIO_QUEUE_MAX (and two less for virtio-scsi) sounds like a hard
limit, maybe 128 is a reasonable candidate for a soft limit.

(I would expect systems that give 128 vcpus to the guest to also be
generously sized in other respects.)

--Sig_/dYAYDJttwU6UCIo+vbbte=D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl4yt/IACgkQ3s9rk8bw
L68v4RAAmNONBZ1RD8SLGd/vXUVfCPrC/t7kcCowzTq2BKRlJAHEHGm9q4Afsv/r
9Ndd9I13FmoxRhsXe6OuSvCQbdUAgY5qyT6DNFc33SrhVYsyrVX7eWEJYs4Ywscf
Wtrk3Vz0bfvSvZsrmuJOTOPOVxa7fzJZFyLZV3qDcOEshcSF/MUtyQ+4T+soZ4xI
HYMP4DdtjCdwaJsFcEQul3hODwdsJo0t18yaXtbHFoLgYHYpA8H2EKyO7DDtOp3l
yspinJUwp3eEfAm8Tt+//6RyCi6PTqPRONpbMcM2tXnDcqL1gDJOgZtMkorWZFfi
C6kOAUum9bWP92cYZ36XwBhxlgLBhaOwpSGOl4/CmTBTLikaSeMl1XaqKG/ALxnY
A3DpIdi9lgW7OfXaFXPkQO1YJRU6IpWHiMzrFIcyU/S+gvlW/mgleiRHrWra2vap
4wI7Tg80jiVgwDtc9QdKdp3G6n4q/GdP9S0qJcmI+LW07hKdKPnHnrFio4LrpZFe
BQA4CBq6QYgiS910o8cW8jCnDFSi3enTwgSFCRzoARUrDJianvYSecNnrSI6UUA2
tdOw4RkMjqehOWH7ATVE7Q5CFcjTkjrVjTOliRFQnk/TIsmbJyiz+nuxmrO+kiRM
DS4+1NQoI0G6iFK6rEnh7kNC4KzjqSqvC0O1zU/3q1UujMmtssI=
=qyla
-----END PGP SIGNATURE-----

--Sig_/dYAYDJttwU6UCIo+vbbte=D--


