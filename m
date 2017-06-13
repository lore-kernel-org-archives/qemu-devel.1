Received: from eggs.gnu.org ([2001:4830:134:3::10]:43128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKhgO-0008Oy-7j
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKhgG-0003kk-Ms
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:00:16 -0400
Date: Tue, 13 Jun 2017 10:00:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170613090002.GA2096@work-vm>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
	<20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
	<20170613080631.GB30171@umbus>
	<20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Juan Quintela <quintela@redhat.com>

* Greg Kurz (groug@kaod.org) wrote:
> On Tue, 13 Jun 2017 16:06:31 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 13, 2017 at 09:33:59AM +0200, Greg Kurz wrote:
> [...]
> > > > > > > +static void pre_2_10_vmstate_register_dummy_icp(sPAPRMachine=
State *spapr, int i)
> > > > > > > +{
> > > > > > > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > > > > > > +
> > > > > > > +    g_assert(!*flag);     =20
> > > > > >=20
> > > > > > Apart from this assert(), you never seem to test the values in =
the
> > > > > > pre_2_10_ignore_icp() array, so it seems a bit pointless.
> > > > > >    =20
> > > > >=20
> > > > > There's the opposite check in pre_2_10_vmstate_unregister_dummy_i=
cp().
> > > > > But I agree it isn't really useful... but more because of paranoi=
a :)   =20
> > > >=20
> > > > I'm all for paranoid assert()s if they can be made using data readi=
ly
> > > > to hand.  Adding a data structure just for the purpose of making an
> > > > assert() later, not so much.
> > > >  =20
> > >=20
> > > It is also passed as opaque argument to vmstate_register(), where it =
is
> > > used as a key when calling vmstate_unregister(). I could possibly pass
> > > (void *) i instead, but I'm not a big fan of hijacking pointer argume=
nts
> > > to pass numbers. =20
> >=20
> > Ah, I see your point.  Creating an array, purely to generate arbitrary
> > pointers is also kind of ugly, though.  Really the cpu_index / XICS
> > server number makes sense to identify the vmstate, but it looks like
> > vmstate_unregister() doesn't take that.
> >=20
>=20
> Indeed... what about adding a vmstate_unregister_by_instance_id() then ?
>=20
> Cc'ing Juan and David.

So what's the problem with a (void *)i ? It's simple, as long as you're
not actually using the opaque anywhere it's easy.

Note from a quick glance at your patch;  will this work migrating
=66rom this 2.10 -> 2.9 ?  Are your dummy vmstate's really good enough for
the 2.9 ?

Dave


> --
> Greg


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
