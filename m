Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30051C19759
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 02:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B6E2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 02:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huT7q-0000xt-9C
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 22:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55717)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1huT6z-0000Wi-KO
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 22:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1huT6y-0002TA-98
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 22:52:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60312 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1huT6x-0002Q7-8Y
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 22:52:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B7B252624C06C64101E9;
 Mon,  5 Aug 2019 10:52:29 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 10:52:24 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, <virtio-fs@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20190801165409.20121-1-stefanha@redhat.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D4799E5.6020006@huawei.com>
Date: Mon, 5 Aug 2019 10:52:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190801165409.20121-1-stefanha@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

From my test, 9p has better bandwidth than virtio as below:

---
9p Test:
# mount -t 9p -o trans=virtio,version=9p2000.L,rw,nodev,msize=1000000000,access=client 9pshare /mnt/9pshare

# fio -direct=1 -time_based -iodepth=1 -rw=randwrite -ioengine=libaio -bs=1M -size=1G -numjob=1 -runtime=30 -group_reporting -name=file -filename=/mnt/9pshare/file
file: (g=0): rw=randwrite, bs=1M-1M/1M-1M/1M-1M, ioengine=libaio, iodepth=1
fio-2.13
Starting 1 process
file: Laying out IO file(s) (1 file(s) / 1024MB)
Jobs: 1 (f=1): [w(1)] [100.0% done] [0KB/1091MB/0KB /s] [0/1091/0 iops] [eta 00m:00s]
file: (groupid=0, jobs=1): err= 0: pid=6187: Mon Aug  5 17:55:44 2019
  write: io=35279MB, bw=1175.1MB/s, iops=1175, runt= 30001msec
    slat (usec): min=589, max=4211, avg=844.04, stdev=124.04
    clat (usec): min=1, max=24, avg= 2.53, stdev= 1.16
     lat (usec): min=591, max=4214, avg=846.57, stdev=124.14
    clat percentiles (usec):
     |  1.00th=[    2],  5.00th=[    2], 10.00th=[    2], 20.00th=[    2],
     | 30.00th=[    2], 40.00th=[    2], 50.00th=[    2], 60.00th=[    3],
     | 70.00th=[    3], 80.00th=[    3], 90.00th=[    3], 95.00th=[    3],
     | 99.00th=[    4], 99.50th=[   13], 99.90th=[   18], 99.95th=[   20],
     | 99.99th=[   22]
    lat (usec) : 2=0.04%, 4=98.27%, 10=1.15%, 20=0.48%, 50=0.06%
  cpu          : usr=23.83%, sys=5.24%, ctx=105843, majf=0, minf=9
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=35279/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1
---

---
virtiofs Test:
# ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/mnt/virtiofs/ -o cache=none

# mount -t virtio_fs myfs /mnt/virtiofs -o rootmode=040000,user_id=0,group_id=0

# fio -direct=1 -time_based -iodepth=1 -rw=randwrite -ioengine=libaio -bs=1M -size=1G -numjob=1 -runtime=30 -group_reporting -name=file -filename=/mnt/virtiofs/file
file: (g=0): rw=randwrite, bs=1M-1M/1M-1M/1M-1M, ioengine=libaio, iodepth=1
fio-2.13
Starting 1 process
file: Laying out IO file(s) (1 file(s) / 1024MB)
Jobs: 1 (f=1): [w(1)] [100.0% done] [0KB/895.1MB/0KB /s] [0/895/0 iops] [eta 00m:00s]
file: (groupid=0, jobs=1): err= 0: pid=6046: Mon Aug  5 17:54:58 2019
  write: io=23491MB, bw=801799KB/s, iops=783, runt= 30001msec
    slat (usec): min=93, max=390, avg=233.40, stdev=64.22
    clat (usec): min=849, max=4083, avg=1039.32, stdev=178.98
     lat (usec): min=971, max=4346, avg=1272.72, stdev=200.34
    clat percentiles (usec):
     |  1.00th=[  972],  5.00th=[  980], 10.00th=[  988], 20.00th=[  988],
     | 30.00th=[  996], 40.00th=[ 1004], 50.00th=[ 1012], 60.00th=[ 1012],
     | 70.00th=[ 1020], 80.00th=[ 1032], 90.00th=[ 1032], 95.00th=[ 1384],
     | 99.00th=[ 1560], 99.50th=[ 1768], 99.90th=[ 3664], 99.95th=[ 4016],
     | 99.99th=[ 4048]
    lat (usec) : 1000=37.21%
    lat (msec) : 2=62.39%, 4=0.34%, 10=0.06%
  cpu          : usr=15.39%, sys=4.03%, ctx=23496, majf=0, minf=10
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=23491/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1
---

And the backend filesystem is ext4 + ramdisk, and 9p has deeper queue
depth than virtiofs catched by iostat. Then I check the code, and found
9p uses pwritev, but virtiofs uses pwrite. I wonder if virtiofs could
also use iovec to improve its performance.

I'd like to help contributing the patch in the future.

Thanks,
Jun

On 2019/8/2 0:54, Stefan Hajnoczi wrote:
> This patch series introduces the virtiofsd --thread-pool-size=NUM and sets the
> default value to 64.  Each virtqueue has its own thread pool for processing
> requests.  Blocking requests no longer pause virtqueue processing and I/O
> performance should be greatly improved when the queue depth is greater than 1.
> 
> Linux boot and pjdfstest have been tested with these patches and the default
> thread pool size of 64.
> 
> I have now concluded the thread-safety code audit.  Please let me know if you
> have concerns about things I missed.
> 
> Performance
> -----------
> Please try these patches out and share your results.
> 
> Scalability
> -----------
> There are several synchronization primitives that are taken by the virtqueue
> processing thread or the thread pool worker.  Unfortunately this is necessary
> to protect shared state.  It means that thread pool workers contend on or at
> least access thread synchronization primitives.  If anyone has suggestions for
> improving this situation, please discuss.
> 
> 1. vu_dispatch_rwlock - libvhost-user from races between the vhost-user
>    protocol thread and the virtqueue processing and thread pool worker threads.
> 
> 2. vq_lock - protects the virtqueue from races between the virtqueue processing
>    thread and thread pool workers.
> 
> 3. init_rwlock - protects FUSE_INIT/FUSE_DESTROY from races with other
>    requests.
> 
> 4. se->lock - protects se->list and the FUSE_INTERRUPT shared state.
> 
> Ideally we could avoid hitting all of these locks on each request.  That would
> make the code scale better.
> 
> Future work
> -----------
> This series does not complete the multithreading effort yet.  Two items are
> still missing:
> 1. Multiqueue support
> 2. CPU affinity for virtqueue processing threads and thread pools
> 
> Stefan Hajnoczi (4):
>   virtiofsd: process requests in a thread pool
>   virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
>   virtiofsd: fix lo_destroy() resource leaks
>   virtiofsd: add --thread-pool-size=NUM option
> 
>  contrib/virtiofsd/fuse_i.h         |   2 +
>  contrib/virtiofsd/fuse_lowlevel.c  |  25 +-
>  contrib/virtiofsd/fuse_virtio.c    | 491 ++++++++++++++++-------------
>  contrib/virtiofsd/passthrough_ll.c |  43 ++-
>  contrib/virtiofsd/seccomp.c        |   1 +
>  5 files changed, 318 insertions(+), 244 deletions(-)
> 

