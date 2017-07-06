Received: from eggs.gnu.org ([2001:4830:134:3::10]:33718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dT8ju-0000BA-Mt
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dT8jr-0002UQ-JU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:30:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:37821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dT8jr-0002Te-8g
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:30:43 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Thu, 6 Jul 2017 15:30:37 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7392745A8@shsmsx102.ccr.corp.intel.com>
References: <1498617479-5809-1-git-send-email-wei.w.wang@intel.com>
	<20170706164819-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170706164819-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Jan Scheurich <jan.scheurich@ericsson.com>

On Thursday, July 6, 2017 9:49 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 28, 2017 at 10:37:59AM +0800, Wei Wang wrote:
> > This patch enables the virtio-net tx queue size to be configurable
> > between 256 (the default queue size) and 1024 by the user when the
> > vhost-user backend is used.
> >
> > Currently, the maximum tx queue size for other backends is 512 due to
> > the following limitations:
> > - QEMU backend: the QEMU backend implementation in some cases may send
> > 1024+1 iovs to writev.
> > - Vhost_net backend: there are possibilities that the guest sends a
> > vring_desc of memory which crosses a MemoryRegion thereby generating
> > more than 1024 iovs after translation from guest-physical address in
> > the backend.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>=20
> Could you pls add a bit info about how this was tested?
> Was any special setup for dpdk necessary?

Yes, I used the vhost-user implementation in DPDK. So, on the host, I have=
=20
the legacy ovs-dpdk setup ready (I'm using dpdk-stable-16.11.1 and openvswi=
tch-2.6.1,
the setup steps can be found inside the source code directory).

When booting the guest, I have the following QEMU commands:
-chardev socket,id=3Dchar1,path=3D/usr/local/var/run/openvswitch/vhost-user=
-1
-netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar1,vhostforce
-device virtio-net-pci,mac=3D52:54:00:00:00:01,netdev=3Dmynet1,tx_queue_siz=
e=3D1024

To check the guest tx queue size, I simply added a printk() at the end of v=
irtnet_probe()
to print out vi->sq->vq->num_free, which initially equals to the queue size=
.

Then, I did Ping and netperf tests to transmit packets between VMs, which w=
orked fine.

If the related configuration support to Libvirt is ready, I think we can ge=
t the customer
to try in their test environment, too.

Best,
Wei
