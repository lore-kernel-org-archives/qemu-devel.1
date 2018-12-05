Received: from eggs.gnu.org ([2001:4830:134:3::10]:37090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUWnh-0003ni-FP
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUWnb-0007ux-Lp
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:01:13 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:00:52 +0000
Message-ID: <20181205130047.GC5549@quinoa.localdomain>
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-8-aaron@os.amperecomputing.com>
	<CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
	<20181203204452.GB5549@quinoa.localdomain>
	<CAFEAcA900U3amGOGRKGNu+-j9EDhdrZ1U1U5MtoW5BeTo74iOQ@mail.gmail.com>
	<05205391-27bf-c6be-bc71-648eee127c47@linaro.org>
In-Reply-To: <05205391-27bf-c6be-bc71-648eee127c47@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6952A6B6FE1A5B4BB7CF61744BF78C88@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Dec 03 16:57, Richard Henderson wrote:
> On 12/3/18 4:19 PM, Peter Maydell wrote:
> > On Mon, 3 Dec 2018 at 20:45, Aaron Lindsay <aaron@os.amperecomputing.co=
m> wrote:
> >>
> >> On Nov 30 16:10, Peter Maydell wrote:
> >>> PMCEID2 and PMCEID3 are only defined from ARMv8.1; before that they
> >>> are UNDEFINED. So these registers need to be only defined if a
> >>> suitable feature bit or ID register field check passes.
> >>
> >> It looks like we don't currently support any ARMv8.1+ CPUs and don't
> >> have an entry in the `arm_features` enum for it. I'll plan to add
> >> ARM_FEATURE_V81 and make defining these registers depend on it, assumi=
ng
> >> any future CPUs supporting it will use that, unless you feel I should =
do
> >> something different.
> >=20
> > I think that the idea going forward is to prefer an ID
> > register check of some kind -- Richard ?
>=20
> Yes.  It would appear that this feature should be controlled by
> ID_DFR0.PerfMon.  So,
>=20
>   if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >=3D 4)
>=20
> once the appropriate FIELDs are added to cpu.h.
>=20
> Since this test is not used within translate*.c, there is no need to move
> id_dfr* into ARMISARegisters.  Since these are only aliases, they do not =
affect
> migration, and so do not (yet) need to be filled in by kvm.

Sounds reasonable to me. One clarification - do we also need to guard
against the 0b1111 value for ID_DFR0.PerfMon, which implies an
implementation-defined, non-PMUv3 PMU, or is it safe to assume no one
will attempt that flavor in QEMU?

-Aaron
