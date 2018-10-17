Received: from eggs.gnu.org ([2001:4830:134:3::10]:46191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gCrna-0001m8-Pc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gCrnZ-00074L-V7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:48:06 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Wed, 17 Oct 2018 19:47:56 +0000
Message-ID: <20181017194748.GB25905@quinoa.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-12-aclindsa@gmail.com>
	<be878ed3-509f-8ed8-8c28-71e3d0214837@linaro.org>
In-Reply-To: <be878ed3-509f-8ed8-8c28-71e3d0214837@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A24947424E333C4CB64BD13C977E49A7@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 11/14] target/arm: PMU: Add instruction
 and cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aaron Lindsay <aclindsa@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On Oct 16 17:04, Richard Henderson wrote:
> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> > + * Return the underlying cycle count for the PMU cycle counters. If we=
're in
> > + * usermode, simply return 0.
> > + */
> > +static uint64_t cycles_get_count(CPUARMState *env)
> > +{
> > +#ifndef CONFIG_USER_ONLY
> > +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > +                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> > +#else
> > +    return 0;
> > +#endif
> > +}
>=20
> Usually we pass through the host cycle counter.
> See cpu_get_host_ticks().

Why do you prefer cpu_get_host_ticks()? And are you suggesting this for
just user-mode, or both system and user?

PMCCNTR used this same qemu_clock_get_ns() call previous to my patch
(see where this patch replaces that call with one to cycles_get_count()
in pmccntr_op_start()). Of course, we could keep the preexisting PMCCNTR
behavior while making the new cycle counter use cpu_get_host_ticks(),
but having two ways through the same interface which count cycles
differently feels wrong.

-Aaron
