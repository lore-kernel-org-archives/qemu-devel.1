Received: from eggs.gnu.org ([2001:4830:134:3::10]:55876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cOSTb-00047o-5P
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cOSTZ-0005b2-Mu
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:02:19 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cOSTZ-0005ag-He
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:02:17 -0500
Received: by mail-qt0-x243.google.com with SMTP id 3so36748754qtr.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 09:02:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170103155047.GE14707@stefanha-x1.localdomain>
References: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
	<20170103155047.GE14707@stefanha-x1.localdomain>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Tue, 3 Jan 2017 12:02:14 -0500
Message-ID: <CA+scX6mCDjnZdEMemuDerPxR2L4w12PyyvH==tW_PdW6Kqe7+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Performance about x-data-plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, libvir-list <libvir-list@redhat.com>

Hi Stefan,

Thanks for your reply.

On Tue, Jan 3, 2017 at 10:50 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Dec 22, 2016 at 01:34:47AM -0500, Weiwei Jia wrote:
>> With QEMU x-data-plane, I find the performance has not been improved
>> very much. Please see following two settings.
>
> Using IOThreads improves scalability for SMP guests with many disks.  It
> does not improve performance for a single disk benchmark because there
> is nothing to spread across IOThreads.
>
>> Setting 1: I/O thread in host OS (VMM) reads 4KB each time from disk
>> (8GB in total). Pin the I/O thread to pCPU 5 which will serve I/O
>> thread dedicatedly. I find the performance is around 250 MB/s.
>
> 250 MB/s / 4 KB = 64k IOPS
>
> This seems like a reasonable result for single thread with a single
> disk.  I guess the benchmark queue depth setting is larger than 1 though
> because it would only allow 15 microseconds per request.

For this test, we have two disks as a RAID 0. Each of the disk is 2.5
inch and has around 130 MB/s bandwidth (sequential read) as
specification said.

>
>> Setting 2: I/O thread in guest OS (VMM) reads 4KB each time from
>> virtual disk (8GB in total). Pin the I/O thread to vCPU 5 and pin vCPU
>> 5 thread to pCPU5 so that vCPU 5 handles this I/O thread dedicatedly
>> and pCPU5 serve vCPU5 dedicatedly. In order to keep vCPU5 not to be
>> idle, I also pin one cpu intensive thread (while (1) {i++}) on vCPU 5
>> so that the I/O thread on it can be served without delay. For this
>> setting, I find the performance for this I/O thread is around 190
>> MB/s.
>
> 190 MB/s / 4 KB = 48k IOPS
>
> I worry that your while (1) {i++} thread may prevent achieving the best
> performance if the guest kernel scheduler allows it to use its time
> slice.
>
> Two options that might work better are:
> 1. idle=poll guest kernel command-line parameter
> 2. kvm.ko's halt_poll_ns host kernel module parameter

Yes, I add "idle=poll" currently but I did not try "kvm.ko's
halt_poll_ns" yet. I will try it. Actually, current days, I have made
a RAID 0 with four disks and each of them is 2.5 inch and has 130 MB/s
bandwidth (from specification) for sequential read. I also fix some
interrupts delay problem. See following for the latest experiment and
problems.

I run one I/O thread (sequential read 4 KB each time and read 8 GB in
total) in host OS, the throughput is around 420 MB/s. However, when I
run this I/O thread in one VM (no other VM is created and data-plane
is enabled) with dedicated hardware, the throughput will be around 350
MB/s. The VM's experiment setting is as follows.

In the VM, there are 15 vCPUs (vCPU0 - vCPU14); each vCPU is pinned to
corresponding dedicated pCPU (for example, vCPU 0 is pinned to pCPU0
... vCPU 14 is pinned to pCPU 14); "Idle=poll" is added in the VM's
boot grub so that the vCPU will not be idle; in the VM, all the
interrupts are pinned to vCPU0 to guarantee these interrupts can be
responded on time; the I/O thread is executed on one of the vCPU
except vCPU0.

In the host OS, there are 16 pCPUs (pCPU0 - pCPU15); pCPU 0 - pCPU 14
are used for vCPU0 - vCPU 14 in the VM dedicatedly; pCPU 15 is used by
QEMU IOthread (data-plane) to handle I/O read requests from VM
dedicatedly.

Kernel version: 3.16.39
QEMU version: 2.4.1


I don't know why there is 70 MB/s difference between host OS and guest
OS as above experiment. Does anyone have same experiences? Any
comments? Thank you in advance.

BTW, I have checked several times about my hardware configuration and
I think the throughput difference as above should be related to QEMU.
Maybe, I miss any configuration about QEMU.

>
>> NOTE: For setting 2, I also pin the QEMU dedicated IOthread
>> (x-data-plane) in host OS to pCPU to handle I/O requests from guest OS
>> dedicatedly.
>
> Which pCPU did you pin the dataplane thread to?  Did you try changing
> this?

No, it is pinned to pCPU 15 dedicatedly. Please see above latest
experiment and problem.

>
>> I think for setting 2, the performance of I/O thread should be almost
>> the same as setting 1. I cannot understand why it is 60 MB/s lower
>> than setting 1. I am wondering whether there are something wrong with
>> my x-data-plane setting or virtio setting for VM.  Would you please
>> give me some hints? Thank you.
>
> Ideally QEMU should achieve the same performance as bare metal.  In
> practice the overhead increases as IOPS increases.  You may be able to
> achieve 260 MB/s inside the guest with a larger request size since it
> involves fewer I/O requests.

Yes, I agree with you that it should achieve the performance as bare
metal. I will try a larger request size. Thank you.

>
> The expensive part is the virtqueue kick.  Recently we tried polling the
> virtqueue instead of waiting for the ioeventfd file descriptor and got
> double-digit performance improvements:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00148.html
>
> If you want to understand the performance of your benchmark you'll have
> compare host/guest disk stats (e.g. request lifetime, disk utilization,
> queue depth, average request size) to check that the bare metal and
> guest workloads are really sending comparable I/O patterns to the
> physical disk.
>
> Then you using Linux and/or QEMU tracing to analyze the request latency
> by looking at interesting points in the request lifecycle like virtqueue
> kick, host Linux AIO io_submit(2), etc.
>

Thank you. I will look into "polling the virtqueue" as you said above.
Currently, I just use blktrace to see disk stats and add logs in the
I/O workload to see the time latency for each request. What kind of
tools are you using to analyze request lifecycle like virtqueue kick,
host Linux AIO iosubmit, etc.

Do you trace the lifecycle like this
(http://www.linux-kvm.org/page/Virtio/Block/Latency#Performance_data)
but it seems to be out of date. Does it
(http://repo.or.cz/qemu-kvm/stefanha.git/shortlog/refs/heads/tracing-dev-0.12.4)
still work on QEMU 2.4.1?


Thank you,
Weiwei Jia
