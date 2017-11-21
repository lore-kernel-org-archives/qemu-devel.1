Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eHCQg-0007kh-Tf
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eHCQd-00028k-Ly
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:33:50 -0500
Message-ID: <1511285617.862.65.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 21 Nov 2017 17:33:37 +0000
In-Reply-To: <8760a4x8f9.fsf@linaro.org>
References: <1511222455.862.5.camel@linuxfoundation.org>
	<8760a4x8f9.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-system-ppc hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, david@gibson.dropbear.id.au

On Tue, 2017-11-21 at 09:55 +0000, Alex Benn=C3=A9e wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> > At this point I therefore wanted to seek advice on what the real
> > issue
> > is here and how to fix it!
> Code should be using cpu_interrupt() to change things but we have
> plenty
> of examples in the code of messing with cpu->interrupt_request
> directly
> which is often why the assert() in cpu_interrupt() doesn't get a
> chance
> to fire.
>=20
> The two most prolific direct users seems to be i386 and ppc.
>=20
> The i386 cases are all most likely OK as it tends to be in KVM
> emulation
> code where by definition the BQL is already held by the time you get
> there. For PPC it will depend on how you got there. The
> multi-thread-tcg.txt document describes the approach:
>=20
> =C2=A0 Emulated hardware state
> =C2=A0 -----------------------
>=20
> =C2=A0 Currently thanks to KVM work any access to IO memory is
> automatically
> =C2=A0 protected by the global iothread mutex, also known as the BQL (B=
ig
> =C2=A0 Qemu Lock). Any IO region that doesn't use global mutex is expec=
ted
> to
> =C2=A0 do its own locking.
>=20
> =C2=A0 However IO memory isn't the only way emulated hardware state can=
 be
> =C2=A0 modified. Some architectures have model specific registers that
> =C2=A0 trigger hardware emulation features. Generally any translation
> helper
> =C2=A0 that needs to update more than a single vCPUs of state should ta=
ke
> the
> =C2=A0 BQL.
>=20
> =C2=A0 As the BQL, or global iothread mutex is shared across the system=
 we
> =C2=A0 push the use of the lock as far down into the TCG code as possib=
le
> to
> =C2=A0 minimise contention.
>=20
> =C2=A0 (Current solution)
>=20
> =C2=A0 MMIO access automatically serialises hardware emulation by way o=
f
> the
> =C2=A0 BQL. Currently ARM targets serialise all ARM_CP_IO register
> accesses
> =C2=A0 and also defer the reset/startup of vCPUs to the vCPU context by
> way
> =C2=A0 of async_run_on_cpu().
>=20
> =C2=A0 Updates to interrupt state are also protected by the BQL as they
> can
> =C2=A0 often be cross vCPU.
>=20
> So basically it comes down to the call-path into your final
> cpu_interrupt() call which is why I guess your doing the:
>=20
> =C2=A0 if (!qemu_mutex_iothread_locked()) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_lock_iothread();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock_iothread();
> =C2=A0 }
>=20
> dance. I suspect the helper functions are called both from device
> emulation (where BQL is held) and from vCPU helpers (where it is
> currently not).
>=20
> So I suggest the fix is:
>=20
> =C2=A01. Convert sites doing their own manipulation of
> =C2=A0cpu->interrupt_request() to call the helper instead
> =C2=A02. If helper directly called from TCG code:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- take BQL before calling cpu_inter=
rupt(), release after
> =C2=A0=C2=A0=C2=A0=C2=A0Else if helper shared between MMIO/TCG paths
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- take BQL from TCG path, call help=
er, release after
>=20
> It might be there is some sensible re-factoring that could be done to
> make things clearer but I'll leave that to the PPC experts to weigh
> in
> on.
>=20
> Hope that helps!

It does indeed, thanks. I've sent out a proposed patch which does the
above so people can review it and see if its the right thing to do.
Certainly its working fine locally.

Cheers,

Richard
