Received: from eggs.gnu.org ([2001:4830:134:3::10]:52931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dBl68-0002Zw-53
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dBl65-0007I0-1N
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:49:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dBl64-0007Hp-Nv
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:49:48 -0400
Date: Fri, 19 May 2017 19:49:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170519194544-mutt-send-email-mst@kernel.org>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Fri, May 19, 2017 at 11:10:33AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote:
> > On 05/17/2017 02:22 PM, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
> > > >=20
> > > >=20
> > > > On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
> > > > > > >=20
> > > > > >=20
> > > > > > Hi:
> > > > > >=20
> > > > > > Care to post the driver codes too?
> > > > > >=20
> > > > > OK. It may take some time to clean up the driver code before
> > > > > post it out. You can first
> > > > > have a check of the draft at the repo here:
> > > > > https://github.com/wei-w-wang/vhost-pci-driver
> > > > >=20
> > > > > Best,
> > > > > Wei
> > > >=20
> > > > Interesting, looks like there's one copy on tx side. We used to
> > > > have zerocopy support for tun for VM2VM traffic. Could you
> > > > please try to compare it with your vhost-pci-net by:
> > > >=20
> > We can analyze from the whole data path - from VM1's network stack to
> > send packets -> VM2's
> > network stack to receive packets. The number of copies are actually t=
he
> > same for both.
>=20
> That's why I'm asking you to compare the performance. The only reason f=
or
> vhost-pci is performance. You should prove it.
>=20
> >=20
> > vhost-pci: 1-copy happen in VM1's driver xmit(), which copes packets
> > from its network stack to VM2's
> > RX ring buffer. (we call it "zerocopy" because there is no intermedia=
te
> > copy between VMs)
> > zerocopy enabled vhost-net: 1-copy happen in tun's recvmsg, which cop=
ies
> > packets from VM1's TX ring
> > buffer to VM2's RX ring buffer.
>=20
> Actually, there's a major difference here. You do copy in guest which
> consumes time slice of vcpu thread on host. Vhost_net do this in its ow=
n
> thread. So I feel vhost_net is even faster here, maybe I was wrong.

Yes but only if you have enough CPUs. The point of vhost-pci
is to put the switch in a VM and scale better with # of VMs.

> >=20
> > That being said, we compared to vhost-user, instead of vhost_net,
> > because vhost-user is the one
> > that is used in NFV, which we think is a major use case for vhost-pci=
.
>=20
> If this is true, why not draft a pmd driver instead of a kernel one? An=
d do
> you use virtio-net kernel driver to compare the performance? If yes, ha=
s OVS
> dpdk optimized for kernel driver (I think not)?
>=20
> What's more important, if vhost-pci is faster, I think its kernel drive=
r
> should be also faster than virtio-net, no?

If you have a vhost CPU per VCPU and can give a host CPU to each using
that will be faster.  But not everyone has so many host CPUs.


> >=20
> >=20
> > > > - make sure zerocopy is enabled for vhost_net
> > > > - comment skb_orphan_frags() in tun_net_xmit()
> > > >=20
> > > > Thanks
> > > >=20
> > >=20
> > > You can even enable tx batching for tun by ethtool -C tap0 rx-frame=
s
> > > N. This will greatly improve the performance according to my test.
> > >=20
> >=20
> > Thanks, but would this hurt latency?
> >=20
> > Best,
> > Wei
>=20
> I don't see this in my test.
>=20
> Thanks
