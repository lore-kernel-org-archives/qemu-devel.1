Received: from eggs.gnu.org ([2001:4830:134:3::10]:60328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG5tH-00031c-BG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG5tD-0005oC-7I
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:50:31 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:59120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG5tC-0005n0-UM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:50:27 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6B54FFF8B6
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:50:25 +0200 (CEST)
Date: Wed, 31 May 2017 17:50:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531175018.37024b80@bahia.lan>
In-Reply-To: <20170531150933.10156-2-alex.bennee@linaro.org>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/uB5.lNIzW0/6X26zfPlEYFg";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] gdbstub: modernise DEBUG_GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com, qemu-devel@nongnu.org

--Sig_/uB5.lNIzW0/6X26zfPlEYFg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 16:09:32 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Convert the a gdb_debug helper which compiles away to nothing when not
> used but still ensures the format strings are checked. There is some
> minor code motion for the incorrect checksum message to report it
> before we attempt to send the reply.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  gdbstub.c | 77 +++++++++++++++++++++++++++------------------------------=
------
>  1 file changed, 33 insertions(+), 44 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 86eed4f97c..a249846954 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -271,7 +271,20 @@ static int gdb_signal_to_target (int sig)
>          return -1;
>  }
> =20
> -//#define DEBUG_GDB
> +/* #define DEBUG_GDB */
> +
> +#ifdef DEBUG_GDB
> +# define DEBUG_GDB_GATE 1
> +#else
> +# define DEBUG_GDB_GATE 0
> +#endif
> +
> +#define gdb_debug(fmt, ...) do { \
> +    if (DEBUG_GDB_GATE) { \
> +        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
> +    } \
> +} while (0)
> +
> =20
>  typedef struct GDBRegisterState {
>      int base_reg;
> @@ -547,9 +560,7 @@ static int put_packet_binary(GDBState *s, const char =
*buf, int len)
>  /* return -1 if error, 0 if OK */
>  static int put_packet(GDBState *s, const char *buf)
>  {
> -#ifdef DEBUG_GDB
> -    printf("reply=3D'%s'\n", buf);
> -#endif
> +    gdb_debug("reply=3D'%s'\n", buf);
> =20
>      return put_packet_binary(s, buf, strlen(buf));
>  }
> @@ -955,9 +966,9 @@ static int gdb_handle_packet(GDBState *s, const char =
*line_buf)
>      uint8_t *registers;
>      target_ulong addr, len;
> =20
> -#ifdef DEBUG_GDB
> -    printf("command=3D'%s'\n", line_buf);
> -#endif
> +
> +    gdb_debug("command=3D'%s'\n", line_buf);
> +
>      p =3D line_buf;
>      ch =3D *p++;
>      switch(ch) {
> @@ -1518,17 +1529,14 @@ static void gdb_read_byte(GDBState *s, int ch)
>          /* Waiting for a response to the last packet.  If we see the sta=
rt
>             of a new command then abandon the previous response.  */
>          if (ch =3D=3D '-') {
> -#ifdef DEBUG_GDB
> -            printf("Got NACK, retransmitting\n");
> -#endif
> +            gdb_debug("Got NACK, retransmitting\n");
>              put_buffer(s, (uint8_t *)s->last_packet, s->last_packet_len);
> +        } else if (ch =3D=3D '+') {
> +            gdb_debug("Got ACK\n");
> +        } else {
> +            gdb_debug("Got '%c' when expecting ACK/NACK\n", ch);
>          }
> -#ifdef DEBUG_GDB
> -        else if (ch =3D=3D '+')
> -            printf("Got ACK\n");
> -        else
> -            printf("Got '%c' when expecting ACK/NACK\n", ch);
> -#endif
> +
>          if (ch =3D=3D '+' || ch =3D=3D '$')
>              s->last_packet_len =3D 0;
>          if (ch !=3D '$')
> @@ -1549,9 +1557,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>                  s->line_sum =3D 0;
>                  s->state =3D RS_GETLINE;
>              } else {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub received garbage between packets: 0x%x\n=
", ch);
> -#endif
> +                gdb_debug("received garbage between packets: 0x%x\n", ch=
);
>              }
>              break;
>          case RS_GETLINE:
> @@ -1567,9 +1573,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>                  /* end of command, start of checksum*/
>                  s->state =3D RS_CHKSUM1;
>              } else if (s->line_buf_index >=3D sizeof(s->line_buf) - 1) {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub command buffer overrun, dropping command=
\n");
> -#endif
> +                gdb_debug("command buffer overrun, dropping command\n");
>                  s->state =3D RS_IDLE;
>              } else {
>                  /* unescaped command character */
> @@ -1583,9 +1587,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>                  s->state =3D RS_CHKSUM1;
>              } else if (s->line_buf_index >=3D sizeof(s->line_buf) - 1) {
>                  /* command buffer overrun */
> -#ifdef DEBUG_GDB
> -                printf("gdbstub command buffer overrun, dropping command=
\n");
> -#endif
> +                gdb_debug("command buffer overrun, dropping command\n");
>                  s->state =3D RS_IDLE;
>              } else {
>                  /* parse escaped character and leave escape state */
> @@ -1597,25 +1599,18 @@ static void gdb_read_byte(GDBState *s, int ch)
>          case RS_GETLINE_RLE:
>              if (ch < ' ') {
>                  /* invalid RLE count encoding */
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got invalid RLE count: 0x%x\n", ch);
> -#endif
> +                gdb_debug("got invalid RLE count: 0x%x\n", ch);
>                  s->state =3D RS_GETLINE;
>              } else {
>                  /* decode repeat length */
>                  int repeat =3D (unsigned char)ch - ' ' + 3;
>                  if (s->line_buf_index + repeat >=3D sizeof(s->line_buf) =
- 1) {
>                      /* that many repeats would overrun the command buffe=
r */
> -#ifdef DEBUG_GDB
> -                    printf("gdbstub command buffer overrun,"
> -                           " dropping command\n");
> -#endif
> +                    gdb_debug("command buffer overrun, dropping command\=
n");
>                      s->state =3D RS_IDLE;
>                  } else if (s->line_buf_index < 1) {
>                      /* got a repeat but we have nothing to repeat */
> -#ifdef DEBUG_GDB
> -                    printf("gdbstub got invalid RLE sequence\n");
> -#endif
> +                    gdb_debug("got invalid RLE sequence\n");
>                      s->state =3D RS_GETLINE;
>                  } else {
>                      /* repeat the last character */
> @@ -1630,9 +1625,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>          case RS_CHKSUM1:
>              /* get high hex digit of checksum */
>              if (!isxdigit(ch)) {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got invalid command checksum digit\n");
> -#endif
> +                gdb_debug("got invalid command checksum digit\n");
>                  s->state =3D RS_GETLINE;
>                  break;
>              }
> @@ -1643,21 +1636,17 @@ static void gdb_read_byte(GDBState *s, int ch)
>          case RS_CHKSUM2:
>              /* get low hex digit of checksum */
>              if (!isxdigit(ch)) {
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got invalid command checksum digit\n");
> -#endif
> +                gdb_debug("got invalid command checksum digit\n");
>                  s->state =3D RS_GETLINE;
>                  break;
>              }
>              s->line_csum |=3D fromhex(ch);
> =20
>              if (s->line_csum !=3D (s->line_sum & 0xff)) {
> +                gdb_debug("got command packet with incorrect checksum\n"=
);
>                  /* send NAK reply */
>                  reply =3D '-';
>                  put_buffer(s, &reply, 1);
> -#ifdef DEBUG_GDB
> -                printf("gdbstub got command packet with incorrect checks=
um\n");
> -#endif
>                  s->state =3D RS_IDLE;
>              } else {
>                  /* send ACK reply */


--Sig_/uB5.lNIzW0/6X26zfPlEYFg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlku5joACgkQAvw66wEB28LhdQCfSg6sYjDdjOblOE/925EP4cdR
Xc0AnApjXzEDEdwhfEylqYxSx16MHtHP
=4aQd
-----END PGP SIGNATURE-----

--Sig_/uB5.lNIzW0/6X26zfPlEYFg--
