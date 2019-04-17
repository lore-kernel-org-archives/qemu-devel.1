Received: from eggs.gnu.org ([209.51.188.92]:48008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGZae-00079I-70
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGZac-0006c5-VD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:42:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hGZac-0006aZ-Iz
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:42:18 -0400
Date: Tue, 16 Apr 2019 18:42:10 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <3FFA6883-42F6-444A-AC17-EACA1E9ED4F7@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
In-Reply-To: <20190416092042.GB32709@stefanha-x1.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Thanks Stefan and Dongli for your feedback and advices!

I will do the further investigation per your advices and get back to you la=
ter on.

Thanks,=20
-Wei

=EF=BB=BFOn 4/16/19, 2:20 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:

    On Tue, Apr 16, 2019 at 07:23:38AM +0800, Dongli Zhang wrote:
    >=20
    >=20
    > On 4/16/19 1:34 AM, Wei Li wrote:
    > > Hi @Paolo Bonzini & @Stefan Hajnoczi,
    > >=20
    > > Would you please help confirm whether @Paolo Bonzini's multiqueue f=
eature change will benefit virtio-scsi or not? Thanks!
    > >=20
    > > @Stefan Hajnoczi,
    > > I also spent some time on exploring the virtio-scsi multi-queue fea=
tures via num_queues parameter as below, here are what we found:
    > >=20
    > > 1. Increase number of Queues from one to the same number as CPU wil=
l get better IOPS increase.
    > > 2. Increase number of Queues to the number (e.g. 8) larger than the=
 number of vCPU (e.g. 2) can get even better IOPS increase.
    >=20
    > As mentioned in below link, when the number of hw queues is larger th=
an
    > nr_cpu_ids, the blk-mq layer would limit and only use at most nr_cpu_=
ids queues
    > (e.g., /sys/block/sda/mq/).
    >=20
    > That is, when the num_queus=3D4 while vcpus is 2, there should be only =
2 queues
    > available /sys/block/sda/mq/
    >=20
    > https://lore.kernel.org/lkml/1553682995-5682-1-git-send-email-dongli.=
zhang@oracle.com/
    >=20
    > I am just curious how increasing the num_queues from 2 to 4 would dou=
ble the
    > iops, while there are only 2 vcpus available...
   =20
    I don't know the answer.  It's especially hard to guess without seeing
    the benchmark (fio?) configuration and QEMU command-line.
   =20
    Common things to look at are:
   =20
    1. Compare "iostat -dx 1" inside the guest and host.  Are the I/O
       patterns comparable?  blktrace(8) can give you even more detail on
       the exact I/O patterns.  If the guest and host have different I/O
       patterns (blocksize, IOPS, queue depth) then request merging or
       I/O scheduler effects could be responsible for the difference.
   =20
    2. kvm_stat or perf record -a -e kvm:\* counters for vmexits and
       interrupt injections.  If these counters vary greatly between queue
       sizes, then that is usually a clue.  It's possible to get higher
       performance by spending more CPU cycles although your system doesn't
       have many CPUs available, so I'm not sure if this is the case.
   =20
    3. Power management and polling (kvm.ko halt_poll_ns, tuned profiles,
       and QEMU iothread poll-max-ns).  It's expensive to wake a CPU when i=
t
       goes into a low power mode due to idle.  There are several features
       that can keep the CPU awake or even poll so that request latency is
       reduced.  The reason why the number of queues may matter is that
       kicking multiple queues may keep the CPU awake more than batching
       multiple requests onto a small number of queues.
   =20
    Stefan
   =20
