Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fxrSd-0003dm-SG
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fxrSc-0004bS-Ml
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:24:27 -0400
MIME-Version: 1.0
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 6 Sep 2018 16:24:12 +0600
Message-ID: <CANzW0mueyweHLy5k_UPvYLSwyB3_4o9+SBMWvnPFBsC+PdRF_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] backend for blk or fs with guaranteed
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>

Hi all,

I'm developing paravirtualized target linux system which runs multiple
linux containers (LXC) inside itself. (For those, who unfamiliar with LXC,
simply put, it's an isolated group of userspace processes with their own
rootfs.) Each container should be provided access to its rootfs located at
host and execution of container should be deterministic. Particularly, it
means that container I/O operations must be synchronized within some
predefined quantum of guest _virtual_ time, i.e. its I/O activity shouldn't
be delayed by host performance or activities on host and other containers.
In other words, guest should see it's like either infinite throughput and
zero latency, or some predefined throughput/latency characteristics
guaranteed per each rootfs.

While other sources of non-determinism are seem to be eliminated (using
TCG, -icount, etc.), asynchronous I/O still introduces it.

What is scope of "(asynchronous) I/O" term within qemu? Is it something
related to block devices layer only, or generic term, covering whole
datapath between vCPU and backend?
If it relates to block devices only, does usage of VirtFS guarantee
deterministic access, or it still involves some asynchrony relative to
guest virtual clock?
Is it possible to force asynchronous I/O within qemu to be blocking by some
external means (host OS configuration, hooks, etc.) ? I know, it may
greatly slow down guest performance, but it's still better than nothing.
Maybe some trivial patch can be made to qemu code at virtio, block backend
or platform syscalls level?
Maybe I/O automatically (and guaranteed) fallbacks to synchronous mode in
some particular configurations, such as using block device with image
located on tmpfs in RAM (either directly or via overlay fs) ? If so, it's
great!
Or maybe some other solutions exists?...

Main problem is to organize access from guest linux to some file system at
host (directory, mount point, image file... doesn't matter) in
deterministic manner.
Secondary problem is to optimize performance as much as possible by:
- avoiding unnecessary overheads (e.g. using virtio infrastructure,
preference virtfs over blk device, etc.);
- allowing some asynchrony within defined quantum of time (e.g. 10ms), i.e.
i/o order and speed are free to float within each quantum borders, while
result seen by guest at end of quantum is always same.

Actually, what I'm trying to achieve have direct contradiction with most
people trying to avoid, because synchronous I/O degradates performance in
vast majority of usage scenarios.

Does anyone have any thoughts on this?

Best regards,
  Artem Pisarenko
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
