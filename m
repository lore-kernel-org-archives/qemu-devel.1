Received: from eggs.gnu.org ([2001:4830:134:3::10]:46751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqEa7-00020H-Ea
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqEa6-0004Ty-Ih
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:51:51 -0400
MIME-Version: 1.0
In-Reply-To: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
References: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 Mar 2017 07:51:46 +0000
Message-ID: <CAJSP0QXYdcBt1zOLEz1fdVBg6eo2Yg+uCA=u2nPQHBe01Bo9ow@mail.gmail.com>
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
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Sat, Mar 11, 2017 at 11:54 AM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> This series optimizes the I/O performance of VMDK driver.
>
> Patch 1 makes the VMDK driver to allocate multiple clusters at once. Earlier
> it used to allocate cluster by cluster which slowed down its performance to a
> great extent.
>
> Patch 2 changes the metadata update code to update the L2 tables for multiple
> clusters at once.

This patch series is a performance optimization.  Benchmark results
are required to justify optimizations.  Please include performance
results in the next revision.

A popular disk I/O benchmarking is fio (https://github.com/axboe/fio).
I suggest a write-heavy workload with a large block size:

$ cat fio.job
[global]
direct=1
filename=/dev/vdb
ioengine=libaio
runtime=30
ramp_time=5

[job1]
iodepth=4
rw=randwrite
bs=256k
$ for i in 1 2 3 4 5; do fio --output=fio-$i.txt fio.job; done #
WARNING: overwrites /dev/vdb

It's good practice to run the benchmark several times because there is
usually some variation between runs.  This allows you to check that
the variance is within a reasonable range (5-10% on a normal machine
that hasn't been specially prepared for benchmarking).

Stefan
