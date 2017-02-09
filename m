Received: from eggs.gnu.org ([2001:4830:134:3::10]:56610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbdWX-0003Ef-Go
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbdWW-0005wX-D1
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:27:49 -0500
Date: Thu, 9 Feb 2017 09:27:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170209012739.GE22807@lemon.lan>
References: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
	<08b13ba8-5e66-5fd9-3c4f-b567e87137d8@redhat.com>
	<20170208143008.GC22807@lemon.lan>
	<CACSixLqwwEw+oPPJzg=Z=NAAN8WBDiynhbvbAhY-MbPBnHqWnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACSixLqwwEw+oPPJzg=Z=NAAN8WBDiynhbvbAhY-MbPBnHqWnQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question about QEMU's threading model and stacking
 multiple block drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adrian Suarez <adrian@eitrsystems.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 02/08 11:00, Adrian Suarez wrote:
> >
> > Do you only start submitting request to B (step 3) after the fast dev=
ice
> > I/O
> > completes (step 2.a)? The fact that they are serialized incurs extra
> > latency.
> > Have you tried to do 2 and 3 in parallel with AIO?
>=20
>=20
> In step 2, we perform an asynchronous call to the fast device, supplyin=
g a
> callback that calls aio_bh_schedule_oneshot() to schedule the completio=
n in
> the AioContext of the block driver. Step 3 uses bdrv_aio_writev(), but =
I'm
> not sure if this is actually causing the write to be performed
> synchronously to the backing device. What I'm expecting is that
> bdrv_aio_writev() issues the write and then yields so that we don't
> serialize all writes to the backing device.

OK, what I'm wondering is why call bdrv_aio_writev() in a BH instead of r=
ight
away. IOW, have you traced how much time is spent before even calling
bdrv_aio_writev()?

>=20
> Thanks,
> Adrian
>=20
> On Wed, Feb 8, 2017 at 6:30 AM, Fam Zheng <famz@redhat.com> wrote:
>=20
> > On Wed, 02/08 14:59, Max Reitz wrote:
> > > CC-ing qemu-block, Stefan, Fam.
> > >
> > >
> > > On 08.02.2017 03:38, Adrian Suarez wrote:
> > > > We=E2=80=99ve implemented a block driver that exposes storage to =
QEMU VMs. Our
> > > > block driver (O) is interposing on writes to some other type of s=
torage
> > > > (B). O performs low latency replication and then asynchronously i=
ssues
> > the
> > > > write to the backing block driver, B, using bdrv_aio_writev(). Ou=
r
> > problem
> > > > is that the write latencies seen by the workload in the guest sho=
uld be
> > > > those imposed by O plus the guest I/O and QEMU stack (around 25us=
 total
> > > > based on our measurements), but we=E2=80=99re actually seeing muc=
h higher
> > latencies
> > > > (around 120us). We suspect that this is due to the backing block
> > driver B=E2=80=99s
> > > > coroutines blocking our coroutines. The sequence of events is as
> > follows
> > > > (see diagram:
> > > > https://docs.google.com/drawings/d/12h1QbecvxzlKxSFvGKYAzvAJ18kTW
> > 6AVTwDR6VA8hkw/pub?w=3D576&h=3D565
> >
> > I cannot open this, so just trying to understand from steps below..
> >
> > > > ):
> > > >
> > > > 1. Write is issued to our block driver O using the asynchronous
> > interface
> > > > for QEMU block driver.
> > > > 2. Write is replicated to a fast device asynchronously.
> > > > 2.a. In a different thread, the fast device invokes a callback on
> > > > completion that causes a coroutine to be scheduled to run in the =
QEMU
> > > > iothread that acknowledges completion of the write to the guest O=
S.
> > > > 2.b. The coroutine scheduled in (2.a) is executed.
> > > > 3. Write is issued asynchronously to the backing block driver, B.
> > > > 3.a. The backing block driver, B, invokes the completion function
> > supplied
> > > > by us, which frees any memory associated with the write (e.g. cop=
ies
> > of IO
> > > > vectors).
> >
> > Do you only start submitting request to B (step 3) after the fast dev=
ice
> > I/O
> > completes (step 2.a)? The fact that they are serialized incurs extra
> > latency.
> > Have you tried to do 2 and 3 in parallel with AIO?
> >
> > > >
> > > > Steps (1), (2), and (3) are performed in the same coroutine (our
> > driver's
> > > > bdrv_aio_writev() implementation). (2.a) is executed in a thread =
that
> > is
> > > > part of our transport library linked by O, and (2.b) and (3.a) ar=
e
> > executed
> > > > as coroutines in the QEMU iothread.
> > > >
> > > > We've tried improving the performance by using separate iothreads=
 for
> > the
> > > > two devices, but this only shaved about lowered the latency to ar=
ound
> > 100us
> > > > and caused stability issues. What's the best way to create a sepa=
rate
> > > > iothread for the backing driver to do all of its work in?
> > >
> > > I don't think it's possible to use different AioContexts for
> > > BlockDriverStates in the same BDS chain, at least not currently. Bu=
t
> > > others may know more about this.
> >
> > This may change in the future but currently all the BDSes in a chain =
need
> > to
> > stay on the same AioContext.
> >
> > Fam
> >
