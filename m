Received: from eggs.gnu.org ([209.51.188.92]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpBv7-0004HD-83
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpBv6-0002vJ-7A
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:58:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gpBv5-0002v6-VK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:58:16 -0500
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d8360c7-436f-3cfc-8b69-d63ca11cf1a2@redhat.com>
Date: Thu, 31 Jan 2019 06:58:12 -0600
MIME-Version: 1.0
In-Reply-To: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GU5I0QnLI9Tq6bZyLDeXt77jRqc9vjZ78"
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GU5I0QnLI9Tq6bZyLDeXt77jRqc9vjZ78
From: Eric Blake <eblake@redhat.com>
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>
Message-ID: <6d8360c7-436f-3cfc-8b69-d63ca11cf1a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
In-Reply-To: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 10:48 PM, Lucien Murray-Pitts wrote:
> The result is that vCont now does not recognise the case where no proce=
ss/thread is provided after the action.

Thanks for re-sending; this one came through a lot nicer!  Welcome to
the community; while a first submission can always be a bit daunting,
the maintainers generally will help fix things up as you refine your
process for making future submissions run more smoothly.

My next suggestion: wrap your commit message body around 65-70 columns,
rather than using long lines. While it may sound archaic, many
developers still use 80-column terminals, and 'git log' adds
indentation; long lines become difficult to read if you don't manually
wrap them.

>=20
> This may not show up with GDB, but using Lauterbach Trace32, and Hexray=
s IDA Pro this issue is immediately seen.
> The response is a "$#00" empty packet, showing it is unsupported packet=
=2E
>=20
> This is defined in the RSP document as "An action with no thread-id mat=
ches all threads."
> (https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#vCont-p=
acket )
>=20
> Thus the valid vCont packets now are as below, however parsing is still=
 not very strict.
>   vCont;c/s                 - Step/Continue all threads
>   vCont;c/s:[pX.]Y          - Step/Continue optional process X, thread =
Y
>   vCont;C##/S##:[pX.]Y      - Step/Continue with signal ## on optional =
process X, thread Y
>   * If X or Y are -1 then it applies the action to all processes/thread=
s.
>=20
> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
> ---
>  gdbstub.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

I'll let someone more familiar with gdbstub review the actual patch
content for correctness, but I'll do a quick pass for style:

>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index bfc7afb509..ce0dde2e24 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1169,6 +1169,7 @@ static int is_query_packet(const char *p, const c=
har *query, char separator)
>   */
>  static int gdb_handle_vcont(GDBState *s, const char *p)
>  {
> +    GDBThreadIdKind vcontThreadType ;

No space before ;

>      int res, signal =3D 0;
>      char cur_action;
>      char *newstates;
> @@ -1218,12 +1219,23 @@ static int gdb_handle_vcont(GDBState *s, const =
char *p)
>              goto out;
>          }
> =20
> -        if (*p++ !=3D ':') {
> +        /*
> +         * In the case we have vCont;c or vCont;s - action is on all t=
hreads

Grammar suggestion: s/In the case/When/, and use a trailing '.' to end
the sentence.

> +         * Alternatively vCont;c;s:p1.1 is a possible, but meaningless=
 format,
> +         * And in the else the "vCont;c:p1.1;... format is supported.

s/And in the else/otherwise/

> +         */
> +        if (*p =3D=3D '\0' || *p =3D=3D ';') {
> +            vcontThreadType =3D GDB_ALL_THREADS ;
> +            pid =3D 1 ;
> +            tid =3D 1 ;

Again, no space before ;

> +        } else if (*p++ =3D=3D ':') {
> +            vcontThreadType =3D read_thread_id(p, &p, &pid, &tid) ;
> +        } else {
>              res =3D -ENOTSUP;
>              goto out;
>          }
> =20
> -        switch (read_thread_id(p, &p, &pid, &tid)) {
> +        switch (vcontThreadType) {
>          case GDB_READ_THREAD_ERR:
>              res =3D -EINVAL;
>              goto out;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GU5I0QnLI9Tq6bZyLDeXt77jRqc9vjZ78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxS8OUACgkQp6FrSiUn
Q2rgswf9H+74r7orJqiPulyQUpwdKczf3UcPvuBXUirHYS792sHfZzpP5ILa/myD
2Auv97fgqVI8xn834Iyzvce7zWbNpMQpVMCUjD6ojMVMgjr/rEs4dMmvEPyXoSHA
lhYRul+xXId5MpnB4s2a5R1tTy8s6UaqK5QsjLQCp+iZSbLcx8rD60BB5lE3BMNR
fXDlpZA4hRxlXmRnQhAK/M4uGCC+5cPWU2h7P4LxXRuYKR9j1+5vZ10BR0Q9btKl
f36gRkRwDQSjS7kLpKXNMYDtIlLoCyCO1x76ZwfxLlX74yLsK1Y26h6LYJo7zWR3
vUmgEgp5cEttFTWSxkicEjyyKF1VHA==
=GaEO
-----END PGP SIGNATURE-----

--GU5I0QnLI9Tq6bZyLDeXt77jRqc9vjZ78--
