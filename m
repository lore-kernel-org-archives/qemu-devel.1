Received: from eggs.gnu.org ([209.51.188.92]:55811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gjeUl-0007sf-1d
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gjeUb-0002Xb-Ee
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:16:02 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40382)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gjeUb-0002Mh-6C
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:16:01 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<000601d4a8e8$a8a10170$f9e30450$@ru>
	<CANzW0mtY6R0HtZJCoT5OTNdz9+ycrktnbMVjZ0uMAmXT69=N3g@mail.gmail.com>
In-Reply-To: <CANzW0mtY6R0HtZJCoT5OTNdz9+ycrktnbMVjZ0uMAmXT69=N3g@mail.gmail.com>
Date: Wed, 16 Jan 2019 09:16:00 +0300
Message-ID: <001301d4ad62$f3f44820$dbdcd860$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce attributes for timers
 subsystem and remove QEMU_CLOCK_VIRTUAL_EXT clock type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>
Cc: 'qemu-devel' <qemu-devel@nongnu.org>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>

> From: Artem Pisarenko [mailto:artem.k.pisarenko@gmail.com]
> > It seems, that this approach is not always correct.
> > Now timerlist_deadline_ns uses all virtual timers for deadline calculation (including
> external
> > ones).
> > qemu_start_warp_timer uses the deadline for setting warp timer (which should be
> deterministic).
> > Therefore warp timer may become non-deterministic and replay may behave differently compared
> to
> > recording phase.
> >
> > We have to rollback these or improve somehow to avoid non-determinism.
> 
> I dont understand how this approach would even introduce
> non-determinism. I'm not sure about aspects of timers subsystem you
> mentioned, assuming that maybe we missed something when tried to
> optimize. But this has nothing to do with determinism as long as we
> treat all virtual clock timers as deterministic, regardless of
> EXTERNAL attribute being set or not. They are intended to be used as
> such by design, aren't? This attribute was introduced purely to avoid
> extra events in log.

Right, but deadline calculation and icount warp events (that are written into the log too)
depend on the active virtual timers. Therefore external ones may affect icount warp
operation sequence.

Pavel Dovgalyuk
