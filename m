Received: from eggs.gnu.org ([2001:4830:134:3::10]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWD23-0007Br-6K
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWD22-0002WU-3r
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:42:11 -0400
Date: Sat, 15 Jul 2017 12:42:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170715024202.GH17539@umbus.fritz.box>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
	<CAFEAcA8kQF3xS6=uQiXf6FSbP56xmStPN9SoqWy1cmzMFFUpOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8kQF3xS6=uQiXf6FSbP56xmStPN9SoqWy1cmzMFFUpOQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sbobroff@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 04:13:05PM +0100, Peter Maydell wrote:
> On 14 July 2017 at 07:15, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> > The following changes since commit 49bcce4b9c11759678fd223aefb48691c495=
9d4f:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-1=
2' into staging (2017-07-13 16:56:06 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170714
> >
> > for you to fetch changes up to e11134d2ac7744569d7c387102368c507d340c30:
> >
> >   pseries: Allow HPT resizing with KVM (2017-07-14 09:28:30 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2017-07-14
> >
> > Two major batches in this set, rather than the usual collection of
> > assorted fixes.
> >
> >     * More DRC cleanup.  This gets the state management into a state
> >       which should fix many of the hotplug+migration problems we've
> >       had.  Plus it gets the migration stream format into something
> >       well defined and pretty minimal which we can reasonably support
> >       into the future.
> >
> >     * Hashed Page Table resizing.  It's been a while since this was
> >       posted, but it's been through several previous rounds of review.
> >       The kernel parts (both guest and host) are merged in 4.11, so
> >       this is the only remaining piece left to allow resizing of the
> >       HPT in a running guest.
> >
> > There are also a handful of unrelated fixes.
>=20
> Hi. I'm afraid this fails to build on the w32 compiler:
>   CC      ppc64-softmmu/hw/ppc/spapr.o
> /home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c: In function
> =E2=80=98spapr_get_resize_hpt=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c:2642:1: error:
> control reaches end of non-void functio
> n [-Werror=3Dreturn-type]
>  }

Drat.  Is there an easy way to test compile for w32?

>  ^
>=20
> The compiler is confused (it doesn't realise that "assert(0)"
> cannot return), but you can make it happier like this:
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 09b6ff0..68f936c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2638,7 +2638,7 @@ static char *spapr_get_resize_hpt(Object *obj,
> Error **errp)
>      case SPAPR_RESIZE_HPT_REQUIRED:
>          return g_strdup("required");
>      }
> -    assert(0);
> +    g_assert_not_reached();
>  }
>=20
>  static void spapr_set_resize_hpt(Object *obj, const char *value, Error *=
*errp)
>=20
>=20
> I think g_assert_not_reached() is easier to read anyway; I
> always have to think for a moment about whether assert(0)
> or assert(1) is the "always assert" condition...

Yes, seems good.  Should I resend, or will you adjust in place?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllpgPoACgkQbDjKyiDZ
s5JKgQ//YRhLi0u4BJ3yNUpagX+r2+7MsOie6u9X1DQ6XqXtWbJueRTd8NFYUcST
jD5Ewf577v3UShCHpIfHeWYUcjaV3lXC2Gyuh7bcIYBdVbWzFkw3dtbXEOODOgYT
1U78nQPJ0rKTPFgoZPt63lvhdcAewtlSSS2BuKyxh6qMA+qndFkkROdFgNK4BS2W
12Z9ODDtFlWUcjKlhBwhFwpiRnRvtOcndD2VxzAIcNlTHeSZs9kEEuKQN7jLvGmu
9ZsROWGvjk3pTj6e5aRzkAdRewpcvriX/XR/Dh2jvyD9cuKZJWpjb1cQqp6NN8UN
1F8+fYVA5QRZid5wud0gShTCnMrt16KrRmPQe700Mf1qZDkkt8VBrm4ByuwFVh3p
GsLERlMA1IuIXcmd8DjHXcERP3KlL9IiUd7llYpVxEk2ojN/1xgE8I0BNihk7H00
oQJtvmPlIUZrNkRVOa/33IkeBx+J543NesAwf+8IpG7JXmtCOsgc3J/wnxJqLAIi
jipdYhxz8cA1wL4OyHeA0MtmRzkjH5gNcoL62gbpwaXvXMqLzE0/PphxETQU4BqR
/P4Xn8xReIauhgY7s5fB8Ub6bg6toplPe1KKcnr1rbV0L66NOcUfpnJGQ6OLYoD/
OMFL7bqDcbydiSGWKAjlg5XQ90QRRkEJu8HR0Md3m68DTWEdfK8=
=Swpu
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
