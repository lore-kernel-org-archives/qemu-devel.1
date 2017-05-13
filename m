Received: from eggs.gnu.org ([2001:4830:134:3::10]:55035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d9SRa-000867-Fi
	for qemu-devel@nongnu.org; Sat, 13 May 2017 04:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d9SRY-00010D-Ux
	for qemu-devel@nongnu.org; Sat, 13 May 2017 04:30:30 -0400
Date: Sat, 13 May 2017 17:59:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170513075916.GB13183@umbus.fritz.box>
References: <201705030257.v432vMO2008047@linux03a.ddci.com>
	<20170512065204.GJ12908@umbus.fritz.box>
	<OFFF668533.5CB81117-ON8625811E.004C96EA-8625811E.0050117D@ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <OFFF668533.5CB81117-ON8625811E.004C96EA-8625811E.0050117D@ddci.com>
Subject: Re: [Qemu-devel] [PATCH v2] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 09:34:33AM -0500, alarson@ddci.com wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote on 05/12/2017 01:52:04=
=20
> AM:
>=20
> > From: David Gibson <david@gibson.dropbear.id.au>
> > To: Aaron Larson <alarson@ddci.com>
> > Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> > Date: 05/12/2017 01:52 AM
> > Subject: Re: [PATCH v2] target-ppc: Enable open-pic timers to count and=
=20
> generate interrupts
> >=20
> > On Tue, May 02, 2017 at 07:57:22PM -0700, Aaron Larson wrote:
> > >=20
> > > Previous QEMU open-pic implemented the 4 open-pic timers including all
> > > timer registers, but the timers did not "count" or generate any
> > > interrupts.  The patch makes the timers both count and generate
> > > interrupts.  The timer clock frequency is fixed at 100MHZ.
> > >=20
> > > Signed-off-by: Aaron Larson <alarson@ddci.com>
> >=20
> > Looks sound in concept AFAICT not knowing the openpic hardware.
>=20
> Thanks again for your review.  I will provide an updated patch to
> address all of the comments, but I need a bit more guidance on some.
>=20
> > > ---
> > >  hw/intc/openpic.c | 135=20
> ++++++++++++++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 117 insertions(+), 18 deletions(-)
> > >=20
>=20
> > > +/* If enabled is true, arranges for an interrupt to be raised val=20
> clocks into
> > > +   the future, if enabled is false cancels the timer. */
> > > +static void openpic_tmr_set_tmr(OpenPICTimer *tmr, uint32_t val, boo=
l=20
> enabled)
> > > +{
> > > +    /* If timer doesn't exist, create it. */
> > > +    if (tmr->qemu_timer =3D=3D NULL) {
> > > +        tmr->qemu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=20
> &qemu_timer_cb, tmr);
> > > +        DPRINTF("Created timer for n_IRQ %d\n", tmr->n_IRQ);
> >=20
> > Is there a reason to lazily create the timer, rather than always
> > creating it at init time and just activating it when the timer is set?
>=20
> I'm not familiar with the QEMU timer code so guidance is appreciated,
> but a quick check indicates there wouldn't be much overhead to do as
> you suggest.  I will change to that approach.

Ok.  I'm not an expert on the timers either, so I'll trust your
judgement.  In general I'd suggest simplicity unless there's an
observed performance problem, which would also suggest the early
initialization.

> > > +    }
> > > +    uint64_t ns =3D ticks_to_ns(val & ~TCCR_TOG);
> > > +    /* A count of zero causes a timer to be set to expire=20
> immediately.  This
> > > +       effectively stops the simulation so we don't honor that=20
> configuration.
> > > +       On real hardware, this would generate an interrupt on every=
=20
> clock cycle
> > > +       if the interrupt was unmasked. */
> >=20
> > Could you also jam up if the count is non-zero but a too-small value
> > to make forward progress?  ...
>=20
> The case I'm concerned about is where a transient value is programmed
> to the timer and the interrupt is masked.  In that case QEMU will fire
> the timer on (potentially) every other clock,

Erm.. TCG doesn't really have "clocks" as such, so I'm not entirely
sure what you mean here.

> which will slow the
> emulation down until a more sane value is programmed.  I could add
> code to inhibit the timer while the associated interrupt is masked,
> but that is messy, and this seems like an unlikely corner case.

I concur.

> Let me know how you'd like this handled.
>=20
> > >  static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t=20
> val,
> > > -                                unsigned len)
> > > +                              unsigned len)
> > >  {
> > >      OpenPICState *opp =3D opaque;
> > >      int idx;
> > >=20
> > > -    addr +=3D 0x10f0;
> > > -
> > >      DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64 "\n",
> > > -            __func__, addr, val);
> > > +            __func__, (addr + 0x10f0), val);
> > >      if (addr & 0xF) {
> > >          return;
> > >      }
> > >=20
> > > -    if (addr =3D=3D 0x10f0) {
> > > +    if (addr =3D=3D 0) {
> >=20
> > I don't really understand how this change fits in with the rest - it
> > appears to be changing existing unrelated behaviour.
>=20
> I debated on changing this.  I needed to make changes to both the
> timer read and write code, and the existing code was inconsistent on
> the treatment of the offset.  The open-pic has a standard memory map
> and the timer block starts at 0x10f0 from the BAR.  Of course the
> region in QEMU for the timer is setup such that the timer is at offset
> zero in the QEMU timer memory region.  The write code added the offset
> to match the hardware, the read code did not, and consequently the
> code I added for timer read and write needed to be gratuitously
> different because of that.  I chose to update the write to match the
> read.  I can undo the change, if you'd like, but it does make the
> resulting code harder to understand (IMHO).

So, making the read/write functions use consistent addressing sounds
like a good idea.  But I think it would be clearer to do this as a
preliminary patch, rather than folded in with adding the timers
implementation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFrzUAAoJEGw4ysog2bOSxU4P/jqEW596tEK+KhqEag2+3sLn
eOKgs9h4eJyzUvOQOrIZ5dSSC6EjPdK7l5q4Z7tWR9lWTcx+MKFRK2jT3aJQqJ0R
9t/GwwJWyen0XO15uBBgTFc7bd+EcOupO0XwelpRbUa0CBrWl+2jVjumdWx1ScIE
7AWQ9tsNeV69S6JResvhK/AFdWI90x/bsjpy5D9fEjh5Tp+yeyu0bsIhur5tCS68
cxbOU7Q8f51rw4rlWE2cidkRVwNludglykWIWvMCJHvO43TgU1FjEHnVBXFXACwM
uY0tg2C4kWr+S5x+tCw8AgLj44P32paWQLDh+4WoFEOqrECEMEn/TnoT43d5zqeK
zDe5Rnc3jLNb3ZqJfp+Uf+K4ZNI3iIQTOv3kQ4I65opNG4z7xlKqwyvlSC1vPRym
jsff9LQFIa3NjC+3q/IdLDel1xsKgmx6DLT2diAUnakSR5QsQINc0FapFSylvBD9
e75EV4oJvYGjmao0uEcbWnweYoqa4RWOwI1bUyi4UA56sOkKkX4ammPhQnHeppq4
Wc1zJrLwk5Jf7XrNyUFSjhfITAnGRx2fmrC0YA+KBZbSrwNkAX3XqSTxd+nBX0Sf
laOG1G4HEE9kAm4bkkgV4zlSOdVSlAaVShhWNze/raN148llK773mwVVrvJdyha3
Bsyi830jM6ZWSNXcsY9C
=VvAS
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
