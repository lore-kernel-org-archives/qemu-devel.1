Received: from eggs.gnu.org ([2001:4830:134:3::10]:60092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cr5Va-00089I-88
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cr5VZ-0007dw-4m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:22:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170323150955.GD12560@stefanha-x1.localdomain>
References: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
	<CAJSP0QXYdcBt1zOLEz1fdVBg6eo2Yg+uCA=u2nPQHBe01Bo9ow@mail.gmail.com>
	<CAC2QTZbOK76fi3fX_msqc_UJu_J1RMkA7dXnSn+Zs5Cxyon6jA@mail.gmail.com>
	<20170323150955.GD12560@stefanha-x1.localdomain>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 23 Mar 2017 21:52:36 +0530
Message-ID: <CAC2QTZZSPKXW6_Aaw4pTOqixpijT7XuiO3TjXwWz6BNkR-H+9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] Allocate mutiple clusters for VMDK I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Mar 23, 2017 at 8:39 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Mar 21, 2017 at 09:14:08AM +0000, Ashijeet Acharya wrote:
>> On Tue, 21 Mar 2017 at 13:21, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> > On Sat, Mar 11, 2017 at 11:54 AM, Ashijeet Acharya
>> > <ashijeetacharya@gmail.com> wrote:
>> > > This series optimizes the I/O performance of VMDK driver.
>> > >
>> > > Patch 1 makes the VMDK driver to allocate multiple clusters at once.
>> > Earlier
>> > > it used to allocate cluster by cluster which slowed down its performance
>> > to a
>> > > great extent.
>> > >
>> > > Patch 2 changes the metadata update code to update the L2 tables for
>> > multiple
>> > > clusters at once.
>> >
>> > This patch series is a performance optimization.  Benchmark results
>> > are required to justify optimizations.  Please include performance
>> > results in the next revision.
>> >
>> > A popular disk I/O benchmarking is fio (https://github.com/axboe/fio).
>> > I suggest a write-heavy workload with a large block size:
>> >
>> > $ cat fio.job
>> > [global]
>> > direct=1
>> > filename=/dev/vdb
>> > ioengine=libaio
>> > runtime=30
>> > ramp_time=5
>> >
>> > [job1]
>> > iodepth=4
>> > rw=randwrite
>> > bs=256k
>> > $ for i in 1 2 3 4 5; do fio --output=fio-$i.txt fio.job; done #
>> > WARNING: overwrites /dev/vdb
>> >
>> > It's good practice to run the benchmark several times because there is
>> > usually some variation between runs.  This allows you to check that
>> > the variance is within a reasonable range (5-10% on a normal machine
>> > that hasn't been specially prepared for benchmarking).
>>
>>
>> I ran a few write tests of 128M using qemu-io and the results showed the
>> time to drop to almost half, will those work? Although, I will also try to
>> use the tool you mentioned later today when I am free and include those
>> results as well.
>
> Maybe, it's hard to say without seeing the commands you ran.

These are the commands I ran to test the write requests:

My test file "test1.vmdk" is a 1G empty vmdk image created by using
'qemu-img' tool.

Before optimization:
$ ./bin/qemu-io -f vmdk --cache writeback
qemu-io> open -n -o driver=vmdk test1.vmdk
qemu-io> aio_write 0 128M
qemu-io> wrote 134217728/134217728 bytes at offset 0
128 MiB, 1 ops; 0:00:16.46 (7.772 MiB/sec and 0.0607 ops/sec)

After optimization:
$ ./bin/qemu-io -f vmdk --cache writeback
qemu-io> open -n -o driver=vmdk test1.vmdk
qemu-io> aio_write 0 128M
qemu-io> wrote 134217728/134217728 bytes at offset 0
128 MiB, 1 ops; 0:00:08.19 (15.627 MiB/sec and 0.1221 ops/sec)

Will these work?

Although, I do have to mention that I ran these tests on my PC at home
two weeks ago and since I am back in my college campus again, I no
longer have access to it. Compared to my PC, my laptop has very low
specs (for eg: it embarrassingly takes more than 3 minutes for the
same write request of 128M in the 'before optimization' case), so I
won't be able to reproduce those results here. If possible, can anyone
of you maintainers run these tests with the fio tool on your machines
and send me the results in case the above ones don't work and help me
out? Sorry!

Thanks
Ashijeet
