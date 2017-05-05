Received: from eggs.gnu.org ([2001:4830:134:3::10]:34737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZOL-0007he-6m
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZOH-00033w-8Q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d6ZOG-00033d-VY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:19:09 -0400
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<5ec930ef-82e1-85ee-71bd-2d3f1b554a68@redhat.com>
	<590C1948.6010301@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3f76f518-c157-822e-17c6-17d81f6ac62a@redhat.com>
Date: Fri, 5 May 2017 17:18:54 +0800
MIME-Version: 1.0
In-Reply-To: <590C1948.6010301@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>



On 2017=E5=B9=B405=E6=9C=8805=E6=97=A5 14:18, Wei Wang wrote:
> On 05/05/2017 12:05 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B404=E6=9C=8819=E6=97=A5 14:38, Wang, Wei W wrote:
>>> Hi,
>>> We made some design changes to the original vhost-pci design, and=20
>>> want to open
>>> a discussion about the latest design (labelled 2.0) and its=20
>>> extension (2.1).
>>> 2.0 design: One VM shares the entire memory of another VM
>>> 2.1 design: One VM uses an intermediate memory shared with another=20
>>> VM for
>>>                      packet transmission.
>>> For the convenience of discussion, I have some pictures presented at=20
>>> this link:
>>> _https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost=
-pci-rfc2.0.pdf_=20
>>>
>>
>> Hi, is there any doc or pointer that describes the the design in=20
>> detail? E.g patch 4 in v1=20
>> https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05163.html.
>>
>> Thanks
>
> That link is kind of obsolete.
>
> We currently only have high level introduction of the design:
>
> For the device part design, please check slide 12:
> http://www.linux-kvm.org/images/5/55/02x07A-Wei_Wang-Design_of-Vhost-pc=
i.pdf=20
>
> The vhost-pci protocol is changed to be an extension of vhost-user=20
> protocol.
>
> For the driver part design, please check Fig. 2:
>
> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pc=
i-rfc2.0.pdf=20
>

Thanks for the pointers. It would be nice to have a doc like patch 4 in=20
v1, this could ease reviewers, otherwise we may guess and ask for them.

>
>
>>> Fig. 1 shows the common driver frame that we want use to build the=20
>>> 2.0 and 2.1
>>> design. A TX/RX engine consists of a local ring and an exotic ring.
>>> Local ring:
>>> 1) allocated by the driver itself;
>>> 2) registered with the device (i.e. virtio_add_queue())
>>> Exotic ring:
>>> 1) ring memory comes from the outside (of the driver), and exposed=20
>>> to the driver
>>>      via a BAR MMIO;
>>> 2) does not have a registration in the device, so no=20
>>> ioeventfd/irqfd, configuration
>>> registers allocated in the device
>>> Fig. 2 shows how the driver frame is used to build the 2.0 design.
>>> 1) Asymmetric: vhost-pci-net <-> virtio-net
>>> 2) VM1 shares the entire memory of VM2, and the exotic rings are the=20
>>> rings
>>>     from VM2.
>>> 3) Performance (in terms of copies between VMs):
>>>     TX: 0-copy (packets are put to VM2=E2=80=99s RX ring directly)
>>>     RX: 1-copy (the green arrow line in the VM1=E2=80=99s RX engine)
>>> Fig. 3 shows how the driver frame is used to build the 2.1 design.
>>> 1) Symmetric: vhost-pci-net <-> vhost-pci-net
>>> 2) Share an intermediate memory, allocated by VM1=E2=80=99s vhost-pci=
 device,
>>> for data exchange, and the exotic rings are built on the shared memor=
y
>>> 3) Performance:
>>>     TX: 1-copy
>>> RX: 1-copy
>>> Fig. 4 shows the inter-VM notification path for 2.0 (2.1 is similar).
>>> The four eventfds are allocated by virtio-net, and shared with=20
>>> vhost-pci-net:
>>> Uses virtio-net=E2=80=99s TX/RX kickfd as the vhost-pci-net=E2=80=99s=
 RX/TX callfd
>>> Uses virtio-net=E2=80=99s TX/RX callfd as the vhost-pci-net=E2=80=99s=
 RX/TX kickfd
>>> Example of how it works:
>>> After packets are put into vhost-pci-net=E2=80=99s TX, the driver kic=
ks TX,=20
>>> which
>>> causes the an interrupt associated with fd3 to be injected to=20
>>> virtio-net
>>> The draft code of the 2.0 design is ready, and can be found here:
>>> Qemu: _https://github.com/wei-w-wang/vhost-pci-device_
>>> Guest driver: _https://github.com/wei-w-wang/vhost-pci-driver_
>>> We tested the 2.0 implementation using the Spirent packet
>>> generator to transmit 64B packets, the results show that the
>>> throughput of vhost-pci reaches around 1.8Mpps, which is around
>>> two times larger than the legacy OVS+DPDK.
>>
>> Does this mean OVS+DPDK can only have ~0.9Mpps? A little bit surprise=20
>> that the number looks rather low (I can get similar result if I use=20
>> kernel bridge).
>>
>
> Yes, that's what we got on our machine (E5-2699 @2.2G). Do you have=20
> numbers of OVS+DPDK?
>
> Best,
> Wei
>
>

I don't, I only have kernel data path numbers now. Just curious about=20
the numbers.

Thanks
