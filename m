Received: from eggs.gnu.org ([2001:4830:134:3::10]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1duyKr-0001C8-22
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1duyKn-00058l-Qx
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1duyKn-0004zx-Kt
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:03:53 -0400
Date: Thu, 21 Sep 2017 06:03:47 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <840800224.19387835.1505988227572.JavaMail.zimbra@redhat.com>
In-Reply-To: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
References: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio/vhost: reset dev->log after syncing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org



----- Original Message -----
> vhost_log_put() is called to decomission the dirty log between qemu and
> a vhost device when stopping the device. Such a call can happen from
> migration_completion().
>=20
> Present code sets dev->log_size to zero too early in vhost_log_put(),
> causing the sync check to always return false. As a consequence, the
> last pass on the dirty bitmap never happens at the end of migration.
>=20
> If a vhost device was busy (writing to guest memory) until the last
> moments before vhost_virtqueue_stop(), this error will result in guest
> memory corruption (at least) following migrations.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/virtio/vhost.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 5fd69f0..ddc42f0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bool
> sync)
>      if (!log) {
>          return;
>      }
> -    dev->log =3D NULL;
> -    dev->log_size =3D 0;
> =20
>      --log->refcnt;
>      if (log->refcnt =3D=3D 0) {
> @@ -396,6 +394,9 @@ static void vhost_log_put(struct vhost_dev *dev, bool
> sync)
> =20
>          g_free(log);
>      }
> +
> +    dev->log =3D NULL;
> +    dev->log_size =3D 0;
>  }
> =20
>  static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
> --
> 1.7.1
>=20
>=20
