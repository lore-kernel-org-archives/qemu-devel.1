Received: from eggs.gnu.org ([2001:4830:134:3::10]:37716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS2v8-0006EU-5i
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS2nO-0002gx-Ns
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:34:42 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 28 Nov 2018 16:29:34 +0000
Message-ID: <65af28818a724749839dcb6576e0413d@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
	<20181128161917.GE4222@dhcp-200-186.str.redhat.com>
	<48596f1fe100419c8b28ed54bda0117b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1811280827330.4577@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1811280827330.4577@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/18] xen: introduce new
 'XenBus' and 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: 'Kevin Wolf' <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Eduardo
	Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
	Henderson <rth@twiddle.net>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 28 November 2018 16:28
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: 'Kevin Wolf' <kwolf@redhat.com>; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano Stabellini
> <sstabellini@kernel.org>; Eduardo Habkost <ehabkost@redhat.com>; Michael
> S. Tsirkin <mst@redhat.com>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Anthony Perard <anthony.perard@citrix.com>;
> Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
> Subject: RE: [Qemu-block] [PATCH 02/18] xen: introduce new 'XenBus' and
> 'XenDevice' object hierarchy
>=20
> On Wed, 28 Nov 2018, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Sent: 28 November 2018 16:19
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> > > devel@lists.xenproject.org; Stefano Stabellini
> <sstabellini@kernel.org>;
> > > Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin
> > > <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
> Anthony
> > > Perard <anthony.perard@citrix.com>; Paolo Bonzini
> <pbonzini@redhat.com>;
> > > Richard Henderson <rth@twiddle.net>
> > > Subject: Re: [Qemu-block] [PATCH 02/18] xen: introduce new 'XenBus'
> and
> > > 'XenDevice' object hierarchy
> > >
> > > Am 21.11.2018 um 16:11 hat Paul Durrant geschrieben:
> > > > This patch adds the basic boilerplate for a 'XenBus' object that
> will
> > > act
> > > > as a parent to 'XenDevice' PV backends.
> > > > A new 'XenBridge' object is also added to connect XenBus to the
> system
> > > bus.
> > > >
> > > > The XenBus object is instantiated by a new xen_bus_init() function
> > > called
> > > > from the same sites as the legacy xen_be_init() function.
> > > >
> > > > Subsequent patches will flesh-out the functionality of these
> objects.
> > > >
> > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > >
> > > > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > > > new file mode 100644
> > > > index 0000000000..dede2d914a
> > > > --- /dev/null
> > > > +++ b/hw/xen/xen-bus.c
> > > > @@ -0,0 +1,125 @@
> > > > +/*
> > > > + * Copyright (c) Citrix Systems Inc.
> > > > + * All rights reserved.
> > > > + */
> > >
> > > This doesn't look very compatible with the GPL. In fact it might even
> > > make it illegal for the QEMU project to distribute this code. :-)
> > >
> > > Other files you add throughout the series seem to have the same
> problem.
> > >
> >
> > I was working on the assumption that a lack of explicit license meant
> that the overall project license as described in item 2 in LICENSE. Did I
> misinterpret that text?
>=20
> It's "All rights reserved." the problem

Oh, I see. I'm happy to remove that.

  Paul
