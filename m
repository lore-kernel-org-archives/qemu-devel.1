Received: from eggs.gnu.org ([2001:4830:134:3::10]:50963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faMf6-0005Au-DO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faMf5-0008WG-D6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:52:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1faMf5-0008TC-7F
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:52:11 -0400
Date: Tue, 3 Jul 2018 16:52:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180703165200.180c93bb.cohuck@redhat.com>
In-Reply-To: <20180703142817.GA3088@vbusired-vm>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, 3 Jul 2018 09:28:17 -0500
Venu Busireddy <venu.busireddy@oracle.com> wrote:

> On 2018-07-03 12:58:25 +0300, Roman Kagan wrote:
> > On Mon, Jul 02, 2018 at 02:14:52PM -0700, si-wei liu wrote: =20
> > > On 7/2/2018 9:14 AM, Roman Kagan wrote: =20
> > > > Is the scheme going to be applied/extended to other transports (vmb=
us,
> > > > virtio-ccw, etc.)? =20
> > > Well, it depends on the use case, and how feasible it can be extended=
 to
> > > other transport due to constraints and transport specifics.
> > >  =20
> > > > Is the failover group concept going to be used beyond PT-PV network
> > > > device failover? =20
> > > Although the concept of failover group is generic, the implementation=
 itself
> > > may vary. =20
> >=20
> > My point with these two questions is that since this patchset is
> > defining external interfaces -- with guest OS, with management layer --=
 =20
>=20
> This patch set is not defining any external interfaces. All this is doing
> is provide the means and locations to store the "group identifier". How
> that info will be used, I thought, should be another patch set.
>=20
> Venu
>=20
> > which are not easy to change later, it might make sense to try and see
> > if the interfaces map to other usecases.  E.g. I think we can get enough
> > information on how Hyper-V handles PT-PV network device failover from
> > the current Linux implementation; it may be a good idea to share some
> > concepts and workflows with virtio-pci.

But this patch set defines a host<->guest interface to make pairing
information on the host available to the guest, no?

=46rom my point of view, there are several concerns:
- This approach assumes a homogeneous pairing (same transport), and
  even more, it assumes that this transport is pci.
- It won't work for zPCI (although zPCI is really strange) -- this
  means it will be completely unusable on s390x.
- It is too focused on a narrow use case. How is it supposed to be
  extended?

What I would prefer:
- Implement a pairing id support that does not rely on a certain
  transport, but leverages virtio (which is in the game anyway). We'd
  get at least the "virtio-net device paired with vfio" use case, which
  is what is currently implemented in the Linux kernel.
- Think about a more generic way to relay configuration metadata to the
  host.
