Received: from eggs.gnu.org ([2001:4830:134:3::10]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimgg-0002KX-Nt
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimgd-0000q4-Jm
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:44:22 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimgd-0000po-Ew
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:44:19 -0500
Received: by mail-qt0-x241.google.com with SMTP id g14so41176505qti.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:44:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-9-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd88d3c0-0ba9-b402-6cd8-7a2ead9016b8@amsat.org>
Date: Mon, 5 Feb 2018 16:44:15 -0300
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-9-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="dr9lHHOzRY707jvRaGg7B6pKMNRTd3TF1"
Subject: Re: [Qemu-devel] [PATCH 08/10] cuda: factor out timebase-derived
 counter value and load time
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
--dr9lHHOzRY707jvRaGg7B6pKMNRTd3TF1
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 lvivier@redhat.com
Message-ID: <dd88d3c0-0ba9-b402-6cd8-7a2ead9016b8@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 08/10] cuda: factor out timebase-derived
 counter value and load time
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
 <20180203103727.26457-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 07:37 AM, Mark Cave-Ayland wrote:
> Commit b981289c49 "PPC: Cuda: Use cuda timer to expose tbfreq to guest"=
 altered
> the timer calculations from those based upon the hardware CUDA clock fr=
equency
> to those based upon the CPU timebase frequency.
>=20
> In fact we can isolate the differences to 2 simple changes: one to the =
counter
> read value and another to the counter load time. Move these changes int=
o
> separate functions so the implementation can be swapped later.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 00e71fcd5e..184d151702 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -145,21 +145,29 @@ static void cuda_update_irq(CUDAState *s)
>      }
>  }
> =20
> -static uint64_t get_tb(uint64_t time, uint64_t freq)
> +static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
>  {
> -    return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
> +    /* Reverse of the tb calculation algorithm that Mac OS X uses on b=
ootup */
> +    uint64_t tb_diff =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
),
> +                                s->tb_frequency, NANOSECONDS_PER_SECON=
D) -
> +                           ti->load_time;

Easier to read imho:

       uint64_t tb_diff =3D get_counter_load_time(s, ti) - ti->load_time;=


Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +
> +    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
> +}
> +
> +static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
> +{
> +    uint64_t load_time =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL),
> +                                  s->tb_frequency, NANOSECONDS_PER_SEC=
OND);
> +    return load_time;
>  }
> =20
>  static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
>  {
>      int64_t d;
>      unsigned int counter;
> -    uint64_t tb_diff;
> -    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> =20
> -    /* Reverse of the tb calculation algorithm that Mac OS X uses on b=
ootup. */
> -    tb_diff =3D get_tb(current_time, s->tb_frequency) - ti->load_time;=

> -    d =3D (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
> +    d =3D get_counter_value(s, ti);
> =20
>      if (ti->index =3D=3D 0) {
>          /* the timer goes down from latch to -1 (period of latch + 2) =
*/
> @@ -178,8 +186,7 @@ static unsigned int get_counter(CUDAState *s, CUDAT=
imer *ti)
>  static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)=

>  {
>      CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
> -    ti->load_time =3D get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                           s->tb_frequency);
> +    ti->load_time =3D get_counter_load_time(s, ti);
>      ti->counter_value =3D val;
>      cuda_timer_update(s, ti, ti->load_time);
>  }
>=20


--dr9lHHOzRY707jvRaGg7B6pKMNRTd3TF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4tA8ACgkQ4+MsLN6t
wN6BIxAAkYhLq6e+cpMxP+JtLKvag6slH9bCXNB5vT1BPqsP9mEOAfZRA3ZU+laI
2uOg9Ni3A2LRZHIeKejw5r9OIeCJYb/p+e7bmWTtEBt7DJ4U1bQJ14u/EHgWBahB
E0xujbJLKvCKvpIPPvTxwUTyWeRIm2cuGmRWcmqBjaUFTtQekI5ARm3WGDIXLBfb
4furzSRxPz5Aeo7KsXIs2nVRcszgIZu9pV5xOmipG3YRGWZ6mE4p4QVM4ZjhEm8W
/d14w6hlhCm9FWOoBwGIIChpn78jQiFD5oqJO06yiXqBTFCH6n8lVL9lBEDDzwo2
r62KBbB5v1a4CBBe6CAvm9TyxwiYZ3aR/Yv4ZmxGVhEXcPjpHt9GMXEm32xNkZSi
lhwYnTpxTDHZCBgvSns4il7iDEOfiTJx0xyUauiZJixMHBv4FaSb6oCXHYhQLdPb
QtsoybMm2XRgzNEfvBejCo/frJYQEtbs4rd9Bo6wlLbco9gPKoZyUodxpX9gZYsB
5xHCtEWTO1N+bLoDXAq8vVijT7t129KVsNKUDXCVxj0r6xhPCK1nbGL5k0+FPhW9
VF0WZAUh1m6RHmavnEEEyQ/dn7JJzvdglMiCXY/sfgAegFke9VLKl+6ilg+7JUfx
kucqqtIPqYeHhwc+nEX88SdgSAZVMcTGgeRP495D/slHhWgR+PQ=
=JYES
-----END PGP SIGNATURE-----

--dr9lHHOzRY707jvRaGg7B6pKMNRTd3TF1--
