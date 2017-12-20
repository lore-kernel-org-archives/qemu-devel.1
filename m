Received: from eggs.gnu.org ([2001:4830:134:3::10]:45250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVgr-0002hd-9o
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVgn-0005Ra-9e
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:09:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRVgm-0005QO-WD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:09:05 -0500
Date: Wed, 20 Dec 2017 06:08:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220060700-mutt-send-email-mst@kernel.org>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-5-marcel@redhat.com>
	<CAAdtpL5XgR5wvJzfLHdtdR00fm9VPU50yycG-pdeL4i8-9Hsmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAdtpL5XgR5wvJzfLHdtdR00fm9VPU50yycG-pdeL4i8-9Hsmw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Yuval Shaia <yuval.shaia@oracle.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Dec 19, 2017 at 04:13:18PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Marcel, Yuval,
>=20
> On Sun, Dec 17, 2017 at 9:54 AM, Marcel Apfelbaum <marcel@redhat.com> w=
rote:
> > From: Yuval Shaia <yuval.shaia@oracle.com>
> >
> > PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA de=
vice.
> > It works with its Linux Kernel driver AS IS, no need for any special =
guest
> > modifications.
> >
> > While it complies with the VMware device, it can also communicate wit=
h bare
> > metal RDMA-enabled machines and does not require an RDMA HCA in the h=
ost, it
> > can work with Soft-RoCE (rxe).
> >
> > It does not require the whole guest RAM to be pinned allowing memory
> > over-commit and, even if not implemented yet, migration support will =
be
> > possible with some HW assistance.
> >
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> > ---
> [...]
> >  28 files changed, 5132 insertions(+), 4 deletions(-)
> >  create mode 100644 hw/net/pvrdma/pvrdma.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_backend.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_backend.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_backend_defs.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_cmd.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_defs.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_dev_api.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_ib_verbs.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_main.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_ring.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_rm.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_rm.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_rm_defs.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_types.h
> >  create mode 100644 hw/net/pvrdma/pvrdma_utils.c
> >  create mode 100644 hw/net/pvrdma/pvrdma_utils.h
> >  create mode 100644 hw/net/pvrdma/trace-events
> [...]
>=20
> Since we already have a hw/xenpv/ directory,

But e.g. xen nic is under hw/net/

> can we place these files
> into hw/vmwarepv/ rather than hw/net/pvrdma/?
>=20
> A smarter move might be to create a hw/pv/ dir and have hw/pv/{xen,vmwa=
re}.
>=20
> Regards,
>=20
> Phil.

That's not how we layout things. We group them by function not by
interface. Thus I think that hw/rdma/ is better.

--=20
MST
