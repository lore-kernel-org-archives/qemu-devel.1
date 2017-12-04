Received: from eggs.gnu.org ([2001:4830:134:3::10]:40097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eLzEJ-0005Ze-FN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eLzEI-0006uz-JP
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:28:51 -0500
Message-ID: <1512426516.862.222.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 04 Dec 2017 22:28:36 +0000
In-Reply-To: <20171204014422.GJ2130@umbus.fritz.box>
References: <1512143347-20128-1-git-send-email-richard.purdie@linuxfoundation.org>
	<20171204010040.GF2130@umbus.fritz.box>
	<20171204014422.GJ2130@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] target/ppc: Fix system
 lockups caused by interrupt_request state corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Mon, 2017-12-04 at 12:44 +1100, David Gibson wrote:
> On Mon, Dec 04, 2017 at 12:00:40PM +1100, David Gibson wrote:
> >=20
> > On Fri, Dec 01, 2017 at 03:49:07PM +0000, Richard Purdie wrote:
> > >=20
> > > Occasionally in Linux guests on x86_64 we're seeing logs like:
> > >=20
> > > ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending
> > > 00000100req 00000004
> > >=20
> > > when they should read:
> > >=20
> > > ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending
> > > 00000100req 00000002
> > >=20
> > > The "00000004" is CPU_INTERRUPT_EXITTB yet the code calls
> > > cpu_interrupt(cs, CPU_INTERRUPT_HARD) ("00000002") in this
> > > function
> > > just before the log message. Something is causing the HARD bit
> > > setting
> > > to get lost.
> > >=20
> > > The knock on effect of losing that bit is the decrementer timer
> > > interrupts
> > > don't get delivered which causes the guest to sit idle in its
> > > idle handler
> > > and 'hang'.
> > >=20
> > > The issue occurs due to races from code which sets
> > > CPU_INTERRUPT_EXITTB.
> > >=20
> > > Rather than poking directly into cs->interrupt_request, that code
> > > needs to:
> > >=20
> > > a) hold BQL
> > > b) use the cpu_interrupt() helper
> > >=20
> > > This patch fixes the call sites to do this, fixing the hang.
> > >=20
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> > > >
> > I strongly suspect there's a better way to do this long term - a
> > lot
> > of that old ppc TCG code is really crufty.=C2=A0=C2=A0But as best I c=
an tell,
> > this is certainly a fix over what we had.=C2=A0=C2=A0So, applied to
> > ppc-for-2.11.
> I take that back.=C2=A0=C2=A0Running make check with this patch results=
 in:
>=20
> =C2=A0 GTESTER check-qtest-ppc64
> **
> ERROR:/home/dwg/src/qemu/cpus.c:1582:qemu_mutex_lock_iothread:
> assertion failed: (!qemu_mutex_iothread_locked())
> Broken pipe
> qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
> GTester: last random seed: R02S895b0f4813776bf68c147bf987e73f7b
> make: *** [/home/dwg/src/qemu/tests/Makefile.include:852: check-
> qtest-ppc64] Error 1
>=20
> So, I've reverted it.

Sorry about that. I tried to stress the code paths and no issues showed
up in our testing but hadn't realised those tests existed.

Given there do seem to be mixed locked and unlocked code paths I've
taken a different approach and sent a v3 which passes those tests.

I do agree with you that there is probably a better way but that would
need someone with a better understanding of the bigger picture than I
have. This patch does stop our image tests locking up so does seem to
fix a valid/real problem which people can run into.

Cheers,

Richard
