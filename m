Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C24C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DE520748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKpra3B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DE520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mWD-0004Oq-DN
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k3mAy-0006js-8R
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 16:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k3mAv-0003gg-NX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 16:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596744460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=joeqeLvJ2iySElb5CMt+QdGfxkouO4ht/kWT8/rNr0s=;
 b=gKpra3B7J3NJW3c7ivv3Lw3h8h9XqEDsgCyRoUUeAjtcWEYqny51XM1AemhmXwQ4FErVOd
 v9iRM+O4YijSG+NaR6Fye314qvpc9LRpcqUVjs0OiZ91mdevWIZe3/S0LviK5TvHiBVF94
 +0kqU9Zb49hAJcLde3JbUdPIA5O9lT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-XPP8kz4rNd2l_PNXlWfDAg-1; Thu, 06 Aug 2020 16:07:38 -0400
X-MC-Unique: XPP8kz4rNd2l_PNXlWfDAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E64B800404;
 Thu,  6 Aug 2020 20:07:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-23.rdu2.redhat.com [10.10.112.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9C811944D;
 Thu,  6 Aug 2020 20:07:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 2E87D220441; Thu,  6 Aug 2020 16:07:29 -0400 (EDT)
Date: Thu, 6 Aug 2020 16:07:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Derek Su <jwsu1986@gmail.com>
Subject: Re: [Virtio-fs] virtio-fs performance
Message-ID: <20200806200729.GH367847@redhat.com>
References: <CAFKS8hWbckrE_cyJCf0pgFresD-JQk66wo-6uJA=Gu2MhReHVw@mail.gmail.com>
 <20200728134936.GA21660@stefanha-x1.localdomain>
 <20200728152719.GD78409@redhat.com>
 <CAFKS8hUPdx=eHpvYqB3T__ZBWyztfNPGSBtiBDiqMotA8Cca9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFKS8hUPdx=eHpvYqB3T__ZBWyztfNPGSBtiBDiqMotA8Cca9Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 03:51:50PM +0800, Derek Su wrote:
> Vivek Goyal <vgoyal@redhat.com> 於 2020年7月28日 週二 下午11:27寫道：
> >
> > On Tue, Jul 28, 2020 at 02:49:36PM +0100, Stefan Hajnoczi wrote:
> > > > I'm trying and testing the virtio-fs feature in QEMU v5.0.0.
> > > > My host and guest OS are both ubuntu 18.04 with kernel 5.4, and the
> > > > underlying storage is one single SSD.
> > > >
> > > > The configuations are:
> > > > (1) virtiofsd
> > > > ./virtiofsd -o
> > > > source=/mnt/ssd/virtiofs,cache=auto,flock,posix_lock,writeback,xattr
> > > > --thread-pool-size=1 --socket-path=/tmp/vhostqemu
> > > >
> > > > (2) qemu
> > > > qemu-system-x86_64 \
> > > > -enable-kvm \
> > > > -name ubuntu \
> > > > -cpu Westmere \
> > > > -m 4096 \
> > > > -global kvm-apic.vapic=false \
> > > > -netdev tap,id=hn0,vhost=off,br=br0,helper=/usr/local/libexec/qemu-bridge-helper
> > > > \
> > > > -device e1000,id=e0,netdev=hn0 \
> > > > -blockdev '{"node-name": "disk0", "driver": "qcow2",
> > > > "refcount-cache-size": 1638400, "l2-cache-size": 6553600, "file": {
> > > > "driver": "file", "filename": "'${imagefolder}\/ubuntu.qcow2'"}}' \
> > > > -device virtio-blk,drive=disk0,id=disk0 \
> > > > -chardev socket,id=ch0,path=/tmp/vhostqemu \
> > > > -device vhost-user-fs-pci,chardev=ch0,tag=myfs \
> > > > -object memory-backend-memfd,id=mem,size=4G,share=on \
> > > > -numa node,memdev=mem \
> > > > -qmp stdio \
> > > > -vnc :0
> > > >
> > > > (3) guest
> > > > mount -t virtiofs myfs /mnt/virtiofs
> > > >
> > > > I tried to change virtiofsd's --thread-pool-size value and test the
> > > > storage performance by fio.
> > > > Before each read/write/randread/randwrite test, the pagecaches of
> > > > guest and host are dropped.
> > > >
> > > > ```
> > > > RW="read" # or write/randread/randwrite
> > > > fio --name=test --rw=$RW --bs=4k --numjobs=1 --ioengine=libaio
> > > > --runtime=60 --direct=0 --iodepth=64 --size=10g
> > > > --filename=/mnt/virtiofs/testfile
> > > > done
> >
> > Couple of things.
> >
> > - Can you try cache=none option in virtiofsd. That will bypass page
> >   cache in guest. It also gets rid of latencies related to
> >   file_remove_privs() as of now.
> >
> > - Also with direct=0, are we really driving iodepth of 64? With direct=0
> >   it is cached I/O. Is it still asynchronous at this point of time of
> >   we have fallen back to synchronous I/O and driving queue depth of
> >   1.
> 
> Hi, Vivek
> 
> I did not see any difference in queue depth with direct={0|1} in my fio test.
> Are there more clues to dig into this issue?

I tried it just again. fio seems to say queue depth 64 in both the cases
but I am not sure if this is correct. Reason being that I get much
better performance with direct=1. Also fio man page says.

 libaio Linux native asynchronous I/O. Note that Linux may
        only support queued behavior with non-buffered I/O
        (set  `direct=1'  or  `buffered=0').   This engine
        defines engine specific options.

Are you see difference in effective bandwidth/iops when you run with
direct=0/1. I see it. 

Anyway, in an attempt to narrow down the issues, I ran virtiofsd 
with cache=none and did not enable xattr. (As of now xattr case
needs to be optimized with SB_NOSEC).

I ran virtiofsd as follows.

./virtiofsd --socket-path=/tmp/vhostqemu2 -o source=/mnt/sdb/virtiofs-source2/ -o no_posix_lock -o modcaps=+sys_admin -o log_level=info -o cache=none --daemonize

And then ran following fio commands with direct=0 and direct=1.

fio --name=test --rw=randwrite --bs=4K --numjobs=1 --ioengine=libaio --runtime=30 --direct=0 --iodepth=64 --filename=fio-file1

direct=0
--------
write: IOPS=8712, BW=34.0MiB/s (35.7MB/s)(1021MiB/30001msec)

direct=1
--------
write: IOPS=84.4k, BW=330MiB/s (346MB/s)(4096MiB/12428msec)

So I see almost 10 fold jump in throughput with direct=1. So I believe
direct=0 is not driving the queue depth.

You raised interesting issue of --thread-pool-size=1 vs 64 and I decided
to give it a try. I ran same tests as above with thread pool size 1
and following are results.

with direct=0
-------------
write: IOPS=14.7k, BW=57.4MiB/s (60.2MB/s)(1721MiB/30001msec)

with direct=1
-------------
write: IOPS=71.7k, BW=280MiB/s (294MB/s)(4096MiB/14622msec);

So with we are driving queue depth 1 (direct=0), looks like
--thread-pool-size 1 is helping. I see higher IOPS. But when we are
driving queue depth of 64, then --thread-pool-size=1 seems to hurt.

Now question is, why thread pool size 64 by default hurts so much
for the case of queue depth 1.

You raised anohter issue of it being slower than NFSv4/CIFS. I think
you can run virtiofsd with cache=none and without enabling xattr
and post results here so that we have some idea how much better
NFSv4/CIFS is.

Thanks
Vivek


