Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA5C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF58206E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lgk3Ugae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF58206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc41l-00043s-8L
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kc40U-00037G-It
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kc40S-0000St-0X
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604916155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRmhH02CCaK6iNc3uUQR8u92q7B3f67ge+timEAbMYI=;
 b=Lgk3UgaeOnIiW/Z7naQv662uwPUgrDkQ0pYJcyangYuvAyV/S9QWH7hV/AOu4pKtz+0qQ/
 af+7hs6cfvu2at0Ta+Z6erzHBVIiEI5vct2JDoP4z69nYwwhqk3ZrmWntcN3h7LEk40zV6
 hkmkq7r3iC8d0xLDtT7ybtiFYsasVcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-WJ45_7ZwOhGaXpoNpZz4nw-1; Mon, 09 Nov 2020 05:02:31 -0500
X-MC-Unique: WJ45_7ZwOhGaXpoNpZz4nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ABAB8049F5;
 Mon,  9 Nov 2020 10:02:30 +0000 (UTC)
Received: from work-vm (ovpn-114-198.ams2.redhat.com [10.36.114.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2C16385;
 Mon,  9 Nov 2020 10:02:21 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:02:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Use --thread-pool-size=0 to mean
 no thread pool
Message-ID: <20201109100218.GD3024@work-vm>
References: <20201105194416.GA1384085@redhat.com>
 <20201105195253.GB1384085@redhat.com>
 <D9233684-9B76-468E-A5F1-B35DA3F3C091@intel.com>
 <20201106223524.GG1436035@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201106223524.GG1436035@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Fri, Nov 06, 2020 at 08:33:50PM +0000, Venegas Munoz, Jose Carlos wrote:
> > Hi Vivek,
> > 
> > I have tested with Kata 1.12-apha0, the results seems that are better for the use fio config I am tracking. 
> > 
> > The fio config does  randrw:
> > 
> > fio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio --bs=4k --iodepth=64 --size=200M --readwrite=randrw --rwmixread=75
> > 
> 
> Hi Carlos,
> 
> Thanks for the testing. 
> 
> So basically two conclusions from your tests.
> 
> - for virtiofs, --thread-pool-size=0 is performing better as comapred
>   to --thread-pool-size=1 as well as --thread-pool-size=64. Approximately
>   35-40% better.
> 
> - virtio-9p is still approximately 30% better than virtiofs
>   --thread-pool-size=0.
> 
> As I had done the analysis that this particular workload (mixed read and
> write) is bad with virtiofs because after every write we are invalidating
> attrs and cache so next read ends up fetching attrs again. I had posted
> patches to gain some of the performance.
> 
> https://lore.kernel.org/linux-fsdevel/20200929185015.GG220516@redhat.com/
> 
> But I got the feedback to look into implementing file leases instead.
> 
> Anyway, good to know that --thread-pool-size=0 narrows the performance
> gap substantially (more than half) for this workload. I will look into
> identifying further bottlenecks.

Could you try this thread-pool-size=0 together with your attr patches;
does that catch up to 9p (even though I know you need to rework the attr
stuff as leases).

> Given in my tests, most of the workload benefited from
> --thread-pool-size=0, may be this can be the default and user can
> opt-in for a thread pool (--thread-pool-size=64) once it is known
> that a particular workload benefits from it.
> 
> David, Stefan, WDYT?

I think having the option makes sense; the default I'm not sure about;
what confuses me is why it helps - although it's also interesting it
helps 9p as well.

Dave

> 
> Thanks
> Vivek
> 
> > - I can see better results with this patch
> > - 9pfs is still better in the case of Kata because of the use of:
> > https://github.com/kata-containers/packaging/blob/stable-1.12/qemu/patches/5.0.x/0001-9p-removing-coroutines-of-9p-to-increase-the-I-O-per.patch
> > 
> > Results:
> > ./fio-results-run_virtiofs_tread_pool_0
> >    READ: bw=42.8MiB/s (44.8MB/s), 42.8MiB/s-42.8MiB/s (44.8MB/s-44.8MB/s), io=150MiB (157MB), run=3507-3507msec
> >   WRITE: bw=14.3MiB/s (14.9MB/s), 14.3MiB/s-14.3MiB/s (14.9MB/s-14.9MB/s), io=49.0MiB (52.4MB), run=3507-3507msec
> > ./fio-results-run_9pfs
> >    READ: bw=55.1MiB/s (57.8MB/s), 55.1MiB/s-55.1MiB/s (57.8MB/s-57.8MB/s), io=150MiB (157MB), run=2722-2722msec
> >   WRITE: bw=18.4MiB/s (19.3MB/s), 18.4MiB/s-18.4MiB/s (19.3MB/s-19.3MB/s), io=49.0MiB (52.4MB), run=2722-2722msec
> > ./fio-results-run_virtiofs_tread_pool_1
> >    READ: bw=34.5MiB/s (36.1MB/s), 34.5MiB/s-34.5MiB/s (36.1MB/s-36.1MB/s), io=150MiB (157MB), run=4354-4354msec
> >   WRITE: bw=11.5MiB/s (12.0MB/s), 11.5MiB/s-11.5MiB/s (12.0MB/s-12.0MB/s), io=49.0MiB (52.4MB), run=4354-4354msec
> > ./fio-results-run_virtiofs_tread_pool_64
> >    READ: bw=32.3MiB/s (33.8MB/s), 32.3MiB/s-32.3MiB/s (33.8MB/s-33.8MB/s), io=150MiB (157MB), run=4648-4648msec
> >   WRITE: bw=10.8MiB/s (11.3MB/s), 10.8MiB/s-10.8MiB/s (11.3MB/s-11.3MB/s), io=49.0MiB (52.4MB), run=4648-4648msec
> > 
> > Next: 
> > - run https://github.com/rhvgoyal/virtiofs-tests for  tread_pool_0, tread_pool_64, and 9pfs
> > - Test https://lore.kernel.org/linux-fsdevel/20201009181512.65496-1-vgoyal@redhat.com/
> > 
> > All the testing  for kata is based in:
> > https://github.com/jcvenegas/mrunner/blob/master/scripts/bash_workloads/build-qemu-and-run-fio-test.sh
> > 
> > I ran this using an azure VM.
> > 
> > Cheers,
> > Carlos
> > 
> > 
> > ﻿On 05/11/20 13:53, "Vivek Goyal" <vgoyal@redhat.com> wrote:
> > 
> >     On Thu, Nov 05, 2020 at 02:44:16PM -0500, Vivek Goyal wrote:
> >     > Right now we create a thread pool and main thread hands over the request
> >     > to thread in thread pool to process. Number of threads in thread pool
> >     > can be managed by option --thread-pool-size.
> >     > 
> >     > There is a chance that in case of some workloads, we might get better
> >     > performance if we don't handover the request to a different thread
> >     > and process in the context of thread receiving the request.
> >     > 
> >     > To implement that, redefine the meaning of --thread-pool-size=0 to
> >     > mean that don't use a thread pool. Instead process the request in
> >     > the context of thread receiving request from the queue.
> >     > 
> >     > I can't think how --thread-pool-size=0 is useful and hence using
> >     > that. If it is already useful somehow, I could look at defining
> >     > a new option say "--no-thread-pool".
> >     > 
> >     > I think this patch will be used more as a debug help to do comparison
> >     > when it is more effecient to do not hand over the requests to a
> >     > thread pool.
> > 
> >     I ran virtiofs-tests to comapre --thread-pool-size=0 and
> >     --thread-pool-size=64. And results seem to be all over the place. In
> >     some cases thread pool seems to perform batter and in other cases
> >     no-thread-pool seems to perform better.
> > 
> >     But in general it looks like that except for the case of libaio workload,
> >     no-thread-pool is helping.
> > 
> >     Thanks
> >     Vivek
> > 
> >     NAME                    WORKLOAD                Bandwidth       IOPS            
> >     thread-pool             seqread-psync           682.4mb         170.6k          
> >     no-thread-pool          seqread-psync           679.3mb         169.8k          
> > 
> >     thread-pool             seqread-psync-multi     2415.9mb        603.9k          
> >     no-thread-pool          seqread-psync-multi     2528.5mb        632.1k          
> > 
> >     thread-pool             seqread-mmap            591.7mb         147.9k          
> >     no-thread-pool          seqread-mmap            595.6mb         148.9k          
> > 
> >     thread-pool             seqread-mmap-multi      2195.3mb        548.8k          
> >     no-thread-pool          seqread-mmap-multi      2286.1mb        571.5k          
> > 
> >     thread-pool             seqread-libaio          329.1mb         82.2k           
> >     no-thread-pool          seqread-libaio          271.5mb         67.8k           
> > 
> >     thread-pool             seqread-libaio-multi    1387.1mb        346.7k          
> >     no-thread-pool          seqread-libaio-multi    1508.2mb        377.0k          
> > 
> >     thread-pool             randread-psync          59.0mb          14.7k           
> >     no-thread-pool          randread-psync          78.5mb          19.6k           
> > 
> >     thread-pool             randread-psync-multi    226.4mb         56.6k           
> >     no-thread-pool          randread-psync-multi    289.2mb         72.3k           
> > 
> >     thread-pool             randread-mmap           48.4mb          12.1k           
> >     no-thread-pool          randread-mmap           57.4mb          14.3k           
> > 
> >     thread-pool             randread-mmap-multi     183.5mb         45.8k           
> >     no-thread-pool          randread-mmap-multi     240.5mb         60.1k           
> > 
> >     thread-pool             randread-libaio         329.4mb         82.3k           
> >     no-thread-pool          randread-libaio         261.8mb         65.4k           
> > 
> >     thread-pool             randread-libaio-multi   252.1mb         63.0k           
> >     no-thread-pool          randread-libaio-multi   278.3mb         69.5k           
> > 
> >     thread-pool             seqwrite-psync          54.9mb          13.7k           
> >     no-thread-pool          seqwrite-psync          77.8mb          19.4k           
> > 
> >     thread-pool             seqwrite-psync-multi    219.9mb         54.9k           
> >     no-thread-pool          seqwrite-psync-multi    314.8mb         78.7k           
> > 
> >     thread-pool             seqwrite-mmap           191.7mb         47.9k           
> >     no-thread-pool          seqwrite-mmap           201.4mb         50.3k           
> > 
> >     thread-pool             seqwrite-mmap-multi     346.6mb         86.6k           
> >     no-thread-pool          seqwrite-mmap-multi     387.6mb         96.9k           
> > 
> >     thread-pool             seqwrite-libaio         306.4mb         76.6k           
> >     no-thread-pool          seqwrite-libaio         248.2mb         62.0k           
> > 
> >     thread-pool             seqwrite-libaio-multi   328.5mb         82.1k           
> >     no-thread-pool          seqwrite-libaio-multi   305.6mb         76.4k           
> > 
> >     thread-pool             randwrite-psync         55.6mb          13.9k           
> >     no-thread-pool          randwrite-psync         81.2mb          20.3k           
> > 
> >     thread-pool             randwrite-psync-multi   227.0mb         56.7k           
> >     no-thread-pool          randwrite-psync-multi   311.6mb         77.8k           
> > 
> >     thread-pool             randwrite-mmap          35.3mb          9038            
> >     no-thread-pool          randwrite-mmap          58.1mb          14.5k           
> > 
> >     thread-pool             randwrite-mmap-multi    140.8mb         35.2k           
> >     no-thread-pool          randwrite-mmap-multi    210.5mb         52.6k           
> > 
> >     thread-pool             randwrite-libaio        307.1mb         76.7k           
> >     no-thread-pool          randwrite-libaio        279.4mb         69.8k           
> > 
> >     thread-pool             randwrite-libaio-multi  361.3mb         90.3k           
> >     no-thread-pool          randwrite-libaio-multi  302.6mb         75.6k           
> > 
> >     thread-pool             randrw-psync            34.1mb/11.4mb   8754/2929       
> >     no-thread-pool          randrw-psync            38.7mb/12.9mb   9919/3321       
> > 
> >     thread-pool             randrw-psync-multi      126.2mb/42.3mb  31.5k/10.5k     
> >     no-thread-pool          randrw-psync-multi      172.2mb/57.7mb  43.0k/14.4k     
> > 
> >     thread-pool             randrw-mmap             24.1mb/8270kb   6194/2067       
> >     no-thread-pool          randrw-mmap             42.0mb/14.0mb   10.5k/3606      
> > 
> >     thread-pool             randrw-mmap-multi       127.9mb/42.8mb  31.9k/10.7k     
> >     no-thread-pool          randrw-mmap-multi       179.4mb/60.0mb  44.8k/15.0k     
> > 
> >     thread-pool             randrw-libaio           64.0mb/21.4mb   16.0k/5485      
> >     no-thread-pool          randrw-libaio           79.6mb/26.6mb   19.9k/6831      
> > 
> >     thread-pool             randrw-libaio-multi     174.2mb/58.3mb  43.5k/14.5k     
> >     no-thread-pool          randrw-libaio-multi     201.6mb/67.5mb  50.4k/16.8k     
> > 
> > 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


