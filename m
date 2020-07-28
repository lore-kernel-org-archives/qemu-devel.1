Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C1BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DA4206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fX6n02DX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DA4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RWb-00061x-Gc
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0RVt-00056Y-Bv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:27:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0RVr-0002Pg-ME
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595950050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7ACDhOuy6pbdcVKPDt9pYC0XiZK/+3F9afcD++UUl8=;
 b=fX6n02DXQ+fSY1niPgQV/4MeFlrgEjDPncTnpdy3mgmlfeYX1ZEQ4/GIzyyVYVbNUExP3l
 kqorLK9Z5uwoZMkFDKMGOxgeIw+B1CgV+V5fAt6DpD5uukc27XkoI6mD8uiGtRWzn0uyTU
 CydilSkDsaeerka0xj2BM8kVfbC7ibQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-43x8TjOePuiVes5JpEpUIw-1; Tue, 28 Jul 2020 11:27:26 -0400
X-MC-Unique: 43x8TjOePuiVes5JpEpUIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E47F8800460;
 Tue, 28 Jul 2020 15:27:25 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-119.rdu2.redhat.com [10.10.116.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFDD171F9;
 Tue, 28 Jul 2020 15:27:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 241AA220204; Tue, 28 Jul 2020 11:27:19 -0400 (EDT)
Date: Tue, 28 Jul 2020 11:27:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] virtio-fs performance
Message-ID: <20200728152719.GD78409@redhat.com>
References: <CAFKS8hWbckrE_cyJCf0pgFresD-JQk66wo-6uJA=Gu2MhReHVw@mail.gmail.com>
 <20200728134936.GA21660@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200728134936.GA21660@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: virtio-fs@redhat.com, jwsu1986@gmail.com, qemu-devel@nongnu.org,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 02:49:36PM +0100, Stefan Hajnoczi wrote:
> > I'm trying and testing the virtio-fs feature in QEMU v5.0.0.
> > My host and guest OS are both ubuntu 18.04 with kernel 5.4, and the
> > underlying storage is one single SSD.
> > 
> > The configuations are:
> > (1) virtiofsd
> > ./virtiofsd -o 
> > source=/mnt/ssd/virtiofs,cache=auto,flock,posix_lock,writeback,xattr
> > --thread-pool-size=1 --socket-path=/tmp/vhostqemu
> > 
> > (2) qemu
> > qemu-system-x86_64 \
> > -enable-kvm \
> > -name ubuntu \
> > -cpu Westmere \
> > -m 4096 \
> > -global kvm-apic.vapic=false \
> > -netdev tap,id=hn0,vhost=off,br=br0,helper=/usr/local/libexec/qemu-bridge-helper
> > \
> > -device e1000,id=e0,netdev=hn0 \
> > -blockdev '{"node-name": "disk0", "driver": "qcow2",
> > "refcount-cache-size": 1638400, "l2-cache-size": 6553600, "file": {
> > "driver": "file", "filename": "'${imagefolder}\/ubuntu.qcow2'"}}' \
> > -device virtio-blk,drive=disk0,id=disk0 \
> > -chardev socket,id=ch0,path=/tmp/vhostqemu \
> > -device vhost-user-fs-pci,chardev=ch0,tag=myfs \
> > -object memory-backend-memfd,id=mem,size=4G,share=on \
> > -numa node,memdev=mem \
> > -qmp stdio \
> > -vnc :0
> > 
> > (3) guest
> > mount -t virtiofs myfs /mnt/virtiofs
> > 
> > I tried to change virtiofsd's --thread-pool-size value and test the
> > storage performance by fio.
> > Before each read/write/randread/randwrite test, the pagecaches of
> > guest and host are dropped.
> > 
> > ```
> > RW="read" # or write/randread/randwrite
> > fio --name=test --rw=$RW --bs=4k --numjobs=1 --ioengine=libaio
> > --runtime=60 --direct=0 --iodepth=64 --size=10g
> > --filename=/mnt/virtiofs/testfile
> > done

Couple of things.

- Can you try cache=none option in virtiofsd. That will bypass page
  cache in guest. It also gets rid of latencies related to
  file_remove_privs() as of now. 

- Also with direct=0, are we really driving iodepth of 64? With direct=0
  it is cached I/O. Is it still asynchronous at this point of time of
  we have fallen back to synchronous I/O and driving queue depth of
  1.

- With cache=auto/always, I am seeing performance issues with small writes
  and trying to address it.

https://lore.kernel.org/linux-fsdevel/20200716144032.GC422759@redhat.com/
https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/

Thanks
Vivek

> > ```
> > 
> > --thread-pool-size=64 (default)
> >     seq read: 305 MB/s
> >     seq write: 118 MB/s
> >     rand 4KB read: 2222 IOPS
> >     rand 4KB write: 21100 IOPS
> > 
> > --thread-pool-size=1
> >     seq read: 387 MB/s
> >     seq write: 160 MB/s
> >     rand 4KB read: 2622 IOPS
> >     rand 4KB write: 30400 IOPS
> > 
> > The results show the performance using default-pool-size (64) is
> > poorer than using single thread.
> > Is it due to the lock contention of the multiple threads?
> > When can virtio-fs get better performance using multiple threads?
> > 
> > 
> > I also tested the performance that guest accesses host's files via
> > NFSv4/CIFS network filesystem.
> > The "seq read" and "randread" performance of virtio-fs are also worse
> > than the NFSv4 and CIFS.
> > 
> > NFSv4:
> >   seq write: 244 MB/s
> >   rand 4K read: 4086 IOPS
> > 
> > I cannot figure out why the perf of NFSv4/CIFS with the network stack
> > is better than virtio-fs.
> > Is it expected? Or, do I have an incorrect configuration?
> 
> No, I remember benchmarking the thread pool and did not see such a big
> difference.
> 
> Please use direct=1 so that each I/O results in a virtio-fs request.
> Otherwise the I/O pattern is not directly controlled by the benchmark
> but by the page cache (readahead, etc).
> 
> Using numactl(8) or taskset(1) to launch virtiofsd allows you to control
> NUMA and CPU scheduling properties. For example, you could force all 64
> threads to run on the same host CPU using taskset to see if that helps
> this I/O bound workload.
> 
> fio can collect detailed statistics on queue depths and a latency
> histogram. It would be interesting to compare the --thread-pool-size=64
> and --thread-pool-size=1 numbers.
> 
> Comparing the "perf record -e kvm:kvm_exit" counts between the two might
> also be interesting.
> 
> Stefan



> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


