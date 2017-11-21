Received: from eggs.gnu.org ([2001:4830:134:3::10]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eGvzy-0006lL-CO
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eGvzt-0002eF-HR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:01:10 -0500
Message-ID: <1511222455.862.5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 21 Nov 2017 00:00:55 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu-system-ppc hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi,

I work on the Yocto Project and we use qemu to test boot our Linux
images and run tests against them. We've been noticing some instability
for ppc where the images sometimes hang, usually around udevd bring up
time so just after booting into userspace.

To cut a long story short, I've tracked down what I think is the
problem. I believe the decrementer timer stops receiving interrupts so
tasks in our images hang indefinitely as the timer stopped.=C2=A0

It can be summed up with this line of debug:

ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 0000=
0004

It should normally read:

ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level=C2=A01 =3D> pending 00000100req=
 00000002

The question is why=C2=A0CPU_INTERRUPT_EXITTB ends up being set when the
lines above this=C2=A0log message clearly sets=C2=A0CPU_INTERRUPT_HARD (v=
ia=C2=A0
cpu_interrupt() ).

I note in cpu.h:

=C2=A0=C2=A0=C2=A0=C2=A0/* updates protected by BQL */
=C2=A0=C2=A0=C2=A0=C2=A0uint32_t interrupt_request;

(for struct CPUState)

The ppc code does "cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB" in 5
places, 3 in excp_helper.c and 2 in helper_regs.h. In all cases, =C2=A0
g_assert(qemu_mutex_iothread_locked()); fails. If I do something like:

if (!qemu_mutex_iothread_locked()) {
=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_lock_iothread();
=C2=A0=C2=A0=C2=A0=C2=A0cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock_iothread();
} else {
=C2=A0=C2=A0=C2=A0=C2=A0cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
}

in these call sites then I can no longer lock qemu up with my test
case.

I suspect the _HARD setting gets overwritten which stops the=C2=A0
decrementer interrupts being delivered.

I don't know if taking this lock in these situations is going to be bad
for performance and whether such a patch would be right/wrong.

At this point I therefore wanted to seek advice on what the real issue
is here and how to fix it!

Cheers,

Richard
