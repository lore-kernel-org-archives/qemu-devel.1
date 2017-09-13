Received: from eggs.gnu.org ([2001:4830:134:3::10]:57148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds25f-0005c8-P4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds25e-0001QN-Bu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:28:07 -0400
Date: Wed, 13 Sep 2017 17:03:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913070338.GH7550@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
	<cc212d72-1eff-86ae-1e34-fdc1636015e5@ilande.co.uk>
	<20170911171953.GE2150@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Content-Disposition: inline
In-Reply-To: <20170911171953.GE2150@work-vm>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, lvivier@redhat.com, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 06:19:54PM +0100, Dr. David Alan Gilbert wrote:
> * Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> > On 11/09/17 11:48, David Gibson wrote:
> >=20
> > > On Mon, Sep 11, 2017 at 10:30:33AM +0100, Dr. David Alan Gilbert wrot=
e:
> > >> * Greg Kurz (groug@kaod.org) wrote:
> > >>> On Sun, 10 Sep 2017 15:37:33 +0100
> > >>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> > >>>
> > >>>> Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescr=
iption"
> > >>>> appears to drop the internal CPU IRQ state from the migration stre=
am. Whilst
> > >>>> testing migration on g3beige/mac99 machines, test images would ran=
domly fail to
> > >>>> resume unless a key was pressed on the VGA console.
> > >>>>
> > >>>> Further investigation suggests that internal CPU IRQ state isn't b=
eing
> > >>>> preserved and so interrupts asserted at the time of migration are =
lost. Adding
> > >>>> the pending_interrupts and irq_input_state fields back into the mi=
gration
> > >>>> stream appears to fix the problem here during local tests.
> > >>>>
> > >>>> As part of this commit we bump the vmstate_ppc version from 5 to 6=
 to handle
> > >>>> the additional fields.
> > >>>>
> > >>>
> > >>> And so this unconditionally breaks backward migration... what about=
 adding
> > >>> a subsection for this ?
> > >>
> > >> and wiring it to a flag on the machine type so that older machine ty=
pes
> > >> don't send it.
> > >=20
> > > Right, a subsection is certainly necessary to avoid breaking backwards
> > > migration.
> >=20
> > The suggestion of using the VMSTATE_*_V macros with an increased version
> > number came from Alexey's original review of the patch many months ago
> > which is why I did it that way.
> >=20
> > Out of curiosity though, what is the criteria for supporting backwards
> > migration? Obviously forward migration is supported as-is in this
> > manner, so what determines if a patch needs to be backwards compatible
> > and how far?
>=20
> It's a bit fuzzy.  Downstream we do backwards migration between various
> versions - and those versions are pretty arbitrarily chosen.
> Generally I prefer if we don't break that upstream either, although
> it isn't tested much.

Right.  In this case not breaking backwards migration upstream is
essentially a favour to downstream, since unbreaking it downstream
once its broken upstream is a real PITA.

> If it was in code that was specific to your g3beige I wouldn't mind;
> but for ppc in general then if it breaks the server migration it'll
> be a pain we'd have to then fix.  Best to keep it working upstream.

Right.

> But it's fairly easy to put new fields in a subsection and tie it
> to a property;  that makes it easy to switch it on/off in machine
> types.

In this case I'm not sure we even need a property - I think we could
migrate it only when it's non-zero.  That shold only break it in cases
where actually it would already break.

> > > But apart from that I want to understand better exactly why this is
> > > necessary.  What's the state that's being lost, and is it really not
> > > recoverable from anywhere else.
> >=20
> > The test case I have is installing Darwin PPC 6.02 with qemu-system-ppc
> > TCG and repeatedly pausing, executing "savevm foo", then quitting and
> > continuing with "-loadvm foo" during the installation phase. About 1 in
> > 10 times the installer hangs after the loadvm until I press a key, at
> > which point it carries on as normal.
> >=20
> > I then proceeded to going backwards through the git history until I
> > found out that it was the removal of the pending_interrupts,
> > irq_input_state and access_type fields during the conversion to
> > VMStateDescription commit a90db15 which seemed to cause the problem.
> >=20
> > > The other thing that concerns me is how we're encoding the
> > > information.  These are essentially internal fields, not reflecting
> > > something with an architected encoding - adding those to the migration
> > > stream is often a bad idea - it inhibits our ability to rework
> > > internal encodings.
> >=20
> > I'm not sure how this should be managed, however there was a similar
> > issue with excp_prefix (which was also removed in a90db15) that was
> > fixed in 2360b6e by calling a helper in cpu_post_load(). I can't easily
> > see how could work with env.pending_interrupts and env.irq_input_state
> > though.
>=20
> Without knowing anything about this hardware... generally the migration
> stream should reflect the real state of the system rather than internal
> implementation detail, that way if you change the implementation you
> don't need to fudge the state.  Having said that, there's generally
> some internal state that's perhaps not immediately obvious from specs
> until you try and implement it.

Right.  I'm not really sure how to handle this yet.  The CPU irq
numbers are pretty much arbitrarily assigned, I don't think much
thought has gone into them.  And if its going to become part of the
migration ABI, some thought needs to be put into it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm42EcACgkQbDjKyiDZ
s5JWSRAAoVFZiMLWJ4vY+/q0khJ8x4EGGWQfqtuBLBEY8exbtW+WjpwlrnSl+dla
W9Sk7tmCzTBjxIxeyno+5SdnmgE2MQyBOk0+p/9q6Z2f/LVNmAcEX95DkIzxSNVG
J/9Zy8GvWB3599O7yLn/T7QbKB8fKCTI3dZfbMk4ZC7quRh+Y0bjCXwgIoz6F1ES
mMsfzj/0QWn69zzYR6Yj2UatYpJ6qBv4hBk37gxFbPo9FR8jhN4bjB/Um4+tDZvc
Zp3XRqx8W80yIlLQfMyIPsKAzAMrZ6V7Y2+aBi3zsq3pA7pjALJC9J6GVA7KQgo8
ZPpYczMqWGhKEF9Qh3re+3oV2Per+9VevV8aEtAvBI/7d4wk3GAFlI0lyd8gW9rk
fiG62aXjehUHSMoQPud6Eb4yYuudk/+UaD4enWNJjc8I/b2C07IuvlXDoGJuv462
5nyVJtUPvhgkWk3Zuh7zezcU0FbgK/NJnQzA3NxsIH7ByE7t3R0CJoRt5NiBD8bK
xpV4+xYlbvY8fABWtP33bp1ybuih2ryIznbqQ4nmt+b5sKyM+XB0t1nZxbu6HDF9
wUJvFU5Rz46tOkjSfdndQ+axXf15yTbFzbyhpEQPTx0eYxBcFMHKjc/y2K4oHuww
AXGlMyGrEdZE1pRmNCjEYs6R/6MFGoJh/rv8bv7arkjqwA+PELA=
=NW7t
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
