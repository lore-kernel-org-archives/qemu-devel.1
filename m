Received: from eggs.gnu.org ([2001:4830:134:3::10]:52060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adrian@eitrsystems.com>) id 1cbI8z-0005vZ-Uk
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adrian@eitrsystems.com>) id 1cbI8y-0004Wn-GK
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:38:06 -0500
Received: from mail-wj0-x22e.google.com ([2a00:1450:400c:c01::22e]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adrian@eitrsystems.com>)
	id 1cbI8y-0004Rj-8l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:38:04 -0500
Received: by mail-wj0-x22e.google.com with SMTP id b20so7067993wjs.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 18:38:02 -0800 (PST)
MIME-Version: 1.0
From: Adrian Suarez <adrian@eitrsystems.com>
Date: Tue, 7 Feb 2017 18:38:00 -0800
Message-ID: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Question about QEMU's threading model and stacking
 multiple block drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We=E2=80=99ve implemented a block driver that exposes storage to QEMU VMs. =
Our
block driver (O) is interposing on writes to some other type of storage
(B). O performs low latency replication and then asynchronously issues the
write to the backing block driver, B, using bdrv_aio_writev(). Our problem
is that the write latencies seen by the workload in the guest should be
those imposed by O plus the guest I/O and QEMU stack (around 25us total
based on our measurements), but we=E2=80=99re actually seeing much higher l=
atencies
(around 120us). We suspect that this is due to the backing block driver B=
=E2=80=99s
coroutines blocking our coroutines. The sequence of events is as follows
(see diagram:
https://docs.google.com/drawings/d/12h1QbecvxzlKxSFvGKYAzvAJ18kTW6AVTwDR6VA=
8hkw/pub?w=3D576&h=3D565
):

1. Write is issued to our block driver O using the asynchronous interface
for QEMU block driver.
2. Write is replicated to a fast device asynchronously.
2.a. In a different thread, the fast device invokes a callback on
completion that causes a coroutine to be scheduled to run in the QEMU
iothread that acknowledges completion of the write to the guest OS.
2.b. The coroutine scheduled in (2.a) is executed.
3. Write is issued asynchronously to the backing block driver, B.
3.a. The backing block driver, B, invokes the completion function supplied
by us, which frees any memory associated with the write (e.g. copies of IO
vectors).

Steps (1), (2), and (3) are performed in the same coroutine (our driver's
bdrv_aio_writev() implementation). (2.a) is executed in a thread that is
part of our transport library linked by O, and (2.b) and (3.a) are executed
as coroutines in the QEMU iothread.

We've tried improving the performance by using separate iothreads for the
two devices, but this only shaved about lowered the latency to around 100us
and caused stability issues. What's the best way to create a separate
iothread for the backing driver to do all of its work in?

-Adrian
