Received: from eggs.gnu.org ([2001:4830:134:3::10]:47781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDB2q-0006Vk-9p
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDB2p-0002fz-Ge
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:21:08 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Thu, 18 Oct 2018 16:20:58 +0000
Message-ID: <20181018162048.GB12691@quinoa.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-12-aclindsa@gmail.com>
	<be878ed3-509f-8ed8-8c28-71e3d0214837@linaro.org>
	<20181017194748.GB25905@quinoa.localdomain>
	<32172d01-329a-764e-449c-efb83e353353@linaro.org>
In-Reply-To: <32172d01-329a-764e-449c-efb83e353353@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DAC7DC327D9204CA1FBEF57E22DC5F1@prod.exchangelabs.com>
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

On Oct 17 14:12, Richard Henderson wrote:
> On 10/17/18 12:47 PM, Aaron Lindsay wrote:
> > On Oct 16 17:04, Richard Henderson wrote:
> >> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> >>> + * Return the underlying cycle count for the PMU cycle counters. If =
we're in
> >>> + * usermode, simply return 0.
> >>> + */
> >>> +static uint64_t cycles_get_count(CPUARMState *env)
> >>> +{
> >>> +#ifndef CONFIG_USER_ONLY
> >>> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> >>> +                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> >>> +#else
> >>> +    return 0;
> >>> +#endif
> >>> +}
> >>
> >> Usually we pass through the host cycle counter.
> >> See cpu_get_host_ticks().
> >=20
> > Why do you prefer cpu_get_host_ticks()? And are you suggesting this for
> > just user-mode, or both system and user?
>=20
> Just user-mode.  Providing a clock with unknown scaling is more useful th=
an a
> constant 0.

Okay, that makes sense I think. I slightly dislike the fact that the
behavior is silently different between user and system mode, but perhaps
some documentation could alleviate my concern - is there an appropriate
place to document this difference?

It occurs to me that one argument for always returning 0 is that it's
immediately obvious that the behavior is different from system mode,
eliminating the possibility of a user assuming results from user and
system mode are comparable.

-Aaron
