Received: from eggs.gnu.org ([2001:4830:134:3::10]:45079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjJU-0001NE-Ta
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjJS-0002Lf-RD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:47:08 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 11 Dec 2018 14:46:55 +0000
Message-ID: <20181211144648.GJ5549@quinoa.localdomain>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-15-aaron@os.amperecomputing.com>
	<CAFEAcA8Tt3ygYCZO7ZYkZPwmPQniBu6fLnr+RjNUAmgZdTT0kA@mail.gmail.com>
In-Reply-To: <CAFEAcA8Tt3ygYCZO7ZYkZPwmPQniBu6fLnr+RjNUAmgZdTT0kA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D4C75ADAC02D0448280294E5599843C@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 14/14] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On Dec 06 16:03, Peter Maydell wrote:
> On Wed, 5 Dec 2018 at 13:44, Aaron Lindsay <aaron@os.amperecomputing.com>=
 wrote:
> >
> > Setup a QEMUTimer to get a callback when we expect counters to next
> > overflow and trigger an interrupt at that time.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > ---
> >  target/arm/cpu.c    |  12 +++++
> >  target/arm/cpu.h    |   7 +++
> >  target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 139 insertions(+), 6 deletions(-)
> >
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -733,6 +733,8 @@ struct ARMCPU {
> >
> >      /* Timers used by the generic (architected) timer */
> >      QEMUTimer *gt_timer[NUM_GTIMERS];
> > +    /* Timer used by the PMU */
> > +    QEMUTimer *pmu_timer;
>=20
> We don't seem to migrate this timer state. Is that OK? If so,
> a brief comment somewhere with the rationale would be helpful.

cpu_post_load() calls pmccntr_op_finish() and pmevcntr_op_finish() for
each counter via pmu_op_finish(). They handle setting the timer
according to the restored counters' state. I'll add a comment here at
the definition unless you prefer somewhere else.

-Aaron
