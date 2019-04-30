Received: from eggs.gnu.org ([209.51.188.92]:34438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLRgh-00055z-Ak
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLRgg-000811-0x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:16:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hLRgf-00080U-MX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:16:41 -0400
Date: Tue, 30 Apr 2019 15:16:25 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190430121624.GA8708@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>
Cc: Cornelia Huck <cohuck@redhat.com>, mst@redhat.com, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, jgg@mellanox.com

On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> On 4/15/19 12:35 PM, Yuval Shaia wrote:
> > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > >=20
> > > > Data center backends use more and more RDMA or RoCE devices and m=
ore and
> > > > more software runs in virtualized environment.
> > > > There is a need for a standard to enable RDMA/RoCE on Virtual Mac=
hines.
> > > >=20
> > > > Virtio is the optimal solution since is the de-facto para-virtual=
izaton
> > > > technology and also because the Virtio specification
> > > > allows Hardware Vendors to support Virtio protocol natively in or=
der to
> > > > achieve bare metal performance.
> > > >=20
> > > > This RFC is an effort to addresses challenges in defining the RDM=
A/RoCE
> > > > Virtio Specification and a look forward on possible implementatio=
n
> > > > techniques.
> > > >=20
> > > > Open issues/Todo list:
> > > > List is huge, this is only start point of the project.
> > > > Anyway, here is one example of item in the list:
> > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This =
means that
> > > >    in order to support for example 32K QPs we will need 64K VirtQ=
. Not sure
> > > >    that this is reasonable so one option is to have one for all a=
nd
> > > >    multiplex the traffic on it. This is not good approach as by d=
esign it
> > > >    introducing an optional starvation. Another approach would be =
multi
> > > >    queues and round-robin (for example) between them.
> > > >=20
> Typically there will be a one-to-one mapping between QPs and CPUs (on t=
he
> guest). So while one would need to be prepared to support quite some QP=
s,
> the expectation is that the actual number of QPs used will be rather lo=
w.
> In a similar vein, multiplexing QPs would be defeating the purpose, as =
the
> overall idea was to have _independent_ QPs to enhance parallelism.

Since Jason already addresses the issue then i'll skip it.

>=20
> > > > Expectations from this posting:
> > > > In general, any comment is welcome, starting from hey, drop this =
as it is a
> > > > very bad idea, to yeah, go ahead, we really want it.
> > > > Idea here is that since it is not a minor effort i first want to =
know if
> > > > there is some sort interest in the community for such device.
> > >=20
> > > My first reaction is: Sounds sensible, but it would be good to have=
 a
> > > spec for this :)
> > >=20
> > > You'll need a spec if you want this to go forward anyway, so at lea=
st a
> > > sketch would be good to answer questions such as how many virtqueue=
s
> > > you use for which purpose, what is actually put on the virtqueues,
> > > whether there are negotiable features, and what the expectations fo=
r
> > > the device and the driver are. It also makes it easier to understan=
d
> > > how this is supposed to work in practice.
> > >=20
> > > If folks agree that this sounds useful, the next step would be to
> > > reserve an id for the device type.
> >=20
> > Thanks for the tips, will sure do that, it is that first i wanted to =
make
> > sure there is a use case here.
> >=20
> > Waiting for any feedback from the community.
> >=20
> I really do like the ides; in fact, it saved me from coding a similar t=
hing
> myself :-)

Isn't it the great thing with open source :-)

>=20
> However, I'm still curious about the overall intent of this driver. Whe=
re
> would the I/O be routed _to_ ?
> It's nice that we have a virtualized driver, but this driver is
> intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> And this I/O needs to be send to (and possibly received from)
> something.

Idea is to have a virtio-rdma device emulation (patch #2) on host that wi=
ll
relay the traffic to the real HW on host.

It will be good to have design that will allow Virtio-HW to be plugged to
the host and use the same driver. In this case the emulated device would
not be needed - the driver will "attach" to the Virtqueue exposed by the
virtio-HW instead of the emulated RDMA device.

I don't know of any public virtio-rdma HW.

>=20
> So what exactly is this something?
> An existing piece of HW on the host?
> If so, wouldn't it be more efficient to use vfio, either by using SR-IO=
V or
> by using virtio-mdev?

vfio needs to be implemented by every HW vendor where this approach is a
generic one that is not depended on the HW.

SV-IOV has it's limitations.

And with virtio-mdev, sorry but do not know, can you elaborate more?

>=20
> Another guest?

No

> If so, how would we route the I/O from one guest to the other?
> Shared memory? Implementing a full-blown RDMA switch in qemu?
>=20
> Oh, and I would _love_ to have a discussion about this at KVM Forum.
> Maybe I'll manage to whip up guest-to-guest RDMA connection using ivshm=
em
> ... let's see.

Well, I've posted a proposal for a talk, lets see if it'll be accepted.

>=20
> Cheers,
>=20
> Hannes
> --=20
> Dr. Hannes Reinecke            Teamlead Storage & Networking
> hare@suse.de                              +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
> GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=FCrnberg)
