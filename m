Received: from eggs.gnu.org ([2001:4830:134:3::10]:51330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gKgSi-0005oy-Bl
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gKgSe-0006bs-8w
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:18:52 -0500
Received: from mail-eopbgr700129.outbound.protection.outlook.com
	([40.107.70.129]:51576
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gKgSc-0006Ig-8R
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:18:47 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 8 Nov 2018 09:18:28 +0000
Message-ID: <BN6PR2201MB125149DC3207B92416CF18AEC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540498768-8736-4-git-send-email-aleksandar.markovic@rt-rk.com>,
	<03cea7f3-cbb7-6e4d-3104-01aba47cde09@weilnetz.de>
In-Reply-To: <03cea7f3-cbb7-6e4d-3104-01aba47cde09@weilnetz.de>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 3/3] target/mips: Add disassembler support
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>

Hello, Stefan.

I appreciate your note and guidance.

>=20
> On 25.10.18 22:19, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >=20
> > Add disassembler support for nanoMIPS.
> >=20
> > Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> > Signed-off-by: Matthew Fortune <matthew.fortune@mips.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  MAINTAINERS           |     2 +
> >  configure             |     3 +
> >  disas/Makefile.objs   |     1 +
> >  disas/nanomips.cpp    | 22242 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  disas/nanomips.h      |  1099 +++
> >  include/disas/bfd.h   |     1 +
> >  include/exec/poison.h |     1 +
> >  target/mips/cpu.c     |    13 +-
> >  8 files changed, 23360 insertions(+), 2 deletions(-)
> >  create mode 100644 disas/nanomips.cpp
> >  create mode 100644 disas/nanomips.h
>=20
>=20
> Hi,
>=20
> the disassembler needs more work for the next QEMU release: it uses lots
> of wrong format strings which will result in wrong output at least on
> big endian hosts.
>=20
> This patch enables the compiler errors to see those bugs:
>=20
> diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
> index 1238c2ff33..62be5b6d00 100644
> --- a/disas/nanomips.cpp
> +++ b/disas/nanomips.cpp
> @@ -138,7 +138,7 @@ namespace img
>          return a;
>      }
>=20
> -    std::string format(const char *format, ...)
> +    std::string GCC_FMT_ATTR(1, 2) format(const char *format, ...)
>      {
>          char buffer[256];
>          va_list args;
>=20

After applying this oatch, I see these warnings:=20

rtrk@rtrkw774-lin:~/Build/qemu-tot$ make
	CHK version_gen.h
  CXX     disas/nanomips.o
disas/nanomips.cpp: In member function =91uint64 NMD::renumber_registers(ui=
nt64, uint64*, size_t)=92:
disas/nanomips.cpp:288:45: error: format =91%d=92 expects argument of type =
=91int=92, but argument 2 has type =91uint64 {aka long long unsigned int}=
=92 [-Werror=3Dformat=3D]
                    index, register_list_size));
                                             ^
disas/nanomips.cpp:288:45: error: format =91%d=92 expects argument of type =
=91int=92, but argument 3 has type =91size_t {aka long unsigned int}=92 [-W=
error=3Dformat=3D]
disas/nanomips.cpp: In member function =91std::__cxx11::string NMD::GPR(uin=
t64)=92:
disas/nanomips.cpp:504:78: error: format =91%d=92 expects argument of type =
=91int=92, but argument 2 has type =91uint64 {aka long long unsigned int}=
=92 [-Werror=3Dformat=3D]
     throw std::runtime_error(img::format("Invalid GPR register index %d", =
reg));
                                                                           =
   ^
disas/nanomips.cpp: In member function =91std::__cxx11::string NMD::FPR(uin=
t64)=92:
disas/nanomips.cpp:521:78: error: format =91%d=92 expects argument of type =
=91int=92, but argument 2 has type =91uint64 {aka long long unsigned int}=
=92 [-Werror=3Dformat=3D]
     throw std::runtime_error(img::format("Invalid FPR register index %d", =
reg));
                                                                           =
   ^
disas/nanomips.cpp: In member function =91std::__cxx11::string NMD::AC(uint=
64)=92:
disas/nanomips.cpp:535:77: error: format =91%d=92 expects argument of type =
=91int=92, but argument 2 has type =91uint64 {aka long long unsigned int}=
=92 [-Werror=3Dformat=3D]
     throw std::runtime_error(img::format("Invalid AC register index %d", r=
eg));
                                                                           =
  ^
disas/nanomips.cpp: In member function =91std::__cxx11::string NMD::IMMEDIA=
TE(uint64)=92:
disas/nanomips.cpp:541:37: error: format =91%x=92 expects argument of type =
=91unsigned int=92, but argument 2 has type =91uint64 {aka long long unsign=
ed int}=92 [-Werror=3Dformat=3D]
     return img::format("0x%x", value);
                                     ^
disas/nanomips.cpp: In member function =91std::__cxx11::string NMD::IMMEDIA=
TE(int64)=92:
disas/nanomips.cpp:547:35: error: format =91%d=92 expects argument of type =
=91int=92, but argument 2 has type =91int64 {aka long long int}=92 [-Werror=
=3Dformat=3D]
     return img::format("%d", value);
                                   ^
disas/nanomips.cpp: In member function =91std::__cxx11::string NMD::CPR(uin=
t64)=92:
disas/nanomips.cpp:554:35: error: format =91%d=92 expects argument of type =
=91int=92, but argument 2 has type =91uint64 {aka long long unsigned int}=
=92 [-Werror=3Dformat=3D]
     return img::format("CP%d", reg);
                                   ^
cc1plus: all warnings being treated as errors
/home/rtrk/Build/qemu-tot/rules.mak:94: recipe for target 'disas/nanomips.o=
' failed
make: *** [disas/nanomips.o] Error 1

Did you have the same warnings? Is there any way to get more similar warnin=
gs?

Can I modify:

    std::string format(const char *format,
                       std::string s)
    {
        char buffer[256];

        sprintf(buffer, format, s.c_str());

        return buffer;
    }

to get some more warnings of that kind?

In all cases of warnings above, int64 is avoidable - it is used for things =
like ordinal number of a register, which is obviously a small integer.

The whole disassembler, it looks to me, does not need 64-bit integers, exce=
pt in some limited cases of decoding 48-bit instructions.

In any case, a cleanup is planned for the 3.2., for this and other things. =
I'll think about that.

Thanks,
Aleksandar


> I also noticed that the code does not use POSIX data types but
> introduces its own integer types in disas/nanomips.h. This should be
> fixed, too, because it prevents the use of PRIu64 etc. in the format
> strings.
>=20
> Regards
> Stefan Weil
>=20
