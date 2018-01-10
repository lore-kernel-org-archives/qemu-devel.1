Received: from eggs.gnu.org ([2001:4830:134:3::10]:52429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ7kw-0005Ha-JH
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ7kt-0007YJ-DT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:12:50 -0500
Date: Wed, 10 Jan 2018 13:51:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180110025137.GP2131@umbus.fritz.box>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-2-sjitindarsingh@gmail.com>
	<1515499621.3287.17.camel@redhat.com>
	<1515543573.1993.10.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dJyWBSYfjLochwFK"
Content-Disposition: inline
In-Reply-To: <1515543573.1993.10.camel@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 1/3] hw/ppc/spapr_caps:
 Rework spapr_caps to use uint8 internal representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-ppc@nongnu.org, paulus@ozlabs.org, qemu-devel@nongnu.org


--dJyWBSYfjLochwFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 11:19:33AM +1100, Suraj Jitindar Singh wrote:
> On Tue, 2018-01-09 at 13:07 +0100, Andrea Bolognani wrote:
> > On Tue, 2018-01-09 at 20:21 +1100, Suraj Jitindar Singh wrote:
> > [...]
> > > +static void cap_htm_allow(sPAPRMachineState *spapr, uint8_t val,
> > > Error **errp)
> > > +{
> > > +    if (!val) {
> > > +        /* TODO: We don't support disabling htm yet */
> > > +        return;
> > > +    }
> > >      if (tcg_enabled()) {
> > >          error_setg(errp,
> > > -                   "No Transactional Memory support in TCG, try
> > > cap-htm=3Doff");
> > > +                   "No Transactional Memory support in TCG, try
> > > cap-htm=3D0");
> > >      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
> > >          error_setg(errp,
> > > -"KVM implementation does not support Transactional Memory, try
> > > cap-htm=3Doff"
> > > +"KVM implementation does not support Transactional Memory, try
> > > cap-htm=3D0"
> > >              );
> > >      }
> > >  }
> >=20
> > Changing the command-line interface from off/on to 0/1 seems
> > unnecessary, given that broken/workaround/fixed are used for the
> > capabilities you introduce later in the series. off/on look much
> > better IMHO.
>=20
> These are booleans so they have to be "on"/"off" anyway... 0/1 doesn't
> work. My bad :/ I'll fix the message.
>=20
> >=20
> > [...]
> > > -static bool spapr_caps_needed(void *opaque)
> > > -{
> > > -    sPAPRMachineState *spapr =3D opaque;
> > > -
> > > -    return (spapr->forced_caps.mask !=3D 0) || (spapr-
> > > >forbidden_caps.mask !=3D 0);
> > > -}
> > > -
> > >  /* This has to be called from the top-level spapr post_load, not
> > > the
> > >   * caps specific one.  Otherwise it wouldn't be called when the
> > > source
> > >   * caps are all defaults, which could still conflict with
> > > overridden
> > >   * caps on the destination */
> > >  int spapr_caps_post_migration(sPAPRMachineState *spapr)
> > >  {
> > > -    uint64_t allcaps =3D 0;
> > >      int i;
> > >      bool ok =3D true;
> > >      sPAPRCapabilities dstcaps =3D spapr->effective_caps;
> > >      sPAPRCapabilities srccaps;
> > > =20
> > >      srccaps =3D default_caps_with_cpu(spapr, first_cpu);
> > > -    srccaps.mask |=3D spapr->mig_forced_caps.mask;
> > > -    srccaps.mask &=3D ~spapr->mig_forbidden_caps.mask;
> > > +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > +        if (spapr->mig_caps.caps[i] & SPAPR_CAP_CMD_LINE) {
> > > +            srccaps.caps[i] =3D spapr->mig_caps.caps[i] &
> > > ~SPAPR_CAP_CMD_LINE;
> > > +        }
> > > +    }
> > > =20
> > > -    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> > > +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > >          sPAPRCapabilityInfo *info =3D &capability_table[i];
> > > =20
> > > -        allcaps |=3D info->flag;
> > > -
> > > -        if ((srccaps.mask & info->flag) && !(dstcaps.mask & info-
> > > >flag)) {
> > > -            error_report("cap-%s=3Don in incoming stream, but off in
> > > destination",
> > > -                         info->name);
> > > +        if (srccaps.caps[i] > dstcaps.caps[i]) {
> > > +            error_report("cap-%s higher level (%d) in incoming
> > > stream than on destination (%d)",
> > > +                         info->name, srccaps.caps[i],
> > > dstcaps.caps[i]);
> > >              ok =3D false;
> > >          }
> > > =20
> > > -        if (!(srccaps.mask & info->flag) && (dstcaps.mask & info-
> > > >flag)) {
> > > -            warn_report("cap-%s=3Doff in incoming stream, but on in
> > > destination",
> > > -                         info->name);
> > > +        if (srccaps.caps[i] < dstcaps.caps[i]) {
> > > +            warn_report("cap-%s lower level (%d) in incoming
> > > stream than on destination (%d)",
> > > +                         info->name, srccaps.caps[i],
> > > dstcaps.caps[i]);
> > >          }
> > >      }
> >=20
> > These numeric comparisons make me feel very uneasy :)
> >=20
> > What if we need to add more possible values down the line? Should
> > there be at least some room between existing values to avoid painting
> > ourselves in a corner? Eg. instead of using 0/1/2 use 20/40/60...
> >=20
> > You clearly know more about the problem than I do, so feel free to
> > dismiss all of the above... I thought I would bring up my worries
> > just in case :)
>=20
> For these capabilities I think we're ok to keep it as 0/1/2. In the
> event we need a bigger range another capability can be added with other
> possible values which was the whole point of introducing this generic
> framework. The basic idea is the receiving side must always support a
> higher "level" than the source.
>=20
> With these new capabilities it's more likely we'll have to add an
> entirly new one than require more possible values. :)
>=20
> It could even be possible to have a per capability comparison function
> to confirm compatibility in future. But again thats an exercise for
> when/if more complex capabilities are added.

