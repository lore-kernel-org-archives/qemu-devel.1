Received: from eggs.gnu.org ([2001:4830:134:3::10]:36492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj3oj-0001Cz-Bd
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj3og-0002R8-2Y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:57:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cj3of-0002QT-S6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:57:14 -0500
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <331bf747-0c32-0f1a-eda0-40e6fa507494@redhat.com>
Date: Wed, 1 Mar 2017 13:57:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fallback from irqfd to
 non-irqfd notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 01/03/2017 12:50, Halil Pasic wrote:
> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is activ=
e"
> changed how notifications are done for virtio-blk substantially. Due to=
 a
> race condition interrupts are lost when irqfd is torn down after
> notify_guest_bh was scheduled but before it actually runs.

I don't think the non-irqfd notification mechanism is thread safe, and
that would be a problem for this patch.

What is the path that causes the irqfd to be torn down?  Only something
like a reset should cause it (the only call in virtio-blk is from
virtio_blk_data_plane_stop), and then the guest doesn't care anymore
about interrupts.

That path also does a qemu_bh_delete, so the notify_guest_bh should not
be invoked at all.

Paolo

>  Furthermore
> virtio_notify_irqfd ignores the value returned by event_notifier_set
> which correctly indicates that notification has failed due to bad file
> descriptor.
>=20
> Let's fix this by making virtio_notify_irqfd fall back to the non-irqfd
> notification mechanism if event_notifier_set fails.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>=20
> This is probably not the only way to fix this: suggestions welcome. I
> did not use a fixes tag because I'm not sure yet where exactly things g=
ot
> broken. Maybe guys more familiar with dataplane an coroutines can help
> (Paolo, Stefan).
> ---
>  hw/virtio/virtio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..8e1c1e9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1581,7 +1581,9 @@ void virtio_notify_irqfd(VirtIODevice *vdev, Virt=
Queue *vq)
>       * to an atomic operation.
>       */
>      virtio_set_isr(vq->vdev, 0x1);
> -    event_notifier_set(&vq->guest_notifier);
> +    if (event_notifier_set(&vq->guest_notifier)) {
> +        virtio_notify_vector(vdev, vq->vector);
> +    }
>  }
> =20
>  static void virtio_irq(VirtQueue *vq)
>=20
