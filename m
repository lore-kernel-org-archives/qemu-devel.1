Received: from eggs.gnu.org ([209.51.188.92]:45163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gpYwl-0003VT-Si
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gpYwd-00074b-KA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:33:25 -0500
Received: from greensocs.com ([193.104.36.180]:57275)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gpYwZ-00073C-DV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:33:20 -0500
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <622bb639-5ab5-d427-e84f-bc3ef85c83da@greensocs.com>
Date: Fri, 1 Feb 2019 14:33:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PGjdZpCHU03h8AxaZtPyN8cyHjIOYg1nR"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PGjdZpCHU03h8AxaZtPyN8cyHjIOYg1nR
From: Luc Michel <luc.michel@greensocs.com>
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
Message-ID: <622bb639-5ab5-d427-e84f-bc3ef85c83da@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
In-Reply-To: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lucien,

On 1/31/19 5:48 AM, Lucien Murray-Pitts wrote:
> The result is that vCont now does not recognise the case where no proce=
ss/thread is provided after the action.
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
The coding style for variable names is lower_case_with_underscores (see
CODING_STYLE). I think you can go with a simpler name like
GDBThreadIdKind kind;

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
> +         * Alternatively vCont;c;s:p1.1 is a possible, but meaningless=
 format,
> +         * And in the else the "vCont;c:p1.1;... format is supported.
> +         */> +        if (*p =3D=3D '\0' || *p =3D=3D ';') {
> +            vcontThreadType =3D GDB_ALL_THREAD ;> +            pid =3D=
 1 ;
The spec is not clear but I would opt for GDB_ALL_PROCESSES instead of
GDB_ALL_THREAD here. pid =3D 1; is clearly wrong since you don't know if
this PID exists or is currently attached.

> +            tid =3D 1 ;
This one is not useful either (not used in the switch..case bellow).

Thanks

Luc

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


--PGjdZpCHU03h8AxaZtPyN8cyHjIOYg1nR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxUSpYACgkQd8knW3Qn
Tr4J8hAAgiWobIJiGGCj9hrcGRnK9fvLVZdK4z88dqHYjl7pCLAl2H3ekqT9aw0f
WeKSh/yETONn6LuP5vmhE1OmMxmHhNGSVLD1Tzd/Jh+FYc1uNMrXAVe8J0gdZfGs
MsB5N0H7GUpoiNVIe3ZRv5/R/m8K4u3rfRbJzKksXXiy7rVZAQPOd1xBheZq5fhC
GZw8vYP9BtAi2NsDxmR3aiSgWbQhX3JM2LUHzTXs4HwLXbg7MM2rKp6CwN2B0kTG
vUQgv/IUxcpd6xzV+s3MgQrUwGHdpQ6s02mcSm0r56YbwFR3LdDQ8kG3uOCeDKnZ
RmISRNobzh8NJcEFMib7iizle/WtqghNuwzwovzRVkut5XQEYRUuqzhMrtRacNc4
IKUoUqplH+AsI157F7msSArwcSsj+iwW3fuAF97eg2mc8qYuaX0xkucl5xQ/+7IB
j4oQiuRPN/a6kFw2S5XgMvFENCh3GZOGaqCgVqQKWmtHY3qUCqysZGUN7FMvfRPc
eGVgEME2LVpnBDFq7jyaoSyz3IjzFKXaS3bEdtpuGOrLwcPujp/BYL9BKrSvIl/G
fqjSa8WRVnAc2gAnqL+X95gY3Vp0ajub3gTx19pOnZ3U5Z6t//22vACAKQI7rcXB
dq+w4ukPUu8jKZGnBMA9KB5m/T6JN4oPW6QgbUSdvRkcdqSlSrc=
=Hbp6
-----END PGP SIGNATURE-----

--PGjdZpCHU03h8AxaZtPyN8cyHjIOYg1nR--
