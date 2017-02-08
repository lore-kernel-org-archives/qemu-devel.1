Received: from eggs.gnu.org ([2001:4830:134:3::10]:53879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbTGF-0007eD-IU
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbTGE-0006gO-3z
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:30:19 -0500
Date: Wed, 8 Feb 2017 22:30:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170208143008.GC22807@lemon.lan>
References: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
	<08b13ba8-5e66-5fd9-3c4f-b567e87137d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08b13ba8-5e66-5fd9-3c4f-b567e87137d8@redhat.com>
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

On Wed, 02/08 14:59, Max Reitz wrote:
> CC-ing qemu-block, Stefan, Fam.
>=20
>=20
> On 08.02.2017 03:38, Adrian Suarez wrote:
> > We=E2=80=99ve implemented a block driver that exposes storage to QEMU=
 VMs. Our
> > block driver (O) is interposing on writes to some other type of stora=
ge
> > (B). O performs low latency replication and then asynchronously issue=
s the
> > write to the backing block driver, B, using bdrv_aio_writev(). Our pr=
oblem
> > is that the write latencies seen by the workload in the guest should =
be
> > those imposed by O plus the guest I/O and QEMU stack (around 25us tot=
al
> > based on our measurements), but we=E2=80=99re actually seeing much hi=
gher latencies
> > (around 120us). We suspect that this is due to the backing block driv=
er B=E2=80=99s
> > coroutines blocking our coroutines. The sequence of events is as foll=
ows
> > (see diagram:
> > https://docs.google.com/drawings/d/12h1QbecvxzlKxSFvGKYAzvAJ18kTW6AVT=
wDR6VA8hkw/pub?w=3D576&h=3D565

I cannot open this, so just trying to understand from steps below..

> > ):
> >=20
> > 1. Write is issued to our block driver O using the asynchronous inter=
face
> > for QEMU block driver.
> > 2. Write is replicated to a fast device asynchronously.
> > 2.a. In a different thread, the fast device invokes a callback on
> > completion that causes a coroutine to be scheduled to run in the QEMU
> > iothread that acknowledges completion of the write to the guest OS.
> > 2.b. The coroutine scheduled in (2.a) is executed.
> > 3. Write is issued asynchronously to the backing block driver, B.
> > 3.a. The backing block driver, B, invokes the completion function sup=
plied
> > by us, which frees any memory associated with the write (e.g. copies =
of IO
> > vectors).

Do you only start submitting request to B (step 3) after the fast device =
I/O
completes (step 2.a)? The fact that they are serialized incurs extra late=
ncy.
Have you tried to do 2 and 3 in parallel with AIO?

> >=20
> > Steps (1), (2), and (3) are performed in the same coroutine (our driv=
er's
> > bdrv_aio_writev() implementation). (2.a) is executed in a thread that=
 is
> > part of our transport library linked by O, and (2.b) and (3.a) are ex=
ecuted
> > as coroutines in the QEMU iothread.
> >=20
> > We've tried improving the performance by using separate iothreads for=
 the
> > two devices, but this only shaved about lowered the latency to around=
 100us
> > and caused stability issues. What's the best way to create a separate
> > iothread for the backing driver to do all of its work in?
>=20
> I don't think it's possible to use different AioContexts for
> BlockDriverStates in the same BDS chain, at least not currently. But
> others may know more about this.

This may change in the future but currently all the BDSes in a chain need=
 to
stay on the same AioContext.

Fam
