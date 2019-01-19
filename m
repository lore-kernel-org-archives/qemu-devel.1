Received: from eggs.gnu.org ([209.51.188.92]:45681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gkrxI-0003Fp-Io
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 09:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gkrxD-0000Z9-9d
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 09:50:38 -0500
Received: from greensocs.com ([193.104.36.180]:41703)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gkrx9-00008s-2C
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 09:50:32 -0500
References: <20190118112213.11173-1-philmd@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <867698a8-a20e-54a0-e9f2-9ab505876e9c@greensocs.com>
Date: Sat, 19 Jan 2019 15:50:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190118112213.11173-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H5nnptpp4fUZNMUaFmKsN2QFuUIROoFrx"
Subject: Re: [Qemu-devel] [RFC PATCH] gdbstub: Avoid NULL dereference in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H5nnptpp4fUZNMUaFmKsN2QFuUIROoFrx
From: Luc Michel <luc.michel@greensocs.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Message-ID: <867698a8-a20e-54a0-e9f2-9ab505876e9c@greensocs.com>
Subject: Re: [RFC PATCH] gdbstub: Avoid NULL dereference in
 gdb_handle_packet()
References: <20190118112213.11173-1-philmd@redhat.com>
In-Reply-To: <20190118112213.11173-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 12:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The "Hg" GDB packet is used to select the current thread, and can fail.=

> GDB doesn't not check for failure and emits further packets that can
> access and dereference s->c_cpu or s->g_cpu.
>=20
> Add a check that returns "E22" (EINVAL) when those pointers are not set=
=2E
>=20
> Peter Maydell reported:
>   GDB doesn't check the "Hg" packet failures and emit a
>   "qXfer:features:read" packet which accesses th
>   Looking at the protocol trace from the gdb end:
>   (gdb) set debug remote 1
>   (gdb) target remote :1234
>   Remote debugging using :1234
>   Sending packet:
>   $qSupported:multiprocess+;swbreak+;hwbreak+;qRelocInsn+;fork-events+;=
vfork-events+;exec-events+;vContSupported+;QThreadEvents+;no-resumed+;xml=
Registers=3Di386#6a...Ack
>   Packet received: PacketSize=3D1000;qXfer:features:read+;multiprocess+=

>   Packet qSupported (supported-packets) is supported
>   Sending packet: $vMustReplyEmpty#3a...Ack
>   Packet received:
>   Sending packet: $Hgp0.0#ad...Ack
>   Packet received: E22
>   Sending packet: $qXfer:features:read:target.xml:0,ffb#79...Ack
>   [here is where QEMU crashes]
>=20
>   What seems to happen is that GDB's attempt to set the
>   current thread with the "Hg" command fails because
>   gdb_get_cpu() fails, and so we return an E22 error status.
>   GDB (incorrectly) ignores this and issues a general command
>   anyway, and then QEMU crashes because we don't handle s->g_cpu
>   being NULL in this command's handling code.
>=20
> Fixes: c145eeae1cc
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because these are many if..break but I can't think of a cleaner way=

> today.
I can't think of a better way without an important refactoring of gdbstub=
=2Ec.

> The protocol isn't specific about the error, can it be "E03" for ESRCH
> (No such process)?
> ---
>  gdbstub.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index bfc7afb509..480005b094 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1306,6 +1306,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          put_packet(s, "OK");
>          break;
>      case '?':
> +        if (!s->c_cpu) {
> +            put_packet(s, "E22");
> +            break;
> +        }
>          /* TODO: Make this return the correct value for user-mode.  */=

>          snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,=

>                   gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thre=
ad_id)));
> @@ -1394,6 +1398,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          /* Detach packet */
>          pid =3D 1;
> =20
> +        if (!s->c_cpu || !s->g_cpu) {
> +            put_packet(s, "E22");
> +            break;
> +        }
Even though this is probably true (s->[gc]_cpu =3D=3D NULL probably means=

"no process attached"), the detach packet in itself carries the PID to
detach from. So I would go for a code hardening, something like:

         process =3D gdb_get_process(s, pid);
+        if (!process->attached) {
+            put_packet(s, "E22");
+            break;
+        }
         gdb_process_breakpoint_remove_all(s, process);
         process->attached =3D false;

-        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
+        if (s->c_cpu && pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
             s->c_cpu =3D gdb_first_attached_cpu(s);
         }

-        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
+        if (s->g_cpu && pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
             s->g_cpu =3D gdb_first_attached_cpu(s);
         }


