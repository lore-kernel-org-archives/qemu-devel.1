Received: from eggs.gnu.org ([209.51.188.92]:33768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gorIT-0005RU-0i
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gorIR-00082G-QZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:57:00 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:54976
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1gorIR-000814-Gb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:56:59 -0500
References: <20190129203219.6473-1-jcmvbkbc@gmail.com>
	<cfc9fee5-9f8b-2fb2-d58e-f8e08f5a0a52@adacore.com>
	<d7469a28-716d-5054-cba6-fc3a3001ea6c@greensocs.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <8577ec49-8503-313d-47a0-531163a3e490@adacore.com>
Date: Wed, 30 Jan 2019 15:56:54 +0100
MIME-Version: 1.0
In-Reply-To: <d7469a28-716d-5054-cba6-fc3a3001ea6c@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>



Le 1/30/19 =C3=A0 3:31 PM, Luc Michel a =C3=A9crit=C2=A0:
> Hi,
>=20
> On 1/30/19 2:37 PM, KONRAD Frederic wrote:
>> Hi,
>>
>> Le 1/29/19 =C3=A0 9:32 PM, Max Filippov a =C3=A9crit=C2=A0:
>>> With multiprocess extensions gdb uses 'vKill' packet instead of 'k' t=
o
>>> kill the inferior. Handle 'vKill' the same way 'k' was handled in the
>>> presence of single process.
>>>
>>> Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
>>> (f|s)ThreadInfo and ThreadExtraInfo")
> Thanks for the patch.
>=20
>>>
>>> Cc: Luc Michel <luc.michel@greensocs.com>
>>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>>> ---
>>>  =C2=A0 gdbstub.c | 22 ++++++++++++++++++++++
>>>  =C2=A0 1 file changed, 22 insertions(+)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index bfc7afb50968..1ef31240c055 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -1383,6 +1383,28 @@ static int gdb_handle_packet(GDBState *s, cons=
t
>>> char *line_buf)
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 put_packet(s, buf);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strncmp(p, "Ki=
ll;", 5) =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned long pid;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
 +=3D 5;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (qemu_strtoul(p, &p, 16, &pid)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 put_packet(s, "E22");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rocess =3D gdb_get_process(s, pid);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (process =3D=3D NULL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 put_packet(s, "E22");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (s->process_num <=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Kill the target */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("QEMU: Terminated via GDBstub");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exit(0);
>>
>> I suggest:
>>
>> #ifdef CONFIG_USER_ONLY
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(0);
>> #else
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_system_shutdown_reque=
st(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> You are missing a `break;' here.
>=20
> Regarding the cause, I think it's more an 'host' cause than a 'guest' o=
ne.
>> #endif
>>
>> instead of exit(0);
> I just tested, this is not ideal in the current shape. Not quitting
> immediately makes the stub sends a "W00" packet. It's better if we send
> nothing because GDB interprets that as the connection was closed (which
> is effectively the case). Otherwise in multiprocess mode, GDB thinks th=
e
> other processes are still alive (see below).
>=20
> with exit(0):
> (gdb) k
> Kill the program being debugged? (y or n) y
> Sending packet: $vKill;1#6e...Ack
> Remote connection closed
>=20
> with qemu_system_shutdown_request:
> (gdb) k
> Kill the program being debugged? (y or n) y
> Sending packet: $vKill;1#6e...Ack
> Packet received: W00
> Packet vKill (kill) is supported
> [Inferior 1 (process 1) killed]

Ok makes sense. I didn't think of that.

>=20
> So maybe a solution (for another patch) would be to send a 'W' packet
> for each attached process (using the multiprocess format). Another is t=
o
> prevent 'W' packets to be sent at all... they are not required in this =
case.
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* TODO: handle multiprocess case */
> About the multiprocess case, I would vote to adopt the same behaviour
> (i.e. terminate QEMU), whatever the PID is or how many processes are
> attached. Otherwise we would have different behaviour for the GDB `kill=
`
> command, whether the simulated board exposes multiple processes or not.
> Moreover, I think considering just one PID for a kill command does not
> make much sense in our case.
>=20
> I just tested, GDB is fine with QEMU closing the connection when having
> multiple processes attached if we do exit(0) directly (i.e. do not send
> a 'W00' packet).

Yes I see the same behavior with Linux but it makes GDB crashes with MinG=
W
at least before this patch and the multiprocess one (eg: v3.0.0).

I'll wait for this patch to land and send some trace if I can still repro=
duce.

Cheers,
Fred

>=20
> Thanks.
>=20
> Luc
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto unknown_command;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto unknown_command;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>=20
