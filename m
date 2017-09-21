Received: from eggs.gnu.org ([2001:4830:134:3::10]:51487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1duqb5-00062S-67
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1duqb2-0005GG-3D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:48:11 -0400
References: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6f116856-b587-78fe-ca45-bf970441c422@redhat.com>
Date: Thu, 21 Sep 2017 09:47:46 +0800
MIME-Version: 1.0
In-Reply-To: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Felipe Franciosi <felipe@nutanix.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 2017=E5=B9=B409=E6=9C=8821=E6=97=A5 02:53, Felipe Franciosi wrote:
> vhost_log_put() is called to decomission the dirty log between qemu and
> a vhost device when stopping the device. Such a call can happen from
> migration_completion().
>
> Present code sets dev->log_size to zero too early in vhost_log_put(),
> causing the sync check to always return false. As a consequence, the
> last pass on the dirty bitmap never happens at the end of migration.
>
> If a vhost device was busy (writing to guest memory) until the last
> moments before vhost_virtqueue_stop(), this error will result in guest
> memory corruption (at least) following migrations.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>   hw/virtio/vhost.c |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 5fd69f0..ddc42f0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bo=
ol sync)
>       if (!log) {
>           return;
>       }
> -    dev->log =3D NULL;
> -    dev->log_size =3D 0;
>  =20
>       --log->refcnt;
>       if (log->refcnt =3D=3D 0) {
> @@ -396,6 +394,9 @@ static void vhost_log_put(struct vhost_dev *dev, bo=
ol sync)
>  =20
>           g_free(log);
>       }
> +
> +    dev->log =3D NULL;
> +    dev->log_size =3D 0;
>   }
>  =20
>   static bool vhost_dev_log_is_shared(struct vhost_dev *dev)

Cc: qemu-stable@nongnu.org

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks
