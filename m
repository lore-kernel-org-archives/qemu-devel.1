Received: from eggs.gnu.org ([2001:4830:134:3::10]:45551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX9-0000ko-2p
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX6-00019B-8y
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:15 -0500
Date: Sun, 11 Feb 2018 10:11:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210231103.GV11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-6-mark.cave-ayland@ilande.co.uk>
	<20180210223214.GS11634@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A47bNRIYjYQgpFVi"
Content-Disposition: inline
In-Reply-To: <20180210223214.GS11634@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCHv2 05/12] cuda: rename frequency property to
 tb_frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--A47bNRIYjYQgpFVi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2018 at 09:32:14AM +1100, David Gibson wrote:
> On Fri, Feb 09, 2018 at 06:51:35PM +0000, Mark Cave-Ayland wrote:
> > This allows us to more easily differentiate between the timebase freque=
ncy used
> > to calibrate the MacOS timers and the actual frequency of the hardware =
clock as
> > indicated by CUDA_TIMER_FREQ.
> >=20
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Applied, thanks.

Actually, this patch doesn't compile, because you've changed
ti->frequency in a couple of places where you should only be changing
s->frequency.  I've fixed it up in my tree.

>=20
> > ---
> >  hw/misc/macio/cuda.c  | 10 +++++-----
> >  hw/misc/macio/macio.c |  2 +-
> >  hw/ppc/mac.h          |  2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> > index a88535fa66..232b7f61aa 100644
> > --- a/hw/misc/macio/cuda.c
> > +++ b/hw/misc/macio/cuda.c
> > @@ -158,8 +158,8 @@ static unsigned int get_counter(CUDAState *s, CUDAT=
imer *ti)
> >      uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > =20
> >      /* Reverse of the tb calculation algorithm that Mac OS X uses on b=
ootup. */
> > -    tb_diff =3D get_tb(current_time, ti->frequency) - ti->load_time;
> > -    d =3D (tb_diff * 0xBF401675E5DULL) / (ti->frequency << 24);
> > +    tb_diff =3D get_tb(current_time, ti->tb_frequency) - ti->load_time;
> > +    d =3D (tb_diff * 0xBF401675E5DULL) / (ti->tb_frequency << 24);
> > =20
> >      if (ti->index =3D=3D 0) {
> >          /* the timer goes down from latch to -1 (period of latch + 2) =
*/
> > @@ -179,7 +179,7 @@ static void set_counter(CUDAState *s, CUDATimer *ti=
, unsigned int val)
> >  {
> >      CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
> >      ti->load_time =3D get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                           s->frequency);
> > +                           s->tb_frequency);
> >      ti->counter_value =3D val;
> >      cuda_timer_update(s, ti, ti->load_time);
> >  }
> > @@ -878,7 +878,7 @@ static void cuda_realizefn(DeviceState *dev, Error =
**errp)
> >      struct tm tm;
> > =20
> >      s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer=
1, s);
> > -    s->timers[0].frequency =3D s->frequency;
> > +    s->timers[0].frequency =3D s->tb_frequency;
> >      s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer=
2, s);
> >      s->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
> > =20
> > @@ -909,7 +909,7 @@ static void cuda_initfn(Object *obj)
> >  }
> > =20
> >  static Property cuda_properties[] =3D {
> > -    DEFINE_PROP_UINT64("frequency", CUDAState, frequency, 0),
> > +    DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, =
0),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> > =20
> > diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> > index 44f91d1e7f..a639b09e00 100644
> > --- a/hw/misc/macio/macio.c
> > +++ b/hw/misc/macio/macio.c
> > @@ -451,7 +451,7 @@ void macio_init(PCIDevice *d,
> >      macio_state->escc_mem =3D escc_mem;
> >      /* Note: this code is strongly inspirated from the corresponding c=
ode
> >         in PearPC */
> > -    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "frequency",
> > +    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequen=
cy",
> >                           macio_state->frequency);
> > =20
> >      qdev_init_nofail(DEVICE(d));
> > diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> > index b501af1653..fa78115c95 100644
> > --- a/hw/ppc/mac.h
> > +++ b/hw/ppc/mac.h
> > @@ -99,7 +99,7 @@ typedef struct CUDAState {
> >      CUDATimer timers[2];
> > =20
> >      uint32_t tick_offset;
> > -    uint64_t frequency;
> > +    uint64_t tb_frequency;
> > =20
> >      uint8_t last_b;
> >      uint8_t last_acr;
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A47bNRIYjYQgpFVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/fAQACgkQbDjKyiDZ
s5Kx1g/9EPkKn8pYRvea56gRH4tOugQ+HaIUNg0ulS4PcKqbBMVgN/ih6t7i/OLW
PlX7HfciokjSpuJjMjHVb0jTJhhbYOWo4lsMWRwmQLH7l25FEmFx+g4buT5hAfZF
rvwxCX2IlYzEBJbmqgNsh/lRhbL18D72pKS4TnWeQH9a0PC67EinTmZtCX50GJgY
hFT8KPJJk9I0LIpAagVc2F/tw4Sm6grqjusX/WKg5dnWWZ2Ff9Mszu+YtfqUZnBm
53Qjfp+Lg1YNln5oMrDqGYQ0S8mwSTAD8fZruzM6Z0XYeMgeCzdxIduMWhcpsDuC
vnAgpQJLVD8A2nJr2V8AAjdXxMw3g0zr6gu6Zd6sIOdN4u+/E/Eyl7cEt0fIKD7D
rn6dn2hkgXw5NwnbdsErmVfUFCvoz2BDVkjB0hg6/f/XFODRIg1CXg4qod67IW9z
8J8LovJ85Og/kFuB4G7xvljD8UZdrQZkp75wUGGaNeWp0yt1hX6CcbQl6fH9gaYZ
jXb0le26mZgiEo8hNqC8L0TpNedAQtF5VRk3NSZ2ym6/c4sbzO0NqRF7TKrgrJLw
PGOhvX4Bxc+5t5gjh4h28Yzj27wy9Spm7Gw8LBzp35a5qooI7gE3BQdccADknhRx
/xp4rKSa3DuqYd6G0V+dqMT/SdcX/xc4Qfx/L5RWrTfLuq+6sv4=
=38IM
-----END PGP SIGNATURE-----

--A47bNRIYjYQgpFVi--
