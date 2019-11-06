Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A46C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07062173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGKv2U6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07062173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHTS-0004lS-5b
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSHSL-00045R-8B
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSHSI-0000IP-Tm
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:18:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSHSI-0000I4-Pa
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573031902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5pzd7bfSTuES3d+YiyhdBv6SGqbp/gPMHy01nDBqsQ0=;
 b=NGKv2U6mwF9Ouz8lhmc12uUsMGsl5VQsOMd+fDq4KNc9N1fKbtV99VjxI7zjN7nKDCsc2b
 NvHayRLqB3r634l4EnZJm8/XLwYsisR59cU9H5UbEnc8KOe6mcbx/R/ChyfhA3sRVmUOUO
 ED4X/q9NSAsOPoPNhluNILN9li61MNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-S7ZsHgHIM7-FHRPFsbCt7g-1; Wed, 06 Nov 2019 04:18:18 -0500
X-MC-Unique: S7ZsHgHIM7-FHRPFsbCt7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D75A1005500;
 Wed,  6 Nov 2019 09:18:17 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 421E85D713;
 Wed,  6 Nov 2019 09:18:13 +0000 (UTC)
Date: Wed, 6 Nov 2019 10:18:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Message-ID: <20191106091812.GF189998@stefanha-x1.localdomain>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-2-dplotnikov@virtuozzo.com>
 <20191105155357-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191105155357-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
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
Cc: fam@euphon.net, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 03:56:43PM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 05, 2019 at 07:11:02PM +0300, Denis Plotnikov wrote:
> > @@ -47,6 +48,15 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *=
vpci_dev, Error **errp)
> >      VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> >      DeviceState *proxy =3D DEVICE(vpci_dev);
> >      char *bus_name;
> > +    bool modern =3D virtio_pci_modern(vpci_dev);
> > +    uint32_t virtqueue_size =3D vs->conf.virtqueue_size;
> > +
> > +    if (!modern && virtqueue_size > 128) {
> > +        error_setg(errp,
> > +                   "too big virtqueue size (%u, max: 128) "
> > +                   "for non-modern virtio device", virtqueue_size);
> > +        return;
> > +    }
>=20
> why? what is illegal about 256 for legacy?

I think it was mentioned that this limit is specific to SeaBIOS
src/hw/virtio-pci.c:vp_find_vq():

  #define MAX_QUEUE_NUM      (128)
  ...
  if (num > MAX_QUEUE_NUM) {
      dprintf(1, "ERROR: queue size %d > %d\n", num, MAX_QUEUE_NUM);
      goto fail;
  }

I'm not sure there is anything we can do in QEMU.  Either you can let
SeaBIOS fail, or if you want something more user-friendly, then the
management tool can implement a check based on the SeaBIOS version and
the -device virtio-blk-pci,queue-size=3DSIZE property value.

Stefan

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Cj9QACgkQnKSrs4Gr
c8jTewf+P8ghBu3WuhGm8QwpRrvaRkwewlW1ZtAnbb06aerST7P0XXgdJNAbh5ub
+bPv36Cpdyaq83cHDGkl8zHwpcazvZRZzJ3vdV/UpCARdD0Fap0y5iIhU3yvxbnk
hyk0qwASV2N8XHmT5EMDQLdrVKWbxmKLeQMx/c+qxBeg2Q26Efi/OU92z99SNxNv
DMraC+6uQEEf5NQZEP6nSwarf7iDRtJAOUdI3QGqXeeHBYZGL7yW6XCi9g9hTs7X
iJbVNqbpwPS5l5NDWtXhG1S3Uc+IkOm/C5f2ySQm3PNlfQ5a7tipZH+e58VntV8U
H1d1Z5ep+xKau5pTxig3SER49C9BjA==
=B/Lw
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--


