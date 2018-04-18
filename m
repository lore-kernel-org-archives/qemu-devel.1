Received: from eggs.gnu.org ([2001:4830:134:3::10]:47947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8cOn-00039W-Ej
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8cOm-0001RL-Cq
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:41 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f8cOl-0001Pq-B1
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:40 -0400
Date: Wed, 18 Apr 2018 10:55:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180418005550.GC2317@umbus.fritz.box>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20180417132317.6910-2-bala24@linux.vnet.ibm.com>
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


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 06:53:17PM +0530, Balamuruhan S wrote:
> expected_downtime value is not accurate with dirty_pages_rate * page_size,
> using ram_bytes_remaining would yeild it correct.

This commit message hasn't been changed since v1, but the patch is
doing something completely different.  I think most of the info from
your cover letter needs to be in here.

>=20
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> ---
>  migration/migration.c | 6 +++---
>  migration/migration.h | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 52a5092add..4d866bb920 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, Mi=
grationState *s)
>      }
> =20
>      if (s->state !=3D MIGRATION_STATUS_COMPLETED) {
> -        info->ram->remaining =3D ram_bytes_remaining();
> +        info->ram->remaining =3D s->ram_bytes_remaining;
>          info->ram->dirty_pages_rate =3D ram_counters.dirty_pages_rate;
>      }
>  }
> @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationStat=
e *s,
>      transferred =3D qemu_ftell(s->to_dst_file) - s->iteration_initial_by=
tes;
>      time_spent =3D current_time - s->iteration_start_time;
>      bandwidth =3D (double)transferred / time_spent;
> +    s->ram_bytes_remaining =3D ram_bytes_remaining();
>      s->threshold_size =3D bandwidth * s->parameters.downtime_limit;
> =20
>      s->mbps =3D (((double) transferred * 8.0) /
> @@ -2237,8 +2238,7 @@ static void migration_update_counters(MigrationStat=
e *s,
>       * recalculate. 10000 is a small enough number for our purposes
>       */
>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> -        s->expected_downtime =3D ram_counters.dirty_pages_rate *
> -            qemu_target_page_size() / bandwidth;
> +        s->expected_downtime =3D s->ram_bytes_remaining / bandwidth;
>      }
> =20
>      qemu_file_reset_rate_limit(s->to_dst_file);
> diff --git a/migration/migration.h b/migration/migration.h
> index 8d2f320c48..8584f8e22e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -128,6 +128,7 @@ struct MigrationState
>      int64_t downtime_start;
>      int64_t downtime;
>      int64_t expected_downtime;
> +    int64_t ram_bytes_remaining;
>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
>      int64_t setup_time;
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrWl5MACgkQbDjKyiDZ
s5LtVw/6Aksz5pKVQ+Wet++tKTuaAuK6qZP/YeNI3/METpW3Ij74x7BKZ+6OA1Jv
P5zUVWmpbvEkKE5Jqi6fAm1Je7m39rdrtPS/agSF7ij2AI+32Ddm0BPNUUkgdTPD
br0rmboH0ximBQShl3IkY4KUBduPngN0nS5Mv2gAumllYbdwK0IYo0P+WMIvZdeY
FbH754Jbf9lehT87tKB5bmCiSnUIUwj3VBvcwLOpHvsKnh9j3q0SLGoZmqK6rS9I
aUTPLAgBn1Hcdz/Pww92L64YZwyvCUKCuHYmJNnad73f+62G+UxnZWYzegG6WSj/
OFFRK9FiBsFgZJS9MjJdmER1TnE0cp5OIKbUy2XHUI2u59ATMnZ33VYnXZWyQ8JH
PsKfoaN9Fv4ot8Sa8Mui1TghV+3P4ViSTH7Uh5WqwGTi6SidJ++vgYZd3+FQM8Aa
21wMhFZyZpRdhGUYXJFKSJbFjygyRgqqSCxhlnU+XizUWwMFiJR4AsfNImeNstMM
VgDxANPDpGi8kSfUQJrMOZGSivmXNu/SjG/ghcT4LkLQO1CVjmXNTTlZxzTgufOx
JUmp0PgaluXbfKn+M1bSgznKuY07+ivguzVfucUXAF7fznFIMpVrhQWilJHZ6gt5
/BZwdOVBKObkk6tUqOJsbzQWWuD2CcF2QF7O4Hgcgl7IN78PVpI=
=+iOa
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
