Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D42C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE13E20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0B+kiET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE13E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZLj-0003E2-3Y
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iyZL0-0002ha-3R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iyZKz-0007ja-08
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:52:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iyZKy-0007j4-TE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580727136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOyEZB6Y6FE9CjB2VGEVTaS/cKvdkVO04ZSQanqUxKs=;
 b=T0B+kiEThbwy8eJcebyY8RjWBfZB0fjOoh6Lt0oZAL+fUgH2NRMuAknRXyl/zFu35BsG0z
 OlZvo4lk9i52gRQkvemxomyQY0eJxoHriFL0PjVjz/4bShpqT6rytsFWcS4PheR58su/xp
 KR86C2D/sGf73McYrUdG0n1gSKRpE2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-iT4j5ssrNPy-9fw5zxQYzg-1; Mon, 03 Feb 2020 05:52:12 -0500
X-MC-Unique: iT4j5ssrNPy-9fw5zxQYzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766AB13E5;
 Mon,  3 Feb 2020 10:52:11 +0000 (UTC)
Received: from gondolin (ovpn-117-79.ams2.redhat.com [10.36.117.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 574611E2C0;
 Mon,  3 Feb 2020 10:52:01 +0000 (UTC)
Date: Mon, 3 Feb 2020 11:51:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200203115150.46bd27a3.cohuck@redhat.com>
In-Reply-To: <20200203102529.3op54zggtquoguuo@dritchie>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/_63f4RhQOG=vb1+HohKCg6t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/_63f4RhQOG=vb1+HohKCg6t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Feb 2020 11:25:29 +0100
Sergio Lopez <slp@redhat.com> wrote:

> On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote: =20
> > > On 29/01/20 16:44, Stefan Hajnoczi wrote: =20
> > > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote: =20
> > > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > > >> Stefan Hajnoczi <stefanha@redhat.com> wrote: =20
> > > >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIP=
roxy *vpci_dev, Error **errp)
> > > >>>  {
> > > >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> > > >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > > >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.co=
nf;
> > > >>> +
> > > >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> > > >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > > >>> +        conf->num_queues =3D current_machine->smp.cpus; =20
> > > >> This now maps the request vqs 1:1 to the vcpus. What about the fix=
ed
> > > >> vqs? If they don't really matter, amend the comment to explain tha=
t? =20
> > > > The fixed vqs don't matter.  They are typically not involved in the=
 data
> > > > path, only the control path where performance doesn't matter. =20
> > >=20
> > > Should we put a limit on the number of vCPUs?  For anything above ~12=
8
> > > the guest is probably not going to be disk or network bound. =20
> >=20
> > Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MAX
> > (1024).  We need to at least stay under that limit.
> >=20
> > Should the guest have >128 virtqueues?  Each virtqueue requires guest
> > RAM and 2 host eventfds.  Eventually these resource requirements will
> > become a scalability problem, but how do we choose a hard limit and wha=
t
> > happens to guest performance above that limit? =20
>=20
> From the UX perspective, I think it's safer to use a rather low upper
> limit for the automatic configuration.
>=20
> Users of large VMs (>=3D32 vCPUs) aiming for the optimal performance are
> already facing the need of manually tuning (or relying on a software
> to do that for them) other aspects of it, like vNUMA, IOThreads and
> CPU pinning, so I don't think we should focus on this group.
>=20
> On the other hand, the increase in host resource requirements may have
> unforeseen in some environments, specially to virtio-blk users with
> multiple disks.

Yes... what happens on systems that have both a lot of vcpus and a lot
of disks? We don't know how many other disks are there in the
configuration, and they might be hotplugged later, anyway.

>=20
> All in all, I don't have data that would justify setting the limit to
> one value or the other. The only argument I can put on the table is
> that, so far, we only had one VQ per device, so perhaps a conservative
> value (4? 8?) would make sense from a safety and compatibility point
> of view.

The more I think about it, the more I agree. Aiming a bit lower will
hopefully give more performance with less opportunity for unforeseen
breakage due to resource exhaustion.

--Sig_/_63f4RhQOG=vb1+HohKCg6t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl43+0YACgkQ3s9rk8bw
L69DDA/+M/oVP3CjzjukaC8jVp+JL44bbsnDoJRwQPEVc4BhwEB5OqfOThZfASuO
ILsE8Nku8TKGMtm6qp+arRrrIGdtAbm5y0o1Yc1QKFOoeig9b86LvkT7DDXZdJAQ
v47nHCSOu22/mAlije+bkr1eVF4ZBo0UQGBwBtlC1AyI9sTg6lxyVhhCVh3JYUK6
a80lA0SjK60MEKb+S4r9vxAddzyOQ6tPQg/h4wileu63AcGW8YpkE02ZsWjY1jNq
4x1p3hjOIj4iZdD/jTlE1wffyWXH1Od5qx3+JMMFVngwmm+O7rnSHkWr3IPD0PxI
8es91bAfp1GQP0QZCDu+AlVrrSCuOpmxXxqqF5fKmiOYiedniFCS/5UvHZZn06Nf
rsN/voymj1z+Eu/YqsZdSI/nBiGzZ2wUNuH7C4njNo9ouTdie0V3F5FwxaYLz31U
ebnVCybCI98U2wRDjNz8s5IHumbmH5BaX3wAsAL7Zg9h8lMmjXrozwMqwZtOlG0c
m8HwHoYbfo4Pv3i8qDHTd+Fpv2My7MMwg0xtsVIt14SVAGYBunCH/do+4JmtApBo
5Re9uVpUeul0hn/xrmEgVtNFcJaaqRQdKfKD+XBTwr2Uv6RwxSP1dFWYSAYN27ZF
GicU3n++FiVUSBCU8TE/g1qUWmsd8WG5JwXJJOfzgnXAc5fScIU=
=Te2u
-----END PGP SIGNATURE-----

--Sig_/_63f4RhQOG=vb1+HohKCg6t--


