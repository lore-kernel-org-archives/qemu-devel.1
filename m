Received: from eggs.gnu.org ([2001:4830:134:3::10]:51088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fX9uI-00031R-I3
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 14:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fX9uD-0003yW-HM
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 14:38:38 -0400
From: Programmingkid <programmingkidx@gmail.com>
Message-Id: <2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_5CD3650B-B086-4762-A168-788C3A73FDFE"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 24 Jun 2018 14:38:29 -0400
In-Reply-To: <c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


--Apple-Mail=_5CD3650B-B086-4762-A168-788C3A73FDFE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jun 24, 2018, at 2:30 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 06/24/2018 06:46 AM, Programmingkid wrote:
>>> Even in your referenced PDF, table 3-13, it says that frD is =
unmodified.
>>=20
>> Actually it says when FPSCR[ZE] is set is when frD is unmodified. =
When FPSCR[ZE] is not set it frD's sign is determined by an XOR of the =
signs of the operands. I have verified that this is what happens on real =
PowerPC 750 and 950 CPUs.=20
>=20
>=20
> Of course.  When ZE is not set, 1 / 0 -> inf (and -1 / 0 -> -inf, =
etc).
> But ZE not set is not the topic of discussion, or the subject of your =
patch.

I do believe the ZE is closely tied to the fdiv instruction, and that =
fixing the fdiv instruction does involve the ZE bit.=20

>> I was just wondering are you able to run a PowerPC operating system =
in QEMU
>> in KVM mode on this Power7 computer?
>=20
> Sadly not.  KVM is not enabled in this setup.

Ok. Thanks for letting me know.=20

Attached is my floating point test program. It is made for PowerPC. Does =
this program run on your system? If so, could you send me the results?


--Apple-Mail=_5CD3650B-B086-4762-A168-788C3A73FDFE
Content-Disposition: attachment;
	filename=main.c
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="main.c"
Content-Transfer-Encoding: quoted-printable

/=
**************************************************************************=
************=0A=20*=20File:=20main.c=0A=20*=20Date:=204-30-2017=0A=20*=20=
Description:=20Implement=20a=20test=20program=20for=20various=20floating=20=
point=20instructions.=0A=20*=20Note:=20tests=20made=20to=20work=20with=20=
PowerPC=20G3=20and=20G5=20only.=0A=20*=20Compiling=20on=20Mac=20OS=20X:=20=
use=20gcc-3.3=20-force_cpusubtype_ALL=0A=20*=20Note:=20fsqrt=20test=20=
will=20not=20work=20on=20PowerPC=20G3.=0A=20*=20Version:=202=0A=20=
**************************************************************************=
************/=0A=0A#include=20<stdio.h>=0A#include=20<stdint.h>=0A=
#include=20<math.h>=0A#include=20<float.h>=0A#include=20<inttypes.h>=0A=0A=
//=20Used=20to=20convert=20unsigned=20integer=20<-->=20double=20=0Aunion=20=
Converter=0A{=0A=20=20=20=20double=20d;=20=20=20//=20double=0A=20=20=20=20=
uint64_t=20i;=20//=20integer=0A};=0A=0Atypedef=20union=20Converter=20=
Converter;=0A=20=0A/*=20Describes=20the=20name=20and=20description=20of=20=
each=20bit=20of=20the=20FPSCR=20*/=0Astruct=20fpscr_info=0A{=0A=20=20=20=20=
char=20name[8];=0A=20=20=20=20char=20description[100];=0A};=0A=0Astruct=20=
fpscr_info=20finfo[]=20=3D=20=0A{=0A=20=20=20=20"FX",=20"Floating-point=20=
exception=20summary",=0A=20=20=20=20"FEX",=20"Floating-point=20enabled=20=
exception=20summary",=0A=20=20=20=20"VX",=20"Floating-point=20invalid=20=
operation=20exception=20summary",=0A=20=20=20=20"OX",=20"Floating-point=20=
overflow=20exception",=0A=20=20=20=20"UX",=20"Floating-point=20underflow=20=
exception",=0A=20=20=20=20"ZX",=20"Floating-point=20zero=20divide=20=
exception",=0A=20=20=20=20"XX",=20"Floating-point=20inexact=20=
exception",=0A=20=20=20=20"VXSNAN",=20"Floating-point=20invalid=20=
operation=20exception=20for=20SNaN",=0A=20=20=20=20"VXISI",=20=
"Floating-point=20invalid=20operation=20exception=20for=20=E2=88=9E=20-=20=
=E2=88=9E",=0A=20=20=20=20"VXIDI",=20"Floating-point=20invalid=20=
operation=20exception=20for=20=E2=88=9E/=E2=88=9E",=0A=20=20=20=20=
"VXZDZ",=20"Floating-point=20invalid=20operation=20exception=20for=20=
0/0",=0A=20=20=20=20"VXIMZ",=20"Floating-point=20invalid=20operation=20=
exception=20for=20=E2=88=9E=20*=200",=0A=20=20=20=20"VXVC",=20=
"Floating-point=20invalid=20operation=20exception=20for=20invalid=20=
compare",=0A=20=20=20=20"FR",=20"Floating-point=20fraction=20rounded",=0A=
=20=20=20=20"FI",=20"Floating-point=20fraction=20inexact",=0A=20=20=20=20=
"FPRF",=20"Floating-point=20result=20class=20descriptor=20",=0A=20=20=20=20=
"FPRF",=20"Floating-point=20less=20than=20or=20negative",=0A=20=20=20=20=
"FPRF",=20"Floating-point=20greater=20than=20or=20positive",=0A=20=20=20=20=
"FPRF",=20"Floating-point=20equal=20or=20zero",=0A=20=20=20=20"FPRF",=20=
"Floating-point=20unordered=20or=20NaN",=0A=20=20=20=20"NO=20NAME",=20=
"Reserved=20-=20you=20shouldn't=20be=20seeing=20this",=0A=20=20=20=20=
"VXSOFT",=20"Floating-point=20invalid=20operation=20exception=20for=20=
software=20request",=0A=20=20=20=20"VXSQRT",=20"Floating-point=20invalid=20=
operation=20exception=20for=20invalid=20square=20root",=0A=20=20=20=20=
"VXCVI",=20"Floating-point=20invalid=20operation=20exception=20for=20=
invalid=20integer=20convert",=0A=20=20=20=20"VE",=20"Floating-point=20=
invalid=20operation=20exception=20enable",=0A=20=20=20=20"OE",=20"IEEE=20=
floating-point=20overflow=20exception=20enable",=0A=20=20=20=20"UE",=20=
"IEEE=20floating-point=20underflow=20exception=20enable",=0A=20=20=20=20=
"ZE",=20"IEEE=20floating-point=20zero=20divide=20exception=20enable",=0A=20=
=20=20=20"XE",=20"Floating-point=20inexact=20exception=20enable",=0A=20=20=
=20=20"NI",=20"Floating-point=20non-IEEE=20mode",=0A=20=20=20=20"RN",=20=
"Rounding=20bit=200",=0A=20=20=20=20"RN",=20"Rounding=20bit=201",=0A};=0A=
=20=0A//=20Prints=20all=20the=20FPSCR=20settings=20that=20are=20set=20in=20=
the=20input=0Avoid=20print_fpscr_settings(uint32_t=20fpscr)=0A{=0A=20=20=20=
=20int=20i;=0A=20=20=20=20for=20(i=20=3D=200;=20i=20<=2032;=20i++)=20{=0A=
=20=20=20=20=20=20=20=20if=20(((fpscr=20>>=20i)=20&=200x1)=20=3D=3D=201)=20=
{=0A=20=20=20=20=20=20=20=20=20=20=20=20/*=20right=20description=20=3D=20=
31=20-=20i=20=20Oddity=20of=20IBM=20documentation=20*/=0A=20=20=20=20=20=20=
=20=20=20=20=20=20printf("bit=20%d:=20%s=20-=20%s\n",=2031-i,=20=
finfo[31-i].name,=20finfo[31-i].description);=0A=20=20=20=20=20=20=20=20=
}=0A=20=20=20=20}=0A}=0A=0A=0A#define=20ZE=2027=0A#define=20=
set_fpscr_bit(x)=20asm=20volatile=20("mtfsb1=20%0"=20:=20:=20"i"(x))=0A=0A=
/*=20Keeps=20track=20of=20the=20number=20of=20tests=20that=20failed=20*/=0A=
int=20failed_tests=20=3D=200;=0A=0A//=20Reset=20the=20FPSCR=0Avoid=20=
reset_fpscr()=0A{=0A=20=20=20=20asm=20volatile("mtfsb0=200");=0A=20=20=20=
=20asm=20volatile("mtfsb0=201");=0A=20=20=20=20asm=20volatile("mtfsb0=20=
2");=0A=20=20=20=20asm=20volatile("mtfsb0=203");=0A=20=20=20=20asm=20=
volatile("mtfsb0=204");=0A=20=20=20=20asm=20volatile("mtfsb0=205");=0A=20=
=20=20=20asm=20volatile("mtfsb0=206");=0A=20=20=20=20asm=20=
volatile("mtfsb0=207");=0A=20=20=20=20asm=20volatile("mtfsb0=208");=0A=20=
=20=20=20asm=20volatile("mtfsb0=209");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2010");=0A=20=20=20=20asm=20volatile("mtfsb0=2011");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2012");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2013");=0A=20=20=20=20asm=20volatile("mtfsb0=2014");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2015");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2016");=0A=20=20=20=20asm=20volatile("mtfsb0=2017");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2018");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2019");=0A=20=20=20=20asm=20volatile("mtfsb0=2020");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2021");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2022");=0A=20=20=20=20asm=20volatile("mtfsb0=2023");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2024");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2025");=0A=20=20=20=20asm=20volatile("mtfsb0=2026");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2027");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2028");=0A=20=20=20=20asm=20volatile("mtfsb0=2029");=0A=20=
=20=20=20asm=20volatile("mtfsb0=2030");=0A=20=20=20=20asm=20=
volatile("mtfsb0=2031");=0A=20=20=20=20=0A=20=20=20=20/*=20Check=20if=20=
everything=20is=20alright=20*/=0A=20=20=20=20uint32_t=20fpscr;=0A=20=20=20=
=20Converter=20c;=0A=20=20=20=20asm=20volatile("mffs=20%0"=20:=20=
"=3Df"(c.d));=0A=20=20=20=20fpscr=20=3D=20(uint32_t)c.i;=0A=20=20=20=20=
if=20(fpscr=20!=3D=200)=20{=0A=20=20=20=20=20=20=20=20printf("Warning:=20=
fpscr=20not=20equal=20to=20zero:=200x%x\n",=20fpscr);=0A=20=20=20=20=20=20=
=20=20print_fpscr_settings(fpscr);=0A=20=20=20=20}=0A}=0A=0A/*=0A=20*=20=
The=20action=20to=20take=20if=20a=20test=20fails=0A=20*=20Input=20one:=20=
message=20string=0A=20*=20Input=20two:=20actual=20fpscr=20value=0A=20*=20=
Input=20three:=20expected=20fpscr=20value=0A=20*=20Input=20four:=20=
actual=20answer=0A=20*=20Input=20five:=20expected=20answer=0A=20*/=0A=20=
void=20test_failed(const=20char=20*message,=20uint32_t=20actual_fpscr,=20=
uint32_t=20expected_fpscr,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20uint64_t=20actual_answer,=20uint64_t=20expected_answer)=0A=20{=0A=
=20=20=20=20printf("%s\n",=20message);=0A=20=20=20=20printf("expected=20=
answer:=200x%"=20PRIx64=20"=20(%f)\n",=20expected_answer,=20=
expected_answer);=0A=20=20=20=20printf("=20=20actual=20answer:=200x%"=20=
PRIx64=20"=20(%f)\n",=20actual_answer,=20actual_answer);=0A=20=20=20=20=
printf("expected=20fpscr:=200x%x\n",=20expected_fpscr);=0A=20=20=20=20=
printf("=20=20actual=20fpscr:=200x%x\n",=20actual_fpscr);=0A=20=20=20=20=0A=
=20=20=20=20/*=20Only=20print=20FPSCR=20bits=20if=20there=20is=20a=20=
difference=20*/=0A=20=20=20=20if=20(actual_fpscr=20!=3D=20=
expected_fpscr)=20{=0A=20=20=20=20=20=20=20=20printf("\nactual=20FPSCR=20=
bits=20set:\n");=0A=20=20=20=20=20=20=20=20=
print_fpscr_settings(actual_fpscr);=0A=20=20=20=20=20=20=20=20=
printf("\nexpected=20FPSCR=20bits=20set:\n");=0A=20=20=20=20=20=20=20=20=
print_fpscr_settings(expected_fpscr);=0A=20=20=20=20}=0A=20=20=20=20=
printf("\n");=0A=20=20=20=20failed_tests++;=0A=20}=0A=0A/*=0A=20*=20=
Returns=20the=20value=20of=20the=20FPSCR=0A=20*=20output:=20unsigned=20=
32=20bit=20integer=0A=20*/=0Auint32_t=20get_fpscr()=0A{=0A=20=20=20=20=
asm=20volatile("mffs=20f0");=0A=20=20=20=20asm=20volatile("stfd=20f0,=20=
40(r1)");=0A=20=20=20=20uint32_t=20return_value;=0A=20=20=20=20asm=20=
volatile("lwz=20%0,=2044(r1)"=20:=20"=3Dr"(return_value));=0A=20=20=20=20=
return=20return_value;=0A}=0A=0A=0A/*=20The=20fpscr=20and=20answer=20=
have=20to=20be=20right=20for=20a=20test=20to=20pass.=20*/=0A=0A=0A/*=20=
Test=20the=20fadd=20instruction=20*/=0Avoid=20test_fadd()=0A{=0A=20=20=20=
=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x3ff3333333333334;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82064000;=0A=20=20=20=20reset_fpscr();=20=20=20=20=
=0A=20=20=20=20asm=20volatile("fadd=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20=
:=20"f"(0.4),=20"f"(0.8));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fadd=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=
=20=20=20=20test_failed("fadd=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=20=0A=
/*=20Test=20the=20fadds=20instruction=20*/=0Avoid=20test_fadds()=0A{=0A=20=
=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x407024d500000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82064000;=0A=20=20=20=20reset_fpscr();=20=20=20=20=
=0A=20=20=20=20asm=20volatile("fadds=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20=
:=20"f"(257.445),=20"f"(0.857));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fadds=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=
=20=20=20=20=20test_failed("fadds=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20the=20fsub=20instruction=20*/=0Avoid=20test_fsub()=0A{=0A=20=20=20=
=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x40f2fd1deb11c6d2;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x4000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=20=
asm=20volatile("fsub=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(123456.78),=20"f"(45678.91011));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fsub=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=
=20=20=20=20test_failed("fsub=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20the=20fsubs=20instruction=20*/=0Avoid=20test_fsubs()=0A{=0A=20=20=20=
=20Converter=20c;=0A=20=20=20=20double=20expected_answer=20=3D=20=
0x40884e3d70a3d70a;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x4000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=20=
asm=20volatile("fsub=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(1234.56),=20"f"(456.78));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fsubs=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=
=20=20=20=20=20test_failed("fsubs=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20infinity=20-=20infinity=20*/=0Avoid=20test_inf_minus_inf()=0A{=0A=20=
=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x7ff8000000000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200xa0811000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fsub=20%0,=20%1,=20%1"=20:=20"=3Df"(c.d)=20:=20=
"f"(INFINITY));=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=20=20=20=
=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20c.i=20=3D=3D=20=
expected_answer)=20{=0A=20=20=20=20=20=20=20=20printf("inf=20-=20inf=20=
test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("inf=20-=20inf=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20division=20by=20zero=20*/=0Avoid=20test_division_by_zero()=0A{=0A=20=
=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x0;=0A=20=20=20=20uint32_t=20actual_fpscr,=20expected_fpscr=20=3D=20=
0xc4000010;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=20=
set_fpscr_bit(ZE);=0A=20=20=20=20asm=20volatile("fdiv=20%0,=20%1,=20%2"=20=
:=20"=3Df"(c.d)=20:=20"f"(1.0),=20"f"(0.0));=0A=20=20=20=20actual_fpscr=20=
=3D=20get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20=
expected_fpscr=20&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=
=20=20=20printf("division=20by=20zero=20test=20passed\n");=0A=20=20=20=20=
}=20else=20{=0A=20=20=20=20=20=20=20=20test_failed("division=20by=20zero=20=
test=20failed",=20actual_fpscr,=20expected_fpscr,=20c.i,=20=
expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20Test=20zero=20divided=20=
by=20zero=20*/=0Avoid=20test_zero_div_zero()=0A{=0A=20=20=20=20Converter=20=
c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=200x7ff8000000000000;=0A=
=20=20=20=20uint32_t=20actual_fpscr,=20expected_fpscr=20=3D=20=
0xa0211010;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=20=
set_fpscr_bit(ZE);=0A=20=20=20=20asm=20volatile("fdiv=20%0,=20%1,=20%1"=20=
:=20"=3Df"(c.d)=20:=20"f"(0.0),=20"f"(0.0));=0A=20=20=20=20actual_fpscr=20=
=3D=20get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20=
expected_fpscr=20&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=
=20=20=20printf("0/0=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=
=20=20=20=20=20=20=20test_failed("0/0=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20infinity=20divided=20by=20infinity=20*/=0Avoid=20=
test_inf_div_inf()=0A{=0A=20=20=20=20Converter=20c;=0A=20=20=20=20=
uint64_t=20expected_answer=20=3D=200x7ff8000000000000;=0A=20=20=20=20=
uint32_t=20actual_fpscr,=20expected_fpscr=20=3D=200xa0411000;=0A=20=20=20=
=20reset_fpscr();=0A=20=20=20=20asm=20volatile("fdiv=20%0,=20%1,=20%1"=20=
:=20"=3Df"(c.d)=20:=20"f"(INFINITY));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("inf/inf=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=
=20=20=20=20=20test_failed("inf/inf=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A=0A=
/*=20Test=20the=20fdiv=20instruction=20*/=0Avoid=20test_fdiv()=0A{=0A=20=20=
=20=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x40059f38ee13b48b;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82064000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fdiv=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(1234.56),=20"f"(456.78));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fdiv=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=
=20=20=20=20test_failed("fdiv=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20the=20fdivs=20instruction=20*/=0Avoid=20test_fdivs()=0A{=0A=20=20=20=
=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x40059f38e0000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82024000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fdivs=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(1234.56),=20"f"(456.78));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fdivs=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=
=20=20=20=20=20test_failed("fdivs=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20the=20fmul=20instruction=20*/=0Avoid=20test_fmul()=0A{=0A=20=20=20=
=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x40365c28f5c28f5c;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82024000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fmul=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(5.2),=20"f"(4.3));=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=
=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20c.i=20=3D=3D=
=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20printf("fmul=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fmul=20test=20failed",=20actual_fpscr,=20expected_fpscr,=20=
c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20Test=20the=20=
fmuls=20instruction=20*/=0Avoid=20test_fmuls()=0A{=0A=20=20=20=20=
Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x412135a4a0000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82024000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fmuls=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(1234.56),=20"f"(456.78));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fmuls=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=
=20=20=20=20=20test_failed("fmuls=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20the=20fmul=20instruction=20*/=0Avoid=20test_inf_times_zero()=0A{=0A=
=20=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x7ff8000000000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200xa0111000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fmul=20%0,=20%1,=20%2"=20:=20"=3Df"(c.d)=20:=20=
"f"(INFINITY),=20"f"(0.0));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("inf=20*=200=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=
=20=20=20=20=20=20=20test_failed("inf=20*=200=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20=
}=0A}=0A=0A/*=20Test=20the=20fmadd=20instruction=20*/=0Avoid=20=
test_fmadd()=0A{=0A=20=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20=
expected_answer=20=3D=200x4123fcaadfa43fe5;=0A=20=20=20=20uint32_t=20=
actual_fpscr,=20expected_fpscr=20=3D=200x82024000;=0A=20=20=20=20=
reset_fpscr();=0A=20=20=20=20asm=20volatile("fmadd=20%0,=20%1,=20%2,=20=
%3"=20:=20"=3Df"(c.d)=20:=20"f"(1234.56),=20"f"(456.78),=20=
"f"(91011.12));=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=20=20=20=
=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20c.i=20=3D=3D=20=
expected_answer)=20{=0A=20=20=20=20=20=20=20=20printf("fmadd=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fmadd=20test=20failed",=20actual_fpscr,=20expected_fpscr,=20=
c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20Test=20the=20=
fmadds=20instruction=20*/=0Avoid=20test_fmadds()=0A{=0A=20=20=20=20=
Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x4123fcaae0000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x82064000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20asm=20volatile("fmadds=20%0,=20%1,=20%2,=20%3"=20:=20"=3Df"(c.d)=20:=20=
"f"(1234.56),=20"f"(456.78),=20"f"(91011.12));=0A=20=20=20=20=
actual_fpscr=20=3D=20get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=
=20expected_fpscr=20&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=
=20=20=20=20printf("fmadds=20test=20passed\n");=0A=20=20=20=20}=20else=20=
{=0A=20=20=20=20=20=20=20=20test_failed("fmadds=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20=
}=0A}=0A=0A/*=20Test=20the=20fsqrt=20instruction=20-=20This=20=
instruction=20doesn't=20work=20on=20the=20PowerPC=20750=20(G3).=0A=20=20=20=
It=20does=20work=20on=20the=20PowerPC=20970=20(G5).=20=20*/=0A/*void=20=
test_fsqrt()=0A{=0A=20=20=20=20double=20answer;=0A=20=20=20=20=
reset_fpscr();=0A=20=20=20=20asm=20volatile("fsqrt=20%0,=20%1"=20:=20=
"=3Df"(answer)=20:=20"f"(-1.0));=0A=20=20=20=20if=20(get_fpscr()=20=3D=3D=20=
0xa0011200)=20{=0A=20=20=20=20=20=20=20=20printf("fsqrt=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fsqrt=20test=20failed");=0A=20=20=20=20}=20=20=20=0A}*/=0A=0A=
/*=20Test=20an=20overflow=20condition=20*/=0Avoid=20test_overflow()=0A{=0A=
=20=20=20=20//=20multiplying=20two=20really=20big=20numbers=20equals=20=
overflow=0A=20=20=20=20Converter=20c;=0A=20=20=20=20double=20=
really_big_input;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x7ff0000000000000;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr=20=3D=200x92025000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=
=20really_big_input=20=3D=201.7=20*=20pow(10,=20308);=0A=20=20=20=20asm=20=
volatile("fmul=20%0,=20%1,=20%1"=20:=20"=3Df"(c.d)=20:=20=
"f"(really_big_input));=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=
=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20c.i=20=3D=3D=
=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20printf("overflow=20=
test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("overflow=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20=
Test=20an=20underflow=20condition=20*/=0Avoid=20test_underflow()=0A{=0A=20=
=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20expected_answer=20=3D=20=
0x199999999999a;=0A=20=20=20=20uint32_t=20actual_fpscr,=20expected_fpscr=20=
=3D=200x8a074000;=0A=20=20=20=20reset_fpscr();=0A=20=20=20=20asm=20=
volatile("fmadd=20%0,=20%1,=20%2,=20%3"=20:=20"=3Df"(c.d)=20:=20=
"f"(DBL_MIN),=20"f"(0.1),=20"f"(0.0));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("underflow=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=
=20=20=20=20=20=20test_failed("underflow=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20=
}=0A}=0A=0A/*=20Test=20the=20fctiw=20instruction=20*/=0Avoid=20=
test_fctiw()=0A{=0A=20=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20=
expected_answer;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr;=0A=20=20=20=20double=20frB;=0A=20=20=20=20=0A=20=20=20=20=
/*=20above=20maximum=20value=20test=20*/=0A=20=20=20=20expected_fpscr=20=
=3D=200xa0000100;=0A=20=20=20=20expected_answer=20=3D=200x7fffffff;=0A=20=
=20=20=20frB=20=3D=20pow(2,=2032);=20//=20greater=20than=202^31=20-=201=0A=
=20=20=20=20reset_fpscr();=0A=20=20=20=20asm=20volatile("fctiw=20%0,=20=
%1"=20:=20"=3Df"(c.d)=20:=20"f"(frB));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20(c.i=20&=200xffffffff)=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=
=20=20=20=20printf("fctiw=20above=20maximum=20value=20test=20passed\n");=0A=
=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20test_failed("fctiw=20=
above=20maximum=20value=20test=20failed",=20actual_fpscr,=20=
expected_fpscr,=20(c.i=20&=200xffffffff),=20expected_answer);=0A=20=20=20=
=20}=0A=20=20=20=20=0A=20=20=20=20/*=20below=20minimum=20value=20test*/=0A=
=20=20=20=20expected_fpscr=20=3D=200xa0000100;=0A=20=20=20=20=
expected_answer=20=3D=200x80000000;=0A=20=20=20=20frB=20=3D=20-frB;=20=20=
//=20less=20than=20-2^31=0A=20=20=20=20reset_fpscr();=0A=20=20=20=20asm=20=
volatile("fctiw=20%0,=20%1"=20:=20"=3Df"(c.d)=20:=20"f"(frB));=20=20=20=20=
=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=20=20=20=20if=20=
(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20(c.i=20&=200xffffffff)=20=
=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20printf("fctiw=20=
below=20minimum=20value=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=
=20=20=20=20=20=20=20=20test_failed("fctiw=20below=20minimum=20value=20=
test=20failed",=20actual_fpscr,=20expected_fpscr,=20(c.i=20&=20=
0xffffffff),=20expected_answer);=0A=20=20=20=20}=0A=0A=20=20=20=20/*=20=
float=20to=20integer=20test=20*/=0A=20=20=20=20expected_fpscr=20=3D=20=
0x82060000;=0A=20=20=20=20expected_answer=20=3D=200xd;=0A=20=20=20=20=
reset_fpscr();=0A=20=20=20=20asm=20volatile("fctiw=20%0,=20%1"=20:=20=
"=3Df"(c.d)=20:=20"f"(12.7));=20=20=20=20=0A=20=20=20=20actual_fpscr=20=3D=
=20get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20=
expected_fpscr=20&&=20(c.i=20&=200xffffffff)=20=3D=3D=20expected_answer)=20=
{=0A=20=20=20=20=20=20=20=20printf("fctiw=20integer=20conversion=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fctiw=20integer=20conversion=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20=
}=0A}=0A=0A/*=20Test=20the=20fctiwz=20instruction=20*/=0Avoid=20=
test_fctiwz()=0A{=0A=20=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20=
expected_answer;=0A=20=20=20=20uint32_t=20actual_fpscr,=20=
expected_fpscr;=0A=20=20=20=20double=20frB;=0A=20=20=20=20=0A=20=20=20=20=
/*=20above=20maximum=20value=20test=20*/=0A=20=20=20=20expected_fpscr=20=
=3D=200xa0000100;=0A=20=20=20=20expected_answer=20=3D=200x7fffffff;=0A=20=
=20=20=20frB=20=3D=20pow(2,=2032);=20//=20greater=20than=202^31=20-=201=0A=
=20=20=20=20reset_fpscr();=0A=20=20=20=20asm=20volatile("fctiwz=20%0,=20=
%1"=20:=20"=3Df"(c.d)=20:=20"f"(frB));=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20(c.i=20&=200xffffffff)=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=
=20=20=20=20printf("fctiwz=20above=20maximum=20value=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fctiwz=20above=20maximum=20value=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20(c.i=20&=200xffffffff),=20=
expected_answer);=0A=20=20=20=20}=0A=20=20=20=20=0A=20=20=20=20/*=20=
below=20minimum=20value=20test*/=0A=20=20=20=20expected_fpscr=20=3D=20=
0xa0000100;=0A=20=20=20=20expected_answer=20=3D=200x80000000;=0A=20=20=20=
=20frB=20=3D=20-frB;=20=20//=20less=20than=20-2^31=0A=20=20=20=20=
reset_fpscr();=0A=20=20=20=20asm=20volatile("fctiwz=20%0,=20%1"=20:=20=
"=3Df"(c.d)=20:=20"f"(frB));=20=20=20=20=0A=20=20=20=20actual_fpscr=20=3D=20=
get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20=
&&=20(c.i=20&=200xffffffff)=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=
=20=20=20=20printf("fctiwz=20below=20minimum=20value=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fctiwz=20below=20minimum=20value=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20(c.i=20&=200xffffffff),=20=
expected_answer);=0A=20=20=20=20}=0A=0A=20=20=20=20/*=20float=20to=20=
integer=20test=20*/=0A=20=20=20=20expected_fpscr=20=3D=200x82060000;=0A=20=
=20=20=20expected_answer=20=3D=200x1c;=0A=20=20=20=20reset_fpscr();=0A=20=
=20=20=20asm=20volatile("fctiw=20%0,=20%1"=20:=20"=3Df"(c.d)=20:=20=
"f"(27.98));=20=20=20=20=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=
=20=20=20=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20(c.i=20&=20=
0xffffffff)=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=20=20=20=20=
printf("fctiwz=20integer=20conversion=20test=20passed\n");=0A=20=20=20=20=
}=20else=20{=0A=20=20=20=20=20=20=20=20test_failed("fctiwz=20integer=20=
conversion=20test=20failed",=20actual_fpscr,=20expected_fpscr,=20c.i,=20=
expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20Test=20the=20frsp=20=
instruction=20*/=0Avoid=20test_frsp()=0A{=0A=20=20=20=20Converter=20c;=0A=
=20=20=20=20uint64_t=20expected_answer=20=3D=200x4271f71fc0000000;=0A=20=20=
=20=20uint32_t=20actual_fpscr,=20expected_fpscr=20=3D=200x82064000;=0A=20=
=20=20=20reset_fpscr();=0A=20=20=20=20asm=20volatile("frsp=20%0,=20%1"=20=
:=20"=3Df"(c.d)=20:=20"f"(1234567891012.131415));=0A=20=20=20=20=
actual_fpscr=20=3D=20get_fpscr();=0A=20=20=20=20if=20(actual_fpscr=20=3D=3D=
=20expected_fpscr=20&&=20c.i=20=3D=3D=20expected_answer)=20{=0A=20=20=20=20=
=20=20=20=20printf("frsp=20test=20passed\n");=0A=20=20=20=20}=20else=20{=0A=
=20=20=20=20=20=20=20=20test_failed("frsp=20test=20failed",=20=
actual_fpscr,=20expected_fpscr,=20c.i,=20expected_answer);=0A=20=20=20=20=
}=0A}=0A=0A/*=20Test=20the=20fnmsub=20instruction=20*/=0Avoid=20=
test_fnmsub()=0A{=0A=20=20=20=20Converter=20c;=0A=20=20=20=20uint64_t=20=
expected_answer=20=3D=200xc11cdd3cc985f06e;=0A=20=20=20=20uint32_t=20=
actual_fpscr,=20expected_fpscr=20=3D=200x82028000;=0A=20=20=20=20=
reset_fpscr();=0A=20=20=20=20asm=20volatile("fnmsub=20%0,=20%1,=20%2,=20=
%3"=20:=20"=3Df"(c.d)=20:=20"f"(1234.56),=20"f"(456.78),=20=
"f"(91011.12));=0A=20=20=20=20actual_fpscr=20=3D=20get_fpscr();=0A=20=20=20=
=20if=20(actual_fpscr=20=3D=3D=20expected_fpscr=20&&=20c.i=20=3D=3D=20=
expected_answer)=20{=0A=20=20=20=20=20=20=20=20printf("fnmsub=20test=20=
passed\n");=0A=20=20=20=20}=20else=20{=0A=20=20=20=20=20=20=20=20=
test_failed("fnmsub=20test=20failed",=20actual_fpscr,=20expected_fpscr,=20=
c.i,=20expected_answer);=0A=20=20=20=20}=0A}=0A=0A/*=20Report=20the=20=
results=20of=20all=20the=20tests=20*/=0Avoid=20report_results()=0A{=0A=20=
=20=20=20if=20(failed_tests=20=3D=3D=201)=20{=0A=20=20=20=20=20=20=20=20=
printf("\n=3D=3D=3D=20Warning:=20%d=20test=20failed=20=3D=3D=3D\n",=20=
failed_tests);=0A=20=20=20=20}=20else=20if=20(failed_tests=20>=201)=20{=0A=
=20=20=20=20=20=20=20=20printf("\n=3D=3D=3D=20Warning:=20%d=20tests=20=
failed=20=3D=3D=3D\n",=20failed_tests);=0A=20=20=20=20}=20else=20{=0A=20=20=
=20=20=20=20=20=20printf("\n=3D=3D=3D=20All=20tests=20passed=20=3D=3D=3D\n=
");=0A=20=20=20=20}=0A}=0A=0Aint=20main=20(int=20argc,=20const=20char=20=
*=20argv[])=20{=0A=0A=20=20=20=20test_fadd();=0A=20=20=20=20=
test_fadds();=0A=20=20=20=20test_fsub();=0A=20=20=20=20test_fsubs();=0A=20=
=20=20=20test_fmul();=0A=20=20=20=20test_fmuls();=0A=20=20=20=20=
test_fdiv();=0A=20=20=20=20test_fdivs();=0A=20=20=20=20test_fmadd();=0A=20=
=20=20=20test_fmadds();=20=20=20=20=0A=20=20=20=20//test_fsqrt();=0A=20=20=
=20=20test_inf_minus_inf();=0A=20=20=20=20test_division_by_zero();=0A=20=20=
=20=20test_zero_div_zero();=0A=20=20=20=20test_inf_div_inf();=0A=20=20=20=
=20test_inf_times_zero();=0A=20=20=20=20test_overflow();=0A=20=20=20=20=
test_underflow();=0A=20=20=20=20test_fctiw();=0A=20=20=20=20=
test_fctiwz();=0A=20=20=20=20test_frsp();=0A=20=20=20=20test_fnmsub();=0A=
=20=20=20=20=0A=20=20=20=20report_results();=0A=0A=20=20=20=20return=20=
0;=0A}=0A=

--Apple-Mail=_5CD3650B-B086-4762-A168-788C3A73FDFE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



=
/*************************************************************************=
*************
 * File: main.c
 * Date: 4-30-2017
 * Description: Implement a test program for various floating point =
instructions.
 * Note: tests made to work with PowerPC G3 and G5 only.
 * Compiling on Mac OS X: use gcc-3.3 -force_cpusubtype_ALL
 * Note: fsqrt test will not work on PowerPC G3.
 * Version: 2
 =
**************************************************************************=
************/

#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <float.h>
#include <inttypes.h>

// Used to convert unsigned integer <--> double=20
union Converter
{
    double d;   // double
    uint64_t i; // integer
};

typedef union Converter Converter;
=20
/* Describes the name and description of each bit of the FPSCR */
struct fpscr_info
{
    char name[8];
    char description[100];
};

struct fpscr_info finfo[] =3D=20
{
    "FX", "Floating-point exception summary",
    "FEX", "Floating-point enabled exception summary",
    "VX", "Floating-point invalid operation exception summary",
    "OX", "Floating-point overflow exception",
    "UX", "Floating-point underflow exception",
    "ZX", "Floating-point zero divide exception",
    "XX", "Floating-point inexact exception",
    "VXSNAN", "Floating-point invalid operation exception for SNaN",
    "VXISI", "Floating-point invalid operation exception for =E2=88=9E - =
=E2=88=9E",
    "VXIDI", "Floating-point invalid operation exception for =E2=88=9E/=E2=
=88=9E",
    "VXZDZ", "Floating-point invalid operation exception for 0/0",
    "VXIMZ", "Floating-point invalid operation exception for =E2=88=9E * =
0",
    "VXVC", "Floating-point invalid operation exception for invalid =
compare",
    "FR", "Floating-point fraction rounded",
    "FI", "Floating-point fraction inexact",
    "FPRF", "Floating-point result class descriptor ",
    "FPRF", "Floating-point less than or negative",
    "FPRF", "Floating-point greater than or positive",
    "FPRF", "Floating-point equal or zero",
    "FPRF", "Floating-point unordered or NaN",
    "NO NAME", "Reserved - you shouldn't be seeing this",
    "VXSOFT", "Floating-point invalid operation exception for software =
request",
    "VXSQRT", "Floating-point invalid operation exception for invalid =
square root",
    "VXCVI", "Floating-point invalid operation exception for invalid =
integer convert",
    "VE", "Floating-point invalid operation exception enable",
    "OE", "IEEE floating-point overflow exception enable",
    "UE", "IEEE floating-point underflow exception enable",
    "ZE", "IEEE floating-point zero divide exception enable",
    "XE", "Floating-point inexact exception enable",
    "NI", "Floating-point non-IEEE mode",
    "RN", "Rounding bit 0",
    "RN", "Rounding bit 1",
};
=20
// Prints all the FPSCR settings that are set in the input
void print_fpscr_settings(uint32_t fpscr)
{
    int i;
    for (i =3D 0; i < 32; i++) {
        if (((fpscr >> i) & 0x1) =3D=3D 1) {
            /* right description =3D 31 - i  Oddity of IBM documentation =
*/
            printf("bit %d: %s - %s\n", 31-i, finfo[31-i].name, =
finfo[31-i].description);
        }
    }
}


#define ZE 27
#define set_fpscr_bit(x) asm volatile ("mtfsb1 %0" : : "i"(x))

/* Keeps track of the number of tests that failed */
int failed_tests =3D 0;

// Reset the FPSCR
void reset_fpscr()
{
    asm volatile("mtfsb0 0");
    asm volatile("mtfsb0 1");
    asm volatile("mtfsb0 2");
    asm volatile("mtfsb0 3");
    asm volatile("mtfsb0 4");
    asm volatile("mtfsb0 5");
    asm volatile("mtfsb0 6");
    asm volatile("mtfsb0 7");
    asm volatile("mtfsb0 8");
    asm volatile("mtfsb0 9");
    asm volatile("mtfsb0 10");
    asm volatile("mtfsb0 11");
    asm volatile("mtfsb0 12");
    asm volatile("mtfsb0 13");
    asm volatile("mtfsb0 14");
    asm volatile("mtfsb0 15");
    asm volatile("mtfsb0 16");
    asm volatile("mtfsb0 17");
    asm volatile("mtfsb0 18");
    asm volatile("mtfsb0 19");
    asm volatile("mtfsb0 20");
    asm volatile("mtfsb0 21");
    asm volatile("mtfsb0 22");
    asm volatile("mtfsb0 23");
    asm volatile("mtfsb0 24");
    asm volatile("mtfsb0 25");
    asm volatile("mtfsb0 26");
    asm volatile("mtfsb0 27");
    asm volatile("mtfsb0 28");
    asm volatile("mtfsb0 29");
    asm volatile("mtfsb0 30");
    asm volatile("mtfsb0 31");
   =20
    /* Check if everything is alright */
    uint32_t fpscr;
    Converter c;
    asm volatile("mffs %0" : "=3Df"(c.d));
    fpscr =3D (uint32_t)c.i;
    if (fpscr !=3D 0) {
        printf("Warning: fpscr not equal to zero: 0x%x\n", fpscr);
        print_fpscr_settings(fpscr);
    }
}

/*
 * The action to take if a test fails
 * Input one: message string
 * Input two: actual fpscr value
 * Input three: expected fpscr value
 * Input four: actual answer
 * Input five: expected answer
 */
 void test_failed(const char *message, uint32_t actual_fpscr, uint32_t =
expected_fpscr,
                  uint64_t actual_answer, uint64_t expected_answer)
 {
    printf("%s\n", message);
    printf("expected answer: 0x%" PRIx64 " (%f)\n", expected_answer, =
expected_answer);
    printf("  actual answer: 0x%" PRIx64 " (%f)\n", actual_answer, =
actual_answer);
    printf("expected fpscr: 0x%x\n", expected_fpscr);
    printf("  actual fpscr: 0x%x\n", actual_fpscr);
   =20
    /* Only print FPSCR bits if there is a difference */
    if (actual_fpscr !=3D expected_fpscr) {
        printf("\nactual FPSCR bits set:\n");
        print_fpscr_settings(actual_fpscr);
        printf("\nexpected FPSCR bits set:\n");
        print_fpscr_settings(expected_fpscr);
    }
    printf("\n");
    failed_tests++;
 }

/*
 * Returns the value of the FPSCR
 * output: unsigned 32 bit integer
 */
uint32_t get_fpscr()
{
    asm volatile("mffs f0");
    asm volatile("stfd f0, 40(r1)");
    uint32_t return_value;
    asm volatile("lwz %0, 44(r1)" : "=3Dr"(return_value));
    return return_value;
}


/* The fpscr and answer have to be right for a test to pass. */


/* Test the fadd instruction */
void test_fadd()
{
    Converter c;
    uint64_t expected_answer =3D 0x3ff3333333333334;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
    reset_fpscr();   =20
    asm volatile("fadd %0, %1, %2" : "=3Df"(c.d) : "f"(0.4), "f"(0.8));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fadd test passed\n");
    } else {
        test_failed("fadd test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}
=20
/* Test the fadds instruction */
void test_fadds()
{
    Converter c;
    uint64_t expected_answer =3D 0x407024d500000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
    reset_fpscr();   =20
    asm volatile("fadds %0, %1, %2" : "=3Df"(c.d) : "f"(257.445), =
"f"(0.857));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fadds test passed\n");
    } else {
        test_failed("fadds test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fsub instruction */
void test_fsub()
{
    Converter c;
    uint64_t expected_answer =3D 0x40f2fd1deb11c6d2;
    uint32_t actual_fpscr, expected_fpscr =3D 0x4000;
    reset_fpscr();
    asm volatile("fsub %0, %1, %2" : "=3Df"(c.d) : "f"(123456.78), =
"f"(45678.91011));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fsub test passed\n");
    } else {
        test_failed("fsub test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fsubs instruction */
void test_fsubs()
{
    Converter c;
    double expected_answer =3D 0x40884e3d70a3d70a;
    uint32_t actual_fpscr, expected_fpscr =3D 0x4000;
    reset_fpscr();
    asm volatile("fsub %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fsubs test passed\n");
    } else {
        test_failed("fsubs test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test infinity - infinity */
void test_inf_minus_inf()
{
    Converter c;
    uint64_t expected_answer =3D 0x7ff8000000000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0xa0811000;
    reset_fpscr();
    asm volatile("fsub %0, %1, %1" : "=3Df"(c.d) : "f"(INFINITY));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("inf - inf test passed\n");
    } else {
        test_failed("inf - inf test failed", actual_fpscr, =
expected_fpscr, c.i, expected_answer);
    }
}

/* Test division by zero */
void test_division_by_zero()
{
    Converter c;
    uint64_t expected_answer =3D 0x0;
    uint32_t actual_fpscr, expected_fpscr =3D 0xc4000010;
    reset_fpscr();
    set_fpscr_bit(ZE);
    asm volatile("fdiv %0, %1, %2" : "=3Df"(c.d) : "f"(1.0), "f"(0.0));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("division by zero test passed\n");
    } else {
        test_failed("division by zero test failed", actual_fpscr, =
expected_fpscr, c.i, expected_answer);
    }
}

/* Test zero divided by zero */
void test_zero_div_zero()
{
    Converter c;
    uint64_t expected_answer =3D 0x7ff8000000000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0xa0211010;
    reset_fpscr();
    set_fpscr_bit(ZE);
    asm volatile("fdiv %0, %1, %1" : "=3Df"(c.d) : "f"(0.0), "f"(0.0));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("0/0 test passed\n");
    } else {
        test_failed("0/0 test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test infinity divided by infinity */
void test_inf_div_inf()
{
    Converter c;
    uint64_t expected_answer =3D 0x7ff8000000000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0xa0411000;
    reset_fpscr();
    asm volatile("fdiv %0, %1, %1" : "=3Df"(c.d) : "f"(INFINITY));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("inf/inf test passed\n");
    } else {
        test_failed("inf/inf test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}


/* Test the fdiv instruction */
void test_fdiv()
{
    Converter c;
    uint64_t expected_answer =3D 0x40059f38ee13b48b;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
    reset_fpscr();
    asm volatile("fdiv %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fdiv test passed\n");
    } else {
        test_failed("fdiv test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fdivs instruction */
void test_fdivs()
{
    Converter c;
    uint64_t expected_answer =3D 0x40059f38e0000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
    reset_fpscr();
    asm volatile("fdivs %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fdivs test passed\n");
    } else {
        test_failed("fdivs test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fmul instruction */
void test_fmul()
{
    Converter c;
    uint64_t expected_answer =3D 0x40365c28f5c28f5c;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
    reset_fpscr();
    asm volatile("fmul %0, %1, %2" : "=3Df"(c.d) : "f"(5.2), "f"(4.3));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fmul test passed\n");
    } else {
        test_failed("fmul test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fmuls instruction */
void test_fmuls()
{
    Converter c;
    uint64_t expected_answer =3D 0x412135a4a0000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
    reset_fpscr();
    asm volatile("fmuls %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fmuls test passed\n");
    } else {
        test_failed("fmuls test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fmul instruction */
void test_inf_times_zero()
{
    Converter c;
    uint64_t expected_answer =3D 0x7ff8000000000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0xa0111000;
    reset_fpscr();
    asm volatile("fmul %0, %1, %2" : "=3Df"(c.d) : "f"(INFINITY), =
"f"(0.0));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("inf * 0 test passed\n");
    } else {
        test_failed("inf * 0 test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fmadd instruction */
void test_fmadd()
{
    Converter c;
    uint64_t expected_answer =3D 0x4123fcaadfa43fe5;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
    reset_fpscr();
    asm volatile("fmadd %0, %1, %2, %3" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78), "f"(91011.12));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fmadd test passed\n");
    } else {
        test_failed("fmadd test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fmadds instruction */
void test_fmadds()
{
    Converter c;
    uint64_t expected_answer =3D 0x4123fcaae0000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
    reset_fpscr();
    asm volatile("fmadds %0, %1, %2, %3" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78), "f"(91011.12));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fmadds test passed\n");
    } else {
        test_failed("fmadds test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fsqrt instruction - This instruction doesn't work on the =
PowerPC 750 (G3).
   It does work on the PowerPC 970 (G5).  */
/*void test_fsqrt()
{
    double answer;
    reset_fpscr();
    asm volatile("fsqrt %0, %1" : "=3Df"(answer) : "f"(-1.0));
    if (get_fpscr() =3D=3D 0xa0011200) {
        printf("fsqrt test passed\n");
    } else {
        test_failed("fsqrt test failed");
    }  =20
}*/

/* Test an overflow condition */
void test_overflow()
{
    // multiplying two really big numbers equals overflow
    Converter c;
    double really_big_input;
    uint64_t expected_answer =3D 0x7ff0000000000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0x92025000;
    reset_fpscr();
    really_big_input =3D 1.7 * pow(10, 308);
    asm volatile("fmul %0, %1, %1" : "=3Df"(c.d) : =
"f"(really_big_input));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("overflow test passed\n");
    } else {
        test_failed("overflow test failed", actual_fpscr, =
expected_fpscr, c.i, expected_answer);
    }
}

/* Test an underflow condition */
void test_underflow()
{
    Converter c;
    uint64_t expected_answer =3D 0x199999999999a;
    uint32_t actual_fpscr, expected_fpscr =3D 0x8a074000;
    reset_fpscr();
    asm volatile("fmadd %0, %1, %2, %3" : "=3Df"(c.d) : "f"(DBL_MIN), =
"f"(0.1), "f"(0.0));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("underflow test passed\n");
    } else {
        test_failed("underflow test failed", actual_fpscr, =
expected_fpscr, c.i, expected_answer);
    }
}

/* Test the fctiw instruction */
void test_fctiw()
{
    Converter c;
    uint64_t expected_answer;
    uint32_t actual_fpscr, expected_fpscr;
    double frB;
   =20
    /* above maximum value test */
    expected_fpscr =3D 0xa0000100;
    expected_answer =3D 0x7fffffff;
    frB =3D pow(2, 32); // greater than 2^31 - 1
    reset_fpscr();
    asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(frB));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
expected_answer) {
        printf("fctiw above maximum value test passed\n");
    } else {
        test_failed("fctiw above maximum value test failed", =
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
    }
   =20
    /* below minimum value test*/
    expected_fpscr =3D 0xa0000100;
    expected_answer =3D 0x80000000;
    frB =3D -frB;  // less than -2^31
    reset_fpscr();
    asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(frB));   =20
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
expected_answer) {
        printf("fctiw below minimum value test passed\n");
    } else {
        test_failed("fctiw below minimum value test failed", =
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
    }

    /* float to integer test */
    expected_fpscr =3D 0x82060000;
    expected_answer =3D 0xd;
    reset_fpscr();
    asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(12.7));   =20
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
expected_answer) {
        printf("fctiw integer conversion test passed\n");
    } else {
        test_failed("fctiw integer conversion test failed", =
actual_fpscr, expected_fpscr, c.i, expected_answer);
    }
}

/* Test the fctiwz instruction */
void test_fctiwz()
{
    Converter c;
    uint64_t expected_answer;
    uint32_t actual_fpscr, expected_fpscr;
    double frB;
   =20
    /* above maximum value test */
    expected_fpscr =3D 0xa0000100;
    expected_answer =3D 0x7fffffff;
    frB =3D pow(2, 32); // greater than 2^31 - 1
    reset_fpscr();
    asm volatile("fctiwz %0, %1" : "=3Df"(c.d) : "f"(frB));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
expected_answer) {
        printf("fctiwz above maximum value test passed\n");
    } else {
        test_failed("fctiwz above maximum value test failed", =
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
    }
   =20
    /* below minimum value test*/
    expected_fpscr =3D 0xa0000100;
    expected_answer =3D 0x80000000;
    frB =3D -frB;  // less than -2^31
    reset_fpscr();
    asm volatile("fctiwz %0, %1" : "=3Df"(c.d) : "f"(frB));   =20
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
expected_answer) {
        printf("fctiwz below minimum value test passed\n");
    } else {
        test_failed("fctiwz below minimum value test failed", =
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
    }

    /* float to integer test */
    expected_fpscr =3D 0x82060000;
    expected_answer =3D 0x1c;
    reset_fpscr();
    asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(27.98));   =20
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
expected_answer) {
        printf("fctiwz integer conversion test passed\n");
    } else {
        test_failed("fctiwz integer conversion test failed", =
actual_fpscr, expected_fpscr, c.i, expected_answer);
    }
}

/* Test the frsp instruction */
void test_frsp()
{
    Converter c;
    uint64_t expected_answer =3D 0x4271f71fc0000000;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
    reset_fpscr();
    asm volatile("frsp %0, %1" : "=3Df"(c.d) : =
"f"(1234567891012.131415));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("frsp test passed\n");
    } else {
        test_failed("frsp test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Test the fnmsub instruction */
void test_fnmsub()
{
    Converter c;
    uint64_t expected_answer =3D 0xc11cdd3cc985f06e;
    uint32_t actual_fpscr, expected_fpscr =3D 0x82028000;
    reset_fpscr();
    asm volatile("fnmsub %0, %1, %2, %3" : "=3Df"(c.d) : "f"(1234.56), =
"f"(456.78), "f"(91011.12));
    actual_fpscr =3D get_fpscr();
    if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
        printf("fnmsub test passed\n");
    } else {
        test_failed("fnmsub test failed", actual_fpscr, expected_fpscr, =
c.i, expected_answer);
    }
}

/* Report the results of all the tests */
void report_results()
{
    if (failed_tests =3D=3D 1) {
        printf("\n=3D=3D=3D Warning: %d test failed =3D=3D=3D\n", =
failed_tests);
    } else if (failed_tests > 1) {
        printf("\n=3D=3D=3D Warning: %d tests failed =3D=3D=3D\n", =
failed_tests);
    } else {
        printf("\n=3D=3D=3D All tests passed =3D=3D=3D\n");
    }
}

int main (int argc, const char * argv[]) {

    test_fadd();
    test_fadds();
    test_fsub();
    test_fsubs();
    test_fmul();
    test_fmuls();
    test_fdiv();
    test_fdivs();
    test_fmadd();
    test_fmadds();   =20
    //test_fsqrt();
    test_inf_minus_inf();
    test_division_by_zero();
    test_zero_div_zero();
    test_inf_div_inf();
    test_inf_times_zero();
    test_overflow();
    test_underflow();
    test_fctiw();
    test_fctiwz();
    test_frsp();
    test_fnmsub();
   =20
    report_results();

    return 0;
}



--Apple-Mail=_5CD3650B-B086-4762-A168-788C3A73FDFE--
