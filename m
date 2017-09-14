Received: from eggs.gnu.org ([2001:4830:134:3::10]:44586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsUW5-0005DZ-LO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsUW0-0006x5-Pc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:49:17 -0400
Received: from bran.ispras.ru ([83.149.199.196]:39214 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsUW0-0006s2-IZ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:49:12 -0400
Message-ID: <59BA88D1.9080202@ispras.ru>
Date: Thu, 14 Sep 2017 16:49:05 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
	<0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
In-Reply-To: <0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


On 13.09.2017 17:20, Yongbok Kim wrote:
> (Especially while implementing new instructions), I tended to add coupl=
e of
> helper functions for tracing temporally.
>
> op_helper.c:
> void helper_trace_reg_access(CPUMIPSState *env, target_ulong val)
> {
>      printf("reg =3D "TARGET_FMT_lx"\n", val);
> }
>
> helper.h:
> DEF_HELPER_2(trace_reg_access, void, env, tl)
>
> After this you could use the helper function where you want to trace th=
e
> register value.
> For your case, you can add following line after the tcg_gen_mov_tl().
> gen_helper_trace_reg_access(cpu_env, cpu_gpr[rs]);
>
> You will get the printf every time the part of code is being executed
> (which might be too often).
>
> Regards,
> Yongbok

Thanks, Yongbok!

I've implemented the code you've written. Now I receive values are=20
written into MIPS registers.

Could you explain some aspects about the code you propose?

First, what is the helper function itself? Peter said that it is=20
impossible to get the value that is written to MIPS register at=20
"translation time", but in "run time" there is no mapping between x86=20
and "virtual MIPS" registers. So how it is possible to get these values?:=
-)

Second, I need to make a final modification of helper function. I need=20
to print both "val" that is written to GPR register and the number "num"=20
of the register. I wrote the following:

op_helper.c:
void helper_trace_reg_access(CPUMIPSState *env, int reg, target_ulong val=
)
{
qemu_log("r%d =3D "TARGET_FMT_lx"\n", reg, val);
}

helper.h:
DEF_HELPER_3(trace_reg_access, void, env, int, tl)

and call the function in translate.c like:

gen_helper_trace_reg_access(cpu_env, rd, cpu_gpr[rs]);

But when I compile the QEMU, i get this:
In function =91gen_logic=92:
target/mips/translate.c:2913:13: warning: passing argument 2 of=20
=91gen_helper_trace_reg_access=92 makes pointer from integer without a ca=
st=20
[enabled by default]

What am I missing here?

--=20
Sincerely yours,
Sergey Smolov
