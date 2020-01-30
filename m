Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D721C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E50206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORvewhjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E50206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7Rv-0001NO-E6
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 05:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ix7RF-0000sO-Is
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ix7RD-0007Qx-Ev
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:52:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ix7RD-0007PZ-Ac
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580381562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52R3WfjMwr/4AEiLkD58VYagXb/KV3kiClhCbMyrrBU=;
 b=ORvewhjyk1ULmZI9IaSZfAuI0t7+/BfimpUkLSMwNx/psJpxBTRtmIMmZbiO9J34k60lQO
 l/tX88KsqG6OalrVIt/3+d9JOkRnI1YxUrbsaPPfpkGAdx7+O8ng9obfw3XNdS9MiZpVLl
 8CeuLjVuy0zxuPU9YYMUy8XVER/Fo40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-2mVf8LE2Mim4hNZf_1irFA-1; Thu, 30 Jan 2020 05:52:40 -0500
X-MC-Unique: 2mVf8LE2Mim4hNZf_1irFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 571CA107ACC4;
 Thu, 30 Jan 2020 10:52:39 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EE9C6C523;
 Thu, 30 Jan 2020 10:52:36 +0000 (UTC)
Date: Thu, 30 Jan 2020 10:52:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200130105235.GC176651@stefanha-x1.localdomain>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> >> On Fri, 24 Jan 2020 10:01:57 +0000
> >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy=
 *vpci_dev, Error **errp)
> >>>  {
> >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
> >>> +
> >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> >>> +        conf->num_queues =3D current_machine->smp.cpus;
> >> This now maps the request vqs 1:1 to the vcpus. What about the fixed
> >> vqs? If they don't really matter, amend the comment to explain that?
> > The fixed vqs don't matter.  They are typically not involved in the dat=
a
> > path, only the control path where performance doesn't matter.
>=20
> Should we put a limit on the number of vCPUs?  For anything above ~128
> the guest is probably not going to be disk or network bound.

Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MAX
(1024).  We need to at least stay under that limit.

Should the guest have >128 virtqueues?  Each virtqueue requires guest
RAM and 2 host eventfds.  Eventually these resource requirements will
become a scalability problem, but how do we choose a hard limit and what
happens to guest performance above that limit?

Stefan

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4ytXMACgkQnKSrs4Gr
c8gNcQf/UTROvH/gmW65kqsGLKrkMELDkIbmMoYcWZ18OgMnY0/B7rSxMelhxPUu
uiG+LXgW8usEPz5zq2UrBMXVe5uEuMQ1fiToHtX4csLQjxf8t/JM1Hl3aS9uAr12
1Tg4WWFiNarFdMNoNxyGVmyONDNfDGUBb0YFAv3798XpK3Hmu7d5z912s7uZU+22
MNItuJEFCziujquHcOpD+IkoggagDWYHG4I4lzVmiO+Zk9cu+utRC0+XtRbB1n8v
Lzq3zRS8alzvccHB1W0oJ4XzUGMaiFanDXTolwrOoOZpg0+2kbCCNhJQ26zOyuRu
djx8518bF2YzxFyOGB7O1Kl92BsGkg==
=ix1x
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--


