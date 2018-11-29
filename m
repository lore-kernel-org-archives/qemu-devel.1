Received: from eggs.gnu.org ([2001:4830:134:3::10]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gSLEV-00087F-Vx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gSLEQ-0004Je-7S
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:15:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gSLEP-0004Iv-VN
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:15:46 -0500
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-5-jasowang@redhat.com>
	<e192ba34-dfe0-6e10-540a-a90ee146c1f9@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa28e78e-e8ef-00ae-a284-c910ebb042fe@redhat.com>
Date: Thu, 29 Nov 2018 20:15:36 +0800
MIME-Version: 1.0
In-Reply-To: <e192ba34-dfe0-6e10-540a-a90ee146c1f9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com


On 2018/11/29 =E4=B8=8B=E5=8D=882:21, Thomas Huth wrote:
> On 2018-11-29 04:12, Jason Wang wrote:
>> This test tries to build a packet whose size is greater than INT_MAX
>> which tries to trigger integer overflow in qemu_net_queue_append_iov()
>> which may result OOB.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   tests/virtio-net-test.c | 46 +++++++++++++++++++++++++++++++++++++++=
++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
>> index 33d26ab079..09c220c2fa 100644
>> --- a/tests/virtio-net-test.c
>> +++ b/tests/virtio-net-test.c
>> @@ -245,6 +245,51 @@ static void pci_basic(gconstpointer data)
>>       g_free(dev);
>>       qtest_shutdown(qs);
>>   }
>> +
>> +static void large_tx(gconstpointer data)
>> +{
>> +    QVirtioPCIDevice *dev;
>> +    QOSState *qs;
>> +    QVirtQueuePCI *tx, *rx;
>> +    QVirtQueue *vq;
>> +    const char *cmd =3D "-netdev hubport,id=3Dhp0,hubid=3D0 "
>> +                      "-device virtio-net-pci,netdev=3Dhp0 ";
>> +    uint64_t req_addr;
>> +    uint32_t free_head;
>> +    size_t alloc_size =3D UINT_MAX / 64;
>> +    int i;
>> +
>> +    qs =3D pci_test_start(cmd);
>> +    dev =3D virtio_net_pci_init(qs->pcibus, PCI_SLOT);
>> +
>> +    rx =3D (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0=
);
>> +    tx =3D (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 1=
);
>> +
>> +    driver_init(&dev->vdev);
>> +    vq =3D &tx->vq;
>> +
>> +    /* Bypass the limitation by pointing several descriptors to a sin=
gle
>> +     * smaller area */
>> +    req_addr =3D guest_alloc(qs->alloc, alloc_size);
>> +    for (i =3D 0; i < 64; i ++) {
>> +        if (i =3D=3D 0)
>> +            free_head =3D qvirtqueue_add(vq, req_addr, alloc_size, fa=
lse, true);
>> +        else
>> +            qvirtqueue_add(vq, req_addr, alloc_size, false, true);
> QEMU coding style requires always curly braces. Maybe move the initial
> case before the for-loop and then start the for loop with i=3D1 instead=
?


Ok, fix and post V2.

Thanks


>
>> +    }
>> +    qvirtqueue_add(vq, req_addr, alloc_size, false, false);
>> +    qvirtqueue_kick(&dev->vdev, vq, free_head);
>> +
>> +    qvirtio_wait_used_elem(&dev->vdev, vq, free_head, NULL,
>> +                           QVIRTIO_NET_TIMEOUT_US);
>> +
>> +    qvirtqueue_cleanup(dev->vdev.bus, &tx->vq, qs->alloc);
>> +    qvirtqueue_cleanup(dev->vdev.bus, &rx->vq, qs->alloc);
>> +    qvirtio_pci_device_disable(dev);
>> +    g_free(dev->pdev);
>> +    g_free(dev);
>> +    qtest_shutdown(qs);
>> +}
>>   #endif
>>  =20
>>   static void hotplug(void)
>> @@ -270,6 +315,7 @@ int main(int argc, char **argv)
>>       qtest_add_data_func("/virtio/net/pci/basic", send_recv_test, pci=
_basic);
>>       qtest_add_data_func("/virtio/net/pci/rx_stop_cont",
>>                           stop_cont_test, pci_basic);
>> +    qtest_add_data_func("/virtio/net/pci/large_tx", NULL, large_tx);
>>   #endif
>>       qtest_add_func("/virtio/net/pci/hotplug", hotplug);
>   Thomas
