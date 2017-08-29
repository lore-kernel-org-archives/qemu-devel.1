Received: from eggs.gnu.org ([2001:4830:134:3::10]:51233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeIB-0005q9-HL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeI8-0001Gz-Co
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:47 -0400
Date: Tue, 29 Aug 2017 17:30:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829073046.GM2578@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-7-git-send-email-imammedo@redhat.com>
	<20170825042203.GC2772@umbus.fritz.box>
	<20170825094948.5a7315fd@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <20170825094948.5a7315fd@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 6/6] ppc: drop caching ObjectClass
 from PowerPCCPUAlias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 09:49:48AM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 14:22:03 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Aug 24, 2017 at 10:21:51AM +0200, Igor Mammedov wrote:
> > > Caching there practically doesn't give any benefits
> > > and that at slow path druring querying supported CPU list.
> > > But it introduces non conventional path of where from
> > > comes used CPU type name (kvm_ppc_register_host_cpu_type).
> > >=20
> > > Taking in account that kvm_ppc_register_host_cpu_type()
> > > fixes up models the aliases point to, it's sufficient to
> > > make ppc_cpu_class_by_name() translate cpu alias to
> > > correct cpu type name.
> > > So drop PowerPCCPUAlias::oc field + ppc_cpu_class_by_alias()
> > > and let ppc_cpu_class_by_name() do conversion to cpu type name,
> > > which simplifies code a little bit saving ~20LOC and trouble
> > > wondering why ppc_cpu_class_by_alias() is necessary.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Unfortunately, this will break things.  This isn't purely a cache, in
> > the case handled by kvm_ppc_register_host_cpu_type(), 'oc' is *not*
> > redundant with the name.  The name is based on the specific CPU
> > description, but the oc points to the information for the "host" cpu.
> >=20
> > There may well be a better way to do this, but this isn't it.
> >=20
> > The problem we're trying to solve here is that KVM HV basically only
> > works with -cpu host.  But for the benefit of libvirt (and others), we
> > want, say, -cpu POWER8 to also work if the host *is* a POWER8.  But we
> > *don't* want to require that the host be exactly the same model of
> > POWER8 as "POWER8" would be aliased to with TCG.
>=20
> here is snippet from kvm_ppc_register_host_cpu_type()
>=20
> 1:
>             ppc_cpu_aliases[i].model =3D g_strdup(object_class_get_name(o=
c));     =20
>             suffix =3D strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWERPC_C=
PU);     =20
>             if (suffix) {                                                =
       =20
>                 *suffix =3D 0;                                           =
         =20
>             }
> 2:                                                       =20
>             ppc_cpu_aliases[i].oc =3D oc;
>=20
> where model is fixed up (1) to the name that corresponds to
> exactly the same 'oc' that is cached into (2)
>=20
> any follow up attempt to translate fixed up alias will end up resolving
> it into model =3D> the same 'oc' that would be cached in ppc_cpu_aliases[=
i].oc
>=20
> isn't it?


You're right, I misread the code, sorry.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlGCUACgkQbDjKyiDZ
s5JUqBAA45K3MigjumjvwuW6Xh6+GrDJ6yN6sR4z/mMVbxCuWFclzGE+BqRXSPK7
JEUQH/p7oezUtTge+PhU7hGfyLv65NoAzv5q3h855KxM2x5X072y2dtr58N1MlDU
/zN1h7CaRX3KsLyEwuEJN6y06OSVXDSggmUoP5eIojPHNT7aZU9vRTpjI/mAqnDO
aiPcxOXY0NC4vdkuHKfmliO7TlCYoiXrFGs/GqpzJZ2oOYgvnBlkJhwj3BCHhzFC
Ld5+V4esARjCbNRzaSHHu2byy8gSAiaki5CuLmJhiQFttyY62L01xmP8jFZzkzwp
fj9DEpBLybLLoDUx7QQ23coF24XpuTfjRHYF9WkQ4XMpqPkh4Lv1M3vwJ99HYo17
nPkbb+qENJMdAjgGfrcA1U8MoZImxeyDZySiOUaxfjlgWYIl9gqQh3NZl75Pzkbs
BszZdxVrXbbqYim9UmvVj7P4zvlE5XqwUdI5O+dskl1C7ZXO5R+hYz+JARw5kmn4
Uuu7fI6xFGYQoD/WpCGg7++hjZHZBjXM6UH8V8BGMMS1hkgy3e50ENNiYn6+acVI
yOPPIKUIBYXQX6GvIHUQVXICxa+cDM0yniElEtZLNvCEIh7VluI0ZLJYnP+lBMZC
yV7a9sMETngJd91+5bDLQ1dXpgLCZKFJ4gt7M/UwT5k1wpDfcmQ=
=KQe/
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
