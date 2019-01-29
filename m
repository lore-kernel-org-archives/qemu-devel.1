Received: from eggs.gnu.org ([209.51.188.92]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1goSr9-0003i8-6W
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1goSr8-00082I-DM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:51:11 -0500
Date: Tue, 29 Jan 2019 12:51:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190129125101.GC25983@lakrids.cambridge.arm.com>
References: <87va27n2l8.fsf@linaro.org>
	<20190129114609.GA25983@lakrids.cambridge.arm.com>
	<CAFEAcA-_ShbUthqPSPgEPmV0EeRUO85n=sC-+76gRAH830co_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_ShbUthqPSPgEPmV0EeRUO85n=sC-+76gRAH830co_g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Kernel boot regression with PAuth and
 aarch64-softmmu -cpu max and el2 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Kristina Martsenko <kristina.martsenko@arm.com>, "open list:ARM" <qemu-arm@nongnu.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 29, 2019 at 11:54:13AM +0000, Peter Maydell wrote:
> On Tue, 29 Jan 2019 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > On Tue, Jan 29, 2019 at 11:08:19AM +0000, Alex Benn=C3=A9e wrote:
> > > The -cpu max enabled a cortex-a57 + whatever extra features we've
> > > enabled in QEMU so far. It won't match any "real" CPU but it should=
 be
> > > architecturally correct in so far we implement prerequisite feature=
s for
> > > any given feature. The cpuid feature bits should also be correct as=
 we
> > > test them internally in QEMU to enable features.
> >
> > Just to check, does this enable VHE?
>=20
> It does not. (We have no implementation of VHE yet -- as and when
> we do implement that "-cpu max" will turn it on, but today it doesn't.)

Ok. In that case, the kernel should drop to EL1N and stay there after it
configures EL2.

There are no pointer authentication traps taken to EL1N, so if something
is going wrong, I suspect either:

* a trap is taken to EL2, and we hyp_panic()
* an UNDEF is being taken to EL1N

Thanks,
Mark.
