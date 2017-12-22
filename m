Received: from eggs.gnu.org ([2001:4830:134:3::10]:50811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNk5-0002jc-SE
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNk4-000727-Tw
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:52:05 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNk4-00071B-N2
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:52:04 -0500
Received: by mail-wr0-x244.google.com with SMTP id a41so27949905wra.6
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:52:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221212125.19075-6-maxime.coquelin@redhat.com>
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
	<20171221212125.19075-6-maxime.coquelin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 14:52:02 +0100
Message-ID: <CAJ+F1C+ZupZ2ibELkrCZM6QhQjkAK_6q=GmnoRXKcg5jQp5o1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] vhost-user-test: use
 init_virtio_dev in multiqueue test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Dec 21, 2017 at 10:21 PM, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
> Now that init_virtio_dev() has been generalized to all cases,
> use it in test_multiqueue() to avoid code duplication.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/vhost-user-test.c | 65 ++++++-------------------------------------=
------
>  1 file changed, 8 insertions(+), 57 deletions(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 6a144e8d7e..ec6ac9dc9e 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -892,79 +892,30 @@ static void test_flags_mismatch(void)
>
>  #endif
>
> -static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
> -{
> -    QVirtioPCIDevice *dev;
> -
> -    dev =3D qvirtio_pci_device_find(bus, VIRTIO_ID_NET);
> -    g_assert(dev !=3D NULL);
> -    g_assert_cmphex(dev->vdev.device_type, =3D=3D, VIRTIO_ID_NET);
> -
> -    qvirtio_pci_device_enable(dev);
> -    qvirtio_reset(&dev->vdev);
> -    qvirtio_set_acknowledge(&dev->vdev);
> -    qvirtio_set_driver(&dev->vdev);
> -
> -    return dev;
> -}
> -
> -static void driver_init(QVirtioDevice *dev)
> -{
> -    uint32_t features;
> -
> -    features =3D qvirtio_get_features(dev);
> -    features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
> -                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
> -                            (1u << VIRTIO_RING_F_EVENT_IDX));
> -    qvirtio_set_features(dev, features);
> -
> -    qvirtio_set_driver_ok(dev);
> -}
> -
> -#define PCI_SLOT                0x04
> -
>  static void test_multiqueue(void)
>  {
> -    const int queues =3D 2;
>      TestServer *s =3D test_server_new("mq");
> -    QVirtioPCIDevice *dev;
> -    QPCIBus *bus;
> -    QVirtQueuePCI *vq[queues * 2];
> -    QGuestAllocator *alloc;
>      char *cmd;
> -    int i;
> -
> -    s->queues =3D queues;
> +    uint32_t features_mask =3D ~(QVIRTIO_F_BAD_FEATURE |
> +                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
> +                            (1u << VIRTIO_RING_F_EVENT_IDX));
> +    s->queues =3D 2;
>      test_server_listen(s);
>
>      cmd =3D g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",=
queues=3D%d "
>                            "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,=
vectors=3D%d",
>                            512, 512, root, s->chr_name,
>                            s->socket_path, "", s->chr_name,
> -                          queues, queues * 2 + 2);
> +                          s->queues, s->queues * 2 + 2);
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    bus =3D qpci_init_pc(NULL);
> -    dev =3D virtio_net_pci_init(bus, PCI_SLOT);
> +    init_virtio_dev(s, features_mask);
>
> -    alloc =3D pc_alloc_init();
> -    for (i =3D 0; i < queues * 2; i++) {
> -        vq[i] =3D (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, alloc, i=
);
> -    }
> +    wait_for_rings_started(s, s->queues * 2);
>
> -    driver_init(&dev->vdev);
> -    wait_for_rings_started(s, queues * 2);
> +    uninit_virtio_dev(s);
>
> -    /* End test */
> -    for (i =3D 0; i < queues * 2; i++) {
> -        qvirtqueue_cleanup(dev->vdev.bus, &vq[i]->vq, alloc);
> -    }
> -    pc_alloc_uninit(alloc);
> -    qvirtio_pci_device_disable(dev);
> -    g_free(dev->pdev);
> -    g_free(dev);
> -    qpci_free_pc(bus);
>      qtest_end();
>
>      test_server_free(s);
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
