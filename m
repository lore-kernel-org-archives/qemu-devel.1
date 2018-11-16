Received: from eggs.gnu.org ([2001:4830:134:3::10]:50788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gNgFz-00062Y-BQ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gNgFy-00035Y-GP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:42:07 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 16 Nov 2018 15:41:57 +0000
Message-ID: <20181116154137.GC23658@quinoa.localdomain>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-3-aaron@os.amperecomputing.com>
	<CAFEAcA-ryywQJsequ9F2Yhb2So0U5XuojF5B2o6ttPA3hN732Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-ryywQJsequ9F2Yhb2So0U5XuojF5B2o6ttPA3hN732Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA7FBDFA7212B7449D0E61BA66CEF3C0@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 02/12] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On Nov 16 14:50, Peter Maydell wrote:
> On 5 November 2018 at 18:51, Aaron Lindsay <aaron@os.amperecomputing.com>=
 wrote:
> > pmccntr_read and pmccntr_write contained duplicate code that was alread=
y
> > being handled by pmccntr_sync. Consolidate the duplicated code into two
> > functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> > c15_ccnt in CPUARMState so that we can simultaneously save both the
> > architectural register value and the last underlying cycle count - this
> > ensures time isn't lost and will also allow us to access the 'old'
> > architectural register value in order to detect overflows in later
> > patches.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
>=20
>=20
> >  /**
> > - * pmccntr_sync
> > + * pmccntr_op_start/finish
> > + * @env: CPUARMState
> > + *
> > + * Convert the counter in the PMCCNTR between its delta form (the typi=
cal mode
> > + * when it's enabled) and the guest-visible value. These two calls mus=
t always
> > + * surround any action which might affect the counter.
> > + */
> > +void pmccntr_op_start(CPUARMState *env);
> > +void pmccntr_op_finish(CPUARMState *env);
> > +
> > +/**
> > + * pmu_op_start/finish
> >   * @env: CPUARMState
> >   *
> > - * Synchronises the counter in the PMCCNTR. This must always be called=
 twice,
> > - * once before any action that might affect the timer and again afterw=
ards.
> > - * The function is used to swap the state of the register if required.
> > - * This only happens when not in user mode (!CONFIG_USER_ONLY)
> > + * Convert all PMU counters between their delta form (the typical mode=
 when
> > + * they are enabled) and the guest-visible values. These two calls mus=
t
> > + * surround any action which might affect the counters, and the return=
 value
> > + * from pmu_op_start must be supplied as the second argument to pmu_op=
_finish.
> >   */
> > -void pmccntr_sync(CPUARMState *env);
> > +void pmu_op_start(CPUARMState *env);
> > +void pmu_op_finish(CPUARMState *env);
>=20
> The comment says that pmu_op_start returns a value and pmu_op_finish
> has a second argument, but the prototypes disagree...

Doh, I updated the comment for pmccntr_op_* but missed pmu_op_*. The
last sentence should end after the comma:

> > + * Convert all PMU counters between their delta form (the typical mode=
 when
> > + * they are enabled) and the guest-visible values. These two calls mus=
t
> > + * surround any action which might affect the counters.
> >   */

> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> so if this turns out to be the only problem I can fix it up when
> I apply it to my tree, if you provide suitable new comment text.

I've also updated the comment text in my tree, so if/when there is a v8
of this patchset, it won't be lost.

-Aaron