I concur.  New capabilities which require a more detailed set of
values are reasonably likely.  New values for existing capabilities
are not - to make sense of the capabilities you really need to
understand the set of all possible values when they're defined.  So I
think 0..2 is ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dJyWBSYfjLochwFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpVf7YACgkQbDjKyiDZ
s5KnXxAAkXW2lNhdCnHvrqt/lgl7+O6Myw4dQhnt8PffgevGXvesCfF1NKGJibks
NdxNAHynYdIgh4iiz632m17Cz/L7to434mUX3YSs/wgkFLeEXupdEqXhGf1DsTdJ
sGnWojyGlB6P1g3LjwIpFa2MEFojfhPTXcfC3MzYzi191mL+t+kbGwdwW4XsHXTZ
WgGfAlUejQ+RtaTaUC/YP1emEYn8jvIylaU3E94sW5UZjbS+QeBF5jXBxq48FkpQ
8crXeYVgzBmGabWmJEiijnUxgxlsBRO/ytgcVHIERSUerfhh5y7NqqbtPXRjNbLH
btG39Am16GyjL/PMDiRbk08bk41vd0zDw9Sm55I2TI8srMw+BJqA95Cu/JbFbCpR
bBlZixP1GGRuhsZhKo95C3kARaM+WdJoL2B5hiI+QiXC6y8nkCb3WK0gFX5BYCb4
aZTkjFi2TwPwhYJP7FCA9AvA+iQ3qKaTSjERB5AC5759ftCFjyz9fwOl4PD0Korq
jgb6rUo3bTVZDvFz0tSXn0JT/imd1LclGODmU8+jVjMcX8yQW/AmBq7oa3Zzuiom
egVRMRVoYyE1areBgqz6qpojVHm9T/tJeKQNgclfWqPAavoQwSYAGxBkJc3kLRDU
k9Q42zbr3SW299E/OziBtUuMCsGRpLqPfsDXDO49phHO1HJCxt0=
=W3qM
-----END PGP SIGNATURE-----

--dJyWBSYfjLochwFK--