>          if (s->multiprocess) {
>              unsigned long lpid;
>              if (*p !=3D ';') {
> @@ -1429,6 +1437,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          put_packet(s, "OK");
>          break;
>      case 's':
> +        if (!s->s_cpu) {
if (!s->c_cpu) {

> +            put_packet(s, "E22");
> +            break;
> +        }
>          if (*p !=3D '\0') {
>              addr =3D strtoull(p, (char **)&p, 16);
>              gdb_set_cpu_pc(s, addr);
> @@ -1441,6 +1453,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>              target_ulong ret;
>              target_ulong err;
> =20
> +            if (!s->s_cpu) {
if (!s->c_cpu) {

> +                put_packet(s, "E22");
> +                break;
> +            }
>              ret =3D strtoull(p, (char **)&p, 16);
>              if (*p =3D=3D ',') {
>                  p++;
> @@ -1463,6 +1479,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          }
>          break;
>      case 'g':
> +        if (!s->g_cpu) {
> +            put_packet(s, "E22");
> +            break;
> +        }
>          cpu_synchronize_state(s->g_cpu);
>          len =3D 0;
>          for (addr =3D 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
> @@ -1473,6 +1493,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          put_packet(s, buf);
>          break;
>      case 'G':
> +        if (!s->g_cpu) {
> +            put_packet(s, "E22");
> +            break;
> +        }
>          cpu_synchronize_state(s->g_cpu);
>          registers =3D mem_buf;
>          len =3D strlen(p) / 2;
> @@ -1485,6 +1509,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          put_packet(s, "OK");
>          break;
>      case 'm':
> +        if (!s->g_cpu) {
> +            put_packet(s, "E22");
> +            break;
> +        }
>          addr =3D strtoull(p, (char **)&p, 16);
>          if (*p =3D=3D ',')
>              p++;
> @@ -1504,6 +1532,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          }
>          break;
>      case 'M':
> +        if (!s->g_cpu) {
> +            put_packet(s, "E22");
> +            break;
> +        }
>          addr =3D strtoull(p, (char **)&p, 16);
>          if (*p =3D=3D ',')
>              p++;
> @@ -1642,6 +1674,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>              put_packet(s, "OK");
>              break;
>          } else if (strcmp(p,"C") =3D=3D 0) {
> +            if (!s->g_cpu) {
> +                put_packet(s, "E22");
> +                break;
> +            }
>              /*
>               * "Current thread" remains vague in the spec, so always r=
eturn
>               * the first thread of the current process (gdb returns th=
e
> @@ -1745,6 +1781,10 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>              const char *xml;
>              target_ulong total_len;
> =20
> +            if (!s->g_cpu) {
> +                put_packet(s, "E22");
> +                break;
> +            }
>              process =3D gdb_get_cpu_process(s, s->g_cpu);
>              cc =3D CPU_GET_CLASS(s->g_cpu);
>              if (cc->gdb_core_xml_file =3D=3D NULL) {
>=20

I think you are missing the check for 'p' and 'P' packets, and for the
qOffsets packet in user mode (around line 1701).

Thanks.

--=20
Luc


--H5nnptpp4fUZNMUaFmKsN2QFuUIROoFrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxDORgACgkQd8knW3Qn
Tr5bBg//WWvmMoEMx6Q/FZ9Xex0BZngDxkM20pqPWzvTw8dZvz61lXQFLenB5tHk
vHOCDCJ0oIFI1sgLErJfe5nA1y2cTTSoiEKrpndC65y1qM5bE12SGIaOj/9OgOll
cg0mCih/llyT5PAANdj/30ffk8N5Z3hKjRpVvj4XKCq41vUQ0dgdOV9GdpxiglSv
nWK77r8W/TEVvlE/L1dS2hkZsCPJxoQyIhwxYxTbGGwjskHY0JmkBaN5Lih40rPu
2UoR3yStzpVX2H5wyTdgjBfzoTT9mfc45m6/eM4WrPv6IY7vfsjW+RfK+ehS2Zf/
xguIL4xVtsYJfcA7wIPSnMRF8HGlALcc3i+sUcfSwIJi0gVKdYizFSpC6ti9rHmA
1+uvFrRMVQSwFATGqdTYKPlmv8w/GsmTD/kBCvVdHLLHJYOtHFbpXBpH/q68TBU4
S6ud5JbfnoE5F0qeKLd3D4sVt/Og+eNUoLTxDxXs3pG+fmEWCTBVkQY3JmYsWORB
dUTM53l5PxaSWiCdFDWtVCJT44Q2a3usUJhQp7NwSx5mbM+/NXe8odeuUUPAafb1
5GE6MuNrfmWJEBNhRc/WlTfAnbIVQgqwzmvFld7LineBJe7l7qh+tcADEgcw5p2R
zC/XqA7D2kkzsWnZtaKoymMCyMtEO+/Twcn6uOy+RV7occeYrdE=
=LVNl
-----END PGP SIGNATURE-----

--H5nnptpp4fUZNMUaFmKsN2QFuUIROoFrx--
