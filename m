Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF18C010CF
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289E62190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi6+6Gzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289E62190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRy4Q-0000oX-59
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 07:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iRy3m-0000Km-BN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iRy3j-0001BE-Gy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:35:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iRy3i-000192-RZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572957338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWuHPxG+OliKzJDNJGbQO41ouY6ImAALhIWAPCwGAfo=;
 b=Zi6+6Gzr57vnKKcmuz7XYWWvPBgqxBJqhB9mIAJkK5xOTcnGaXRaMvqeJMJPY3+07YxyFw
 IyRUmgF7wDdR3Atnwh4Jnjae4qxx6IzNIzkxZs0pJs2fJU52/bqhskw++TRF3Mt9yTjYVE
 HZ5CCUNlQtG9O71Ht0lEBqztF09CxfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-3MtwJ1yYP_-08PgG7MSOjw-1; Tue, 05 Nov 2019 07:35:35 -0500
X-MC-Unique: 3MtwJ1yYP_-08PgG7MSOjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40A0477;
 Tue,  5 Nov 2019 12:35:33 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FD5A1A8D8;
 Tue,  5 Nov 2019 12:35:29 +0000 (UTC)
Date: Tue, 5 Nov 2019 13:35:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yongji Xie <elohimes@gmail.com>
Subject: Re: [PATCH] virtio: notify virtqueue via host notifier when available
Message-ID: <20191105123527.GA102667@stefanha-x1.localdomain>
References: <20191021114017.26011-1-stefanha@redhat.com>
 <CAONzpcYQZ2zL4AvdXD6vbMCsfg72213S8wORSoPiAfQ9vCxxZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAONzpcYQZ2zL4AvdXD6vbMCsfg72213S8wORSoPiAfQ9vCxxZQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 11:30:31AM +0800, Yongji Xie wrote:
> On Mon, 21 Oct 2019 at 19:40, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > Host notifiers are used in several cases:
> > 1. Traditional ioeventfd where virtqueue notifications are handled in
> >    the main loop thread.
> > 2. IOThreads (aio_handle_output) where virtqueue notifications are
> >    handled in an IOThread AioContext.
> > 3. vhost where virtqueue notifications are handled by kernel vhost or
> >    a vhost-user device backend.
> >
> > Most virtqueue notifications from the guest use the ioeventfd mechanism=
,
> > but there are corner cases where QEMU code calls virtio_queue_notify().
> > This currently honors the host notifier for the IOThreads
> > aio_handle_output case, but not for the vhost case.  The result is that
> > vhost does not receive virtqueue notifications from QEMU when
> > virtio_queue_notify() is called.
> >
> > This patch extends virtio_queue_notify() to set the host notifier
> > whenever it is enabled instead of calling the vq->(aio_)handle_output()
> > function directly.
> >
> > This fixes the vhost case although it does add a trip through the
> > eventfd for the traditional ioeventfd case.  I don't think it's worth
> > adding a fast path for the traditional ioeventfd case because calling
> > virtio_queue_notify() is rare when ioeventfd is enabled.
> >
> > Reported-by: Felipe Franciosi <felipe@nutanix.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Felipe and Yongji: Only tested with "make check".  Please try
> > vhost-user-scsi/blk and let us know if it fixes the issue.
> >
>=20
> I can see the vhost-user-blk issue is fixed by this patch after the
> below patch applied:
>=20
> diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pc=
i.c
> index 1dc834a..a32a439 100644
> --- a/hw/virtio/vhost-user-blk-pci.c
> +++ b/hw/virtio/vhost-user-blk-pci.c
> @@ -46,6 +46,8 @@ static Property vhost_user_blk_pci_properties[] =3D {
>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>      DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
>                         DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> >  include/hw/virtio/virtio-bus.h | 7 +++++++
> >  hw/virtio/virtio.c             | 4 +++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-=
bus.h
> > index 38c9399cd4..28ca51cb4c 100644
> > --- a/include/hw/virtio/virtio-bus.h
> > +++ b/include/hw/virtio/virtio-bus.h
> > @@ -139,6 +139,13 @@ static inline VirtIODevice *virtio_bus_get_device(=
VirtioBusState *bus)
> >
> >  /* Return whether the proxy allows ioeventfd.  */
> >  bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus);
> > +
> > +/* Return whether ioeventfd has been started. */
> > +static inline bool virtio_bus_ioeventfd_started(VirtioBusState *bus)
> > +{
> > +    return bus->ioeventfd_started;
> > +}
> > +
> >  /* Start the ioeventfd. */
> >  int virtio_bus_start_ioeventfd(VirtioBusState *bus);
> >  /* Stop the ioeventfd. */
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 527df03bfd..abdcec00cd 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1567,6 +1567,8 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
> >
> >  void virtio_queue_notify(VirtIODevice *vdev, int n)
> >  {
> > +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> > +    VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
> >      VirtQueue *vq =3D &vdev->vq[n];
> >
> >      if (unlikely(!vq->vring.desc || vdev->broken)) {
> > @@ -1574,7 +1576,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int =
n)
> >      }
> >
> >      trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > -    if (vq->handle_aio_output) {
> > +    if (virtio_bus_ioeventfd_started(vbus)) {
>=20
> Need to check whether vq->host_notifier is valid or not here.
> Otherwise, it could break the ctrl_vq in vhost_net device.

Good points, thanks!  I will send v2 that works for all vhost-user
devices (including blk, scsi, and net).

Stefan

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BbI8ACgkQnKSrs4Gr
c8iPLAf+LB7EJBHgkDr6ixSs/vQCZ9jkNWv8sZRJMVp3CBPIiCm2KTOzyDi6GKqL
9+S6RQThzSxVdIUudLgN8Q7sa/+EWKfTJCThMNyKWvHgaxx+hGBwkV06pdI13Gio
rucgBgceWPHAQ9Y8xDsbu/dHJtwF1TaMNJScQxoxJAZBK58jt6m/U7WoNkfApaJG
QWJxJGRdnw/OQhZqZjRYVyNOU0B9DSV11O/A8R8m3srjpfCd47R4N1lomvL3bGZl
uazCAa20l/EpzE++0Ln5/7J/wrmGLy5nn/7MXrPBWv1VUtx4jjS/G4dZfO8o7VHz
XYubHlfZCNtF/GM5iQWMnxUmzn4v/w==
=6snv
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--


