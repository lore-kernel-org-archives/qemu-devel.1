Received: from eggs.gnu.org ([209.51.188.92]:58070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hImwX-0002Pl-Sr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 00:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hImwW-0005qB-BQ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 00:22:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hImwW-0005pV-2C
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 00:22:04 -0400
Date: Mon, 22 Apr 2019 21:21:53 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
In-Reply-To: <8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
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

Hi Stefan,

I did investigation per your advices, please see inline for the details and=
 questions.
=20
       1. Compare "iostat -dx 1" inside the guest and host.  Are the I/O
           patterns comparable?  blktrace(8) can give you even more detail =
on
           the exact I/O patterns.  If the guest and host have different I/=
O
           patterns (blocksize, IOPS, queue depth) then request merging or
           I/O scheduler effects could be responsible for the difference.

[wei]: That's good point, I compared 'iostate -dx1" between guest and host,=
 but I have not find obvious difference between guest and host which could r=
esponsible for the difference.
       =20
        2. kvm_stat or perf record -a -e kvm:\* counters for vmexits and
           interrupt injections.  If these counters vary greatly between qu=
eue
           sizes, then that is usually a clue.  It's possible to get higher
           performance by spending more CPU cycles although your system doe=
sn't
           have many CPUs available, so I'm not sure if this is the case.

[wei]: vmexits looks like a reason. I am using FIO tool to read/write block=
 storage via following sample command, interesting thing is that kvm:kvm_exi=
t count decreased from 846K to 395K after I increased num_queues from 2 to 4=
 while the vCPU count is 2.
           1). Does this mean using more queues than vCPU count may increas=
e IOPS via spending more CPU cycle?=20
           2). Could you please help me better understand how more queues i=
s able to spend more CPU cycle? Thanks!
           FIO command: fio --filename=3D/dev/sdb --direct=3D1 --rw=3Drandrw --bs=
=3D4k --ioengine=3Dlibaio --iodepth=3D64 --numjobs=3D4 --time_based --group_reportin=
g --name=3Diops --runtime=3D60 --eta-newline=3D1

        3. Power management and polling (kvm.ko halt_poll_ns, tuned profile=
s,
           and QEMU iothread poll-max-ns).  It's expensive to wake a CPU wh=
en it
           goes into a low power mode due to idle.  There are several featu=
res
           that can keep the CPU awake or even poll so that request latency=
 is
           reduced.  The reason why the number of queues may matter is that
           kicking multiple queues may keep the CPU awake more than batchin=
g
           multiple requests onto a small number of queues.
[wei]: CPU awake could be another reason, I noticed that kvm:kvm_vcpu_wakeu=
p count decreased from 151K to 47K after I increased num_queues from 2 to 4 =
while the vCPU count is 2.
           1). Does this mean more queues may keep CPU more busy and awake =
which reduced the vcpu wakeup time?
           2). If using more num_queues than vCPU count is able to get high=
er IOPS for this case, is it safe to use 4 queues while it only have 2 vCPU,=
 or there is any concern or impact by using more queues than vCPU count whic=
h I should keep in mind?

In addition, does Virtio-scsi support Batch I/O Submission feature which ma=
y be able to increase the IOPS via reducing the number of system calls?

Thanks,
Wei

=EF=BB=BFOn 4/16/19, 6:42 PM, "Wei Li" <wei.d.li@oracle.com> wrote:

    Thanks Stefan and Dongli for your feedback and advices!
   =20
    I will do the further investigation per your advices and get back to yo=
u later on.
   =20
    Thanks,=20
    -Wei
   =20
    =EF=BB=BFOn 4/16/19, 2:20 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
   =20
        On Tue, Apr 16, 2019 at 07:23:38AM +0800, Dongli Zhang wrote:
        >=20
        >=20
        > On 4/16/19 1:34 AM, Wei Li wrote:
        > > Hi @Paolo Bonzini & @Stefan Hajnoczi,
        > >=20
        > > Would you please help confirm whether @Paolo Bonzini's multique=
ue feature change will benefit virtio-scsi or not? Thanks!
        > >=20
        > > @Stefan Hajnoczi,
        > > I also spent some time on exploring the virtio-scsi multi-queue=
 features via num_queues parameter as below, here are what we found:
        > >=20
        > > 1. Increase number of Queues from one to the same number as CPU=
 will get better IOPS increase.
        > > 2. Increase number of Queues to the number (e.g. 8) larger than=
 the number of vCPU (e.g. 2) can get even better IOPS increase.
        >=20
        > As mentioned in below link, when the number of hw queues is large=
r than
        > nr_cpu_ids, the blk-mq layer would limit and only use at most nr_=
cpu_ids queues
        > (e.g., /sys/block/sda/mq/).
        >=20
        > That is, when the num_queus=3D4 while vcpus is 2, there should be o=
nly 2 queues
        > available /sys/block/sda/mq/
        >=20
        > https://lore.kernel.org/lkml/1553682995-5682-1-git-send-email-don=
gli.zhang@oracle.com/
        >=20
        > I am just curious how increasing the num_queues from 2 to 4 would=
 double the
        > iops, while there are only 2 vcpus available...
       =20
        I don't know the answer.  It's especially hard to guess without see=
ing
        the benchmark (fio?) configuration and QEMU command-line.
       =20
        Common things to look at are:
       =20
        1. Compare "iostat -dx 1" inside the guest and host.  Are the I/O
           patterns comparable?  blktrace(8) can give you even more detail =
on
           the exact I/O patterns.  If the guest and host have different I/=
O
           patterns (blocksize, IOPS, queue depth) then request merging or
           I/O scheduler effects could be responsible for the difference.
       =20
        2. kvm_stat or perf record -a -e kvm:\* counters for vmexits and
           interrupt injections.  If these counters vary greatly between qu=
eue
           sizes, then that is usually a clue.  It's possible to get higher
           performance by spending more CPU cycles although your system doe=
sn't
           have many CPUs available, so I'm not sure if this is the case.
       =20
        3. Power management and polling (kvm.ko halt_poll_ns, tuned profile=
s,
           and QEMU iothread poll-max-ns).  It's expensive to wake a CPU wh=
en it
           goes into a low power mode due to idle.  There are several featu=
res
           that can keep the CPU awake or even poll so that request latency=
 is
           reduced.  The reason why the number of queues may matter is that
           kicking multiple queues may keep the CPU awake more than batchin=
g
           multiple requests onto a small number of queues.
       =20
        Stefan
       =20
   =20
