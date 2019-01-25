Received: from eggs.gnu.org ([209.51.188.92]:50681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gmzMo-0003BC-Cg
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gmzMf-0004RV-TJ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:09:41 -0500
Received: from greensocs.com ([193.104.36.180]:34956)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gmzMX-0004N5-Th
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:09:33 -0500
References: <633999897.454680.1548339941611.ref@mail.yahoo.com>
	<633999897.454680.1548339941611@mail.yahoo.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <4a7775a2-c2ba-5c49-53e2-761915ae7766@greensocs.com>
Date: Fri, 25 Jan 2019 12:09:13 +0100
MIME-Version: 1.0
In-Reply-To: <633999897.454680.1548339941611@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lO5KYQ5gs7LwHgHrTTuRrGkuq0E6YKzkM"
Subject: Re: [Qemu-devel] gdb run / pause broken for some debuggers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lO5KYQ5gs7LwHgHrTTuRrGkuq0E6YKzkM
From: Luc Michel <luc.michel@greensocs.com>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <4a7775a2-c2ba-5c49-53e2-761915ae7766@greensocs.com>
Subject: Re: gdb run / pause broken for some debuggers
References: <633999897.454680.1548339941611.ref@mail.yahoo.com>
 <633999897.454680.1548339941611@mail.yahoo.com>
In-Reply-To: <633999897.454680.1548339941611@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 1/24/19 3:25 PM, Lucien Anti-Spam wrote:
> Hi gdbstub maintainers (CC: Luc Michel as he wrote the patch that
> probably caused this issue)
>=20
> I have found an issue with IDA Pro when moving to QEMU3.x where
> RUN/PAUSE has stopped working.
>=20
> I am pretty sure its to do with this debugger sending no thread-id with=

> the vCont packet action
> That is that IDA Pro sends "vCont;c" (action=3Dc, thread-id=3Dnone).=C2=
=A0=C2=A0
>=20
> This is defined in the RSP document=C2=A0as "An action with
> no=C2=A0thread-id=C2=A0matches all threads."
> (https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#vCont-p=
acket=C2=A0)
>=20
> In=C2=A0commit=C2=A0e40e5204af8388e605df2325d9b562c05919350e, which=C2=A0=
added
> multiprocess support for vCont packets,=C2=A0the new code errors right =
away
> if it finds no ":" action\thread-id=C2=A0separator as shown below:
>=20
> =C2=A0if (*p++ !=3D ':') {
> =C2=A0 =C2=A0 =C2=A0res =3D -ENOTSUP;
> ...
Yes, I think you are right, we should fall into the GDB_ALL_PROCESSES
case here.

>=20
> The upper function calling gdb_handle_vcont when -EINVAL or -ERANGE wil=
l
> spit out an "E22" error message, but for -ENOTSUP=C2=A0 we do
> goto-unknown_command label results in IDA Pro thinking the gdbstub is d=
ead.
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D gdb_handle_vcont(s, p=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((res =3D=3D=
 -EINVAL) || (res =3D=3D -ERANGE)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
ut_packet(s, "E22");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... else goto u=
nknown_command:
>=20
> Maybe we should extend this to add a "-ENOTSUP" clause so the "E22" is
> also returned?
>=20
> This "unknown_command:" branch should probably send a "E nn" packet
> rather than just a blank "+" ack although here I do admit the spec is
> very unclear but in most cases they do spec out "E nn" when some part o=
f
> the command turns to garbage.=C2=A0
>=20
> ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown_command:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* put empty packet */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[0] =3D '\0';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_packet(s, buf);

=46rom the spec:

"For any command not supported by the stub, an empty response (=E2=80=98$=
#00=E2=80=99)
should be returned. That way it is possible to extend the protocol. A
newer GDB can tell if a packet is supported based on that response."

And looking into gdbserver GDB sources, they do the same thing:

    default:
      /* It is a request we don't understand.  Respond with an empty
	 packet so that gdb knows that we don't support this
	 request.  */
      own_buf[0] =3D '\0';

So this is probably IDA here which does not correctly handle this "not
supported" response (which should not happen anyway).

Cheers,
Luc

>=20
>=20
>=20
> If people more experienced in this agree I will go ahead and try at a
> patch for both of these issues.
>=20
> Cheers,
> Luc
>=20
>=20


--lO5KYQ5gs7LwHgHrTTuRrGkuq0E6YKzkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxK7loACgkQd8knW3Qn
Tr5SGQ//TdVB7rrK9oCbk+25Oa8Vo/NLBRoyK64m4yHigkR6pIV6cFKO2G3fkP+G
MT1i0LU0K8eAu4ED/3qFzodh/2s1pLFNEHFvBbTJzHlKUpIbw3rdwVu46HHOfX3p
qG4sju9n5vwj55EDqVPeaMBJY85TOWVeh0cXFcujYTcVIMZXw+Uh0LhiLbxGw/Ry
PQmcM67qhePkibC/OvkPLSr3X977XsRWKAhT5Thp3WIo+MUxcbscnZLW4cOYYohi
HrF5nrFkho9pkXIT/WA17K926RUtd9ITLDK/oDN1ixyfN2govLieNGiVJ7gOubUp
DeQkVQJvcIw6r7HtadlM14kea0//r1miB4jlTyBTw4fcdY0+gHDhpVpbMwglXOvH
ylhyhwaPaanCrf/v4QmLrYMUDZ99yceIx2R8I5rWhYBDSYPnCdaRnf8nPRdYFaXg
tByAboxWcPbnmU+DZedImdP+jUrXnaJ4k9P0qZM1C3UiMKfLivTRyPmPuXD2V6gZ
PzlwmDpqrpSvWSod59SxhZYwQfqVVUKtgCFMUVSd2ad41c/qBN8KRskiprbFzYg5
/KLYIgFHHzbWytuxvo2c0L6Kl4SjdZKgIQp5kSsgIr2LoIVTkHvNgv9AArDlzAVI
R58f5XnWo79AWxOx1xk6fmw85lX2NbUrnZsQTLuCc4lcl/sLjKw=
=GGiZ
-----END PGP SIGNATURE-----

--lO5KYQ5gs7LwHgHrTTuRrGkuq0E6YKzkM--
