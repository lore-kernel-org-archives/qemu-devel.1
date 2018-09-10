Received: from eggs.gnu.org ([2001:4830:134:3::10]:57219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fzNmV-0000zy-Ea
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fzNmT-0004j9-ML
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:07:15 -0400
MIME-Version: 1.0
References: <CANzW0mueyweHLy5k_UPvYLSwyB3_4o9+SBMWvnPFBsC+PdRF_A@mail.gmail.com>
In-Reply-To: <CANzW0mueyweHLy5k_UPvYLSwyB3_4o9+SBMWvnPFBsC+PdRF_A@mail.gmail.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Mon, 10 Sep 2018 21:06:55 +0600
Message-ID: <CANzW0mucUZR7eL3mEK+AwJ699Lte7UmoEBwUrVgewDWJ=gRYwg@mail.gmail.com>
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
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>

It looks like things are even worse. Guest demonstrates strange timings
even without access to anything external to machine. I've added Paolo
Bonzini to CC, because issue looks related to cpu/tcg/memory stuff.

I've written simple test script running parallel 'dd' utility processes
operating on files located in RAM. QEMU machine with multiple vCPUs.
Moreover, it have separate NUMA nodes for each vCPU.
Script in brief: it accepts argument with desired processes count, for each
process it mounts tmpfs, binded to node memory, and runs 'dd', binded both
to node cpu and memory, which copies files located on that tmpfs.
It's expected that overall execution time of N parallel processes (or speed
of copying) should always be the same, not depending on N value (of course,
provided that N <=3D nodes_count and 'dd' is single-threaded). Because it's
just as simple as simple loops of instructions just loading and storing
values in memory local to each CPU. No common resources should be involved
- neither software (such as some target OS lock/mutex), nor hardware (such
as memory bus). It should be almost ideal parallelization.
But it's not only degradates when increasing N, but even does it
proportionally !!! Same test running oh host machine (just multicore, no
NUMA) shows expected results: it has degradation (because of common memory
bus), but with non-linear dependency on N.

Script ("test.sh"):
    #!/bin/bash
    N=3D$1
    # Preparation...
    if command -v numactl >/dev/null; then
      USE_NUMA_BIND=3D1
    else
      USE_NUMA_BIND=3D0
    fi
    for i in $(seq 0 $((N - 1)));
    do
      mkdir -p /mnt/testmnt_$i
      if [[ "$USE_NUMA_BIND" =3D=3D 1 ]] ; then
TMPFS_EXTRA_OPT=3D",mpol=3Dbind:$i"; fi
      mount -t tmpfs -o
size=3D25M,noatime,nodiratime,norelatime$TMPFS_EXTRA_OPT tmpfs /mnt/testmnt=
_$i
      dd if=3D/dev/zero of=3D/mnt/testmnt_$i/testfile_r bs=3D10M count=3D1
>/dev/null 2>&1
    done
    # Running...
    for i in $(seq 0 $((N - 1)));
    do
      if [[ "$USE_NUMA_BIND" =3D=3D 1 ]] ; then PREFIX_RUN=3D"numactl
--cpunodebind=3D$i --membind=3D$i"; fi
      $PREFIX_RUN dd if=3D/mnt/testmnt_$i/testfile_r
of=3D/mnt/testmnt_$i/testfile_w bs=3D100 count=3D100000 2>&1 | sed -n 's/^.=
*,
\(.*\)$/\1/p' &
    done
    # Cleanup...
    wait
    for i in $(seq 0 $((N - 1))); do umount /mnt/testmnt_$i; done
    rm -rf /mnt/testmnt_*

Corresponding QEMU command line fragment:
    "-machine accel=3Dtcg -m 2048 -icount 1,sleep=3Doff -rtc clock=3Dvm -sm=
p 10
-cpu qemu64 -numa node -numa node -numa node -numa node -numa node -numa
node -numa node -numa node -numa node -numa node"
(Removing -icount or numa nodes don't change results.)

Example runs on my Intel Core i7-7700 host (adequate results):
  artem@host:~$ sudo ./test.sh 1
  117 MB/s
  artem@host:~$ sudo ./test.sh 10
  91,1 MB/s
  89,3 MB/s
  90,4 MB/s
  85,0 MB/s
  68,7 MB/s
  63,1 MB/s
  62,0 MB/s
  55,9 MB/s
  54,1 MB/s
  56,0 MB/s

Example runs on my tiny linux x86_64 guest (strange results):
  root@guest:~# ./test.sh 1
  17.5 MB/s
  root@guest:~# ./test.sh 10
  3.2 MB/s
  2.7 MB/s
  2.6 MB/s
  2.0 MB/s
  2.0 MB/s
  1.9 MB/s
  1.8 MB/s
  1.8 MB/s
  1.8 MB/s
  1.8 MB/s

Please, explain these results. Or maybe I wrong and it's normal ?


=D1=87=D1=82, 6 =D1=81=D0=B5=D0=BD=D1=82. 2018 =D0=B3. =D0=B2 16:24, Artem =
Pisarenko <artem.k.pisarenko@gmail.com>:

> Hi all,
>
> I'm developing paravirtualized target linux system which runs multiple
> linux containers (LXC) inside itself. (For those, who unfamiliar with LXC=
,
> simply put, it's an isolated group of userspace processes with their own
> rootfs.) Each container should be provided access to its rootfs located a=
t
> host and execution of container should be deterministic. Particularly, it
> means that container I/O operations must be synchronized within some
> predefined quantum of guest _virtual_ time, i.e. its I/O activity shouldn=
't
> be delayed by host performance or activities on host and other containers=
.
> In other words, guest should see it's like either infinite throughput and
> zero latency, or some predefined throughput/latency characteristics
> guaranteed per each rootfs.
>
> While other sources of non-determinism are seem to be eliminated (using
> TCG, -icount, etc.), asynchronous I/O still introduces it.
>
> What is scope of "(asynchronous) I/O" term within qemu? Is it something
> related to block devices layer only, or generic term, covering whole
> datapath between vCPU and backend?
> If it relates to block devices only, does usage of VirtFS guarantee
> deterministic access, or it still involves some asynchrony relative to
> guest virtual clock?
> Is it possible to force asynchronous I/O within qemu to be blocking by
> some external means (host OS configuration, hooks, etc.) ? I know, it may
> greatly slow down guest performance, but it's still better than nothing.
> Maybe some trivial patch can be made to qemu code at virtio, block backen=
d
> or platform syscalls level?
> Maybe I/O automatically (and guaranteed) fallbacks to synchronous mode in
> some particular configurations, such as using block device with image
> located on tmpfs in RAM (either directly or via overlay fs) ? If so, it's
> great!
> Or maybe some other solutions exists?...
>
> Main problem is to organize access from guest linux to some file system a=
t
> host (directory, mount point, image file... doesn't matter) in
> deterministic manner.
> Secondary problem is to optimize performance as much as possible by:
> - avoiding unnecessary overheads (e.g. using virtio infrastructure,
> preference virtfs over blk device, etc.);
> - allowing some asynchrony within defined quantum of time (e.g. 10ms),
> i.e. i/o order and speed are free to float within each quantum borders,
> while result seen by guest at end of quantum is always same.
>
> Actually, what I'm trying to achieve have direct contradiction with most
> people trying to avoid, because synchronous I/O degradates performance in
> vast majority of usage scenarios.
>
> Does anyone have any thoughts on this?
>
> Best regards,
>   Artem Pisarenko
> --
>
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
>   =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=
=BD=D0=BA=D0=BE
>
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
