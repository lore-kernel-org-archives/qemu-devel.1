Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0C5C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEDC2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IepzGTAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEDC2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHDB-0005Fl-Sh
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSHC0-0004i4-N5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSHBz-0001Nt-F4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:01:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSHBz-0001Nj-7J
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573030890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ew/Dk/DaiJhEBSd6zx7lepUTUMluF0OUQn79UOdRsQo=;
 b=IepzGTAcCZ+rGQ+FNmLK3fel1/HIpEPlC78xvph51c672I30u7W0dGWlII7KE/QThEZYIQ
 7GGxq8sWp/P9/FGBOXtm8QVRnsnH12m0kW6Yq4/qzv9001Zwd8wmIB5NNHdm3EZjIW0S7E
 8iGrRVTb36tDfb0y4ERBg/G1r7GZSzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-eXoHYZHIMByQhJKQ4hbnUw-1; Wed, 06 Nov 2019 04:01:26 -0500
X-MC-Unique: eXoHYZHIMByQhJKQ4hbnUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D6B800C72;
 Wed,  6 Nov 2019 09:01:25 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8E615D70E;
 Wed,  6 Nov 2019 09:01:21 +0000 (UTC)
Date: Wed, 6 Nov 2019 10:01:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Message-ID: <20191106090119.GE189998@stefanha-x1.localdomain>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-2-dplotnikov@virtuozzo.com>
 <20191105155357-mutt-send-email-mst@kernel.org>
 <c14296e6-0557-d643-722a-531e3c2f01de@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <c14296e6-0557-d643-722a-531e3c2f01de@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 07:46:31AM +0000, Denis Plotnikov wrote:
>=20
> On 05.11.2019 23:56, Michael S. Tsirkin wrote:
> > On Tue, Nov 05, 2019 at 07:11:02PM +0300, Denis Plotnikov wrote:
> >> The patch protects from creating illegal virtio device configuration
> >> via direct virtqueue size property setting.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> >>   hw/virtio/virtio-blk-pci.c  |  9 +++++++++
> >>   hw/virtio/virtio-scsi-pci.c | 10 ++++++++++
> >>   2 files changed, 19 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
> >> index 60c9185c39..6177ff1df8 100644
> >> --- a/hw/virtio/virtio-blk-pci.c
> >> +++ b/hw/virtio/virtio-blk-pci.c
> >> @@ -48,6 +48,15 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *=
vpci_dev, Error **errp)
> >>   {
> >>       VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(vpci_dev);
> >>       DeviceState *vdev =3D DEVICE(&dev->vdev);
> >> +    bool modern =3D virtio_pci_modern(vpci_dev);
> >> +    uint32_t queue_size =3D dev->vdev.conf.queue_size;
> >> +
> >> +    if (!modern && queue_size > 128) {
> >> +        error_setg(errp,
> >> +                   "too big queue size (%u, max: 128) "
> >> +                   "for non-modern virtio device", queue_size);
> >> +        return;
> >> +    }
> >
> > this enables for transitional so still visible to legacy
> > interface. I am guessing you want to check whether
> > device is accessed through the modern interface instead.
>=20
> My goal is to not break something when I'm setting the queue size > 128=
=20
> (taking into account the current seabios queue size restriction to 128).=
=20
> I'm not quite sure what to check. Could I ask why one want to the check=
=20
> whether accessing through the modern interface and how it could be checke=
d?

virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)

Stefan

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Ci98ACgkQnKSrs4Gr
c8g6nggAlLEywCmbAD2f/a8lwkfbN40OaCkONuoD2uybv1xJtsTsgD3RwOmEBszp
Mk0AmM4Jr7MIcHX2/+nW/qsrwj1gdj/xdnrswqxQJS8W/i/TNm7dTkTj1xNO5TMJ
D3+iclHsi8/1imuAt7FYNZGzC0IXwCynKKcb1xn0/CFTmCkyypM/LC2WOLbzzg6z
VXbEIc0AR3c+bUxy+NU+ZSxUrPTULO9+EYlQP6Zsd1XpFONpFCUMTOCRI6XxlmoO
BID/C7bSw6KIR0GOgU/ADQIl6IPnNZHnB9nuyL3JeRrYUv2KmhTCo49xWVIELRGS
k9klT8YFjRwZUa10s+EIpe+yzuPp3w==
=1/8q
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--


