Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AE32076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iU216Wwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AE32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnVw-0007dS-6y
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLnOh-00079g-8Z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:04:23 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:47337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLnOZ-0002st-Ke
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ITRaC9w6PrD2MGOdpu2dHRwNtseqwV6+vX/KHG3KCAw=; b=iU216WwhrFPM5U8WViU3i1Ye4Y
 fPio3qoFZ5l+F27z2EafUcBtzl7vRjorLuUSt2bYUYZHDLsKqdjGhacU2evzeFm7A+M47yvO+i0kX
 OcqiYXxem+SruNKr+fieZFivQYDhmqJGaIvDliiyWLf+pHlBklo2Mqo0oHb3fL0XgBcp0lwoljKiC
 oy8oLa5AsXAbSqYGJvPREQNBYzgz4lDTpfhfkTDYsTew0CddXf2R5WwvNzCDmoROXc7DbCYTi/242
 +4bt/2TtKXgw8yRwww+OTUtvvO1wEn5f2yLhgt8Asht2GrqUbb+1M8qrJK8+2qTCzJBbOvC5NT4Lc
 GRm30L/w==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Date: Fri, 25 Sep 2020 15:04:06 +0200
Message-ID: <4973513.bp6ERB8pJA@silver>
In-Reply-To: <20200925124139.GJ2873@work-vm>
References: <20200918213436.GA3520@redhat.com>
 <20200924221023.GB132653@redhat.com> <20200925124139.GJ2873@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 09:04:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Freitag, 25. September 2020 14:41:39 CEST Dr. David Alan Gilbert wrote:
> > Hi Carlos,
> > 
> > So you are running following test.
> > 
> > fio --direct=1 --gtod_reduce=1 --name=test
> > --filename=random_read_write.fio --bs=4k --iodepth=64 --size=4G
> > --readwrite=randrw --rwmixread=75 --output=/output/fio.txt
> > 
> > And following are your results.
> > 
> > 9p
> > --
> > READ: bw=211MiB/s (222MB/s), 211MiB/s-211MiB/s (222MB/s-222MB/s),
> > io=3070MiB (3219MB), run=14532-14532msec
> > 
> > WRITE: bw=70.6MiB/s (74.0MB/s), 70.6MiB/s-70.6MiB/s (74.0MB/s-74.0MB/s),
> > io=1026MiB (1076MB), run=14532-14532msec
> > 
> > virtiofs
> > --------
> > 
> > Run status group 0 (all jobs):
> >    READ: bw=159MiB/s (167MB/s), 159MiB/s-159MiB/s (167MB/s-167MB/s),
> >    io=3070MiB (3219MB), run=19321-19321msec>   
> >   WRITE: bw=53.1MiB/s (55.7MB/s), 53.1MiB/s-53.1MiB/s (55.7MB/s-55.7MB/s),
> >   io=1026MiB (1076MB), run=19321-19321msec> 
> > So looks like you are getting better performance with 9p in this case.
> 
> That's interesting, because I've just tried similar again with my
> ramdisk setup:
> 
> fio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio
> --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75
> --output=aname.txt
> 
> 
> virtiofs default options
> test: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=psync, iodepth=64 fio-3.21
> Starting 1 process
> test: Laying out IO file (1 file / 4096MiB)
> 
> test: (groupid=0, jobs=1): err= 0: pid=773: Fri Sep 25 12:28:32 2020
>   read: IOPS=18.3k, BW=71.3MiB/s (74.8MB/s)(3070MiB/43042msec)
>    bw (  KiB/s): min=70752, max=77280, per=100.00%, avg=73075.71,
> stdev=1603.47, samples=85 iops        : min=17688, max=19320, avg=18268.92,
> stdev=400.86, samples=85 write: IOPS=6102, BW=23.8MiB/s
> (24.0MB/s)(1026MiB/43042msec); 0 zone resets bw (  KiB/s): min=23128,
> max=25696, per=100.00%, avg=24420.40, stdev=583.08, samples=85 iops       
> : min= 5782, max= 6424, avg=6105.09, stdev=145.76, samples=85 cpu         
> : usr=0.10%, sys=30.09%, ctx=1245312, majf=0, minf=6 IO depths    :
> 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0% submit    :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% complete  :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% issued rwts:
> total=785920,262656,0,0 short=0,0,0,0 dropped=0,0,0,0 latency   : target=0,
> window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>    READ: bw=71.3MiB/s (74.8MB/s), 71.3MiB/s-71.3MiB/s (74.8MB/s-74.8MB/s),
> io=3070MiB (3219MB), run=43042-43042msec WRITE: bw=23.8MiB/s (24.0MB/s),
> 23.8MiB/s-23.8MiB/s (24.0MB/s-24.0MB/s), io=1026MiB (1076MB),
> run=43042-43042msec
> 
> virtiofs cache=none
> test: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=psync, iodepth=64 fio-3.21
> Starting 1 process
> 
> test: (groupid=0, jobs=1): err= 0: pid=740: Fri Sep 25 12:30:57 2020
>   read: IOPS=22.9k, BW=89.6MiB/s (93.0MB/s)(3070MiB/34256msec)
>    bw (  KiB/s): min=89048, max=94240, per=100.00%, avg=91871.06,
> stdev=967.87, samples=68 iops        : min=22262, max=23560, avg=22967.76,
> stdev=241.97, samples=68 write: IOPS=7667, BW=29.0MiB/s
> (31.4MB/s)(1026MiB/34256msec); 0 zone resets bw (  KiB/s): min=29264,
> max=32248, per=100.00%, avg=30700.82, stdev=541.97, samples=68 iops       
> : min= 7316, max= 8062, avg=7675.21, stdev=135.49, samples=68 cpu         
> : usr=1.03%, sys=27.64%, ctx=1048635, majf=0, minf=5 IO depths    :
> 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0% submit    :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% complete  :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% issued rwts:
> total=785920,262656,0,0 short=0,0,0,0 dropped=0,0,0,0 latency   : target=0,
> window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>    READ: bw=89.6MiB/s (93.0MB/s), 89.6MiB/s-89.6MiB/s (93.0MB/s-93.0MB/s),
> io=3070MiB (3219MB), run=34256-34256msec WRITE: bw=29.0MiB/s (31.4MB/s),
> 29.0MiB/s-29.0MiB/s (31.4MB/s-31.4MB/s), io=1026MiB (1076MB),
> run=34256-34256msec
> 
> virtiofs cache=none thread-pool-size=1
> test: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=psync, iodepth=64 fio-3.21
> Starting 1 process
> 
> test: (groupid=0, jobs=1): err= 0: pid=738: Fri Sep 25 12:33:17 2020
>   read: IOPS=23.7k, BW=92.4MiB/s (96.9MB/s)(3070MiB/33215msec)
>    bw (  KiB/s): min=89808, max=111952, per=100.00%, avg=94762.30,
> stdev=4507.43, samples=66 iops        : min=22452, max=27988, avg=23690.58,
> stdev=1126.86, samples=66 write: IOPS=7907, BW=30.9MiB/s
> (32.4MB/s)(1026MiB/33215msec); 0 zone resets bw (  KiB/s): min=29424,
> max=37112, per=100.00%, avg=31668.73, stdev=1558.69, samples=66 iops       
> : min= 7356, max= 9278, avg=7917.18, stdev=389.67, samples=66 cpu         
> : usr=0.43%, sys=29.07%, ctx=1048627, majf=0, minf=7 IO depths    :
> 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0% submit    :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% complete  :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% issued rwts:
> total=785920,262656,0,0 short=0,0,0,0 dropped=0,0,0,0 latency   : target=0,
> window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>    READ: bw=92.4MiB/s (96.9MB/s), 92.4MiB/s-92.4MiB/s (96.9MB/s-96.9MB/s),
> io=3070MiB (3219MB), run=33215-33215msec WRITE: bw=30.9MiB/s (32.4MB/s),
> 30.9MiB/s-30.9MiB/s (32.4MB/s-32.4MB/s), io=1026MiB (1076MB),
> run=33215-33215msec
> 
> 9p ( mount -t 9p -o trans=virtio kernel /mnt
> -oversion=9p2000.L,cache=mmap,msize=1048576 ) test: (g=0): rw=randrw,
Bottleneck ------------------------------^

