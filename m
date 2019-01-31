Received: from eggs.gnu.org ([209.51.188.92]:34872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gp0TM-0004eS-5A
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gp0TK-0006Tx-Vi
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:44:52 -0500
Received: from sonic314-21.consmr.mail.ne1.yahoo.com ([66.163.189.147]:40244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gp0TK-0006TS-Oj
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:44:50 -0500
Date: Thu, 31 Jan 2019 00:41:21 +0000 (UTC)
From: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Message-ID: <1814910652.595504.1548895281698@mail.yahoo.com>
MIME-Version: 1.0
References: <1814910652.595504.1548895281698.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This fixes a regression in rsp packet vCont due to recently added multiproc=
ess support. (Short commit hash: e40e520).

The result is that vCont now does not recognise the case where no process/t=
hread is provided after the action.
This may not show up with GDB, but using Lauterbach Trace32, and Hexrays ID=
A Pro this issue is immediately seen.The response is a "$#00" empty packet,=
 showing it is unsupported packet.
This is defined in the RSP document as "An action with no thread-id matches=
 all threads."(https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.ht=
ml#vCont-packet )
Thus the valid vCont packets now are as below, however parsing is still not=
 very strict.=C2=A0 vCont;c/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0- Step/Continue all threads=C2=A0 vCont;c/s:[pX.]Y=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Step/Continue optional process X, thread Y=C2=
=A0 vCont;C##/S##:[pX.]Y=C2=A0 =C2=A0 =C2=A0 - Step/Continue with signal ##=
 on optional process X, thread Y=C2=A0 * If X or Y are -1 then it applies t=
he action to all processes/threads.
Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>---=C2=A0gd=
bstub.c | 16 ++++++++++++++--=C2=A01 file changed, 14 insertions(+), 2 dele=
tions(-)
diff --git a/gdbstub.c b/gdbstub.cindex bfc7afb509..ce0dde2e24 100644--- a/=
gdbstub.c+++ b/gdbstub.c@@ -1169,6 +1169,7 @@ static int is_query_packet(co=
nst char *p, const char *query, char separator)=C2=A0 */=C2=A0static int gd=
b_handle_vcont(GDBState *s, const char *p)=C2=A0{+=C2=A0 =C2=A0 GDBThreadId=
Kind vcontThreadType ;=C2=A0 =C2=A0 =C2=A0int res, signal =3D 0;=C2=A0 =C2=
=A0 =C2=A0char cur_action;=C2=A0 =C2=A0 =C2=A0char *newstates;@@ -1218,12 +=
1219,23 @@ static int gdb_handle_vcont(GDBState *s, const char *p)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}=C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*p++ !=3D ':') {+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /*+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In the case we =
have vCont;c or vCont;s - action is on all threads+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* Alternatively vCont;c;s:p1.1 is a possible, but meaningless for=
mat,+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* And in the else the "vCont;c:p1.1;=
... format is supported.+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/+=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (*p =3D=3D '\0' || *p =3D=3D ';') {+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 vcontThreadType =3D GDB_ALL_THREADS ;+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D 1 ;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tid =3D 1 ;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*p++ =3D=3D ':') =
{+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcontThreadType =3D read_thread=
_id(p, &p, &pid, &tid) ;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D -ENOTSUP;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto out;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (read_thread_id(p, &p, &pid, &tid)) {+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (vcontThreadType) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0case GDB_READ_THREAD_ERR:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0res =3D -EINVAL;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto out;--=C2=A02.17.2
