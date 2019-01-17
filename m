Received: from eggs.gnu.org ([209.51.188.92]:44614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gk2K3-0001rO-KD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gk2K2-0001Dn-QK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:42:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:58390)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gk2K2-00013X-HQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:42:42 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<000601d4a8e8$a8a10170$f9e30450$@ru>
	<CANzW0mtY6R0HtZJCoT5OTNdz9+ycrktnbMVjZ0uMAmXT69=N3g@mail.gmail.com>
	<001301d4ad62$f3f44820$dbdcd860$@ru>
	<CANzW0mtVkiZJdYMytbDf2QwGDKTKL453zNbQDV6=xO=XvewmZg@mail.gmail.com>
In-Reply-To: <CANzW0mtVkiZJdYMytbDf2QwGDKTKL453zNbQDV6=xO=XvewmZg@mail.gmail.com>
Date: Thu, 17 Jan 2019 10:42:33 +0300
Message-ID: <000601d4ae38$35431f60$9fc95e20$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
> =D1=81=D1=80, 16 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 12:15, Pavel =
Dovgalyuk <dovgaluk@ispras.ru>:
> >
> > > From: Artem Pisarenko [mailto:artem.k.pisarenko@gmail.com]
> > > > It seems, that this approach is not always correct.
> > > > Now timerlist_deadline_ns uses all virtual timers for deadline =
calculation (including
> > > external
> > > > ones).
> > > > qemu_start_warp_timer uses the deadline for setting warp timer =
(which should be
> > > deterministic).
> > > > Therefore warp timer may become non-deterministic and replay may =
behave differently
> compared
> > > to
> > > > recording phase.
> > > >
> > > > We have to rollback these or improve somehow to avoid =
non-determinism.
> > >
> > > I dont understand how this approach would even introduce
> > > non-determinism. I'm not sure about aspects of timers subsystem =
you
> > > mentioned, assuming that maybe we missed something when tried to
> > > optimize. But this has nothing to do with determinism as long as =
we
> > > treat all virtual clock timers as deterministic, regardless of
> > > EXTERNAL attribute being set or not. They are intended to be used =
as
> > > such by design, aren't? This attribute was introduced purely to =
avoid
> > > extra events in log.
> >
> > Right, but deadline calculation and icount warp events (that are =
written into the log too)
> > depend on the active virtual timers. Therefore external ones may =
affect icount warp
> > operation sequence.
> >
> > Pavel Dovgalyuk
> >
>=20
> Sorry, but I still don't understand the source of non-determinism.

The source is the external timers, that depend on "outer world", e.g., =
slirp.
These timers are not recorded/replayed, but may affect the icount =
warping
(which should remain deterministic).

> From what you said I may understand that replay module actually has
> some additional non-trivial (for me) dependencies on EXTERNAL
> attribute other than one, introduced in 'timerlist_run_timers()' (i.e.
> it expects deadline calculations somewhere else to match decisions
> made in this function, or something like that). I would agree that
> these patch series might introduce some incorrect behavior. But it
> must be identical in all emulations running in same conditions,
> because deadline, warp timer and their effects are all dependent only
> on virtual timers, and, therefore, are deterministic too. Of course,
> it needs to be fixed. Did you find solution ?

Please check the new version of the series.
Patch 22

Pavel Dovgalyuk
