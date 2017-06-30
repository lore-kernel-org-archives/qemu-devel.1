Received: from eggs.gnu.org ([2001:4830:134:3::10]:34565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dQyhb-0007iL-Cz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dQyhY-00072H-4J
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dQyhX-00071H-U2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BE827D0DD
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 16:23:22 +0000 (UTC)
Date: Fri, 30 Jun 2017 12:23:17 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1186247051.45558056.1498839797752.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170630160422.14842-3-maxime.coquelin@redhat.com>
References: <20170630160422.14842-1-maxime.coquelin@redhat.com>
	<20170630160422.14842-3-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user: unregister slave req
 handler at cleanup time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, mst@redhat.com



----- Original Message -----
> If the backend sends a request just before closing the socket,
> the aio dispatcher might schedule its reading after the vhost
> device has been cleaned, leading to a NULL pointer dereference
> in slave_read();
>=20
> vhost_user_cleanup() already closes the socket but it is not
> enough, the handler has to be unregistered.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/vhost-user.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 958ee09..2203011 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -779,6 +779,7 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
> =20
>      u =3D dev->opaque;
>      if (u->slave_fd >=3D 0) {
> +        qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
>          close(u->slave_fd);
>          u->slave_fd =3D -1;
>      }
> --
> 2.9.4
>=20
>=20
