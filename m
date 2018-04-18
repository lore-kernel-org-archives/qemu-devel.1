Received: from eggs.gnu.org ([2001:4830:134:3::10]:48027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8cOq-0003AR-Hd
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8cOm-0001RG-Cr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:44 -0400
Received: from ozlabs.org ([203.11.71.1]:54479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f8cOl-0001Pt-FA
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:40 -0400
Date: Wed, 18 Apr 2018 10:57:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180418005726.GD2317@umbus.fritz.box>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20180418005550.GC2317@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, dgibson@redhat.com, amit.shah@redhat.com


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 10:55:50AM +1000, David Gibson wrote:
> On Tue, Apr 17, 2018 at 06:53:17PM +0530, Balamuruhan S wrote:
> > expected_downtime value is not accurate with dirty_pages_rate * page_si=
ze,
> > using ram_bytes_remaining would yeild it correct.
>=20
> This commit message hasn't been changed since v1, but the patch is
> doing something completely different.  I think most of the info from
> your cover letter needs to be in here.
>=20
> >=20
> > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > ---
> >  migration/migration.c | 6 +++---
> >  migration/migration.h | 1 +
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 52a5092add..4d866bb920 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, =
MigrationState *s)
> >      }
> > =20
> >      if (s->state !=3D MIGRATION_STATUS_COMPLETED) {
> > -        info->ram->remaining =3D ram_bytes_remaining();
> > +        info->ram->remaining =3D s->ram_bytes_remaining;
> >          info->ram->dirty_pages_rate =3D ram_counters.dirty_pages_rate;
> >      }
> >  }
> > @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationSt=
ate *s,
> >      transferred =3D qemu_ftell(s->to_dst_file) - s->iteration_initial_=
bytes;
> >      time_spent =3D current_time - s->iteration_start_time;
> >      bandwidth =3D (double)transferred / time_spent;
> > +    s->ram_bytes_remaining =3D ram_bytes_remaining();
> >      s->threshold_size =3D bandwidth * s->parameters.downtime_limit;
> > =20
> >      s->mbps =3D (((double) transferred * 8.0) /
> > @@ -2237,8 +2238,7 @@ static void migration_update_counters(MigrationSt=
ate *s,
> >       * recalculate. 10000 is a small enough number for our purposes
> >       */
> >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > -        s->expected_downtime =3D ram_counters.dirty_pages_rate *
> > -            qemu_target_page_size() / bandwidth;
> > +        s->expected_downtime =3D s->ram_bytes_remaining / bandwidth;
> >      }

=2E.but more importantly, I still think this change is bogus.  expected
downtime is not the same thing as remaining ram / bandwidth.

> > =20
> >      qemu_file_reset_rate_limit(s->to_dst_file);
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 8d2f320c48..8584f8e22e 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -128,6 +128,7 @@ struct MigrationState
> >      int64_t downtime_start;
> >      int64_t downtime;
> >      int64_t expected_downtime;
> > +    int64_t ram_bytes_remaining;
> >      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
> >      int64_t setup_time;
> >      /*
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrWl/YACgkQbDjKyiDZ
s5K71BAAhO2sOrDs6kPHclnUMLpewGiMXECkBZwsl5svjOC3YykoPL5O36j2bqmf
W54QCCTLZSlLUgMvuxqCaTu/RGb5Yht5avM3IoGLzdW1M37vNwDHHaxLap9YSyFs
BR18p5V7/IN1uOiSykAI/Sm5wn6y7rxPHSBSYQJ3IEVdDq+RiRFgEs6+7rW/+Fq+
Da2/sEcQeb37O41l5ncZh/6Qpl480v1sN8Q9Xue+rKvk+2r+CDwVpPhU3/MNpe9T
0TrtRmKVSWAocHle6vrOGTNNzLxrgo8PlVN2Nxg9xIuhLstZRxTeNpmZBemDPuPg
zNFhWuFGuoF6TnjooKyDztPIV0sSkHojnwcygTFr3a/UZDicjqaliT+JjJEaOAbO
eujEXY0y1Ii36bKxNaZEGRIE/QXtP59jdSeep5i67nR21CJ7K/KUAxzkFwoYXcY2
POpG2WZJROkARXzThxOgttNkjhdqV40ENPPZTVP3YuU3vzUDsK+KT5ZJ1kF3xE7Q
pJVWHU+D8jGAFRLuxxWnQwTQ9URcU/vPyku63KmLx5kCX+TC3W3z2/Oh3d2PzOhb
ZZiLmpVMByMeGnesGvkgk3Mz31G6xTMLJOE3PDbdvEH1buC0NM25KirG3V3pFq7z
nFQNeZ9TwSzji6lmgTYiN8J6Dph/rum0Ywz5lJ8GG57Zwe2HHfE=
=Rgwi
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
