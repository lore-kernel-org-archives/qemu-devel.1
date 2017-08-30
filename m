Received: from eggs.gnu.org ([2001:4830:134:3::10]:48079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmsTp-0005fN-6r
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 22:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmsTo-0006Tp-0z
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 22:11:45 -0400
Date: Wed, 30 Aug 2017 12:07:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170830020722.GB3386@umbus.fritz.box>
References: <20170825211119.474-1-danielhb@linux.vnet.ibm.com>
	<20170829072310.GJ2578@umbus.fritz.box>
	<df49df06-caaf-81f5-7c24-f4324654a262@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <df49df06-caaf-81f5-7c24-f4324654a262@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.11 v2] hw/ppc: CAS reset
 on early device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 05:54:28PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 08/29/2017 04:23 AM, David Gibson wrote:
> > On Fri, Aug 25, 2017 at 06:11:18PM -0300, Daniel Henrique Barboza wrote:
> > > v2:
> > > - rebased with ppc-for-2.11
> > > - function 'spapr_cas_completed' dropped
> > > - function 'spapr_drc_needed' made public and it's now used inside
> > >    'spapr_hotplugged_dev_before_cas'
> > > - 'spapr_drc_needed' was changed to support the migration of logical
> > >    DRCs with devs attached in UNUSED state
> > > - new function: 'spapr_clear_pending_events'. This function is used
> > >    inside ppc_spapr_reset to reset the pending_events QTAILQ
> > Thanks for the followup, unfortunately there is still an important bug
> > left, see comments on the patch itself.
> >=20
> > At a higher level, though, looking at the event reset code made me
> > think of a possible even simpler solution to this problem.
> >=20
> > The queue of events (both hotplug and epow) is already in a simple
> > internal form that's independent of the two delivery mechanisms.  The
> > only difference is what event source triggers the interrupt.  This
> > explains why an extra hotplug event after the CAS "unstuck" the queue.
> >=20
> > AFAICT, a spurious interrupts here should be harmless - the kernel
> > will just check the queue and find nothing there.
> >=20
> > So, it should be sufficient to, after CAS, pulse the hotplug queue
> > interrupt if the hotplug queue is negotiated.
> >=20
> This is something I've tried in my first attempts at this problem, before
> sending the first patch in which I blocked hotplug before CAS. Back then,
> the problem was that the kernel panics with sig 11 (acess of bad area) wh=
en
> receiving the pulse after CAS.

Huh.

> I've investigated it a bit today and it seems that it still the case. Fir=
ing
> an IRQ right
> after CAS breaks the kernel. In fact, if you time a regular CPU hotplug
> right after
> CAS you'll get the same sig 11 kernel ooops. It looks like there is a time
> window after
> CAS that the kernel can't handle the hotplug process and pulsing the hotp=
lug
> queue in this window breaks the guest. I've tried some hacks such as puls=
ing
> the queue
> in the first 'event_scan' call made by the guest, but apparently it is st=
ill
> too early.
>=20
> I've sent an email to the linuxppc-dev mailing list talking about this
> behavior
> and asking if there is a reliable way to know when  we can safely pulse t=
he
> hotplug
> queue. Meanwhile, I'll keep working in the v3 respin of this patch in case
> this
> solution of pulsing the hotplug queue ends up being not feasible.

Right.  As Ben's reply says that definitely looks like a guest kernel
bug.  But, it's in enough kernels in the wild that we really need to
work around it anyway.  I think the reset-at-CAS approach is our best
bet to accomplish that at this stage.

Note that the clear-queue-at-reset preliminary cleanup will be
valuable even if we end up not needing the rest of the reset at CAS
stuff.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmmHdgACgkQbDjKyiDZ
s5JXyxAAoUgzVGz8KP5o4+Qm1wlL++V2vrL3/gr4e7TERSVK4DZlDHXNpHSoIZhY
/Hpq4Fh2AEID5s3/HdHdEPedSwtRiO/L64uY9mlZ0Kho0/ECiGW8As9KZ0e3n6XG
vP73CPOAc5aEr/oRgVSNpxl/GV/ycAYE00FLjPs3ATq8J8N0t7QUNwYmR1BFfP0y
mcgWHMIfLi5n9v+Izld1YTAysGMYiIG3+opQLR+G2bv/vpL1FJA2TuVaFBqKOmeq
3HoFwXsxCfV3x3BiYD2t8Lz726COMejulfPxk7akBbd0DT8qG2gtfKvKO+dLOE+d
A43bUDac9n6JIE5fWAEzondUnKL9rFGhzZBPG6Y30jwGtetx7mbDH7CHwr8Hjka8
5KczK4qSF+mvicYsv6jAHZuvwef/F70gE3nv0abujfN67ojLGRAApNxbbQnCJRAi
ry8uxmDmHGmtm3xv9sLjQmENJBrKNzDqbgd8vhyuQDlO5IhjTQekbdZqoekHJbpQ
zNIxuBgZpX5pVd3PejlDMnteBE8HeNAvdyX82ZFb0teyYrVAgDWhImIR9b5WqfRs
/sfjpPnkPklMqk3XsAvxXDAvNzi4osRAUGBknzvjBiFCAHr6tnNjDBHIX8DnYLUX
qssDdrtCpehRyjX5VGzBYPJn7AtuxouhNwVE08FjRctbC4Q6pNA=
=+ZmT
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
