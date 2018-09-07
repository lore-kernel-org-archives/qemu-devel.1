Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fyBvr-0007Rk-H2
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fyBvp-0007ii-HG
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:15:59 -0400
MIME-Version: 1.0
References: <CANzW0mueyweHLy5k_UPvYLSwyB3_4o9+SBMWvnPFBsC+PdRF_A@mail.gmail.com>
	<20180906110349-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180906110349-mutt-send-email-mst@kernel.org>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Fri, 7 Sep 2018 14:15:44 +0600
Message-ID: <CANzW0muC3rKPJnS1uVDmXe0JQBLUycO22JJ40ED683A7DHheUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] backend for blk or fs with guaranteed
 blocking/synchronous I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Greg Kurz <groug@kaod.org>

No. I don't need realtime behavior. Realtime implies determinism, but
determinism doesn't implies realtime. Of course, I realize that there are
other sources of non-determinism exist, but these are separate stories.
Here I just trying to eliminate one of them - asynchronous emulation of I/O
inside qemu. Realtime isn't solution here.

Firstly, implementing realtime still leaves dependency on host machine (its
performance, hardware configuration, etc.) and number of containers
running. Yes, it will be deterministic, but results are tied to given host
and containers count.
Secondly, it's just an overkill for problem being solved. The problem area
is bounded by guest and QEMU implementation. Using realtime requires to
fight complexities on host also (host kernel must be realtime, system
configuration must be tuned, all possible latencies must be carefully
traced, etc.). I perfectly understand how complex to design realtime system
in generic, and implementing it using linux makes things even more complex.
Thirdly, it works only for KVM (and possibly other virtualization
hypervisors). It's not my case, since my guest running with TCG and
-icount,sleep=3Doff.

It seems you got me wrong. I'll try to explain problem in other way.

Guest virtual clock must run independent of realtime (host) clock. They
might be synchronized only in order to wait for some QEMU/host operation to
be completed, i.e. guest time is being frozen by host performance
bottlenecks, but it's transparent for guest. This is how works (or, at
least, should work) "-icount,sleep=3Doff" in time domain of CPU emulation.
But I/O operations are seems to not respect this "policy". When QEMU
processes I/O request from guest, it allows virtual time to run freely
until backend completes operation and result passed back to guest. And this
is what makes guest to "feel" speed/latency of I/O. It's the core of the
problem.

To explain problem even better I've written a simple script
(test_run_multiple_containers.sh), which emulates execution of multiple
containers:
    #!/bin/bash
    N=3D$1
    for i in $(seq 1 $N);
    do
      dd if=3D/dev/zero of=3D/tmp/testfile_$i bs=3D1K count=3D100000 2>&1 |=
 sed -n
's/^.*, \(.*\)$/\1/p' &
    done
    wait
    rm -f /tmp/testfile*
Where N is a number of containers running in parallel, and /tmp/testfile_$i
is a file located in $i container's rootfs (dedicated mount point, blk
device or something else).
Running
    ./test_run_multiple_containers.sh 1
on real machine should output value, which corresponds to maximum write
speed. Lets define it as "max_io_throughput".
Running this script on real machine with different N values should give
ouptuts with roughly identical values like "max_io_throughput / N".
What I need is that running this script on guest should always give
identical and constant values, not depending on N value, current host load
or something else external to guest. (No magic. While running emulation
will cause at most "max_io_throughput" load on host (in terms of real
time), QEMU will throttle guest virtual clock to be N times slower relative
to realtime clock.)

Also I forgot to mention that container's rootfs aren't required to be
persistent and stay on host during execution of containers. They may be
transferred to guest RAM before execution. They're just source images of
rootfs.

=D1=87=D1=82, 6 =D1=81=D0=B5=D0=BD=D1=82. 2018 =D0=B3. =D0=B2 21:08, Michae=
l S. Tsirkin <mst@redhat.com>:

> On Thu, Sep 06, 2018 at 04:24:12PM +0600, Artem Pisarenko wrote:
> > Hi all,
> >
> > I'm developing paravirtualized target linux system which runs multiple
> linux
> > containers (LXC) inside itself. (For those, who unfamiliar with LXC,
> simply
> > put, it's an isolated group of userspace processes with their own
> rootfs.) Each
> > container should be provided access to its rootfs located at host and
> execution
> > of container should be deterministic. Particularly, it means that
> container I/O
> > operations must be synchronized within some predefined quantum of guest
> > _virtual_ time, i.e. its I/O activity shouldn't be delayed by host
> performance
> > or activities on host and other containers. In other words, guest shoul=
d
> see
> > it's like either infinite throughput and zero latency, or some predefin=
ed
> > throughput/latency characteristics guaranteed per each rootfs.
> >
> > While other sources of non-determinism are seem to be eliminated (using
> TCG,
> > -icount, etc.), asynchronous I/O still introduces it.
>
> ...
>
> Just that you should realize that the issues are not limited to QEMU: to
> get real time behaviour out of a Linux host you need a real-time kernel
> and real-time capable hardware/firmware. I'm not an expert on this at
> all, but see e.g. these old presentations:
> https://lwn.net/Articles/656807/
>
> --
> MST
>
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
