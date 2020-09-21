Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24245C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A34421789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbKqDdnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A34421789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKSGL-00030p-Ep
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 16:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKSFE-0002SD-HS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 16:17:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKSFB-0004sk-PJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 16:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600719420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CVis8ozLJDYsPA2ILkJHvj11QvtCQxe8IZoh70/YuA=;
 b=EbKqDdntR1k9v++qA62M1hXP2QvaO0PcgVwlN/SrW8wNyPXrjZf8Nc4fR/OfgmDWCdA4X1
 OAocrs6L4eEBcNGqcOAfBzfMzDlDR2cVOXuFtSIMcxUn+C02Jdw80e60AE2JPtZbPTQFii
 AmYurgZ7VrAqeSZ4YncXxNyEKltAEtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-pdU5SRJ-NjmpU4_51GnXoQ-1; Mon, 21 Sep 2020 16:16:48 -0400
X-MC-Unique: pdU5SRJ-NjmpU4_51GnXoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED4DD909CC0;
 Mon, 21 Sep 2020 20:16:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-27.rdu2.redhat.com [10.10.114.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDDF23A40;
 Mon, 21 Sep 2020 20:16:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 50E5D220C56; Mon, 21 Sep 2020 16:16:41 -0400 (EDT)
Date: Mon, 21 Sep 2020 16:16:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921201641.GD13362@redhat.com>
References: <20200918213436.GA3520@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918213436.GA3520@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 16:17:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 05:34:36PM -0400, Vivek Goyal wrote:
> Hi All,
> 
> virtiofsd default thread pool size is 64. To me it feels that in most of
> the cases thread pool size 1 performs better than thread pool size 64.
> 
> I ran virtiofs-tests.
> 
> https://github.com/rhvgoyal/virtiofs-tests

I spent more time debugging this. First thing I noticed is that we
are using "exclusive" glib thread pool.

https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new

This seems to run pre-determined number of threads dedicated to that
thread pool. Little instrumentation of code revealed that every new
request gets assiged to new thread (despite the fact that previous
thread finished its job). So internally there might be some kind of
round robin policy to choose next thread for running the job.

I decided to switch to "shared" pool instead where it seemed to spin
up new threads only if there is enough work. Also threads can be shared
between pools.

And looks like testing results are way better with "shared" pools. So
may be we should switch to shared pool by default. (Till somebody shows
in what cases exclusive pools are better).

Second thought which came to mind was what's the impact of NUMA. What
if qemu and virtiofsd process/threads are running on separate NUMA
node. That should increase memory access latency and increased overhead.
So I used "numactl --cpubind=0" to bind both qemu and virtiofsd to node
0. My machine seems to have two numa nodes. (Each node is having 32
logical processors). Keeping both qemu and virtiofsd on same node
improves throughput further.

So here are the results.

vtfs-none-epool --> cache=none, exclusive thread pool.
vtfs-none-spool --> cache=none, shared thread pool.
vtfs-none-spool-numa --> cache=none, shared thread pool, same numa node


NAME                    WORKLOAD                Bandwidth       IOPS            
vtfs-none-epool         seqread-psync           36(MiB/s)       9392            
vtfs-none-spool         seqread-psync           68(MiB/s)       17k             
vtfs-none-spool-numa    seqread-psync           73(MiB/s)       18k             

vtfs-none-epool         seqread-psync-multi     210(MiB/s)      52k             
vtfs-none-spool         seqread-psync-multi     260(MiB/s)      65k             
vtfs-none-spool-numa    seqread-psync-multi     309(MiB/s)      77k             

vtfs-none-epool         seqread-libaio          286(MiB/s)      71k             
vtfs-none-spool         seqread-libaio          328(MiB/s)      82k             
vtfs-none-spool-numa    seqread-libaio          332(MiB/s)      83k             

vtfs-none-epool         seqread-libaio-multi    201(MiB/s)      50k             
vtfs-none-spool         seqread-libaio-multi    254(MiB/s)      63k             
vtfs-none-spool-numa    seqread-libaio-multi    276(MiB/s)      69k             

vtfs-none-epool         randread-psync          40(MiB/s)       10k             
vtfs-none-spool         randread-psync          64(MiB/s)       16k             
vtfs-none-spool-numa    randread-psync          72(MiB/s)       18k             

vtfs-none-epool         randread-psync-multi    211(MiB/s)      52k             
vtfs-none-spool         randread-psync-multi    252(MiB/s)      63k             
vtfs-none-spool-numa    randread-psync-multi    297(MiB/s)      74k             

vtfs-none-epool         randread-libaio         313(MiB/s)      78k             
vtfs-none-spool         randread-libaio         320(MiB/s)      80k             
vtfs-none-spool-numa    randread-libaio         330(MiB/s)      82k             

vtfs-none-epool         randread-libaio-multi   257(MiB/s)      64k             
vtfs-none-spool         randread-libaio-multi   274(MiB/s)      68k             
vtfs-none-spool-numa    randread-libaio-multi   319(MiB/s)      79k             

vtfs-none-epool         seqwrite-psync          34(MiB/s)       8926            
vtfs-none-spool         seqwrite-psync          55(MiB/s)       13k             
vtfs-none-spool-numa    seqwrite-psync          66(MiB/s)       16k             

vtfs-none-epool         seqwrite-psync-multi    196(MiB/s)      49k             
vtfs-none-spool         seqwrite-psync-multi    225(MiB/s)      56k             
vtfs-none-spool-numa    seqwrite-psync-multi    270(MiB/s)      67k             

vtfs-none-epool         seqwrite-libaio         257(MiB/s)      64k             
vtfs-none-spool         seqwrite-libaio         304(MiB/s)      76k             
vtfs-none-spool-numa    seqwrite-libaio         267(MiB/s)      66k             

vtfs-none-epool         seqwrite-libaio-multi   312(MiB/s)      78k             
vtfs-none-spool         seqwrite-libaio-multi   366(MiB/s)      91k             
vtfs-none-spool-numa    seqwrite-libaio-multi   381(MiB/s)      95k             

vtfs-none-epool         randwrite-psync         38(MiB/s)       9745            
vtfs-none-spool         randwrite-psync         55(MiB/s)       13k             
vtfs-none-spool-numa    randwrite-psync         67(MiB/s)       16k             

vtfs-none-epool         randwrite-psync-multi   186(MiB/s)      46k             
vtfs-none-spool         randwrite-psync-multi   240(MiB/s)      60k             
vtfs-none-spool-numa    randwrite-psync-multi   271(MiB/s)      67k             

vtfs-none-epool         randwrite-libaio        224(MiB/s)      56k             
vtfs-none-spool         randwrite-libaio        296(MiB/s)      74k             
vtfs-none-spool-numa    randwrite-libaio        290(MiB/s)      72k             

vtfs-none-epool         randwrite-libaio-multi  300(MiB/s)      75k             
vtfs-none-spool         randwrite-libaio-multi  350(MiB/s)      87k             
vtfs-none-spool-numa    randwrite-libaio-multi  383(MiB/s)      95k             

Thanks
Vivek


