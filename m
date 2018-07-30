Received: from eggs.gnu.org ([2001:4830:134:3::10]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1fk3VE-0001rJ-Vc
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1fk3VD-0001AX-DK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:26:04 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <felix.yzg@gmail.com>) id 1fk3VD-0001AR-6u
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:26:03 -0400
Received: by mail-qt0-x22c.google.com with SMTP id d4-v6so11185495qtn.13
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 01:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <1531468107-1579-1-git-send-email-felix.yzg@gmail.com>
	<20180727101826.GA28555@stefanha-x1.localdomain>
In-Reply-To: <20180727101826.GA28555@stefanha-x1.localdomain>
From: felix yao <felix.yzg@gmail.com>
Date: Mon, 30 Jul 2018 16:25:51 +0800
Message-ID: <CAOH8tkSLrTKdFap4NOrY7NwimF9M-Sj8qNvQzPuabLWms_eBag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] util/thread-pool: add parameter to
 limit maximum threads in thread pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, yaozhenguo@jd.com, QEMU Developers <qemu-devel@nongnu.org>

Hi stefan:
    Thank you very much for your reply. Yes, I want to reduce impact of
resources among virtual machines including I/O resources, vCPU and etc. I
can use CPU pin feature to pin vCPU to dedicated host's physical CPU and
use I/O throttling feature to limit IOPS and bandwidth of VM's disks. But,
When using aio=3Dthreads, I/O worker threads are too many(if we have 16 VMs
in one host, there are 1024 threads at worst) and  can't pinned to
dedicated CPU(dynamic creating). The I/O worker threads seem out of
control. I/O worker threads of one VM's disk may impact the running of
other VM. I am not sure how much of the impact.
    You have mentioned aio=3Dnative in the mail. Yes, When Using -drive
aio=3Dnative, there is no such problem and performance is better. I am
thinking to use it. But, I found a issue report about using Linux AIO on
QEMU, issue link:
https://specs.openstack.org/openstack/nova-specs/specs/mitaka/implemented/l=
ibvirt-aio-mode.html
. http://paste.openstack.org/show/480498/. Do you know about this issue?
Could Linux AIO be safely used in QEMU?
    I have  noticed that there is IOthread feature in QEMU(dedicated thread
to handle disk I/O instead of main thread) recently. I can use 'iothreadpin
iothread=3Dxx cpuset=3Dxxx ' in libvirt XML to pin iothreads of one VM to
dedicated host's physical CPU. Worker threads of the VM are also pinned to
that host's physical CPU. This can also solve my problem.




Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:41=E5=86=99=E9=81=93=EF=BC=9A

> On Fri, Jul 13, 2018 at 03:48:27PM +0800, FelixYao wrote:
> > Hi all:
> >
> > Max threads in thread pool is fixed at 64 before which is not
> > propriate in some situations. For public cloud environment,
> > there are lots of VMs in one host machine. We should limit the worker
> thread
> > numbers for each machine alone based on its ability to prevent impactin=
g
> > each other. Although we can use iotune to limit bandwidth or IOPS of
> block
> > device. That is not enough. Lots of worker threads still impact other
> VMs.
> > I think the ability to limit maximum threads in thread pool is necessar=
y.
> >
> > What's your opinion about this patch? please review it.
>
> I haven't seen any discussion so here are some thoughts:
>
> It sounds like you are trying to control I/O resources so that guests do
> not affect each other.  The threads are an implementation detail and not
> the root of the problem.
>
> For example, if you use -drive aio=3Dnative then reads and writes will no=
t
> use the thread pool and you will setting the thread pool size won't
> solve the problem.
>
> Have you tried QEMU's I/O throttling feature?  You can set bandwidth
> (bps) and IOPS limits, including bursts if you wish to allow temporary
> spikes.  The basic parameters are -drive bps=3DBYTES_PER_SECOND,iops=3DIO=
PS.
> See the QEMU or libvirt documentation for details.
>
