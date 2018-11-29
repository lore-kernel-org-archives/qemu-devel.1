Received: from eggs.gnu.org ([2001:4830:134:3::10]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSFhe-0003VX-99
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSFhZ-00021q-70
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:21:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSFhY-00020d-SW
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:21:29 -0500
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-5-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e192ba34-dfe0-6e10-540a-a90ee146c1f9@redhat.com>
Date: Thu, 29 Nov 2018 07:21:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181129031230.31082-5-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 4/4] virtio-net-test: add large tx
 buffer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

On 2018-11-29 04:12, Jason Wang wrote:
> This test tries to build a packet whose size is greater than INT_MAX
> which tries to trigger integer overflow in qemu_net_queue_append_iov()
> which may result OOB.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/virtio-net-test.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 33d26ab079..09c220c2fa 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -245,6 +245,51 @@ static void pci_basic(gconstpointer data)
>      g_free(dev);
>      qtest_shutdown(qs);
>  }
> +
> +static void large_tx(gconstpointer data)
> +{
> +    QVirtioPCIDevice *dev;
> +    QOSState *qs;
> +    QVirtQueuePCI *tx, *rx;
> +    QVirtQueue *vq;
> +    const char *cmd = "-netdev hubport,id=hp0,hubid=0 "
> +                      "-device virtio-net-pci,netdev=hp0 ";
> +    uint64_t req_addr;
> +    uint32_t free_head;
> +    size_t alloc_size = UINT_MAX / 64;
> +    int i;
> +
> +    qs = pci_test_start(cmd);
> +    dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
> +
> +    rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
> +    tx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 1);
> +
> +    driver_init(&dev->vdev);
> +    vq = &tx->vq;
> +
> +    /* Bypass the limitation by pointing several descriptors to a single
> +     * smaller area */
> +    req_addr = guest_alloc(qs->alloc, alloc_size);
> +    for (i = 0; i < 64; i ++) {
> +        if (i == 0)
> +            free_head = qvirtqueue_add(vq, req_addr, alloc_size, false, true);
> +        else
> +            qvirtqueue_add(vq, req_addr, alloc_size, false, true);

QEMU coding style requires always curly braces. Maybe move the initial
case before the for-loop and then start the for loop with i=1 instead?

> +    }
> +    qvirtqueue_add(vq, req_addr, alloc_size, false, false);
> +    qvirtqueue_kick(&dev->vdev, vq, free_head);
> +
> +    qvirtio_wait_used_elem(&dev->vdev, vq, free_head, NULL,
> +                           QVIRTIO_NET_TIMEOUT_US);
> +
> +    qvirtqueue_cleanup(dev->vdev.bus, &tx->vq, qs->alloc);
> +    qvirtqueue_cleanup(dev->vdev.bus, &rx->vq, qs->alloc);
> +    qvirtio_pci_device_disable(dev);
> +    g_free(dev->pdev);
> +    g_free(dev);
> +    qtest_shutdown(qs);
> +}
>  #endif
>  
>  static void hotplug(void)
> @@ -270,6 +315,7 @@ int main(int argc, char **argv)
>      qtest_add_data_func("/virtio/net/pci/basic", send_recv_test, pci_basic);
>      qtest_add_data_func("/virtio/net/pci/rx_stop_cont",
>                          stop_cont_test, pci_basic);
> +    qtest_add_data_func("/virtio/net/pci/large_tx", NULL, large_tx);
>  #endif
>      qtest_add_func("/virtio/net/pci/hotplug", hotplug);
 Thomas
