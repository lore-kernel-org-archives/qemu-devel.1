Received: from eggs.gnu.org ([209.51.188.92]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1ghzZl-00021q-G1
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1ghzZj-0006SO-E8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:22:29 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 11 Jan 2019 16:22:07 +0000
Message-ID: <20190111162205.GB2819@quinoa.localdomain>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C19AC5E1A4D124298E0480D30770486@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

Ping, just in case this got buried over the holidays...

-Aaron

On Dec 11 10:20, Aaron Lindsay wrote:
> The ARM PMU implementation currently contains a basic cycle counter, but
> it is often useful to gather counts of other events, filter them based
> on execution mode, and/or be notified on counter overflow. These patches
> flesh out the implementations of various PMU registers including
> PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
> arbitrary counter types, implement mode filtering, send interrupts on
> counter overflow, and add instruction, cycle, and software increment
> events.
>=20
> Since v9 [1] I have made the following changes:
> * Added a clarifying comment about how the PMU timer's migration is
>   handled
> * Added a check against implementing PMCEID[23] if ID_DFR0.PerfMon =3D=3D
>   0xf
> * Added TRACEFILT to the ID_DFR0 field definitions
>=20
> [1] - https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00805.html
>=20
> Aaron Lindsay (14):
>   migration: Add post_save function to VMStateDescription
>   target/arm: Reorganize PMCCNTR accesses
>   target/arm: Swap PMU values before/after migrations
>   target/arm: Filter cycle counter based on PMCCFILTR_EL0
>   target/arm: Allow AArch32 access for PMCCFILTR
>   target/arm: Implement PMOVSSET
>   target/arm: Define FIELDs for ID_DFR0
>   target/arm: Make PMCEID[01]_EL0 64 bit registers, add PMCEID[23]
>   target/arm: Add array for supported PMU events, generate
>     PMCEID[01]_EL0
>   target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
>   target/arm: PMU: Add instruction and cycle events
>   target/arm: PMU: Set PMCR.N to 4
>   target/arm: Implement PMSWINC
>   target/arm: Send interrupts on PMU counter overflow
>=20
>  docs/devel/migration.rst    |   9 +-
>  include/migration/vmstate.h |   1 +
>  migration/vmstate.c         |  13 +-
>  target/arm/cpu.c            |  28 +-
>  target/arm/cpu.h            |  81 +++-
>  target/arm/cpu64.c          |   4 -
>  target/arm/helper.c         | 808 ++++++++++++++++++++++++++++++++----
>  target/arm/machine.c        |  24 ++
>  8 files changed, 863 insertions(+), 105 deletions(-)
>=20
> --=20
> 2.19.2
>=20
