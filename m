Received: from eggs.gnu.org ([2001:4830:134:3::10]:53006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbK-0007hr-KQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbJ-00061U-KW
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:10 -0400
Date: Fri, 9 Jun 2017 20:03:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609100336.GJ26521@umbus.fritz.box>
References: <20170608144106.GG25805@umbus.fritz.box>
	<20170609110748.00c8e419@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Content-Disposition: inline
In-Reply-To: <20170609110748.00c8e419@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] unplug_request and migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, jdenemar@redhat.com


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 11:09:10AM +0200, Igor Mammedov wrote:
> On Fri, 9 Jun 2017 00:41:06 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Hi Dave & Juan,
> >=20
> > I'm hoping one of you can answer this.
> >=20
> > I'm currently grappling with (amongst other things) a pseries machine
> > racing a hot unplug operation with a migrate.  There's various issues
> > with what interim state we need, and which bits of it need to be
> > migrated that I'm still investigating.  But, there's a more general
> > question that I'm guessing must have already been addressed for x86.
> >=20
> > For any "soft" unplug device - i.e. using ->unplug_request, rather
> > than ->unplug, giving a device_del command will just ask the guest
> > nicely to release the device, with the completion of the unplug
> > happening only if and when the guest indicates it's ready for the
> > device to go away.  AFAICT, the device_del command will return as soon
> > as the request is made, but if the guest is busy, the completion of
> > the hot unplug could take arbitrarily long.
> >=20
> > So, what happens if there's a migration in between the unplug_request
> > and the guest completing the unplug?  How does libvirt (or whatever)
> > know whether to include the device on the destination machine command
> > line?
> >=20
>=20
> looking at qdev_unplug():
>     if (!migration_is_idle()) {=20
>         error_setg(errp, "device_del not allowed while migrating");
>         return;
>     }
>=20
> so unplug request should fail if migration is in progress , it won't reac=
h guest
> and mgmt side will have to repeat request on migration completion.
>=20
> But it's still possible to issue unplug request first and then start
> migration,

Right, that's the case I'm interested in, not the other way around.

> that's where race between DEVICE_DELETED and migration start (starting DS=
T with
> being unplugged device) occurs.
>=20
> it could be possible:
>  1: on unplug_request() set global flag that there is pending unplug and =
forbid
>     migration until completion. But there is no guarantee that unplug will
>     be completed nor a way to notice that it's failed/rejected by guest.
>     I'm not sure how that could be solved.
>  2: set per device pending_unplug flag and delay unplug event from guest
>     until migration is completed if migration is in progress when unplug
>     callback is called.
>     mgmt will treat the case as usual migration, i.e. start dst with being
>     unplugged device, and device will be removed on dst side on migration
>     completion.
>     (it should be generic solution as x86 is also affected), as place whe=
re
>     to put this common logic I'd suggest hotplug_handler_unplug()

So.. it seems like the short version is that racing migration and
unplug is broken already.

Which is unfortunate, but at least means I don't need to worry about
it particularly for Power.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOnJ1AAoJEGw4ysog2bOS2fkQAJYtcZD/+OwB0d9YeXZB75iF
/svyc3Q7DpW1yezlQPN7yRg99x4THpm/zY7F8KxYn0sWP3gLimfWM2FS/YmWvTCu
JHpFr0S6/J4HO7yzZbuT4NbPUT95MuyGrDNn8eF3SuYlXlvdh5+YuF2UfiXBrbR+
x/caBKjNpluTykuo+Qbc9E1IS+4vM5OXLqIs7HFu+/h6tMBSTDVxM+f/JxJMTkWJ
TQ2+j6T+u0dC+0NPrWlqBW99eg52DmjI6oz+uvpmM/a0qgXOolvLhzpLr6hhCvYV
thSYxAyC4dJs2Nhh3aUqmZwg8kTGq/0Ib+ySO4ytF0yzJVO2OrtSH+Yc74rWWJzj
8FhxxLf5C1aGqYW6qpIHa0qIDI1OTLQPy0qHc7qqdyr8EzdxSNn9EQ8AonsAKXMU
G5EEVEZCVs1qDt3hvZ/tzebTiuFd6OLRIK+VeWXNa8Cy0VcIV/jcGCT1d3RYqyat
xX2Lwiv2uyI50662oe5/wu1cPceHphfdi93KhIFmDBcgl2VzW8xRaIAO8VcvNSHu
aVOYlA+GWCynl1ND2jD1nWNMEvAtCSqSr/OGja4CoOxjkcn7roVtFD9QvLpy2312
ZAFsOQwcnEQyC6OWMkjdbh262Oty8dcem7Cl4df2k1xuWnW1F4dGMwpCYDIBB03v
yKu+JdR/bMZGoupeqgcv
=GHEm
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
