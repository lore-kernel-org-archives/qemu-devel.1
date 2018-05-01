Received: from eggs.gnu.org ([2001:4830:134:3::10]:59968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Matthew.Fortune@mips.com>) id 1fDWrz-0006KZ-1l
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Matthew.Fortune@mips.com>) id 1fDWrv-00063x-MJ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:07:07 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:53481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Matthew.Fortune@mips.com>)
	id 1fDWrv-00062l-GB
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:07:03 -0400
From: Matthew Fortune <Matthew.Fortune@mips.com>
Date: Tue, 1 May 2018 15:07:14 +0000
Message-ID: <02284e13e9c541cda32051204e64fa66@mips.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Introducing a nanoMIPS port for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yongbok Kim <Yongbok.Kim@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>, Aleksandar Rikalo <Aleksandar.Rikalo@mips.com>, Dimitrije Nikolic <Dimitrije.Nikolic@mips.com>, James Hogan <James.Hogan@mips.com>, Paul Burton <Paul.Burton@mips.com>

Earlier today MIPS Tech announced the latest generation of the MIPS family =
of
architectures called nanoMIPS [1]. As part of the development we have been
designing all the open source tools necessary to support the architecture a=
nd,
thanks to the speed with which we were able to prototype, we have also been
using these tools to shape the architecture along the way. This has led to =
some
really interesting improvements in the tools, which MIPS would like to
contribute back to the community. While doing this work many of us have bee=
n
unable to contribute to the community as actively as we would have liked, w=
e
are therefore very grateful for the community support given to the MIPS
architecture over the last 18 months. This announcement has a general
introduction at the start, so if you have already read it for one of the ot=
her
tools, you can skip down to the information specific to QEMU.

For anyone who knows the MIPS architecture you may well wonder why we are
introducing another major variant and the question is perfectly valid. We d=
o
admittedly have quite a few: MIPS I through MIPS IV, MIPS32 and MIPS64 thro=
ugh
to MIPS32R6 and MIPS64R6, MIPS16e, MIPS16e2, microMIPSR3 and microMIPSR6. E=
ach
of these serves (or served) a purpose and there is a high level of synergy
between all of them. In general, they build upon the previous and there is =
a
high level of compatibility, even when switching to a new encoding like mov=
ing
from MIPS to microMIPS. The switch to MIPS32R6/MIPS64R6 was a major shift i=
n
the way the architecture innovated and drew more on the original theory of =
the
architecture, where evolution was not expected to be limited by binary
compatibility. MIPS Release 6 removed instructions and did create some very
minor incompatibility but is also much cleaner to implement from a
micro-architecture perspective. We have taken this idea much further with
nanoMIPS and reimagined the instruction set, by drawing on all the experien=
ce
gained from previous designs. Hopefully others will find it as interesting =
as
we do.

The major driving force behind the nanoMIPS architecture was to achieve
outstanding code density, while also balancing out hardware and software de=
sign
cost. As background MIPS has two compressed ISA variants: MIPS16e, which ca=
nnot
exist without also implementing MIPS32, and microMIPS, which can exist on i=
ts
own. Since MIPS16e has specific limits that cannot be engineered around, we
chose to use an approach similar to the microMIPS design.

nanoMIPS has a variable-length compressed instruction set that is completel=
y
standalone from the other MIPS ISAs. It is designed to compress the highest
frequency instructions to 16-bits, and use 48-bit instructions to efficient=
ly
encode 32-bit constants into the instruction stream. There is also a wider
range of 32-bit instructions, which merge carefully chosen high frequency
instruction sequences into single operations creating more flexible address=
ing
modes such as indexed and scaled indexed addressing, branch compare with
immediate and macro style instructions. The macro like instructions compres=
s
prologue and epilogue sequences, as well as a small number of high frequenc=
y
instruction pairs like two move instructions or a move and function call.
nanoMIPS also totally eliminates branch delay slots which follows a precede=
nt
set by microMIPSR6.

To get the best from a new ISA we also re-engineered the ABI and created a =
new
symbiotic relationship between the ISA and ABI that pushes code density and
performance further still. The ABI creates a fully link time relaxable mode=
l,
which enables us to squeeze every last byte out of the code image even when
deferring final addressing mode and layout decisions to link time. We have =
been
mindful of MIPS heritage and ensured that while open to any possible change=
, we
also have minimal impact when porting code from MIPS to nanoMIPS, and have
plenty of support to achieve source compatibility between the two.

The net effect of these changes leads to an average code size reduction of =
20%
relative to microMIPSR6. This compression could well be one of the best
achieved by GNU tools for any RISC ISA. Comparing the ISA in terms of numbe=
r of
instructions to issue vs microMIPS we also see a reduction of between 8% an=
d
11% of dynamic instruction count.

Below we dig into some technical specifics for QEMU; we welcome any feedbac=
k
and questions as we start to look at rebasing this work to the trunk/master
and formally submitting it. nanoMIPS pre-built toolchains and source code
tarballs are available at:

http://codescape.mips.com/components/toolchain/nanomips/2018.04-02/

QEMU specific details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The nanoMIPS QEMU port borrows a significant amount of logic from the MIPS
port. Most instructions in nanoMIPS exist in one of the other MIPS ISAs, wh=
ich
allows the new decoder to hook into existing logic. Some of the more
interesting technical changes include:

- The Unified Hosting Interface (UHI) for semihosting is supported and,
  in-keeping with the aims of the interface, the same ABI is used with nano=
MIPS
  as MIPS
- Linux user-mode support has been updated significantly, compared to MIPS,=
 to
  follow the new nanoMIPS ABI which utilizes most of the generic syscall an=
d
  signal infrastructure from the Linux kernel

The QEMU build targets for nanoMIPS are nanomips-softmmu and
nanomips-linux-user, rather than the existing mips targets, because nanoMIP=
S is
not designed for use alongside any other MIPS ISA.

QEMU contributors:

- QEMU
  Yongbok Kim, Stefan Markovic, Aleksandar Rikalo, Dimitrije Nikolic
  Aleksandra Karadzic, Matthew Fortune, Paul Burton, James Hogan

[1] https://www.mips.com/press/new-mips-i7200-processor-core-delivers-unmat=
ched-performance-and-efficiency-for-advanced-lte5g-communications-and-netwo=
rking-ic-designs/
