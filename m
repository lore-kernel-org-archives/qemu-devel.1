Received: from eggs.gnu.org ([2001:4830:134:3::10]:35937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cnlHV-0001oi-FH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cnlHQ-0000Yl-I8
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:10:25 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cnlHQ-0000YX-AP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:10:20 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
	<000601d29710$edf987b0$c9ec9710$@ru> <874lyxqpl4.fsf@linaro.org>
In-Reply-To: <874lyxqpl4.fsf@linaro.org>
Date: Tue, 14 Mar 2017 15:10:19 +0300
Message-ID: <000001d29cbb$f396a800$dac3f800$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off introduces unexpected delays in device interactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: "'Nutaro, James J.'" <nutarojj@ornl.gov>, mttcg@listserver.greensocs.com, pbonzini@redhat.com, qemu-devel@nongnu.org

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> > I also encountered icount problems with new MTTCG patches.
> >
> > Record/replay now cannot work, because iothread requests timers
> > without kicking the CPU. And cpu thread updates icount (that
> > are used for the clock).
>=20
> The interaction of kicking the vCPU while grabbing the BQL was a
> side-effect. This is now done explicitly for single-threaded emulation
> by (6546706d28):
>=20
>   tcg: add kick timer for single-threaded vCPU emulation

This is not the same.
BQL helped in making execution deterministic - no io and timer
callbacks were performed while CPU is executing.
Now iothread and CPU thread work simultaneously and timers can't
query virtual time correctly, because (if we could query number of =
executed
instructions) it may have different values on different runs.

I guess you'll have to bring kicking CPU back on iothread invocation
to make execution deterministic in icount mode.

>=20
> > Therefore invocation of iothread uses incorrect clock and
> > all virtual timers behave incorrectly.
> >
> > Record/replay is also broken because current icount is requested
> > from iothread where current_cpu (and icount progress stored in =
icount_extra)
> > is unavailable.
>=20
> I'm working through Paolo's series now but I don't see it as
> insurmountable. The aim of keeping current_cpu set only during the
> cpu-exec loop was intentional because the system as a whole can't make
> assumptions about it always being valid.


Pavel Dovgalyuk
