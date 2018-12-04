Received: from eggs.gnu.org ([2001:4830:134:3::10]:38066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU0pm-0005dQ-6u
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU0pe-0002fk-LJ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:53:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gU0pc-0002Zp-IX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:53:05 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<20181203100608.28538-5-jasowang@redhat.com>
	<ebf8ecc1-fd57-d929-41aa-464dedce589c@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d5c78d38-1e54-5858-add3-cecddd2943c8@redhat.com>
Date: Tue, 4 Dec 2018 10:52:54 +0800
MIME-Version: 1.0
In-Reply-To: <ebf8ecc1-fd57-d929-41aa-464dedce589c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 4/4] virtio-net-test: add large
 tx buffer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com


On 2018/12/4 =E4=B8=8A=E5=8D=8812:46, Eric Blake wrote:
> On 12/3/18 4:06 AM, Jason Wang wrote:
>> This test tries to build a packet whose size is greater than INT_MAX
>> which tries to trigger integer overflow in qemu_net_queue_append_iov()
>> which may result OOB.
>
> Can you also add a packet just slightly larger than NET_BUFSIZE (68k)=20
> to show that we aren't having any further issues at even smaller (and=20
> more likely) values of oversized packets?


Ok.


>
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> =C2=A0 tests/virtio-net-test.c | 44 ++++++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 1 file changed, 44 insertions(+)
>>
>
>> +++ b/tests/virtio-net-test.c
>> @@ -245,6 +245,49 @@ static void pci_basic(gconstpointer data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_shutdown(qs);
>> =C2=A0 }
>> +
>> +static void large_tx(gconstpointer data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 QVirtioPCIDevice *dev;
>> +=C2=A0=C2=A0=C2=A0 QOSState *qs;
>> +=C2=A0=C2=A0=C2=A0 QVirtQueuePCI *tx, *rx;
>> +=C2=A0=C2=A0=C2=A0 QVirtQueue *vq;
>> +=C2=A0=C2=A0=C2=A0 uint64_t req_addr;
>> +=C2=A0=C2=A0=C2=A0 uint32_t free_head;
>> +=C2=A0=C2=A0=C2=A0 size_t alloc_size =3D UINT_MAX / 64;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 qs =3D pci_test_start("-netdev hubport,id=3Dhp0,hu=
bid=3D0 "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-d=
evice virtio-net-pci,netdev=3Dhp0 ");
>
> Why the trailing space?


I guess this is a cut and paste error.


>
>> +=C2=A0=C2=A0=C2=A0 dev =3D virtio_net_pci_init(qs->pcibus, PCI_SLOT);
>> +
>> +=C2=A0=C2=A0=C2=A0 rx =3D (QVirtQueuePCI *)qvirtqueue_setup(&dev->vde=
v, qs->alloc, 0);
>> +=C2=A0=C2=A0=C2=A0 tx =3D (QVirtQueuePCI *)qvirtqueue_setup(&dev->vde=
v, qs->alloc, 1);
>> +
>> +=C2=A0=C2=A0=C2=A0 driver_init(&dev->vdev);
>> +=C2=A0=C2=A0=C2=A0 vq =3D &tx->vq;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Bypass the limitation by pointing several descr=
iptors to a=20
>> single
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * smaller area */
>> +=C2=A0=C2=A0=C2=A0 req_addr =3D guest_alloc(qs->alloc, alloc_size);
>> +=C2=A0=C2=A0=C2=A0 free_head =3D qvirtqueue_add(vq, req_addr, alloc_s=
ize, false, true);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 64; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qvirtqueue_add(vq, req_add=
r, alloc_size, false, i =3D=3D 63 ?
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false : t=
rue);
>
> Any time I see both 'true' and 'false' in a ?: operator, I have to=20
> wonder why you didn't just write the simpler version directly on the=20
> condition.=C2=A0 This is the same as=C2=A0 'i !=3D 63'.
>

Ok.


>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 qvirtqueue_kick(&dev->vdev, vq, free_head);
>> +
>> +=C2=A0=C2=A0=C2=A0 qvirtio_wait_used_elem(&dev->vdev, vq, free_head, =
NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 QVIRTIO_NET_TIMEOUT_US);
>> +
>> +=C2=A0=C2=A0=C2=A0 qvirtqueue_cleanup(dev->vdev.bus, &tx->vq, qs->all=
oc);
>> +=C2=A0=C2=A0=C2=A0 qvirtqueue_cleanup(dev->vdev.bus, &rx->vq, qs->all=
oc);
>> +=C2=A0=C2=A0=C2=A0 qvirtio_pci_device_disable(dev);
>> +=C2=A0=C2=A0=C2=A0 g_free(dev->pdev);
>> +=C2=A0=C2=A0=C2=A0 g_free(dev);
>> +=C2=A0=C2=A0=C2=A0 qtest_shutdown(qs);
>> +}
>> =C2=A0 #endif
>> =C2=A0 =C2=A0 static void hotplug(void)
>> @@ -270,6 +313,7 @@ int main(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_add_data_func("/virtio/net/pci/ba=
sic", send_recv_test,=20
>> pci_basic);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_add_data_func("/virtio/net/pci/rx=
_stop_cont",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 stop_cont_test, pci_basic);
>> +=C2=A0=C2=A0=C2=A0 qtest_add_data_func("/virtio/net/pci/large_tx", NU=
LL, large_tx);
>> =C2=A0 #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_add_func("/virtio/net/pci/hotplug=
", hotplug);
>
> I can reproduce Peter's complaints of this introducing noise to 'make=20
> check':
> qemu-system-x86_64: warning: hub 0 is not connected to host network


Yes, this is intended since the test does not require any host network.=20
I will add a patch to suppress this warning if qtest is enabled.


>
> With patches 2-4 applied but patch 1 omitted, 'make check' fails with:
>
> Broken pipe
> tests/libqtest.c:125: kill_qemu() detected QEMU death from signal 11=20
> (Segmentation fault) (core dumped)
> GTester: last random seed: R02S9569aabcb2d834a9dadcce272c5588db
>
> so the test is definitely triggering the problem as patched by part 1.=20
> Although I'm not confident enough of what the test is doing for an=20
> R-b, and would like it to be less noisy, I can at least add:
>
> Tested-by: Eric Blake <eblake@redhat.com>
>

Thanks
