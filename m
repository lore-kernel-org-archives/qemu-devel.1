Received: from eggs.gnu.org ([2001:4830:134:3::10]:37072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dsV3n-0004En-9D
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dsV3j-0006HV-83
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:24:07 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:1527)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dsV3j-0006Eu-1k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:24:03 -0400
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
	<0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
	<59BA88D1.9080202@ispras.ru>
	<CAFEAcA_HRwa_XFv8M3h_5dK0p6Xiuu1FfF32TPOhEop80wT30A@mail.gmail.com>
	<59BA8F4E.6060600@ispras.ru>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <5cea7ccd-97b3-ecbf-22c1-72b329c467fc@imgtec.com>
Date: Thu, 14 Sep 2017 15:23:57 +0100
MIME-Version: 1.0
In-Reply-To: <59BA8F4E.6060600@ispras.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
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
To: Sergey Smolov <smolov@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 14/09/2017 15:16, Sergey Smolov wrote:
>=20
> On 14.09.2017 16:58, Peter Maydell wrote:
>> At translate time it is generating some extra code which at runtime
>> will call the helper_trace_reg_access() function, passing it the
>> values in the registers at this point. This will result in poor
>> performance if you do it for frequently executed instructions.

Yes indeed. it will be hitting the performance critically the instruction
is quite often used. :)

>=20
> Ok, thank you.
>=20
>> That looks like it ought to work. Check you really did save all your
>> files in your editor before compiling? :-)
>=20
> Yes, I did. These warnings are very suspicious, because they come with
> strange numbers of MIPS GPR registers that I receive for my program.
>=20
> Here is the program:
>=20
> .text
> =C2=A0=C2=A0=C2=A0 addiu $8, $zero, 0x7
> =C2=A0=C2=A0=C2=A0 move $9, $8
> =C2=A0=C2=A0=C2=A0 sll $8, $8, 3
> =C2=A0=C2=A0=C2=A0 add $8, $8, $9
>=20
> Here is the log that helper functions provide:
>=20
> $0 00000007
> $7 00000007
> $0 00000038
> $0 0000003f
>=20
> The first value is register name, the second is the value to be written=
.
> Values are ok, but I expect to see $8 and $9=C2=A0 registers here.
>=20
>>
>> PS: there's no point passing the env pointer into the function if
>> you're not going to use it...

Yes you're right. I had further use of the env but it has been chopped fo=
r
the example.

>=20
> I thought that I need to pass env pointer to helper function because of
> some convention. Again, thank you for the note.
>=20

Sergey,

The reason why your modification is failed is because you passed wrong
argument. Remember that you are not just calling the helper function from
translate.c but you are generating some code to let call the helper
function on run time. You have to create a temporal TCGv to pass the
register number.
You could do it like,
TCGv_i32 tmp =3D tcg_const_i32(rd)
gen_helper_trace_reg_access(cpu_env, tmp, cpu_gpr[rs);
tcg_temp_free_i32(tmp);

or simply use the predefined macro and fix the order of the arguments.

gen_helper_0e1i(trace_reg_access, cpu_gpr[rs], rd);

Regards,
Yongbok
