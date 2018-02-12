Received: from eggs.gnu.org ([2001:4830:134:3::10]:55036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elANT-0006Ku-02
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elANR-0000qn-5z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:26:22 -0500
Date: Mon, 12 Feb 2018 20:25:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180212092553.GH11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-13-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hrQ5MIiBPpJXe8FT"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-13-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 12/12] cuda: convert to trace-events
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


--hrQ5MIiBPpJXe8FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:42PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  Makefile.objs              |  1 +
>  hw/misc/macio/cuda.c       | 50 ++++++++++++++++------------------------=
------
>  hw/misc/macio/trace-events | 11 ++++++++++
>  3 files changed, 29 insertions(+), 33 deletions(-)
>  create mode 100644 hw/misc/macio/trace-events
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index 2efba6d768..3f1a1b674d 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -133,6 +133,7 @@ trace-events-subdirs +=3D hw/net
>  trace-events-subdirs +=3D hw/virtio
>  trace-events-subdirs +=3D hw/audio
>  trace-events-subdirs +=3D hw/misc
> +trace-events-subdirs +=3D hw/misc/macio
>  trace-events-subdirs +=3D hw/usb
>  trace-events-subdirs +=3D hw/scsi
>  trace-events-subdirs +=3D hw/nvram
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 377b91d266..bd9b862034 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -32,19 +32,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
> -
> -/* debug CUDA packets */
> -//#define DEBUG_CUDA_PACKET
> -
> -/* debug CUDA packets */
> -//#define DEBUG_CUDA_PACKET
> -
> -#ifdef DEBUG_CUDA
> -#define CUDA_DPRINTF(fmt, ...)                                  \
> -    do { printf("CUDA: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define CUDA_DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
> =20
>  /* Bits in B data register: all active low */
>  #define TREQ            0x08    /* Transfer request (input) */
> @@ -120,7 +108,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
>          return;
>      }
> =20
> -    CUDA_DPRINTF("CUDA: %s:%d\n", __func__, __LINE__);
> +    trace_cuda_delay_set_sr_int();
> =20
>      expire =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
>      timer_mod(s->sr_delay_timer, expire);
> @@ -141,7 +129,7 @@ static void cuda_update(CUDAState *s)
>              /* data output */
>              if ((ms->b & (TACK | TIP)) !=3D (s->last_b & (TACK | TIP))) {
>                  if (s->data_out_index < sizeof(s->data_out)) {
> -                    CUDA_DPRINTF("send: %02x\n", ms->sr);
> +                    trace_cuda_data_send(ms->sr);
>                      s->data_out[s->data_out_index++] =3D ms->sr;
>                      cuda_delay_set_sr_int(s);
>                  }
> @@ -151,7 +139,7 @@ static void cuda_update(CUDAState *s)
>                  /* data input */
>                  if ((ms->b & (TACK | TIP)) !=3D (s->last_b & (TACK | TIP=
))) {
>                      ms->sr =3D s->data_in[s->data_in_index++];
> -                    CUDA_DPRINTF("recv: %02x\n", ms->sr);
> +                    trace_cuda_data_recv(ms->sr);
>                      /* indicate end of transfer */
>                      if (s->data_in_index >=3D s->data_in_size) {
>                          ms->b =3D (ms->b | TREQ);
> @@ -199,15 +187,13 @@ static void cuda_update(CUDAState *s)
>  static void cuda_send_packet_to_host(CUDAState *s,
>                                       const uint8_t *data, int len)
>  {
> -#ifdef DEBUG_CUDA_PACKET
> -    {
> -        int i;
> -        printf("cuda_send_packet_to_host:\n");
> -        for(i =3D 0; i < len; i++)
> -            printf(" %02x", data[i]);
> -        printf("\n");
> +    int i;
> +
> +    trace_cuda_packet_send(len);
> +    for (i =3D 0; i < len; i++) {
> +        trace_cuda_packet_send_data(i, data[i]);
>      }
> -#endif
> +
>      memcpy(s->data_in, data, len);
>      s->data_in_size =3D len;
>      s->data_in_index =3D 0;
> @@ -411,7 +397,7 @@ static void cuda_receive_packet(CUDAState *s,
>      for (i =3D 0; i < ARRAY_SIZE(handlers); i++) {
>          const CudaCommand *desc =3D &handlers[i];
>          if (desc->command =3D=3D data[0]) {
> -            CUDA_DPRINTF("handling command %s\n", desc->name);
> +            trace_cuda_receive_packet_cmd(desc->name);
>              out_len =3D 0;
>              if (desc->handler(s, data + 1, len - 1, obuf + 3, &out_len))=
 {
>                  cuda_send_packet_to_host(s, obuf, 3 + out_len);
> @@ -440,15 +426,13 @@ static void cuda_receive_packet(CUDAState *s,
>  static void cuda_receive_packet_from_host(CUDAState *s,
>                                            const uint8_t *data, int len)
>  {
> -#ifdef DEBUG_CUDA_PACKET
> -    {
> -        int i;
> -        printf("cuda_receive_packet_from_host:\n");
> -        for(i =3D 0; i < len; i++)
> -            printf(" %02x", data[i]);
> -        printf("\n");
> +    int i;
> +
> +    trace_cuda_packet_receive(len);
> +    for (i =3D 0; i < len; i++) {
> +        trace_cuda_packet_receive_data(i, data[i]);
>      }
> -#endif
> +
>      switch(data[0]) {
>      case ADB_PACKET:
>          {
> diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
> new file mode 100644
> index 0000000000..24c0a36824
> --- /dev/null
> +++ b/hw/misc/macio/trace-events
> @@ -0,0 +1,11 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/misc/macio/cuda.c
> +cuda_delay_set_sr_int(void) ""
> +cuda_data_send(uint8_t data) "send: 0x%02x"
> +cuda_data_recv(uint8_t data) "recv: 0x%02x"
> +cuda_receive_packet_cmd(const char *cmd) "handling command %s"
> +cuda_packet_receive(int len) "length %d"
> +cuda_packet_receive_data(int i, const uint8_t data) "[%d] 0x%02x"
> +cuda_packet_send(int len) "length %d"
> +cuda_packet_send_data(int i, const uint8_t data) "[%d] 0x%02x"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hrQ5MIiBPpJXe8FT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqBXZ4ACgkQbDjKyiDZ
s5LPJw//ZWxFwmxFSzyouHbo8f8LLwmeBnhMwyotNmxrb6MIbDmoqfkCmttWsCs7
7ikXQdVpXd4E9XtxOH3KaCqoh6iyVSgrUCvPiq0nalpJ7YHsN8PgRcJ4cNkW22b4
/vjcMm+u4r+sswBfxUa4/YrF9J8ODCYQ61H2o4NAkEiPsqYxwVwETkzInftUGbub
Q8IgQrwQOG3tUstPYSTDt39LMY3DxsMRyGDexvCKuH+zenvfGb/VkNQw+IptMMkc
7DmtZEEhDLb7G2TUlNsesrQAdqowuSuwi1V04pLEcyLuY1CGe8PzGPQJPk7uc27F
Ra/o+fKqCO9dDMxfU90wrLvzI4TzLzkgeUVFIP8nn/jX/wVgQh4Q+yNq1q/wi7iz
SC54PEIeqqUrMz5PHHY2lRlN0Wt56H4o54i7x2oypmSVevpURdhfvVc3XinijzgN
H0I0VIAMby6PdH7zNkC2OiUPsl1q5VGmE7yD8fxo2odRkPaZBch+OwF3NVedbKmY
OoFpOu/YjeYQ5mUTmkJFWBFiAw3V67QEXBjvms7E/pjGPSxxY/aAmfGfiFRkDRnE
Ur0pSLLkBgkjD5feIdunhBCswv9cAUBOp0rQvOKskTPvoToRERp/KTZ+cIzjXj/5
olNh8ZLysFQ2Tka7fc6XKPx60i+ihQlqWPjStjTPFHdCKWjYlw4=
=rRo4
-----END PGP SIGNATURE-----

--hrQ5MIiBPpJXe8FT--