By increasing 'msize' you would encounter better 9P I/O results.

> bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=psync,
> iodepth=64 fio-3.21
> Starting 1 process
> 
> test: (groupid=0, jobs=1): err= 0: pid=736: Fri Sep 25 12:36:00 2020
>   read: IOPS=16.2k, BW=63.5MiB/s (66.6MB/s)(3070MiB/48366msec)
>    bw (  KiB/s): min=63426, max=82776, per=100.00%, avg=65054.28,
> stdev=2014.88, samples=96 iops        : min=15856, max=20694, avg=16263.34,
> stdev=503.74, samples=96 write: IOPS=5430, BW=21.2MiB/s
> (22.2MB/s)(1026MiB/48366msec); 0 zone resets bw (  KiB/s): min=20916,
> max=27632, per=100.00%, avg=21740.64, stdev=735.73, samples=96 iops       
> : min= 5229, max= 6908, avg=5434.99, stdev=183.95, samples=96 cpu         
> : usr=1.60%, sys=14.28%, ctx=1049348, majf=0, minf=7 IO depths    :
> 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0% submit    :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% complete  :
> 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% issued rwts:
> total=785920,262656,0,0 short=0,0,0,0 dropped=0,0,0,0 latency   : target=0,
> window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>    READ: bw=63.5MiB/s (66.6MB/s), 63.5MiB/s-63.5MiB/s (66.6MB/s-66.6MB/s),
> io=3070MiB (3219MB), run=48366-48366msec WRITE: bw=21.2MiB/s (22.2MB/s),
> 21.2MiB/s-21.2MiB/s (22.2MB/s-22.2MB/s), io=1026MiB (1076MB),
> run=48366-48366msec
> 
> So I'm sitll beating 9p; the thread-pool-size=1 seems to be great for
> read performance here.
> 
> Dave

Best regards,
Christian Schoenebeck



