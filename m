Received: from eggs.gnu.org ([2001:4830:134:3::10]:42910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKo7j-00022s-Bn
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKo7O-00016u-FQ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:25:11 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:46743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eKo7O-00015R-6C
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:24:50 -0500
Received: by mail-wr0-x22a.google.com with SMTP id x49so10673509wrb.13
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 08:24:50 -0800 (PST)
Date: Fri, 1 Dec 2017 11:02:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201110231.GJ23501@stefanha-x1.localdomain>
References: <20171127042815.30725-1-doug16k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <20171127042815.30725-1-doug16k@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] gdbstub: add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel@nongnu.org


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 11:28:15PM -0500, Doug Gale wrote:
> -static int put_packet_binary(GDBState *s, const char *buf, int len)
> +static int put_packet_binary(GDBState *s, const char *buf, int len, bool=
 dump)
>  {
>      int csum, i;
>      uint8_t *p;
> =20
> +    if (TRACE_GDBSTUB_IO_BINARYREPLY_ENABLED && dump)

TRACE_GDBSTUB_IO_BINARYREPLY_ENABLED is a compile-time constant.  To
avoid the overhead when the trace event is compiled in but disabled at
runtime, use:

  if (trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY) && dump)

> +        hexdump(buf, len, trace_gdbstub_io_binaryreply);

Please run scripts/checkpatch.pl before sending patches.  I find it
easiest to use a git hook that automatically scans commits that I make:
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html

QEMU coding style always uses curly braces even when the if statement
body is only one line:

  if (TRACE_GDBSTUB_IO_BINARYREPLY_ENABLED && dump) {
      hexdump(buf, len, trace_gdbstub_io_binaryreply);
  }

> +# gdbstub.c
> +gdbstub_op_start(char const *device) "Starting gdbstub using device %s"
> +gdbstub_op_exiting(uint8_t code) "notifying exit with code=3D0x%02x"
> +gdbstub_op_hit_watchpoint(char const *type, int cpu_gdb_index, uint64_t =
vaddr) "Watchpoint hit, type=3D\"%s\" cpu=3D%d, vaddr=3D0x%" PRIx64 ""
> +gdbstub_op_hit_internal_error(void) "RUN_STATE_INTERNAL_ERROR"
> +gdbstub_op_hit_shutdown(void) "RUN_STATE_SHUTDOWN"
> +gdbstub_op_hit_unknown(int state) "Unknown run state=3D0x%x"
> +gdbstub_op_extra_info(char const *info) "Thread extra info: %s"
> +gdbstub_io_reply(char const *message) "Sent: %s"
> +gdbstub_io_binaryreply(size_t ofs, char const *line) "0x%04zx: %s"
> +gdbstub_io_command(char const *command) "Received: %s"
> +gdbstub_err_got_nack(void) "Got NACK, retransmitting"
> +gdbstub_io_got_ack(void) "Got ACK"
> +gdbstub_io_got_unexpected(char ch) "Got '%c' when expecting ACK/NACK"

Please use 0x%02x instead of %c to prevent misleading/corrupt output
when the input contains control characters.

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaITbHAAoJEJykq7OBq3PI4FUIAMFx1FMsFnlPGcL/2Tmm5Q5+
RZwMhvbJp2utfWWzYv8UmuIyfoPsefBzAlMun7GJn41cS8u+xAZCnhKZnGPKrwXp
F8+nSZ0kJT1N7F28CUCBRKYKkr9aGXsyNw2q6j+3yXm1RqLEgldn2a/6UqHTgb0P
UTaBcD+fqxtisaPd5G7ArWt2ZO/emw6Ax+DA48A+aGhLt3cQaSkROMO3DKj7SoRW
GTukDaz9u/0KRHBDVg+YZs+7HYtaaz1TKjAIW7DmPKMH5Tuu9N8aomrEJgQ42Old
4nTuieY8XbmOIUolwXBya30QQ5TLDi22DmVlo+9BiPYGnNuexxyhXyh6N3Atrvc=
=/iWH
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
