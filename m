Received: from eggs.gnu.org ([2001:4830:134:3::10]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g7GxB-00022K-BF
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g7Gx9-00045d-9K
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:26:53 -0400
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-11-luc.michel@greensocs.com>
	<c81c6345-df29-f7e9-77ea-2682d7e02585@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <84ef6d2d-a4a2-e140-3125-b8ae0e7d45b4@greensocs.com>
Date: Tue, 2 Oct 2018 11:26:28 +0200
MIME-Version: 1.0
In-Reply-To: <c81c6345-df29-f7e9-77ea-2682d7e02585@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/15] gdbstub: add support for extended
 mode packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org



On 10/1/18 6:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Luc,
>=20
> On 01/10/2018 13:56, Luc Michel wrote:
>> Add support for the '!' extended mode packet. This is required for the
>> multiprocess extension.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> ---
>>  gdbstub.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 299783b3b8..d372972dd3 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1280,10 +1280,13 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>>      trace_gdbstub_io_command(line_buf);
>> =20
>>      p =3D line_buf;
>>      ch =3D *p++;
>>      switch(ch) {
>> +    case '!':
>> +        put_packet(s, "OK");
>=20
> Don't we want to also support the 'R' packet?
Hi Philippe,

Thank you for all you reviews!

I'm not sure about this one:
  - do you think calling qemu_system_reset() is the right thing to do?
  - what should we do in user mode? Is there a way to restart the
emulated binary?
  - Looking at the GDB sources, GDB seems to send an 'R' packet on the
"run" command. It starts by a "vKill;pid" packet, then a "vRun". If
"vRun" is not supported by the remote, it falls back to "R". So it seems
that if we want to support "run", we must also implement "vKill;pid",
which probably doesn't make much sense for QEMU. One possible
implementation that would probably work for system mode would be to:
      - do nothing on 'vKill;pid' packet
      - do not implement the 'vRun' packet
      - call qemu_system_reset() on 'R' packet
But it does not align well with the current 'k' packet behaviour, which
simply do an exit(0). Do you have an opinion on this?

Thanks.

Luc.

>=20
>> +        break;
>>      case '?':
>>          /* TODO: Make this return the correct value for user-mode.  *=
/
>>          snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP=
,
>>                   gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thr=
ead_id)));
>>          put_packet(s, buf);
>>
