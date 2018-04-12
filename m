Received: from eggs.gnu.org ([2001:4830:134:3::10]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6XKb-00087A-P0
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6XKa-0007PH-IS
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:11:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6XKa-0007Om-DX
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:11:44 -0400
Date: Thu, 12 Apr 2018 09:11:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180412081140.GA2704@work-vm>
References: <20180411172014.24711-1-clg@kaod.org>
	<20180411192136.GL2667@work-vm>
	<b7df24c5-311d-41b1-6304-a52ef8c28732@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b7df24c5-311d-41b1-6304-a52ef8c28732@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: jiangshanlai@gmail.com, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, alex.williamson@redhat.com, David Gibson <david@gibson.dropbear.id.au>

* C=E9dric Le Goater (clg@kaod.org) wrote:
> On 04/11/2018 09:21 PM, Dr. David Alan Gilbert wrote:
> > * C=E9dric Le Goater (clg@kaod.org) wrote:
> >> Here is some context for this strange change request.
> >>
> >> On the POWER9 processor, the XIVE interrupt controller can control
> >> interrupt sources using MMIO to trigger events, to EOI or to turn of=
f
> >> the sources. Priority management and interrupt acknowledgment is als=
o
> >> controlled by MMIO in the presenter subengine.
> >>
> >> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> >> device' memory mappings, similarly to VFIO, and the VMAs are populat=
ed
> >> dynamically with the appropriate pages using a fault handler.
> >>
> >> But, these regions are an issue for migration. We need to discard th=
e
> >> associated RAMBlocks from the RAM state on the source VM and let the
> >> destination VM rebuild the memory mappings on the new host in the
> >> post_load() operation just before resuming the system.
> >>
> >> This is the goal of the following proposal. Does it make sense ? It
> >> seems to be working enough to migrate a running guest but there migh=
t
> >> be a better, more subtle, approach.
> >=20
> > If this is always true of RAM devices (which I suspect it is).
> >
> > Interestingly, your patch comes less than 2 weeks after Lai Jiangshan=
's
> >  'add capability to bypass the shared memory'
> >    https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg07511.=
html
>=20
> I missed that.
>=20
> > which is the only other case I think we've got of someone trying to
> > avoid transmitting a block.
> >=20
> > We should try and merge the two sets to make them consistent; you've
> > covered some more cases (the other patch wasn't expected to work with
> > Postcopy anyway).
> > (At this rate then we can expect another 20 for the year....)
> >=20
> > We should probably have:
> >    1) A     bool is_migratable_block(RAMBlock *)
> >    2) A RAMBLOCK_FOREACH_MIGRATABLE(block)  macro that is like
> > RAMBLOCK_FOREACH but does the call to is_migratable_block
> >
> > then the changes should be mostly pretty tidy.
>=20
> yes, indeed, they do.
>=20
> > A sanity check is probably needed on load as well, to give a neat
> > error if for some reason the source transmits pages to you.
>=20
> OK.=20
>=20
> Would a check on the block migratability at the end of function=20
> ram_block_from_stream() be enough ? This is called in ram_load()
> and ram_load_postcopy()

Yes I think that's fine.  Maybe also add one in ram_load() in
the     case RAM_SAVE_FLAG_MEM_SIZE:      which happens right at the
start of the migration stream.

> > One other thing I notice is your code changes ram_bytes_total(),
> > where as the other patch avoids it;  I think your code is actually
> > more correct.
> >=20
> > Is there *any* case in existing QEMUs where we migrate ram devices
> > succesfully, if so we've got to make it backwards compatible; but I
> > think you're saying there isn't.
>=20
> The only RAM devices I know of are the VFIOs.

Great, so we should be OK.

Dave

> Thanks,
>=20
> C.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
