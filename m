Received: from eggs.gnu.org ([2001:4830:134:3::10]:52252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYYKy-0007JE-VP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYYKu-000812-2k
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:55:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYYKt-0007yn-Rm
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:55:52 -0400
Received: by mail-wm0-x243.google.com with SMTP id e16-v6so10024785wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:55:51 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<87y3ezuozw.fsf@linaro.org>
	<CAFEAcA_EXZAHQEyj63Pko8XJqiEnsAHjLXAP6G1R29tqSf+W0A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_EXZAHQEyj63Pko8XJqiEnsAHjLXAP6G1R29tqSf+W0A@mail.gmail.com>
Date: Thu, 28 Jun 2018 15:55:49 +0100
Message-ID: <87o9fvufii.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 00/35] target/arm SVE patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 28 June 2018 at 12:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> This is the remainder of the SVE enablement patches,
>>> with an extra bonus patch to enable ARMv8.2-DotProd.
>>>
>>> V6 updates based on review.
>>
>> One failure from the VQ3 test set:
>>
>> ../qemu.git/aarch64-linux-user/qemu-aarch64 \
>>   ./risu --test-sve=3D3 \
>>   sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin \
>>   --trace=3Dsve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin.t=
race
>>
>> Gives:
>>
>>   loading test image
>>   sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin...
>>   starting apprentice image at 0x4000801000
>>   starting image
>>   fish: =E2=80=9C../qemu.git/aarch64-linux-user/=E2=80=A6=E2=80=9D termi=
nated by signal SIGFPE
>>   (Floating point exception)
>
> Do you have the insn that it's barfing on? In particular,
> I'm guessing from the test name that this is for something
> covered by one of the SDIV_zpzz lines in sve.decode, which
> is already in master rather than in this test series.
> If that's true, then it shouldn't block applying this set...

#0  0x000055555569297f in helper_sve_sdiv_zpzz_s (vd=3D0x555557a522e0, vn=
=3D0x555557a522e0, vm=3D0x555557a51fe0, vg=3D0x555557a52be0, desc=3D<optimi=
sed out>) at /home/alex/lsrc/qemu/qemu.git/target/arm/sve_helper.c:480
#1  0x0000555555b1283f in static_code_gen_buffer ()
#2  0x00005555555ea0d8 in cpu_tb_exec (itb=3D<optimised out>, cpu=3D0x55555=
7a50320) at /home/alex/lsrc/qemu/qemu.git/accel/tcg/cpu-exec.c:171
#3  cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, last_tb=3D<synthetic p=
ointer>, tb=3D<optimised out>, cpu=3D0x555557a50320) at /home/alex/lsrc/qem=
u/qemu.git/accel/tcg/cpu-exec.c:612
#4  cpu_exec (cpu=3Dcpu@entry=3D0x555557a48070) at /home/alex/lsrc/qemu/qem=
u.git/accel/tcg/cpu-exec.c:722
#5  0x000055555560ad40 in cpu_loop (env=3D0x555557a50320) at /home/alex/lsr=
c/qemu/qemu.git/linux-user/aarch64/cpu_loop.c:82
#6  0x00005555555afb0c in main (argc=3D<optimised out>, argv=3D0x7fffffffde=
a8, envp=3D<optimised out>) at /home/alex/lsrc/qemu/qemu.git/linux-user/mai=
n.c:813
#0  0x000055555569297f in helper_sve_sdiv_zpzz_s (vd=3D0x555557a522e0, vn=
=3D0x555557a522e0, vm=3D0x555557a51fe0, vg=3D0x555557a52be0, desc=3D<optimi=
sed out>) at /home/alex/lsrc/qemu/qemu.git/target/arm/sve_helper.c:480
480	DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_DIV)
=3D> 0x55555569297f <helper_sve_sdiv_zpzz_s+63>:	idiv   %r10d
   0x555555692982 <helper_sve_sdiv_zpzz_s+66>:	mov    %eax,%r11d
   0x555555692985 <helper_sve_sdiv_zpzz_s+69>:	mov    %r11d,(%rdi,%r8,1)
   0x555555692989 <helper_sve_sdiv_zpzz_s+73>:	add    $0x4,%r8
   0x55555569298d <helper_sve_sdiv_zpzz_s+77>:	shr    $0x4,%r9w
A syntax error in expression, near `./ $r10d'.

r10d $6 =3D 0xffffffff
rax $7 =3D 0x80000000
rdx $8 =3D 0xffffffff

Yeah so from something already merged in.

--
Alex Benn=C3=A9e
