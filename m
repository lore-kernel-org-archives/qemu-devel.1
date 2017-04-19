Received: from eggs.gnu.org ([2001:4830:134:3::10]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0jFt-0004Rh-Jk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0jFq-00009L-Gd
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:38:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:54829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d0jFq-00005y-56
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:38:18 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 19 Apr 2017 06:38:11 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

Hi,

We made some design changes to the original vhost-pci design, and want to o=
pen
a discussion about the latest design (labelled 2.0) and its extension (2.1)=
.
2.0 design: One VM shares the entire memory of another VM
2.1 design: One VM uses an intermediate memory shared with another VM for
                     packet transmission.

For the convenience of discussion, I have some pictures presented at this l=
ink:
https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rf=
c2.0.pdf

Fig. 1 shows the common driver frame that we want use to build the 2.0 and =
2.1
design. A TX/RX engine consists of a local ring and an exotic ring.
Local ring:
1) allocated by the driver itself;
2) registered with the device (i.e. virtio_add_queue())
Exotic ring:
1) ring memory comes from the outside (of the driver), and exposed to the d=
river
     via a BAR MMIO;
2) does not have a registration in the device, so no ioeventfd/irqfd, confi=
guration
registers allocated in the device

Fig. 2 shows how the driver frame is used to build the 2.0 design.
1) Asymmetric: vhost-pci-net <-> virtio-net
2) VM1 shares the entire memory of VM2, and the exotic rings are the rings
    from VM2.
3) Performance (in terms of copies between VMs):
    TX: 0-copy (packets are put to VM2's RX ring directly)
    RX: 1-copy (the green arrow line in the VM1's RX engine)

Fig. 3 shows how the driver frame is used to build the 2.1 design.
1) Symmetric: vhost-pci-net <-> vhost-pci-net
2) Share an intermediate memory, allocated by VM1's vhost-pci device,
for data exchange, and the exotic rings are built on the shared memory
3) Performance:
    TX: 1-copy
RX: 1-copy

Fig. 4 shows the inter-VM notification path for 2.0 (2.1 is similar).
The four eventfds are allocated by virtio-net, and shared with vhost-pci-ne=
t:
Uses virtio-net's TX/RX kickfd as the vhost-pci-net's RX/TX callfd
Uses virtio-net's TX/RX callfd as the vhost-pci-net's RX/TX kickfd
Example of how it works:
After packets are put into vhost-pci-net's TX, the driver kicks TX, which
causes the an interrupt associated with fd3 to be injected to virtio-net

The draft code of the 2.0 design is ready, and can be found here:
Qemu: https://github.com/wei-w-wang/vhost-pci-device
Guest driver: https://github.com/wei-w-wang/vhost-pci-driver

We tested the 2.0 implementation using the Spirent packet
generator to transmit 64B packets, the results show that the
throughput of vhost-pci reaches around 1.8Mpps, which is around
two times larger than the legacy OVS+DPDK. Also, vhost-pci shows
better scalability than OVS+DPDK.


Best,
Wei
