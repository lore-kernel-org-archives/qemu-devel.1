Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE66C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7368207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg90KVfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7368207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFK1-0007vV-NO
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNFIF-0006Vq-1H
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNFIB-0004Bt-9v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:03:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfiO0ti7rl+OV1wRgx68hiNRtMKaf0SPSuWY/q6uP3Q=;
 b=Jg90KVfJ//Jpl325youijaFMdTPSMLyKuCP7AQuIDBPP4N/V4jUP3hJ0jQuiEGTSuKolnk
 61IHK6En8I9HJicFMgOaEcxR1lvqlyJD1QSn3w0Sx6BpCCMwSqEFpYQzhY4C9JYKb66pz1
 3kocUMu3U4iETN003NKk9v/N/UzvARI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-0yDdH20hNcGKKVV2D8x1pw-1; Tue, 29 Sep 2020 09:03:34 -0400
X-MC-Unique: 0yDdH20hNcGKKVV2D8x1pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C9A98C1CC0;
 Tue, 29 Sep 2020 13:03:33 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-167.rdu2.redhat.com [10.10.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03A615D9CA;
 Tue, 29 Sep 2020 13:03:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6CA9F220203; Tue, 29 Sep 2020 09:03:25 -0400 (EDT)
Date: Tue, 29 Sep 2020 09:03:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Message-ID: <20200929130325.GA220516@redhat.com>
References: <20200918213436.GA3520@redhat.com> <7085634.CctCyd8GvG@silver>
 <20200925185147.GS2873@work-vm> <66718708.HdZnNlUTFG@silver>
MIME-Version: 1.0
In-Reply-To: <66718708.HdZnNlUTFG@silver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Venegas Munoz, Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 27, 2020 at 02:14:43PM +0200, Christian Schoenebeck wrote:
> On Freitag, 25. September 2020 20:51:47 CEST Dr. David Alan Gilbert wrote:
> > * Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> > > On Freitag, 25. September 2020 15:05:38 CEST Dr. David Alan Gilbert wrote:
> > > > > > 9p ( mount -t 9p -o trans=virtio kernel /mnt
> > > > > > -oversion=9p2000.L,cache=mmap,msize=1048576 ) test: (g=0):
> > > > > > rw=randrw,
> > > > > 
> > > > > Bottleneck ------------------------------^
> > > > > 
> > > > > By increasing 'msize' you would encounter better 9P I/O results.
> > > > 
> > > > OK, I thought that was bigger than the default;  what number should I
> > > > use?
> > > 
> > > It depends on the underlying storage hardware. In other words: you have to
> > > try increasing the 'msize' value to a point where you no longer notice a
> > > negative performance impact (or almost). Which is fortunately quite easy
> > > to test on> 
> > > guest like:
> > > 	dd if=/dev/zero of=test.dat bs=1G count=12
> > > 	time cat test.dat > /dev/null
> > > 
> > > I would start with an absolute minimum msize of 10MB. I would recommend
> > > something around 100MB maybe for a mechanical hard drive. With a PCIe
> > > flash
> > > you probably would rather pick several hundred MB or even more.
> > > 
> > > That unpleasant 'msize' issue is a limitation of the 9p protocol: client
> > > (guest) must suggest the value of msize on connection to server (host).
> > > Server can only lower, but not raise it. And the client in turn obviously
> > > cannot see host's storage device(s), so client is unable to pick a good
> > > value by itself. So it's a suboptimal handshake issue right now.
> > 
> > It doesn't seem to be making a vast difference here:
> > 
> > 
> > 
> > 9p mount -t 9p -o trans=virtio kernel /mnt
> > -oversion=9p2000.L,cache=mmap,msize=104857600
> > 
> > Run status group 0 (all jobs):
> >    READ: bw=62.5MiB/s (65.6MB/s), 62.5MiB/s-62.5MiB/s (65.6MB/s-65.6MB/s),
> > io=3070MiB (3219MB), run=49099-49099msec WRITE: bw=20.9MiB/s (21.9MB/s),
> > 20.9MiB/s-20.9MiB/s (21.9MB/s-21.9MB/s), io=1026MiB (1076MB),
> > run=49099-49099msec
> > 
> > 9p mount -t 9p -o trans=virtio kernel /mnt
> > -oversion=9p2000.L,cache=mmap,msize=1048576000
> > 
> > Run status group 0 (all jobs):
> >    READ: bw=65.2MiB/s (68.3MB/s), 65.2MiB/s-65.2MiB/s (68.3MB/s-68.3MB/s),
> > io=3070MiB (3219MB), run=47104-47104msec WRITE: bw=21.8MiB/s (22.8MB/s),
> > 21.8MiB/s-21.8MiB/s (22.8MB/s-22.8MB/s), io=1026MiB (1076MB),
> > run=47104-47104msec
> > 
> > 
> > Dave
> 
> Is that benchmark tool honoring 'iounit' to automatically run with max. I/O 
> chunk sizes? What's that benchmark tool actually? And do you also see no 
> improvement with a simple
> 
> 	time cat largefile.dat > /dev/null

I am assuming that msize only helps with sequential I/O and not random
I/O.

Dave is running random read and random write mix and probably that's why
he is not seeing any improvement with msize increase.

If we run sequential workload (as "cat largefile.dat"), that should
see an improvement with msize increase.

Thanks
Vivek


