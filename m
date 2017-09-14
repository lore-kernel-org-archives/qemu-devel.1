Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsUfi-0004XO-V0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsUfh-0005h7-R4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:59:15 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:49791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsUfh-0005g0-JO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:59:13 -0400
Received: by mail-wr0-x235.google.com with SMTP id u96so406649wrb.6
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 06:59:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59BA88D1.9080202@ispras.ru>
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
	<0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
	<59BA88D1.9080202@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 14:58:50 +0100
Message-ID: <CAFEAcA_HRwa_XFv8M3h_5dK0p6Xiuu1FfF32TPOhEop80wT30A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Sergey Smolov <smolov@ispras.ru>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, QEMU Developers <qemu-devel@nongnu.org>

On 14 September 2017 at 14:49, Sergey Smolov <smolov@ispras.ru> wrote:
> I've implemented the code you've written. Now I receive values are writte=
n
> into MIPS registers.
>
> Could you explain some aspects about the code you propose?
>
> First, what is the helper function itself? Peter said that it is impossib=
le
> to get the value that is written to MIPS register at "translation time", =
but
> in "run time" there is no mapping between x86 and "virtual MIPS" register=
s.
> So how it is possible to get these values?:-)

At translate time it is generating some extra code which at runtime
will call the helper_trace_reg_access() function, passing it the
values in the registers at this point. This will result in poor
performance if you do it for frequently executed instructions.

> Second, I need to make a final modification of helper function. I need to
> print both "val" that is written to GPR register and the number "num" of =
the
> register. I wrote the following:
>
> op_helper.c:
> void helper_trace_reg_access(CPUMIPSState *env, int reg, target_ulong val=
)
> {
> qemu_log("r%d =3D "TARGET_FMT_lx"\n", reg, val);
> }
>
> helper.h:
> DEF_HELPER_3(trace_reg_access, void, env, int, tl)
>
> and call the function in translate.c like:
>
> gen_helper_trace_reg_access(cpu_env, rd, cpu_gpr[rs]);
>
> But when I compile the QEMU, i get this:
> In function =E2=80=98gen_logic=E2=80=99:
> target/mips/translate.c:2913:13: warning: passing argument 2 of
> =E2=80=98gen_helper_trace_reg_access=E2=80=99 makes pointer from integer =
without a cast
> [enabled by default]
>
> What am I missing here?

That looks like it ought to work. Check you really did save all your
files in your editor before compiling? :-)

PS: there's no point passing the env pointer into the function if
you're not going to use it...

thanks
-- PMM
