Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444EC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A79123718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="MLbpzQIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A79123718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVbH-0007rI-UN
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMVZs-0006cw-KC
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:14:52 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMVZr-0006O2-1s
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Jzw1/KRabcxEaqNqC1KBDx3WhsVlJkj13T/W///NaNA=; b=MLbpzQIO41v6DDPt+mpLK8/962
 B4vkjOVq4HFlL/L2Djl4s29R1SObNg9CUGt1r2Bkng7EaJTL1SB/0e25oWSoGYqiaTAomJU3B6lXe
 WJ/snIanzVn9RoJtvQQ+6u2Q4rtoHibqlU6qx3FHrM74rN9jqip1zjynHd/DTjBYNfS7pfbIT+1pM
 x3D4bUyZuOFCMbnvwNracb9YkkY7ekqVNkAKYU9gEAFFyA8iCmEJD8pZ0H7SA+xz4tnunD47ssAdK
 rck/u8ZqsihsgWcPi1JxX5Cm/DeUuzhsDNYDe3D9SwY7n8lyzSytLO8aIIga1bC5T+Bo3+kLIpzje
 xEp5jS5A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>,
 Vivek Goyal <vgoyal@redhat.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Date: Sun, 27 Sep 2020 14:14:43 +0200
Message-ID: <66718708.HdZnNlUTFG@silver>
In-Reply-To: <20200925185147.GS2873@work-vm>
References: <20200918213436.GA3520@redhat.com> <7085634.CctCyd8GvG@silver>
 <20200925185147.GS2873@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
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

On Freitag, 25. September 2020 20:51:47 CEST Dr. David Alan Gilbert wrote:
> * Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> > On Freitag, 25. September 2020 15:05:38 CEST Dr. David Alan Gilbert wrote:
> > > > > 9p ( mount -t 9p -o trans=virtio kernel /mnt
> > > > > -oversion=9p2000.L,cache=mmap,msize=1048576 ) test: (g=0):
> > > > > rw=randrw,
> > > > 
> > > > Bottleneck ------------------------------^
> > > > 
> > > > By increasing 'msize' you would encounter better 9P I/O results.
> > > 
> > > OK, I thought that was bigger than the default;  what number should I
> > > use?
> > 
> > It depends on the underlying storage hardware. In other words: you have to
> > try increasing the 'msize' value to a point where you no longer notice a
> > negative performance impact (or almost). Which is fortunately quite easy
> > to test on> 
> > guest like:
> > 	dd if=/dev/zero of=test.dat bs=1G count=12
> > 	time cat test.dat > /dev/null
> > 
> > I would start with an absolute minimum msize of 10MB. I would recommend
> > something around 100MB maybe for a mechanical hard drive. With a PCIe
> > flash
> > you probably would rather pick several hundred MB or even more.
> > 
> > That unpleasant 'msize' issue is a limitation of the 9p protocol: client
> > (guest) must suggest the value of msize on connection to server (host).
> > Server can only lower, but not raise it. And the client in turn obviously
> > cannot see host's storage device(s), so client is unable to pick a good
> > value by itself. So it's a suboptimal handshake issue right now.
> 
> It doesn't seem to be making a vast difference here:
> 
> 
> 
> 9p mount -t 9p -o trans=virtio kernel /mnt
> -oversion=9p2000.L,cache=mmap,msize=104857600
> 
> Run status group 0 (all jobs):
>    READ: bw=62.5MiB/s (65.6MB/s), 62.5MiB/s-62.5MiB/s (65.6MB/s-65.6MB/s),
> io=3070MiB (3219MB), run=49099-49099msec WRITE: bw=20.9MiB/s (21.9MB/s),
> 20.9MiB/s-20.9MiB/s (21.9MB/s-21.9MB/s), io=1026MiB (1076MB),
> run=49099-49099msec
> 
> 9p mount -t 9p -o trans=virtio kernel /mnt
> -oversion=9p2000.L,cache=mmap,msize=1048576000
> 
> Run status group 0 (all jobs):
>    READ: bw=65.2MiB/s (68.3MB/s), 65.2MiB/s-65.2MiB/s (68.3MB/s-68.3MB/s),
> io=3070MiB (3219MB), run=47104-47104msec WRITE: bw=21.8MiB/s (22.8MB/s),
> 21.8MiB/s-21.8MiB/s (22.8MB/s-22.8MB/s), io=1026MiB (1076MB),
> run=47104-47104msec
> 
> 
> Dave

Is that benchmark tool honoring 'iounit' to automatically run with max. I/O 
chunk sizes? What's that benchmark tool actually? And do you also see no 
improvement with a simple

	time cat largefile.dat > /dev/null

?

Best regards,
Christian Schoenebeck



