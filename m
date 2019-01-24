Received: from eggs.gnu.org ([209.51.188.92]:43800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gmfx2-0003zS-0d
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gmfx0-0001J9-6x
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:25:51 -0500
Received: from sonic312-21.consmr.mail.ne1.yahoo.com ([66.163.191.202]:43190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gmfwy-0001GI-H8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:25:49 -0500
Date: Thu, 24 Jan 2019 14:25:41 +0000 (UTC)
From: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Message-ID: <633999897.454680.1548339941611@mail.yahoo.com>
MIME-Version: 1.0
References: <633999897.454680.1548339941611.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] gdb run / pause broken for some debuggers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>

Hi gdbstub maintainers (CC: Luc Michel as he wrote the patch that probably =
caused this issue)
I have found an issue with IDA Pro when moving to QEMU3.x where RUN/PAUSE h=
as stopped working.
I am pretty sure its to do with this debugger sending no thread-id with the=
 vCont packet action
That is that IDA Pro sends "vCont;c" (action=3Dc, thread-id=3Dnone).=C2=A0=
=C2=A0
This is defined in the RSP document=C2=A0as "An action with no=C2=A0thread-=
id=C2=A0matches all threads."
(https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#vCont-packe=
t=C2=A0)
In=C2=A0commit=C2=A0e40e5204af8388e605df2325d9b562c05919350e, which=C2=A0ad=
ded multiprocess support for vCont packets,=C2=A0the new code errors right =
away if it finds no ":" action\thread-id=C2=A0separator as shown below:
=C2=A0if (*p++ !=3D ':') {=C2=A0 =C2=A0 =C2=A0res =3D -ENOTSUP;...
The upper function calling gdb_handle_vcont when -EINVAL or -ERANGE will sp=
it out an "E22" error message, but for -ENOTSUP=C2=A0 we do goto-unknown_co=
mmand label results in IDA Pro thinking the gdbstub is dead.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D gdb_handle_vcont(s, p);=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((res =3D=3D -EINVAL) || (res =3D=3D =
-ERANGE)) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 put_packet(s, "E22");=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ... else goto unknown_command:
Maybe we should extend this to add a "-ENOTSUP" clause so the "E22" is also=
 returned?
This "unknown_command:" branch should probably send a "E nn" packet rather =
than just a blank "+" ack although here I do admit the spec is very unclear=
 but in most cases they do spec out "E nn" when some part of the command tu=
rns to garbage.=C2=A0
...=C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown_command:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* put empty packet */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0buf[0] =3D '\0';=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_packet(s, b=
uf);


If people more experienced in this agree I will go ahead and try at a patch=
 for both of these issues.
Cheers,Luc
