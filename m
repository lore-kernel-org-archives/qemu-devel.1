Received: from eggs.gnu.org ([2001:4830:134:3::10]:54402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYa2h-00035m-Cz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYa2g-0003fP-1V
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:12:55 -0500
Date: Mon, 8 Jan 2018 14:12:31 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180108161231.GF6646@localhost.localdomain>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104192203.GD3407@localhost.localdomain>
	<20180108135122.637e478a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180108135122.637e478a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] qom: introduce TypeInfo name
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jan 08, 2018 at 01:51:22PM +0100, Igor Mammedov wrote:
> On Thu, 4 Jan 2018 17:22:03 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Thu, Jan 04, 2018 at 11:40:40AM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Hi,
> > >=20
> > > This RFC series is intended to simplify Flattened Device Tree suppo=
rt,
> > > in particular the 'compatible' FDT entry, when Linux names mismatch=
es
> > > QEMU ones, but this is the same device modelled.
> > >=20
> > > Eventually this might help to remove the QDevAlias qdev_alias_table=
[]
> > > in qdev-monitor.c.
> > >  =20
> >=20
> > Didn't look closely at the patches yet, but this sounds like a
> > nice generic way to replace other alias systems.  We have at
> > least:
> Though it seems easy and trivial, I'm a bit concerned about using
> QOM types for the task though.
> Also see commit 6acbe4c6f which labels aliases as a bad idea
> and says that they are there only for compatibility and shouldn't
> be used.

It's true that they are there only for compatibility.  But I
don't think commit 6acbe4c6f label aliases in general as a bad
idea.  It just removes a very limited mechanism and make it
specific to the only place where it was needed.  Now we have at
least 5 different places where we do the same thing, so now it
might be worth it.

But:

> So far I agree with that statement, because it introduces
> ambiguity in code used internally and more worrying is that
> this ambiguity will increase user visible ABI (think of '-device_add FO=
O_ALIAS')
> that we would need to maintain afterwards.

This is a reasonable worry.  If aliases exist only for
compatibility, they should be restricted to the places where
compatibility is really needed.

For example: aliases that affect -cpu shouldn't necessarily
affect -device.


> It would be nice to have unified alias API, but I think it should
> be separate one and limited to the same scope (i.e. compat stuff),
> and even that won't be easy as different alias impl. we have now
> have a different needs.

Starting with a separate API would be a good way to understand
what are our real needs, before deciding if we really want
aliases that affect all object_new() calls.

>=20
> wrt this series targeted usage, I'd prefer that object_new/initialize
> would use real type names when creating devices as it does currently
>=20
> FDT linux guest specific names wouldn't seep into device model
> itself. Firmware (FDT or ACPI) should be separate from device
> implementation.

I agree.  The QOM names and FDT names have different expectations
and assumptions (the commas added to some type names in this
series are one example).  Having the QOM type and FDT name match
on most cases is nice, but this shouldn't be a requirement.

I don't think we should rename user-visible QOM types and change
the command-line interface (and require additional compatibility
cruft) just to make it more convenient for internal FDT code.


>=20
> If really there is need to dynamically scan present devices
> and build FDT from result, then probably we should introduce
> interface that devices could implement if necessary.
> (I was thinking about such possibility for ACPI). But so far
> it looked to me as too much overhead for what we do now.
>=20
>=20
> > * qdev-monitor.c: qdev_alias_table[] (as mentioned above)
> > * chardev/char.c: chardev_alias_table[]
> > * target/alpha/cpu.c: alpha_cpu_aliases[]
> > * target/ppc/cpu-models.c: ppc_cpu_aliases[]
> > * include/hw/boards.h: MachineClass::alias
> >=20
> > Probably there are others I couldn't find.
> >=20
> >=20
> > > So far this is only a 'proof of concept'.
> > > To see how the qtests perform, I only modified 3 devices, 2 used by=
 the
> > > Xilinx Zynq machines (Cadence), and the e1000 (used by the PXE test=
).
> > >=20
> > > Regards,
> > >=20
> > > Phil.
> > >=20
> > > Philippe Mathieu-Daud=E9 (6):
> > >   qom: introduce TypeInfo name aliases
> > >   hw/net/e1000: real device name is 'e1000-82540em', 'e1000' is an =
alias
> > >   hw/char/cadence_uart: add FDT aliases
> > >   arm/xlnx-zynq: use FDT names for the Cadence UART
> > >   hw/net/cadence_gem: add FDT names as alias
> > >   hw/arm/xlnx-zynq: use FDT names for the Cadence GEM
> > >=20
> > >  include/qom/object.h   |  3 +++
> > >  hw/arm/xilinx_zynq.c   |  2 ++
> > >  hw/arm/xlnx-zynqmp.c   |  4 ++--
> > >  hw/char/cadence_uart.c |  7 +++++++
> > >  hw/net/cadence_gem.c   |  6 ++++++
> > >  hw/net/e1000.c         |  5 ++++-
> > >  qom/object.c           | 18 ++++++++++++++++--
> > >  7 files changed, 40 insertions(+), 5 deletions(-)
> > >=20
> > > --=20
> > > 2.15.1
> > >  =20
> >=20
>=20

--=20
Eduardo
