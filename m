Received: from eggs.gnu.org ([2001:4830:134:3::10]:37309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsLG1-00014m-SW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 23:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsLFz-0000xz-9P
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 23:56:05 -0400
Date: Thu, 14 Sep 2017 13:52:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170914035259.GK3972@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170913071249.GI7550@umbus.fritz.box>
	<03027eb0-6528-22c6-dcc1-d20323399ec9@ilande.co.uk>
	<ccacf611-c2e2-9cad-d927-67c0fcaa3ad6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline
In-Reply-To: <ccacf611-c2e2-9cad-d927-67c0fcaa3ad6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: ensure we update the decrementer
 value during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 07:58:23PM +0200, Laurent Vivier wrote:
> On 13/09/2017 19:11, Mark Cave-Ayland wrote:
> > On 13/09/17 08:12, David Gibson wrote:
> >=20
> >> This is subtly incorrect.  It sets the DECR on load to exactly the
> >> value that was saved.  That effectively means that the DECR is frozen
> >> for the migration downtime, which probably isn't what we want.
> >>
> >> Instead we need to save the DECR as an offset from the timebase, and
> >> restore it relative to the (downtime adjusted) timebase on the
> >> destination.
> >>
> >> The complication with that is that the timebase is generally migrated
> >> at the machine level, not the cpu level: the timebase is generally
> >> synchronized between cpus in the machine, and migrating it at the
> >> individual cpu could break that.  Which means we probably need a
> >> machine level hook to handle the decrementer too, even though it
> >> logically *is* per-cpu, because otherwise we'll be trying to restore
> >> it before the timebase is restored.
> >=20
> > I know that we discussed this in-depth last year, however I was working
> > along the lines that Laurent's patch fixed this along the lines of our
> > previous discussion:
> > https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00338.html (and
> > indeed Laurent's analysis at
> > https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01489.html).
> >=20
> > However looking again at the this patch in the context you mentioned
> > above, I'm starting to wonder if the right solution now is for the
> > machine init function for g3beige/mac99 to do the same as spapr, e.g.
> > add cpu_ppc_clock_vm_state_change() as a vm_change_state_handler and
> > then add VMSTATE_PPC_TIMEBASE_V from the machine PPCTimeBase into my new
> > subsection?
> >=20
> > Laurent, do you think that your state change handler would work
> > correctly in this way?
>=20
> I think all is explained in the second link you have mentioned, it seems=
=20
> we don't need a state handler as KVM DECR will no be updated by the migra=
ted value:
>=20
> hw/ppc/ppc.c
>=20
>     736 static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>     737                                  QEMUTimer *timer,
>     738                                  void (*raise_excp)(void *),
>     739                                  void (*lower_excp)(PowerPCCPU *),
>     740                                  uint32_t decr, uint32_t value)
>     741 {
> ...
>     749     if (kvm_enabled()) {
>     750         /* KVM handles decrementer exceptions, we don't need our =
own timer */
>     751         return;
>     752     }
> ...
>=20
> But this allows to migrate it for TCG. And it should be correct because i=
n case of TCG I think [need to check] timebase is stopped too (so offset is=
 0)
>=20
> David, do you agree with that?

Yes, I think so.  Some details might be different, but the basic idea
of migrating the timebase and decrementers at machine level should be
the same for pseries and g3beige/whatever.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm5/RsACgkQbDjKyiDZ
s5ILsw//Sq88F3OmO2i+ITXyfmLeVDBcf24f8+dGNdCq1dxstpXaS3weyjxnHsrX
5F8XobFxYJe5ICtTzBehMdu7skskz9U778MeniUVIEy7/6FOkykKV5UfhpqcUF2A
CNKz/WcgQsQhZ/2U3nyN8zWanhpU+vJHfFO9Ux2iyiyjGt+nAZIGhMYZyCrNRb6j
lKslcx86nMMJYLfOaWaNMG7su3NmVzDA7lWiSY4mCQuZNU5EeQnRDH/paO3ticZB
zlLIJLom2BU5mbYfBS80kSb0hKj2sc9sIglRnE7+nUtFFbm+DcJZsI+OULTHHvHZ
vR/sdNvcN9CulbAq7RsgVq+lNW/mtdOVyXFwzRHOEca7lml16dGLQb5MT4Nq7We5
B7JS1mwoUrodZmOqi1mIBSiT+KokPruzOcZphAjMDtGUWlVqTxrwqAQn8exSiuza
ovt20BJqUvPuDOjG78WSkGKsEZMWPc6D9rkm1x+GZg87KkExomOSTq/jLGmFBRgX
HuK3nVd+DegnRZCLnR0Vh+FGeelAM1Au4or6MweeT2t3tq0kfopRpTl4EtZPesqF
tKMj4ndlDxcx7TBksfnloL/Q71odydtT3ZSLdYe3IGaDc+W8RKc1Cov7f2XF0a/N
JX5zbQ/X06j/lb+lnDbtZyELuaR6HmPiySRuaolX38g7FgBfjxE=
=KB2q
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--
