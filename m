Received: from eggs.gnu.org ([2001:4830:134:3::10]:51592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimhp-0003UY-UD
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimhm-0001L1-OE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:45:33 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimhm-0001Kp-Hi
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:45:30 -0500
Received: by mail-qk0-x242.google.com with SMTP id 69so20967734qkz.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:45:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7e3dc51-ab88-c30e-10d5-f5a22a9cd7f6@amsat.org>
Date: Mon, 5 Feb 2018 16:45:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-6-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="yYp4gQDZqICmkPw4okV3kIYkezSjwJQwL"
Subject: Re: [Qemu-devel] [PATCH 05/10] cuda: rename frequency property to
 tb_frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lvivier@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yYp4gQDZqICmkPw4okV3kIYkezSjwJQwL
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 lvivier@redhat.com
Message-ID: <d7e3dc51-ab88-c30e-10d5-f5a22a9cd7f6@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 05/10] cuda: rename frequency property to
 tb_frequency
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
 <20180203103727.26457-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 07:37 AM, Mark Cave-Ayland wrote:
> This allows us to more easily differentiate between the timebase freque=
ncy used
> to calibrate the MacOS timers and the actual frequency of the hardware =
clock as
> indicated by CUDA_TIMER_FREQ.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/misc/macio/cuda.c  | 10 +++++-----
>  hw/misc/macio/macio.c |  2 +-
>  hw/ppc/mac.h          |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index f036e8d7e1..a200320e7d 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -158,8 +158,8 @@ static unsigned int get_counter(CUDAState *s, CUDAT=
imer *ti)
>      uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> =20
>      /* Reverse of the tb calculation algorithm that Mac OS X uses on b=
ootup. */
> -    tb_diff =3D get_tb(current_time, ti->frequency) - ti->load_time;
> -    d =3D (tb_diff * 0xBF401675E5DULL) / (ti->frequency << 24);
> +    tb_diff =3D get_tb(current_time, ti->tb_frequency) - ti->load_time=
;
> +    d =3D (tb_diff * 0xBF401675E5DULL) / (ti->tb_frequency << 24);
> =20
>      if (ti->index =3D=3D 0) {
>          /* the timer goes down from latch to -1 (period of latch + 2) =
*/
> @@ -179,7 +179,7 @@ static void set_counter(CUDAState *s, CUDATimer *ti=
, unsigned int val)
>  {
>      CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
>      ti->load_time =3D get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                           s->frequency);
> +                           s->tb_frequency);
>      ti->counter_value =3D val;
>      cuda_timer_update(s, ti, ti->load_time);
>  }
> @@ -878,7 +878,7 @@ static void cuda_realizefn(DeviceState *dev, Error =
**errp)
>      struct tm tm;
> =20
>      s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer=
1, s);
> -    s->timers[0].frequency =3D s->frequency;
> +    s->timers[0].frequency =3D s->tb_frequency;
>      s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer=
2, s);
>      s->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
> =20
> @@ -909,7 +909,7 @@ static void cuda_initfn(Object *obj)
>  }
> =20
>  static Property cuda_properties[] =3D {
> -    DEFINE_PROP_UINT64("frequency", CUDAState, frequency, 0),
> +    DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, =
0),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 44f91d1e7f..a639b09e00 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -451,7 +451,7 @@ void macio_init(PCIDevice *d,
>      macio_state->escc_mem =3D escc_mem;
>      /* Note: this code is strongly inspirated from the corresponding c=
ode
>         in PearPC */
> -    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "frequency",
> +    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequen=
cy",
>                           macio_state->frequency);
> =20
>      qdev_init_nofail(DEVICE(d));
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index b501af1653..fa78115c95 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -99,7 +99,7 @@ typedef struct CUDAState {
>      CUDATimer timers[2];
> =20
>      uint32_t tick_offset;
> -    uint64_t frequency;
> +    uint64_t tb_frequency;
> =20
>      uint8_t last_b;
>      uint8_t last_acr;
>=20


--yYp4gQDZqICmkPw4okV3kIYkezSjwJQwL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4tFYACgkQ4+MsLN6t
wN4zHQ//Xlj2OgQYs4FXIB2ydUvmOX9QQ15f47EJjB8nHgjAXgDFObHhmddcdeiO
qibJkgnAPM4dWqhaGWkTgqqUxy9QyopFNDtBxT7MZ96Fjg9f+pkc1O/L8yuiM3Ty
1wMZdYC3P2e3e6qK46mF4q/96BtfarY8b3IXm4cy3f3EVHRO9uKGYy7npQdVR0O7
Bhz9yzjJYvChthgLeuu59SCiqXN3kUzYRTh7GJBDhTduew+dw78TRhGdt2r0MjvL
EqMNrPeV8qvEjnHaX3xgns1Qi1lUgs1ExTy2czYpMvPurZmjC//tBVMBR0wuwxy0
qo4NnlSQzfQdC5jO+KW0GtUKrA/xjLXji3mAH+OwGcv4BsvU1bmd/CdCcKMe+pAF
dbEpBOUFCDmPcIvQ2uWXmNRw533qalIOdUrwb9bgl6qQZa6kHRCQO0Ptd//BVvYO
HXxesJ2MdPielbGqHW6/suK6urU6xT+xFSvA6RasyPW9P80b0Q2p7aQq98KDjKrH
CZ8Ze6X6crHwZ6SwM1xZM4aV9CXpyAuPF3o9K5tNjLXJNGmIhyDqrnCpArYCY2SD
Llro8Wk9+HQR3vW5HdkkYrWaGyht1ROY+8CUQeszjg5kSHzXbvSY4AABNkhwwjzP
BmcUy2k/L4fpXarIxYmoIAJc2VnW7sycuapU/Dy1r4wWBlG/JPI=
=hdsj
-----END PGP SIGNATURE-----

--yYp4gQDZqICmkPw4okV3kIYkezSjwJQwL--
