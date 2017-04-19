Received: from eggs.gnu.org ([2001:4830:134:3::10]:60906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d0k57-0005QT-Gw
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d0k55-0004zu-Rq
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:31:17 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:34763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d0k55-0004z7-Ed
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:31:15 -0400
Received: by mail-lf0-x22b.google.com with SMTP id t144so7644217lff.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 00:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Apr 2017 07:31:02 +0000
Message-ID: <CAJ+F1CL3P96gSVcZCCPatZGp7yUGeryEVSV4aX4rDXRjVBo0uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

Hi

On Wed, Apr 19, 2017 at 10:38 AM Wang, Wei W <wei.w.wang@intel.com> wrote:

> Hi,
>
> We made some design changes to the original vhost-pci design, and want to
> open
> a discussion about the latest design (labelled 2.0) and its extension
> (2.1).
> 2.0 design: One VM shares the entire memory of another VM
> 2.1 design: One VM uses an intermediate memory shared with another VM for
>                      packet transmission.
>
> For the convenience of discussion, I have some pictures presented at this
> link:
>
> *https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci=
-rfc2.0.pdf*
> <https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci=
-rfc2.0.pdf>
>
> Fig. 1 shows the common driver frame that we want use to build the 2.0 an=
d
> 2.1
> design. A TX/RX engine consists of a local ring and an exotic ring.
>

Isn't "external" (or "remote") more appropriate than "exotic" ?

Local ring:
> 1) allocated by the driver itself;
> 2) registered with the device (i.e. virtio_add_queue())
> Exotic ring:
> 1) ring memory comes from the outside (of the driver), and exposed to the
> driver
>      via a BAR MMIO;
> 2) does not have a registration in the device, so no ioeventfd/irqfd,
> configuration
> registers allocated in the device
>
> Fig. 2 shows how the driver frame is used to build the 2.0 design.
> 1) Asymmetric: vhost-pci-net <-> virtio-net
> 2) VM1 shares the entire memory of VM2, and the exotic rings are the ring=
s
>     from VM2.
> 3) Performance (in terms of copies between VMs):
>     TX: 0-copy (packets are put to VM2=E2=80=99s RX ring directly)
>     RX: 1-copy (the green arrow line in the VM1=E2=80=99s RX engine)
>

Why is the copy necessary?


> Fig. 3 shows how the driver frame is used to build the 2.1 design.
> 1) Symmetric: vhost-pci-net <-> vhost-pci-net
> 2) Share an intermediate memory, allocated by VM1=E2=80=99s vhost-pci dev=
ice,
> for data exchange, and the exotic rings are built on the shared memory
> 3) Performance:
>     TX: 1-copy
> RX: 1-copy
>
> Fig. 4 shows the inter-VM notification path for 2.0 (2.1 is similar).
> The four eventfds are allocated by virtio-net, and shared with
> vhost-pci-net:
> Uses virtio-net=E2=80=99s TX/RX kickfd as the vhost-pci-net=E2=80=99s RX/=
TX callfd
> Uses virtio-net=E2=80=99s TX/RX callfd as the vhost-pci-net=E2=80=99s RX/=
TX kickfd
> Example of how it works:
> After packets are put into vhost-pci-net=E2=80=99s TX, the driver kicks T=
X, which
> causes the an interrupt associated with fd3 to be injected to virtio-net
>
> The draft code of the 2.0 design is ready, and can be found here:
> Qemu: *https://github.com/wei-w-wang/vhost-pci-device*
> <https://github.com/wei-w-wang/vhost-pci-device>
>

The repository contains a single big commit (
https://github.com/wei-w-wang/vhost-pci-device/commit/fa01ec5e41de176197dae=
505c05b659f5483187f).
Please try to provide a seperate patch or series of patch from an upstream
commit/release point.


> Guest driver: *https://github.com/wei-w-wang/vhost-pci-driver*
> <https://github.com/wei-w-wang/vhost-pci-driver>
>
> We tested the 2.0 implementation using the Spirent packet
> generator to transmit 64B packets, the results show that the
> throughput of vhost-pci reaches around 1.8Mpps, which is around
> two times larger than the legacy OVS+DPDK. Also, vhost-pci shows
> better scalability than OVS+DPDK.
>
>
> Best,
> Wei
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
--=20
Marc-Andr=C3=A9 Lureau
