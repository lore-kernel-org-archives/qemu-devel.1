Received: from eggs.gnu.org ([209.51.188.92]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp3KT-0006Hs-2S
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp3KP-0004oV-2o
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:47:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gp3KM-0004Wx-Vc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:47:48 -0500
References: <1814910652.595504.1548895281698.ref@mail.yahoo.com>
	<1814910652.595504.1548895281698@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abb3cb89-447e-019d-568e-77cf8f8a4968@redhat.com>
Date: Wed, 30 Jan 2019 21:47:19 -0600
MIME-Version: 1.0
In-Reply-To: <1814910652.595504.1548895281698@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XPBfZNeRejJn45l6lKU5IWRbzpKSwsedj"
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XPBfZNeRejJn45l6lKU5IWRbzpKSwsedj
From: Eric Blake <eblake@redhat.com>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
Message-ID: <abb3cb89-447e-019d-568e-77cf8f8a4968@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
References: <1814910652.595504.1548895281698.ref@mail.yahoo.com>
 <1814910652.595504.1548895281698@mail.yahoo.com>
In-Reply-To: <1814910652.595504.1548895281698@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 6:41 PM, Lucien Anti-Spam via Qemu-devel wrote:
> This fixes a regression in rsp packet vCont due to recently added multi=
process support. (Short commit hash: e40e520).
>=20

Your mailer completely botched the message (wrong line endings?)  Can
you please resend, preferably using git send-email, or at a minimum
attaching git format-patch output rather than inline pasting, so that we
stand a chance of seeing what you actually intended?

> The result is that vCont now does not recognise the case where no proce=
ss/thread is provided after the action.
> This may not show up with GDB, but using Lauterbach Trace32, and Hexray=
s IDA Pro this issue is immediately seen.The response is a "$#00" empty p=
acket, showing it is unsupported packet.
> This is defined in the RSP document as "An action with no thread-id mat=
ches all threads."(https://sourceware.org/gdb/current/onlinedocs/gdb/Pack=
ets.html#vCont-packet )
> Thus the valid vCont packets now are as below, however parsing is still=
 not very strict.=C2=A0 vCont;c/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0- Step/Continue all threads=C2=A0 vCont;c/s:[pX.]Y=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Step/Continue optional process X, threa=
d Y=C2=A0 vCont;C##/S##:[pX.]Y=C2=A0 =C2=A0 =C2=A0 - Step/Continue with s=
ignal ## on optional process X, thread Y=C2=A0 * If X or Y are -1 then it=
 applies the action to all processes/threads.
> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>---=C2=A0=
gdbstub.c | 16 ++++++++++++++--=C2=A01 file changed, 14 insertions(+), 2 =
deletions(-)
> diff --git a/gdbstub.c b/gdbstub.cindex bfc7afb509..ce0dde2e24 100644--=
- a/gdbstub.c+++ b/gdbstub.c@@ -1169,6 +1169,7 @@ static int is_query_pac=
ket(const char *p, const char *query, char separator)=C2=A0 */=C2=A0stati=
c int gdb_handle_vcont(GDBState *s, const char *p)=C2=A0{+=C2=A0 =C2=A0 G=
DBThreadIdKind vcontThreadType ;=C2=A0 =C2=A0 =C2=A0int res, signal =3D 0=
;=C2=A0 =C2=A0 =C2=A0char cur_action;=C2=A0 =C2=A0 =C2=A0char *newstates;=
@@ -1218,12 +1219,23 @@ static int gdb_handle_vcont(GDBState *s, const ch=
ar *p)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*p++ !=3D=
 ':') {+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
* In the case we have vCont;c or vCont;s - action is on all threads+=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Alternatively vCont;c;s:p1.1 is a possible,=
 but meaningless format,+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* And in the e=
lse the "vCont;c:p1.1;... format is supported.+=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*/+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*p =3D=3D '\0' || *p =3D=3D ';'=
) {+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcontThreadType =3D GDB_ALL=
_THREADS ;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D 1 ;+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tid =3D 1 ;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
 else if (*p++ =3D=3D ':') {+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc=
ontThreadType =3D read_thread_id(p, &p, &pid, &tid) ;+=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D -=
ENOTSUP;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (read_=
thread_id(p, &p, &pid, &tid)) {+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (vcont=
ThreadType) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case GDB_READ_THREAD_ERR:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D -EINVAL;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;--=C2=A02.17.2
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XPBfZNeRejJn45l6lKU5IWRbzpKSwsedj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxSb8cACgkQp6FrSiUn
Q2rwSQgApH9M0y/SWYvsJD7spDw2h/E19w0oXoKiDjLf2HDrd0Y1dAhvPHSlPsza
W5HWjUMaDRUGM1zSLikoIQV9vpYntnIcVN/GQFB7rwGFZqei2ACTr6qVfLEdZXzo
uFJuY0u1P2iXOhfem5mEyAuClcSXTO46dxnJBSJ8Hwz3zN998vPnJwMLxPICr4nE
6xME5RX1t8b8hB79bXm3ak2SPb8Po14jUXlBdNEXJJUlBlOJ49RI+J2fY+HNy9lD
8+1C8N3KOnJBdKZNmBhNqegBnTvNhCGbon78RYjMrGuI2GAx3D/g5v3tGZvD+ddr
iaS+W5HZgDpx0z8aR75uJ2xGVLCoVA==
=9Nrg
-----END PGP SIGNATURE-----

--XPBfZNeRejJn45l6lKU5IWRbzpKSwsedj--
